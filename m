From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  6 Sep 2016 09:45:18 -0600
Subject: [PATCH] coresight: perf: deal with error condition properly
Message-ID: <1473176718-1693-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function coresight_build_path() should return -ENOMEM when kzalloc
fails to allocated the requested memory.  That way callers can deal
with the error condition in a similar way.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 drivers/hwtracing/coresight/coresight.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 98eb207684fa..2cd7c718198a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -135,7 +135,7 @@ static void free_event_data(struct work_struct *work)
 	}
 
 	for_each_cpu(cpu, mask) {
-		if (event_data->path[cpu])
+		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
 			coresight_release_path(event_data->path[cpu]);
 	}
 
@@ -220,7 +220,7 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		 * referenced later when the path is actually needed.
 		 */
 		event_data->path[cpu] = coresight_build_path(csdev);
-		if (!event_data->path[cpu])
+		if (IS_ERR(event_data->path[cpu]))
 			goto err;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index fcbedd3905e3..7bf00a0beb6f 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -429,7 +429,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev)
 
 	path = kzalloc(sizeof(struct list_head), GFP_KERNEL);
 	if (!path)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(path);
 
-- 
2.7.4
