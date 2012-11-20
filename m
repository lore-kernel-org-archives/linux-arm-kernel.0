From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:07 +0100
Subject: [PATCH 16/16] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the Versatile FPGA interrupt controller driver, used in
the Integrator/AP, Integrator/CP and some Versatile boards, out
of arch/arm/plat-versatile and down to drivers/irqchip where we
have consensus that such drivers belong. The header file is
consequently moved to <linux/platform_data/irq-versatile-fpga.h>.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/mach-integrator/integrator_ap.c           |   12 +---
 arch/arm/mach-integrator/integrator_cp.c           |   11 +---
 arch/arm/mach-versatile/core.c                     |    2 +-
 arch/arm/plat-versatile/Kconfig                    |    9 ---
 arch/arm/plat-versatile/Makefile                   |    1 -
 drivers/irqchip/Kconfig                            |    9 +++
 drivers/irqchip/Makefile                           |    1 +
 .../irqchip/irq-versatile-fpga.c                   |   60 ++++++++++----------
 .../linux/irqchip/versatile-fpga.h                 |    2 -
 10 files changed, 49 insertions(+), 62 deletions(-)
 rename arch/arm/plat-versatile/fpga-irq.c => drivers/irqchip/irq-versatile-fpga.c (83%)
 rename arch/arm/plat-versatile/include/plat/fpga-irq.h => include/linux/irqchip/versatile-fpga.h (73%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..22b7ac7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -284,8 +284,8 @@ config ARCH_INTEGRATOR
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_FPGA_IRQ
 	select SPARSE_IRQ
+	select VERSATILE_FPGA_IRQ
 	help
 	  Support for ARM's Integrator platform.
 
@@ -318,7 +318,7 @@ config ARCH_VERSATILE
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
 	select PLAT_VERSATILE_CLOCK
-	select PLAT_VERSATILE_FPGA_IRQ
+	select VERSATILE_FPGA_IRQ
 	help
 	  This enables support for ARM Ltd Versatile board.
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index e6617c1..28649ac 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -31,6 +32,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irqchip/versatile-fpga.h>
 #include <linux/mtd/physmap.h>
 #include <linux/clk.h>
 #include <linux/platform_data/clk-integrator.h>
@@ -56,8 +58,6 @@
 #include <asm/mach/pci.h>
 #include <asm/mach/time.h>
 
-#include <plat/fpga-irq.h>
-
 #include "common.h"
 
 /* 
@@ -432,16 +432,11 @@ static struct sys_timer ap_of_timer = {
 	.init		= ap_init_timer_of,
 };
 
-static const struct of_device_id fpga_irq_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
-	{ /* Sentinel */ }
-};
-
 static void __init ap_init_irq_of(void)
 {
 	/* disable core module IRQs */
 	writel(0xffffffffU, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
-	of_irq_init(fpga_irq_of_match);
+	irqchip_init();
 	integrator_clk_init(false);
 }
 
@@ -502,7 +497,6 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.nr_irqs	= NR_IRQS_INTEGRATOR_AP,
 	.init_early	= ap_init_early,
 	.init_irq	= ap_init_irq_of,
-	.handle_irq	= fpga_handle_irq,
 	.timer		= &ap_of_timer,
 	.init_machine	= ap_init_of,
 	.restart	= integrator_restart,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 5b08e8e..64d1b57 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -20,6 +21,7 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
+#include <linux/irqchip/versatile-fpga.h>
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/clk-integrator.h>
@@ -46,7 +48,6 @@
 #include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
-#include <plat/fpga-irq.h>
 #include <plat/sched_clock.h>
 
 #include "common.h"
@@ -299,14 +300,9 @@ static struct sys_timer cp_of_timer = {
 	.init		= intcp_timer_init_of,
 };
 
-static const struct of_device_id fpga_irq_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
-	{ /* Sentinel */ }
-};
-
 static void __init intcp_init_irq_of(void)
 {
-	of_irq_init(fpga_irq_of_match);
+	irqchip_init();
 	integrator_clk_init(true);
 }
 
@@ -353,7 +349,6 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.nr_irqs	= NR_IRQS_INTEGRATOR_CP,
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq_of,
-	.handle_irq	= fpga_handle_irq,
 	.timer		= &cp_of_timer,
 	.init_machine	= intcp_init_of,
 	.restart	= integrator_restart,
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 5b5c1ee..5d59294 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -32,6 +32,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/irqchip/versatile-fpga.h>
 #include <linux/gfp.h>
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
@@ -51,7 +52,6 @@
 #include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
-#include <plat/fpga-irq.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 2a4ae8a..619f0fa 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -6,15 +6,6 @@ config PLAT_VERSATILE_CLOCK
 config PLAT_VERSATILE_CLCD
 	bool
 
-config PLAT_VERSATILE_FPGA_IRQ
-	bool
-	select IRQ_DOMAIN
-
-config PLAT_VERSATILE_FPGA_IRQ_NR
-       int
-       default 4
-       depends on PLAT_VERSATILE_FPGA_IRQ
-
 config PLAT_VERSATILE_LEDS
 	def_bool y if NEW_LEDS
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 74cfd94..f88d448 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -2,7 +2,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
-obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d80e5c7..a774cd3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -24,3 +24,12 @@ config ARM_VIC_NR
 	help
 	  The maximum number of VICs available in the system, for
 	  power management.
+
+config VERSATILE_FPGA_IRQ
+	bool
+	select IRQ_DOMAIN
+
+config VERSATILE_FPGA_IRQ_NR
+	int
+	default 4
+	depends on VERSATILE_FPGA_IRQ
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 9c7f91e..476a5e4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
 obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o
 obj-$(CONFIG_ARM_GIC)   += irq-gic.o
 obj-$(CONFIG_ARM_VIC)   += irq-vic.o
+obj-$(CONFIG_VERSATILE_FPGA_IRQ) += irq-versatile-fpga.o
diff --git a/arch/arm/plat-versatile/fpga-irq.c b/drivers/irqchip/irq-versatile-fpga.c
similarity index 83%
rename from arch/arm/plat-versatile/fpga-irq.c
rename to drivers/irqchip/irq-versatile-fpga.c
index 091ae10..3c48946 100644
--- a/arch/arm/plat-versatile/fpga-irq.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -1,8 +1,10 @@
 /*
  *  Support for Versatile FPGA-based IRQ controllers
  */
+#include <linux/bitops.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -10,7 +12,8 @@
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
-#include <plat/fpga-irq.h>
+
+#include "irqchip.h"
 
 #define IRQ_STATUS		0x00
 #define IRQ_RAW_STATUS		0x04
@@ -41,7 +44,7 @@ struct fpga_irq_data {
 };
 
 /* we cannot allocate memory when the controllers are initially registered */
-static struct fpga_irq_data fpga_irq_devices[CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR];
+static struct fpga_irq_data fpga_irq_devices[CONFIG_VERSATILE_FPGA_IRQ_NR];
 static int fpga_irq_id;
 
 static void fpga_irq_mask(struct irq_data *d)
@@ -117,13 +120,12 @@ static int fpga_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	struct fpga_irq_data *f = d->host_data;
 
 	/* Skip invalid IRQs, only register handlers for the real ones */
-	if (!(f->valid & (1 << hwirq)))
+	if (!(f->valid & BIT(hwirq)))
 		return -ENOTSUPP;
 	irq_set_chip_data(irq, f);
 	irq_set_chip_and_handler(irq, &f->chip,
 				handle_level_irq);
 	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	f->used_irqs++;
 	return 0;
 }
 
@@ -132,13 +134,15 @@ static struct irq_domain_ops fpga_irqdomain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static __init struct fpga_irq_data *
-fpga_irq_prep_struct(void __iomem *base, const char *name, u32 valid) {
+void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
+			  int parent_irq, u32 valid, struct device_node *node)
+{
 	struct fpga_irq_data *f;
+	int i;
 
 	if (fpga_irq_id >= ARRAY_SIZE(fpga_irq_devices)) {
-		printk(KERN_ERR "%s: too few FPGA IRQ controllers, increase CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR\n", __func__);
-		return NULL;
+		pr_err("%s: too few FPGA IRQ controllers, increase CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR\n", __func__);
+		return;
 	}
 	f = &fpga_irq_devices[fpga_irq_id];
 	f->base = base;
@@ -147,29 +151,28 @@ fpga_irq_prep_struct(void __iomem *base, const char *name, u32 valid) {
 	f->chip.irq_mask = fpga_irq_mask;
 	f->chip.irq_unmask = fpga_irq_unmask;
 	f->valid = valid;
-	fpga_irq_id++;
-
-	return f;
-}
-
-void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
-			  int parent_irq, u32 valid, struct device_node *node)
-{
-	struct fpga_irq_data *f;
-
-	f = fpga_irq_prep_struct(base, name, valid);
-	if (!f)
-		return;
 
 	if (parent_irq != -1) {
 		irq_set_handler_data(parent_irq, f);
 		irq_set_chained_handler(parent_irq, fpga_irq_handle);
 	}
 
-	f->domain = irq_domain_add_legacy(node, fls(valid), irq_start, 0,
+	/* This will also allocate irq descriptors */
+	f->domain = irq_domain_add_simple(node, fls(valid), irq_start,
 					  &fpga_irqdomain_ops, f);
+
+	/* This will allocate all valid descriptors in the linear case */
+	for (i = 0; i < fls(valid); i++)
+		if (valid & BIT(i)) {
+			if (!irq_start)
+				irq_create_mapping(f->domain, i);
+			f->used_irqs++;
+		}
+
 	pr_info("FPGA IRQ chip %d \"%s\" @ %p, %u irqs\n",
 		fpga_irq_id, name, base, f->used_irqs);
+
+	fpga_irq_id++;
 }
 
 #ifdef CONFIG_OF
@@ -193,18 +196,15 @@ int __init fpga_irq_of_init(struct device_node *node,
 	if (of_property_read_u32(node, "valid-mask", &valid_mask))
 		valid_mask = 0;
 
-	f = fpga_irq_prep_struct(base, node->name, valid_mask);
-	if (!f)
-		return -ENOMEM;
+	fpga_irq_init(base, node->name, 0, -1, valid_mask, node);
 
 	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
 	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
 
-	f->domain = irq_domain_add_linear(node, fls(valid_mask), &fpga_irqdomain_ops, f);
-	f->used_irqs = hweight32(valid_mask);
-
-	pr_info("FPGA IRQ chip %d \"%s\" @ %p, %u irqs\n",
-		fpga_irq_id, node->name, base, f->used_irqs);
 	return 0;
 }
+
+IRQCHIP_DECLARE(versatile_fpga_irq, "arm,versatile-fpga-irq",
+		fpga_irq_of_init);
+
 #endif
diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/include/linux/irqchip/versatile-fpga.h
similarity index 73%
rename from arch/arm/plat-versatile/include/plat/fpga-irq.h
rename to include/linux/irqchip/versatile-fpga.h
index 1fac965..91bcfb6 100644
--- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
+++ b/include/linux/irqchip/versatile-fpga.h
@@ -7,7 +7,5 @@ struct pt_regs;
 void fpga_handle_irq(struct pt_regs *regs);
 void fpga_irq_init(void __iomem *, const char *, int, int, u32,
 		struct device_node *node);
-int fpga_irq_of_init(struct device_node *node,
-		     struct device_node *parent);
 
 #endif
-- 
1.7.9.5
