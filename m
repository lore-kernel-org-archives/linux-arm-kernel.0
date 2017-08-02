From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:16 -0600
Subject: [PATCH 22/26] coresight tmc: Support for save-restore in ETR
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-23-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The Coresight SoC 600 TMC ETR supports save-restore feature,
where the values of the RRP/RWP and STS.Full are retained
when it leaves the Disabled state. Hence, we must program the
RRP/RWP and STS.Full to a proper value. For now, set the RRP/RWP
to the base address of the buffer and clear the STS.Full register.
This can be later exploited for proper save-restore of ETR
trace contexts (e.g, perf).

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 13 ++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h     |  9 +++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 40ddcf11ae4c..68fbc8f7450e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -22,7 +22,7 @@
 
 static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
-	u32 axictl;
+	u32 axictl, sts;
 
 	/* Zero out the memory to help with debug */
 	memset(drvdata->vaddr, 0, drvdata->size);
@@ -47,6 +47,17 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, drvdata->paddr);
+	/*
+	 * If the TMC pointers must be programmed before the session,
+	 * we have to set it properly (i.e, RRP/RWP to base address and
+	 * STS to "not full").
+	 */
+	if (tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE)) {
+		tmc_write_rrp(drvdata, drvdata->paddr);
+		tmc_write_rwp(drvdata, drvdata->paddr);
+		sts = readl_relaxed(drvdata->base + TMC_STS) & ~TMC_STS_FULL;
+		writel_relaxed(sts, drvdata->base + TMC_STS);
+	}
 
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index f39caa6a45c3..d0da43a14246 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -119,6 +119,15 @@ enum tmc_mem_intf_width {
 #define TMC_ETR_SG			(0x1U << 0)
 /* ETR has separate read/write cache encodings */
 #define TMC_ETR_AXI_ARCACHE		(0x1U << 1)
+/*
+ * TMC_ETR_SAVE_RESTORE - Values of RRP/RWP/STS.Full are
+ * retained when TMC leaves Disabled state, allowing us to continue
+ * the tracing from a point where we stopped. This also implies that
+ * the RRP/RWP/STS.Full should always be programmed to the correct
+ * value. Unfortunately this is not advertised by the hardware,
+ * so we have to rely on PID of the IP to detect the functionality.
+ */
+#define TMC_ETR_SAVE_RESTORE		(0x1U << 2)
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
-- 
2.7.4
