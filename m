From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 17 May 2018 20:20:21 -0500
Subject: [PATCH 3/6] coresight: use IS_ENABLED for CONFIGs that may be modules
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
Message-ID: <20180518012024.22645-3-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking for CONFIG_x fails if CONFIG_x=m, use IS_ENABLED that is
true for built-ins and modules instead.  Required when building
various coresight components as modules.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.h | 2 +-
 drivers/hwtracing/coresight/coresight-priv.h     | 2 +-
 include/linux/coresight.h                        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4faf5e..539b250df455 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -43,7 +43,7 @@ struct etm_filters {
 };
 
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
 
 #else
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 0e5a74dae6a6..83a6f5b7a683 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -136,7 +136,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e5421b83e4e6..548fa56b29bd 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -236,7 +236,7 @@ struct coresight_ops {
 	const struct coresight_ops_source *source_ops;
 };
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-- 
2.17.0
