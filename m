From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 22 Nov 2010 13:08:15 +0000
Subject: [PATCH] arm: GIC: Do not try to register more then NR_IRQS interrupts
In-Reply-To: <1290431040-15417-1-git-send-email-pawel.moll@arm.com>
References: <1290431040-15417-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1290431295-16052-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change limits number of GIC-originating interrupts to the
platform maximum (defined by NR_IRQS) while still initialising
all distributor registers.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/common/gic.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 772f95f..20e1412 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -231,14 +231,6 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	max_irq = (max_irq + 1) * 32;
 
 	/*
-	 * The GIC only supports up to 1020 interrupt sources.
-	 * Limit this to either the architected maximum, or the
-	 * platform maximum.
-	 */
-	if (max_irq > max(1020, NR_IRQS))
-		max_irq = max(1020, NR_IRQS);
-
-	/*
 	 * Set all global interrupts to be level triggered, active low.
 	 */
 	for (i = 32; i < max_irq; i += 16)
@@ -264,6 +256,12 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
 
 	/*
+	 * Limit number of interrupts registered to the platform maximum
+	 */
+	WARN_ON(max_irq > NR_IRQS);
+	max_irq = min(max_irq, NR_IRQS);
+
+	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
 	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
-- 
1.6.3.3
