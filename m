From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 15:49:51 -0600
Subject: [PATCH 1/5] coresight: Make path enable/disable aware of operation
 mode
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1536702595-9999-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make functions that enable and disable a path aware of the mode,
i.e sysFS or perf, they are being operated from.  That way said
mode can be communicated to device specific operations in order
to control how verbose they can be.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 drivers/hwtracing/coresight/coresight-priv.h     | 2 +-
 drivers/hwtracing/coresight/coresight.c          | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index abe8249b893b..92affdcf2467 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -304,7 +304,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 
 fail_disable_path:
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_PERF);
 fail_end_stop:
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, 0);
@@ -356,7 +356,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	}
 
 	/* Disabling the path make its elements available to other sessions */
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_PERF);
 }
 
 static int etm_event_add(struct perf_event *event, int mode)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index c11da5564a67..acfe67646a05 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -136,7 +136,7 @@ static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
 		writel_relaxed((u32)(val >> 32), addr + hi_offset);
 }
 
-void coresight_disable_path(struct list_head *path);
+void coresight_disable_path(struct list_head *path, u32 mode);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e73ca6af4765..118b435f0887 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -277,7 +277,7 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
-void coresight_disable_path(struct list_head *path)
+void coresight_disable_path(struct list_head *path, u32 mode)
 {
 	u32 type;
 	struct coresight_node *nd;
@@ -369,7 +369,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 out:
 	return ret;
 err:
-	coresight_disable_path(path);
+	coresight_disable_path(path, mode);
 	goto out;
 }
 
@@ -677,7 +677,7 @@ int coresight_enable(struct coresight_device *csdev)
 	return ret;
 
 err_source:
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_SYSFS);
 
 err_path:
 	coresight_release_path(path);
@@ -714,7 +714,7 @@ void coresight_disable(struct coresight_device *csdev)
 		break;
 	}
 
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_SYSFS);
 	coresight_release_path(path);
 
 out:
-- 
2.7.4
