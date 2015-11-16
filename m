From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 19:13:26 +0000
Subject: [PATCH 2/4] irqchip/gic: Make sure all interrupts are deactivated at
 boot
In-Reply-To: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
References: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1447701208-18150-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a GIC/GICv3 based system, we have no idea what
state the firmware (or previous kernel in the case of kexec)
has left the GIC, and some interrupts may still be active.

In order to garantee that we have a clean state, make sure
the active bits are cleared at init time.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 44a077f..f174ce0 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -84,12 +84,15 @@ void __init gic_dist_config(void __iomem *base, int gic_irqs,
 		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GIC_DIST_PRI + i);
 
 	/*
-	 * Disable all interrupts.  Leave the PPI and SGIs alone
-	 * as they are enabled by redistributor registers.
+	 * Deactivate and disable all SPIs. Leave the PPI and SGIs
+	 * alone as they are in the redistributor registers on GICv3.
 	 */
-	for (i = 32; i < gic_irqs; i += 32)
+	for (i = 32; i < gic_irqs; i += 32) {
 		writel_relaxed(GICD_INT_EN_CLR_X32,
-					base + GIC_DIST_ENABLE_CLEAR + i / 8);
+			       base + GIC_DIST_ACTIVE_CLEAR + i / 8);
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       base + GIC_DIST_ENABLE_CLEAR + i / 8);
+	}
 
 	if (sync_access)
 		sync_access();
@@ -102,7 +105,9 @@ void gic_cpu_config(void __iomem *base, void (*sync_access)(void))
 	/*
 	 * Deal with the banked PPI and SGI interrupts - disable all
 	 * PPI interrupts, ensure all SGI interrupts are enabled.
+	 * Make sure everything is deactivated.
 	 */
+	writel_relaxed(GICD_INT_EN_CLR_X32, base + GIC_DIST_ACTIVE_CLEAR);
 	writel_relaxed(GICD_INT_EN_CLR_PPI, base + GIC_DIST_ENABLE_CLEAR);
 	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
 
-- 
2.1.4
