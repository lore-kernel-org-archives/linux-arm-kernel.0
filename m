From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 15 Jul 2015 15:38:29 +0100
Subject: [PATCH 2/2] irqchip: gic: remove reduntant gic_set_irqchip_flags
In-Reply-To: <1436971109-20189-1-git-send-email-sudeep.holla@arm.com>
References: <1436971109-20189-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1436971109-20189-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the GIC chip implementation enables IRQCHIP_SKIP_SET_WAKE and
IRQCHIP_MASK_ON_SUSPEND by default, the platforms requiring them need
not override the irqchip flags as before.

This patch removes all the users of gic_set_irqchip_flags and the
function itself.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-shmobile/intc-sh73a0.c   | 1 -
 arch/arm/mach-shmobile/setup-r8a7779.c | 1 -
 arch/arm/mach-ux500/cpu.c              | 1 -
 arch/arm/mach-zynq/common.c            | 1 -
 drivers/irqchip/irq-gic.c              | 5 -----
 include/linux/irqchip/arm-gic.h        | 1 -
 6 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index fd63ae6532fc..151a71a41fe3 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -313,7 +313,6 @@ void __init sh73a0_init_irq(void)
 	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
-	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE);
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 
 	register_intc_controller(&intcs_desc);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index c03e562be12b..aea5cff9495d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -719,7 +719,6 @@ void __init r8a7779_init_irq_dt(void)
 	void __iomem *gic_dist_base = ioremap_nocache(0xf0001000, 0x1000);
 	void __iomem *gic_cpu_base = ioremap_nocache(0xf0000100, 0x1000);
 #endif
-	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE);
 
 #ifdef CONFIG_ARCH_SHMOBILE_LEGACY
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e31d3d61c998..6cb10c77afd8 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -56,7 +56,6 @@ void __init ux500_init_irq(void)
 	struct device_node *np;
 	struct resource r;
 
-	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 	np = of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
 	of_address_to_resource(np, 0, &r);
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 616d5840fc2e..2ad1accfba35 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -186,7 +186,6 @@ static void __init zynq_map_io(void)
 
 static void __init zynq_irq_init(void)
 {
-	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index eda24604a0f3..d1fe884d770e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -882,11 +882,6 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
-void gic_set_irqchip_flags(unsigned long flags)
-{
-	gic_chip.flags |= flags;
-}
-
 void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
 			   u32 percpu_offset, struct device_node *node)
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 9de976b4f9a7..61a2007eb49a 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -95,7 +95,6 @@
 
 struct device_node;
 
-void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
-- 
1.9.1
