From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:41 +0200
Subject: [PATCH v2 37/38] ARM: orion: remove no longer needed DT IRQ code
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-38-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the move of the Orion5x Device Tree support to use
irqchip_init() for the interrupt controller probing, the
plat-orion/irq.c code for DT-probing of the interrupt controller is no
longer necessary, so we can get rid of it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/include/plat/irq.h |  1 -
 arch/arm/plat-orion/irq.c              | 32 --------------------------------
 2 files changed, 33 deletions(-)

diff --git a/arch/arm/plat-orion/include/plat/irq.h b/arch/arm/plat-orion/include/plat/irq.h
index 50547e4..96be19e 100644
--- a/arch/arm/plat-orion/include/plat/irq.h
+++ b/arch/arm/plat-orion/include/plat/irq.h
@@ -12,5 +12,4 @@
 #define __PLAT_IRQ_H
 
 void orion_irq_init(unsigned int irq_start, void __iomem *maskaddr);
-void __init orion_dt_init_irq(void);
 #endif
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 27ec18b..8c1fc06 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -38,35 +38,3 @@ void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 }
-
-#ifdef CONFIG_OF
-static int __init orion_add_irq_domain(struct device_node *np,
-				       struct device_node *interrupt_parent)
-{
-	int i = 0;
-	void __iomem *base;
-
-	do {
-		base = of_iomap(np, i);
-		if (base) {
-			orion_irq_init(i * 32, base + 0x04);
-			i++;
-		}
-	} while (base);
-
-	irq_domain_add_legacy(np, i * 32, 0, 0,
-			      &irq_domain_simple_ops, NULL);
-	return 0;
-}
-
-static const struct of_device_id orion_irq_match[] = {
-	{ .compatible = "marvell,orion-intc",
-	  .data = orion_add_irq_domain, },
-	{},
-};
-
-void __init orion_dt_init_irq(void)
-{
-	of_irq_init(orion_irq_match);
-}
-#endif
-- 
1.9.2
