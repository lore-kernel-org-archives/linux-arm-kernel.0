From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Thu, 27 Aug 2015 12:06:09 +0800
Subject: [PATCH] Coresight: ETMv4: Prevent TRCRSCTLR0&1 from being accessed
Message-ID: <1440648369-4614-1-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. TRCRSCTLRn - Resource Selection Control Registers n=0~1 are reserved,
   we shouldn't access them.
2. The max number of 'n' here is defined in TRCIDR4.NUMRSPAIR whoes value
   indicates the number of resource selection *pairs*, and 0 indicates
   one resource selection pair, 1 indicates two pairs, and so on ...

So, the total number of resource selection control registers which we can
access is (TRCIDR4.NUMRSPAIR * 2)

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1312e99..9425249 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -136,7 +136,9 @@ static void etm4_enable_hw(void *info)
 		writel_relaxed(drvdata->cntr_val[i],
 			       drvdata->base + TRCCNTVRn(i));
 	}
-	for (i = 0; i < drvdata->nr_resource; i++)
+
+	/* Resource selector pair 0 is always implemented and reserved */
+	for (i = 2; i < (drvdata->nr_resource + 1) * 2; i++)
 		writel_relaxed(drvdata->res_ctrl[i],
 			       drvdata->base + TRCRSCTLRn(i));
 
@@ -489,8 +491,9 @@ static ssize_t reset_store(struct device *dev,
 		drvdata->cntr_val[i] = 0x0;
 	}
 
-	drvdata->res_idx = 0x0;
-	for (i = 0; i < drvdata->nr_resource; i++)
+	/* Resource selector pair 0 is always implemented and reserved */
+	drvdata->res_idx = 0x2;
+	for (i = 2; i < (drvdata->nr_resource + 1) * 2; i++)
 		drvdata->res_ctrl[i] = 0x0;
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -1729,7 +1732,7 @@ static ssize_t res_idx_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	/* Resource selector pair 0 is always implemented and reserved */
-	if ((val == 0) || (val >= drvdata->nr_resource))
+	if (val < 2 || val > (drvdata->nr_resource + 1) * 2)
 		return -EINVAL;
 
 	/*
@@ -2498,7 +2501,9 @@ static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
 		drvdata->cntr_val[i] = 0x0;
 	}
 
-	for (i = 2; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is always implemented and reserved */
+	drvdata->res_idx = 0x2;
+	for (i = 2; i < (drvdata->nr_resource + 1) * 2; i++)
 		drvdata->res_ctrl[i] = 0x0;
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-- 
1.9.1
