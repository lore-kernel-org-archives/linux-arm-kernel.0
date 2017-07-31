From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:07 +0100
Subject: [PATCH v3 29/59] irqchip/gic-v3-its: Set implementation defined bit
 to enable VLPIs
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-30-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A long time ago, GITS_CTLR[1] used to be called GITC_CTLR.EnableVLPI.
It has been subsequently deprecated and is now an "Implementation
Defined" bit that may ot may not be set for GICv4. Brilliant.

And the current crop of the FastModel requires that bit for VLPIs
to be enabled. Oh well... Let's set it and find out what breaks.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 7 +++++--
 include/linux/irqchip/arm-gic-v3.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a177af0b1657..a5b1317d89eb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2610,7 +2610,7 @@ static int its_force_quiescent(void __iomem *base)
 		return 0;
 
 	/* Disable the generation of all interrupts to this ITS */
-	val &= ~GITS_CTLR_ENABLE;
+	val &= ~(GITS_CTLR_ENABLE | GITS_CTLR_ImDe);
 	writel_relaxed(val, base + GITS_CTLR);
 
 	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
@@ -2879,7 +2879,10 @@ static int __init its_probe_one(struct resource *res,
 
 	gits_write_cwriter(0, its->base + GITS_CWRITER);
 	ctlr = readl_relaxed(its->base + GITS_CTLR);
-	writel_relaxed(ctlr | GITS_CTLR_ENABLE, its->base + GITS_CTLR);
+	ctlr |= GITS_CTLR_ENABLE;
+	if (its->is_v4)
+		ctlr |= GITS_CTLR_ImDe;
+	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
 	err = its_init_domain(handle, its);
 	if (err)
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6bc142cfa616..1ea576c8126f 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -298,6 +298,7 @@
 #define GITS_TRANSLATER			0x10040
 
 #define GITS_CTLR_ENABLE		(1U << 0)
+#define GITS_CTLR_ImDe			(1U << 1)
 #define	GITS_CTLR_ITS_NUMBER_SHIFT	4
 #define	GITS_CTLR_ITS_NUMBER		(0xFU << GITS_CTLR_ITS_NUMBER_SHIFT)
 #define GITS_CTLR_QUIESCENT		(1U << 31)
-- 
2.11.0
