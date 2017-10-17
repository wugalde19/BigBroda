
module BigBroda
  class Table < BigBroda::Client

    attr_accessor :options

    def initialize( opts={})
      super
    end

    def self.list(project_id, dataset_id)
      parse_response BigBroda::Auth.client.execute(
        BigBroda::Auth.api.tables.list,
        projectId: project_id, datasetId: dataset_id
      )
    end

    def self.get(project_id, config_database, table_name)
      parts      = table_name.split('.')
      dataset_id = parts.first
      table_id   = parts.last
      res = BigBroda::Auth.client.execute(
        :api_method=> BigBroda::Auth.api.tables.get,
        :parameters=> {"projectId"=> project_id, "datasetId"=> dataset_id, "tableId"=> table_id  }
      )
      parse_response(res)
    end

    def self.update(project_id, dataset_id, table_id, body={})
      res = BigBroda::Auth.client.execute(
        :api_method=> BigBroda::Auth.api.tables.update,
        :body_object=> body , #{"datasetReference"=> {"datasetId" =>"whoa"}},
        :parameters=> {"projectId"=> project_id, "datasetId" => dataset_id, "tableId"=> table_id }
      )
      parse_response(res)
    end

    def self.patch(project_id, dataset_id, table_id, body={})
      res = BigBroda::Auth.client.execute(
        :api_method=> BigBroda::Auth.api.tables.update,
        :body_object=> body , #{"datasetReference"=> {"datasetId" =>"whoa"}},
        :parameters=> {"projectId"=> project_id, "datasetId" => dataset_id, "tableId"=> table_id }
      )
      parse_response(res)
    end

    def self.create(project_id, dataset_id, body={})
      res = BigBroda::Auth.client.execute(
        :api_method=> BigBroda::Auth.api.tables.insert,
        :body_object=> body , #{"datasetReference"=> {"datasetId" =>"whoa"}},
        :parameters=> {"projectId"=> project_id, "datasetId"=> dataset_id }
      )
      parse_response(res)
    end

    def self.delete(project_id, dataset_id, table_id, body={})
      res = BigBroda::Auth.client.execute(
        :api_method=> BigBroda::Auth.api.tables.delete,
        #:body_object=> body, #{"deleteContents"=> false},
        :parameters=> {"projectId"=> project_id, "datasetId" => dataset_id, "tableId"=> table_id }
      )
       res.status == 204 ?  true : parse_response(res)
    end

  end
end
