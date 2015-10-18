From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:33 -0600
Subject: [PATCH V2 16/30] coresight: keeping track of enabled sink buffers
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-17-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep track of enabled sink buffers as a path between source
and sinks is being built.  That way sinks associated to a
source can be accessed quickly.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h |  3 ++-
 drivers/hwtracing/coresight/coresight.c      | 16 ++++++++++------
 include/linux/coresight.h                    |  2 ++
 3 files changed, 14 insertions(+), 7 deletions(-)

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
index 083080d435af..a40519d5a9e2 100644
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
@@ -312,15 +313,18 @@ int coresight_build_paths(struct coresight_device *csdev,
 	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
 	    csdev->activated) {
-		if (enable)
+		if (enable) {
 			ret = coresight_enable_path(path);
-		else
+			if (!ret && sinks)
+				list_add(&csdev->sinks, sinks);
+		} else {
 			ret = coresight_disable_path(path);
+		}
 	} else {
 		for (i = 0; i < csdev->nr_outport; i++) {
 			conn = &csdev->conns[i];
 			if (coresight_build_paths(conn->child_dev,
-						    path, enable) == 0)
+						  path, sinks, enable) == 0)
 				ret = 0;
 		}
 	}
@@ -347,7 +351,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (csdev->enable)
 		goto out;
 
-	if (coresight_build_paths(csdev, &path, true)) {
+	if (coresight_build_paths(csdev, &path, NULL, true)) {
 		dev_err(&csdev->dev, "building path(s) failed\n");
 		goto out;
 	}
@@ -373,7 +377,7 @@ void coresight_disable(struct coresight_device *csdev)
 		goto out;
 
 	coresight_disable_source(csdev);
-	if (coresight_build_paths(csdev, &path, false))
+	if (coresight_build_paths(csdev, &path, NULL, false))
 		dev_err(&csdev->dev, "releasing path(s) failed\n");
 
 out:
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 0601da01eeb2..dd530a6d3e21 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -153,6 +153,7 @@ struct coresight_connection {
  * @dev:	The device entity associated to this component.
  * @refcnt:	keep track of what is in use.
  * @path_link:	link of current component into the path being enabled.
+ * @sinks:	link of currently enabled sinks for a source.
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
  * @activated:	'true' only if a _sink_ has been activated.  A sink can be
@@ -169,6 +170,7 @@ struct coresight_device {
 	struct device dev;
 	atomic_t *refcnt;
 	struct list_head path_link;
+	struct list_head sinks;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
 	bool activated;	/* true only if a sink is part of a path */
-- 
1.9.1
