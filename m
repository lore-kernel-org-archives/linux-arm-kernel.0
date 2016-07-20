From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Jul 2016 14:38:19 -0600
Subject: [PATCH V2 5/6] coresight: adding sink parameter to function
 coresight_build_path()
In-Reply-To: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1469047100-18131-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now function coresight_build_path() was counting on a sink to
have been selected (from sysFS) prior to being called.  This patch
adds a string argument so that a sink matching the argument can be
selected.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h     |  3 +-
 drivers/hwtracing/coresight/coresight.c          | 40 +++++++++++++++---------
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f4174f36c5a0..f8c7a8733b23 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -184,7 +184,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		 * list of devices from source to sink that can be
 		 * referenced later when the path is actually needed.
 		 */
-		event_data->path[cpu] = coresight_build_path(csdev);
+		event_data->path[cpu] = coresight_build_path(csdev, NULL);
 		if (!event_data->path[cpu])
 			goto err;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ad975c58080d..3cb574b3cdd9 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -94,7 +94,8 @@ static inline void CS_UNLOCK(void __iomem *addr)
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode);
 struct coresight_device *coresight_get_sink(struct list_head *path);
-struct list_head *coresight_build_path(struct coresight_device *csdev);
+struct list_head *coresight_build_path(struct coresight_device *csdev,
+				       const char *sink);
 void coresight_release_path(struct list_head *path);
 
 #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d08d1ab9bba5..cbbb51a16dff 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -372,30 +372,41 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
  * @csdev:	The device to start from.
  * @path:	The list to add devices to.
+ * @sink:	The name of the sink this path should connect with.
  *
- * The tree of Coresight device is traversed until an activated sink is
- * found.  From there the sink is added to the list along with all the
- * devices that led to that point - the end result is a list from source
- * to sink. In that list the source is the first device and the sink the
- * last one.
+ * The tree of Coresight device is traversed until an activated sink or
+ * the one specified by @sink is found.
+ * From there the sink is added to the list along with all the devices that
+ * led to that point - the end result is a list from source to sink. In that
+ * list the source is the first device and the sink the last one.
  */
 static int _coresight_build_path(struct coresight_device *csdev,
-				 struct list_head *path)
+				 struct list_head *path, const char *sink)
 {
 	int i;
 	bool found = false;
 	struct coresight_node *node;
 
-	/* An activated sink has been found.  Enqueue the element */
-	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) && csdev->activated)
-		goto out;
+	/*
+	 * First see if we are dealing with a sink.  If we have one check if
+	 * it was selected via sysFS or the perf cmd line.
+	 */
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		/* Activated via perf cmd line */
+		if (sink && !strcmp(dev_name(&csdev->dev), sink))
+			goto out;
+		/* Activated via sysFS */
+		if (csdev->activated)
+			goto out;
+	}
 
 	/* Not a sink - recursively explore each port found on this element */
 	for (i = 0; i < csdev->nr_outport; i++) {
 		struct coresight_device *child_dev = csdev->conns[i].child_dev;
 
-		if (child_dev && _coresight_build_path(child_dev, path) == 0) {
+		if (child_dev &&
+		    _coresight_build_path(child_dev, path, sink) == 0) {
 			found = true;
 			break;
 		}
@@ -422,7 +433,8 @@ out:
 	return 0;
 }
 
-struct list_head *coresight_build_path(struct coresight_device *csdev)
+struct list_head *coresight_build_path(struct coresight_device *csdev,
+				       const char *sink)
 {
 	struct list_head *path;
 	int rc;
@@ -433,7 +445,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev)
 
 	INIT_LIST_HEAD(path);
 
-	rc = _coresight_build_path(csdev, path);
+	rc = _coresight_build_path(csdev, path, sink);
 	if (rc) {
 		kfree(path);
 		return ERR_PTR(rc);
@@ -508,7 +520,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (csdev->enable)
 		goto out;
 
-	path = coresight_build_path(csdev);
+	path = coresight_build_path(csdev, NULL);
 	if (IS_ERR(path)) {
 		pr_err("building path(s) failed\n");
 		ret = PTR_ERR(path);
-- 
2.7.4
