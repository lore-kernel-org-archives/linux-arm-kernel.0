From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:18 -0600
Subject: [PATCH V2 01/30] coresight: etm3x: moving etm_readl/writel to header
 file
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving functions etm_readl/writel to file "coresight-etm.h"
for access by code outside of the main ETM3x driver.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   | 29 +++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm3x.c | 29 ---------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index b4481eb29304..34f7db881fa7 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -251,4 +251,33 @@ enum etm_addr_type {
 	ETM_ADDR_TYPE_START,
 	ETM_ADDR_TYPE_STOP,
 };
+
+static inline void etm_writel(struct etm_drvdata *drvdata,
+			      u32 val, u32 off)
+{
+	if (drvdata->use_cp14) {
+		if (etm_writel_cp14(off, val)) {
+			dev_err(drvdata->dev,
+				"invalid CP14 access to ETM reg: %#x", off);
+		}
+	} else {
+		writel_relaxed(val, drvdata->base + off);
+	}
+}
+
+static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
+{
+	u32 val;
+
+	if (drvdata->use_cp14) {
+		if (etm_readl_cp14(off, &val)) {
+			dev_err(drvdata->dev,
+				"invalid CP14 access to ETM reg: %#x", off);
+		}
+	} else {
+		val = readl_relaxed(drvdata->base + off);
+	}
+
+	return val;
+}
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d630b7ece735..c1dc095c3fb0 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -42,35 +42,6 @@ module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 static int etm_count;
 static struct etm_drvdata *etmdrvdata[NR_CPUS];
 
-static inline void etm_writel(struct etm_drvdata *drvdata,
-			      u32 val, u32 off)
-{
-	if (drvdata->use_cp14) {
-		if (etm_writel_cp14(off, val)) {
-			dev_err(drvdata->dev,
-				"invalid CP14 access to ETM reg: %#x", off);
-		}
-	} else {
-		writel_relaxed(val, drvdata->base + off);
-	}
-}
-
-static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
-{
-	u32 val;
-
-	if (drvdata->use_cp14) {
-		if (etm_readl_cp14(off, &val)) {
-			dev_err(drvdata->dev,
-				"invalid CP14 access to ETM reg: %#x", off);
-		}
-	} else {
-		val = readl_relaxed(drvdata->base + off);
-	}
-
-	return val;
-}
-
 /*
  * Memory mapped writes to clear os lock are not supported on some processors
  * and OS lock must be unlocked before any memory mapped access on such
-- 
1.9.1
