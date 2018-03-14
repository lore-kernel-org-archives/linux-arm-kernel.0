From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 13 Mar 2018 19:50:01 -0500
Subject: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
Message-ID: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of the GICR_CTLR.RWP control bit was expanded to indicate
status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
or completed. Software must observe GICR_CTLR.RWP==0 after clearing
GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 30 +++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f..85cd158 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1875,15 +1875,31 @@ static void its_cpu_init_lpis(void)
 		gic_data_rdist()->pend_page = pend_page;
 	}
 
-	/* Disable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
 
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
+	/* Make sure LPIs are disabled before programming PEND/PROP registers */
+	if (val & GICR_CTLR_ENABLE_LPIS) {
+		u32 count = 1000000; /* 1s! */
+
+		/* Disable LPIs */
+		val &= ~GICR_CTLR_ENABLE_LPIS;
+		writel_relaxed(val, rbase + GICR_CTLR);
+
+		/* Make sure any change to GICR_CTLR is observable by the GIC */
+		dsb(sy);
+
+		/* Wait for GICR_CTLR.RWP==0 or timeout */
+		while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
+			if (!count) {
+				pr_err("CPU%d: Failed to disable LPIs\n",
+				       smp_processor_id());
+				return;
+			}
+			cpu_relax();
+			udelay(1);
+			count--;
+		};
+	}
 
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c00c4c33..4d5fb60 100644
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
