From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:14 -0600
Subject: [PATCH 20/26] coresight tmc etr: Cleanup AXICTL register handling
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-21-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

This patch cleans up how we setup the AXICTL register on
TMC ETR. At the moment we don't set the CacheCtrl bits, which
drives the arcache and awcache bits on AXI bus specifying the
cacheablitiy. Set this to Write-back Read and Write-allocate.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 +++-------
 drivers/hwtracing/coresight/coresight-tmc.h     | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 9c39c899ebd5..880b53527599 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -36,13 +36,9 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 
 	axictl = readl_relaxed(drvdata->base + TMC_AXICTL);
-	axictl |= TMC_AXICTL_WR_BURST_16;
-	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-	axictl &= ~TMC_AXICTL_SCT_GAT_MODE;
-	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-	axictl = (axictl &
-		  ~(TMC_AXICTL_PROT_CTL_B0 | TMC_AXICTL_PROT_CTL_B1)) |
-		  TMC_AXICTL_PROT_CTL_B1;
+	axictl &= ~TMC_AXICTL_CLEAR_MASK;
+	axictl |= (TMC_AXICTL_PROT_CTL_B1 | TMC_AXICTL_WR_BURST_16);
+	axictl |= TMC_AXICTL_AXCACHE_OS;
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, drvdata->paddr);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index f55203d48673..07c0bf1d9269 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -54,11 +54,26 @@
 #define TMC_STS_TMCREADY_BIT	2
 #define TMC_STS_FULL		BIT(0)
 #define TMC_STS_TRIGGERED	BIT(1)
-/* TMC_AXICTL - 0x110 */
+/*
+ * TMC_AXICTL - 0x110
+ *
+ * TMC AXICTL format for SoC-400
+ *	Bits [0-1]	: ProtCtrlBit0-1
+ *	Bits [2-5]	: CacheCtrlBits 0-3 (AxCACHE)
+ *	Bit  6		: Reserved
+ *	Bit  7		: ScatterGatherMode
+ *	Bits [8-11]	: WrBurstLen
+ *	Bits [12-31]	: Reserved.
+ */
+#define TMC_AXICTL_CLEAR_MASK 0xfbf
+
 #define TMC_AXICTL_PROT_CTL_B0	BIT(0)
 #define TMC_AXICTL_PROT_CTL_B1	BIT(1)
 #define TMC_AXICTL_SCT_GAT_MODE	BIT(7)
 #define TMC_AXICTL_WR_BURST_16	0xF00
+/* Write-back Read and Write-allocate */
+#define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
+
 /* TMC_FFCR - 0x304 */
 #define TMC_FFCR_FLUSHMAN_BIT	6
 #define TMC_FFCR_EN_FMT		BIT(0)
-- 
2.7.4
