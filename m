From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 21 Mar 2018 20:58:49 -0500
Subject: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
Message-ID: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of the GICR_CTLR.RWP control bit was expanded to indicate
status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
or completed. Software must observe GICR_CTLR.RWP==0 after clearing
GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v2:
  -Revert readl_relaxed_poll() usage since it's not usable in GICv3 probe().
  -Changes to pr_xxx messages.

Changes since v1:
  -Moved LPI disable code to a seperate function as Marc suggested.
  -Mark's suggestion to use readl_relaxed_poll_timeout() helper functions.

 drivers/irqchip/irq-gic-v3-its.c   | 75 +++++++++++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2cbb19c..c1e8a8e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -1875,16 +1876,6 @@ static void its_cpu_init_lpis(void)
 		gic_data_rdist()->pend_page = pend_page;
 	}
 
-	/* Disable LPIs */
-	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
-
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
-
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
@@ -3287,13 +3278,69 @@ static bool gic_rdists_supports_plpis(void)
 	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
 }
 
+static int redist_disable_lpis(void)
+{
+	void __iomem *rbase = gic_data_rdist_rd_base();
+	u64 timeout = USEC_PER_SEC;
+	u64 val;
+
+	if (!gic_rdists_supports_plpis()) {
+		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
+		return -ENXIO;
+	}
+
+	val = readl_relaxed(rbase + GICR_CTLR);
+	if (!(val & GICR_CTLR_ENABLE_LPIS))
+		return 0;
+
+	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
+		smp_processor_id());
+	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+
+	/* Disable LPIs */
+	val &= ~GICR_CTLR_ENABLE_LPIS;
+	writel_relaxed(val, rbase + GICR_CTLR);
+
+	/* Make sure any change to GICR_CTLR is observable by the GIC */
+	dsb(sy);
+
+	/**
+	 * Software must observe RWP==0 after clearing GICR_CTLR.EnableLPIs
+	 * from 1 to 0 before programming GICR_PEND{PROP}BASER registers.
+	 * Bail out the driver probe() in case of timeout.
+	 */
+	while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
+		if (!timeout) {
+			pr_err("CPU%d: Failed to observe RWP==0 after disabling LPIs\n",
+			       smp_processor_id());
+			return -ETIMEDOUT;
+		}
+		udelay(1);
+		timeout--;
+	}
+
+	/**
+	 * After it has been written to 1, it is IMPLEMENTATION DEFINED whether
+	 * the bit GICR_CTLR.EnableLPI becomes RES1 or can be cleared to 0.
+	 * Bail out the driver probe() on systems where it's RES1.
+	 */
+	if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
+		pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 int its_cpu_init(void)
 {
 	if (!list_empty(&its_nodes)) {
-		if (!gic_rdists_supports_plpis()) {
-			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
-			return -ENXIO;
-		}
+		int ret;
+
+		ret = redist_disable_lpis();
+		if (ret)
+			return ret;
+
 		its_cpu_init_lpis();
 		its_cpu_init_collection();
 	}
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b26eccc..c6f4c48 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -106,6 +106,7 @@
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_RWP			(1UL << 3)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
