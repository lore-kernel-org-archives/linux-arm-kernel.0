From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:26 -0600
Subject: [RFC PATCH 12/20] coresight: keeping track of enabled sink buffers
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-13-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep track of enabled sink buffers as paths between source
and sinks are being built.  That way sinks associated to a
source can be accessed quickly.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h |  3 ++-
 drivers/hwtracing/coresight/coresight.c      | 11 +++++++----
 include/linux/coresight.h                    |  2 ++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 8a52fdcb4bd6..3d7467f315ed 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -53,7 +53,8 @@ static inline void CS_UNLOCK(void __iomem *addr)
 }
 
 int coresight_build_paths(struct coresight_device *csdev,
-			  struct list_head *path, bool enable);
+			  struct list_head *path,
+			  struct list_head *sinks, bool enable);
 
 #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
 extern int etm_readl_cp14(u32 off, unsigned int *val);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 7a54d8069670..2e9f6248fb7e 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -302,7 +302,8 @@ static int coresight_disable_path(struct list_head *path)
 }
 
 int coresight_build_paths(struct coresight_device *csdev,
-			  struct list_head *path, bool enable)
+			  struct list_head *path,
+			  struct list_head *sinks, bool enable)
 {
 	int i, ret = -EINVAL;
 	struct coresight_connection *conn;
@@ -314,13 +315,15 @@ int coresight_build_paths(struct coresight_device *csdev,
 	    csdev->activated) {
 		if (enable)
 			ret = coresight_enable_path(path);
+			if (!ret && sinks)
+				list_add(&csdev->sinks, sinks);
 		else
 			ret = coresight_disable_path(path);
 	} else {
 		for (i = 0; i < csdev->nr_outport; i++) {
 			conn = &csdev->conns[i];
 			if (coresight_build_paths(conn->child_dev,
-						    path, enable) == 0)
+						  path, sinks, enable) == 0)
 				ret = 0;
 		}
 	}
@@ -347,7 +350,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (csdev->enable)
 		goto out;
 
-	if (coresight_build_paths(csdev, &path, true)) {
+	if (coresight_build_paths(csdev, &path, NULL, true)) {
 		dev_err(&csdev->dev, "building path(s) failed\n");
 		goto out;
 	}
@@ -373,7 +376,7 @@ void coresight_disable(struct coresight_device *csdev)
 		goto out;
 
 	coresight_disable_source(csdev);
-	if (coresight_build_paths(csdev, &path, false))
+	if (coresight_build_paths(csdev, &path, NULL, false))
 		dev_err(&csdev->dev, "releasing path(s) failed\n");
 
 out:
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 48c3b9df0ae0..da76b2951f10 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -154,6 +154,7 @@ struct coresight_connection {
  * @dev:	The device entity associated to this component.
  * @refcnt:	keep track of what is in use.
  * @path_link:	link of current component into the path being enabled.
+ * @sinks:	list of currently enabled sinks for a source.
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
  * @activated:	'true' only if a _sink_ has been activated.  A sink can be
@@ -170,6 +171,7 @@ struct coresight_device {
 	struct device dev;
 	atomic_t *refcnt;
 	struct list_head path_link;
+	struct list_head sinks;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
 	bool activated;	/* true only if a sink is part of a path */
-- 
1.9.1
