From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Nov 2015 11:33:01 -0700
Subject: [RESEND PATCH V4 09/26] coresight: add API to get sink from path
In-Reply-To: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448303598-11249-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an API allowing external code to quickly get a handle on the
sink within a path.  The sink is always last, but adding an API allows
to keep the path's node structure private and remove redundant checks.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h |  1 +
 drivers/hwtracing/coresight/coresight.c      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 2dc59a5c5b1e..ed116b303e87 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -60,6 +60,7 @@ static inline void CS_UNLOCK(void __iomem *addr)
 
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path);
+struct coresight_device *coresight_get_sink(struct list_head *path);
 struct list_head *coresight_build_path(struct coresight_device *csdev);
 void coresight_release_path(struct list_head *path);
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 7e4064b31c99..47a4e109f700 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -322,6 +322,21 @@ err:
 	goto out;
 }
 
+struct coresight_device *coresight_get_sink(struct list_head *path)
+{
+	struct coresight_device *csdev;
+
+	if (!path)
+		return NULL;
+
+	csdev = list_last_entry(path, struct coresight_node, link)->csdev;
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return NULL;
+
+	return csdev;
+}
+
 /**
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
  * @csdev:	The device to start from.
-- 
1.9.1
