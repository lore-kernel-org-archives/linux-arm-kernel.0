From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 23 Nov 2010 19:45:42 +0000
Subject: [PATCH v2] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
Message-ID: <1290541542-12917-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change limits number of GIC-originating interrupts to the
platform maximum (defined by NR_IRQS) while still initialising
all distributor registers.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/common/gic.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 772f95f..7cbc41d 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -210,7 +210,7 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 			  unsigned int irq_start)
 {
-	unsigned int max_irq, i;
+	unsigned int gic_irqs, irq_limit, i;
 	u32 cpumask = 1 << smp_processor_id();
 
 	if (gic_nr >= MAX_GIC_NR)
@@ -227,46 +227,45 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	/*
 	 * Find out how many interrupts are supported.
 	 */
-	max_irq = readl(base + GIC_DIST_CTR) & 0x1f;
-	max_irq = (max_irq + 1) * 32;
-
-	/*
-	 * The GIC only supports up to 1020 interrupt sources.
-	 * Limit this to either the architected maximum, or the
-	 * platform maximum.
-	 */
-	if (max_irq > max(1020, NR_IRQS))
-		max_irq = max(1020, NR_IRQS);
+	gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
+	gic_irqs = (gic_irqs + 1) * 32;
 
 	/*
 	 * Set all global interrupts to be level triggered, active low.
 	 */
-	for (i = 32; i < max_irq; i += 16)
+	for (i = 32; i < gic_irqs; i += 16)
 		writel(0, base + GIC_DIST_CONFIG + i * 4 / 16);
 
 	/*
 	 * Set all global interrupts to this CPU only.
 	 */
-	for (i = 32; i < max_irq; i += 4)
+	for (i = 32; i < gic_irqs; i += 4)
 		writel(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
 	/*
 	 * Set priority on all global interrupts.
 	 */
-	for (i = 32; i < max_irq; i += 4)
+	for (i = 32; i < gic_irqs; i += 4)
 		writel(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
 
 	/*
 	 * Disable all interrupts.  Leave the PPI and SGIs alone
 	 * as these enables are banked registers.
 	 */
-	for (i = 32; i < max_irq; i += 32)
+	for (i = 32; i < gic_irqs; i += 32)
 		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
 
 	/*
+	 * Limit number of interrupts registered to the platform maximum
+	 */
+	irq_limit = gic_data[gic_nr].irq_offset + gic_irqs;
+	if (WARN_ON(irq_limit > NR_IRQS))
+		irq_limit = NR_IRQS;
+
+	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
-	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
+	for (i = irq_start; i < irq_limit; i++) {
 		set_irq_chip(i, &gic_chip);
 		set_irq_chip_data(i, &gic_data[gic_nr]);
 		set_irq_handler(i, handle_level_irq);
-- 
1.6.3.3
