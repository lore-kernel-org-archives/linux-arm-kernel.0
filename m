From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Jun 2017 16:22:54 +0100
Subject: [PATCH v2 10/12] coresight tmc: Support for save-restore in ETR
In-Reply-To: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1498490576-1350-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
 drivers/hwtracing/coresight/coresight-tmc.h     |  8 ++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ff11b92..7294fb7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -22,7 +22,7 @@
 
 static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
-	u32 axictl;
+	u32 axictl, sts;
 
 	/* Zero out the memory to help with debug */
 	memset(drvdata->vaddr, 0, drvdata->size);
@@ -45,6 +45,17 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		  TMC_AXICTL_PROT_CTL_B1;
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, drvdata->paddr);
+	/*
+	 * If the TMC pointers must be programmed before the session,
+	 * we have to set it properly (i.e, RRP/RWP to base address and
+	 * STS to "not full").
+	 */
+	if (tmc_has_cap(drvdata, TMC_CAP_ETR_SAVE_RESTORE)) {
+		tmc_write_rrp(drvdata, drvdata->paddr);
+		tmc_write_rwp(drvdata, drvdata->paddr);
+		sts = readl_relaxed(drvdata->base + TMC_STS) & ~TMC_STS_FULL;
+		writel_relaxed(sts, drvdata->base + TMC_STS);
+	}
 
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 87e4561..d5ef51e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -90,6 +90,14 @@ enum tmc_mem_intf_width {
 };
 
 #define TMC_CAP_ETR_SG_UNIT			(1U << 0)
+/*
+ * TMC_CAP_ETR_SAVE_RESTORE - Values of RRP/RWP/STS.Full are
+ * retained when TMC leaves Disabled state, allowing us to continue
+ * the tracing from a point where we stopped. This also implies that
+ * the RRP/RWP/STS.Full should always be programmed to the correct
+ * value.
+ */
+#define TMC_CAP_ETR_SAVE_RESTORE	(1U << 1)
 
 /**
  * struct tmc_cap - Describes the capabilities of the TMC.
-- 
2.7.5
