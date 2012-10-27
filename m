From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 18:45:16 +0200
Subject: [PATCH 3/3] arm: mvebu: move irq controller driver to drivers/irqchip
In-Reply-To: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351356317-16758-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    4 +-
 arch/arm/mach-mvebu/common.h                       |    3 -
 drivers/irqchip/Makefile                           |    1 +
 .../irqchip}/irq-armada-370-xp.c                   |   58 +++++++++-----------
 drivers/irqchip/irqchip.c                          |    3 +
 drivers/irqchip/irqchip.h                          |    2 +
 8 files changed, 36 insertions(+), 38 deletions(-)
 rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (87%)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 416d46e..415ed0f 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -9,6 +9,7 @@ config ARCH_MVEBU
 	select PINCTRL
 	select PLAT_ORION
 	select SPARSE_IRQ
+	select USE_IRQCHIP
 
 if ARCH_MVEBU
 
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 57f996b..7f4e9f4 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -2,4 +2,4 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
 obj-y += system-controller.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o addr-map.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 68f1483..9b28991 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/time-armada-370-xp.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -56,8 +57,7 @@ static const char * const armada_370_xp_dt_board_dt_compat[] = {
 DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
-	.init_irq	= armada_370_xp_init_irq,
-	.handle_irq     = armada_370_xp_handle_irq,
+	.init_irq	= irqchip_init,
 	.timer		= &armada_370_xp_timer,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_board_dt_compat,
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 02f89ea..f0eaa21 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -17,7 +17,4 @@
 
 void mvebu_restart(char mode, const char *cmd);
 
-void armada_370_xp_init_irq(void);
-void armada_370_xp_handle_irq(struct pt_regs *regs);
-
 #endif
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 77adcb1..d1a163c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_USE_IRQCHIP) += irqchip.o
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
+obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
similarity index 87%
rename from arch/arm/mach-mvebu/irq-armada-370-xp.c
rename to drivers/irqchip/irq-armada-370-xp.c
index 5f5f939..148a67c 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -23,6 +23,7 @@
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 /* Interrupt Controller Registers Map */
@@ -39,6 +40,27 @@ static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
 
+static asmlinkage void __exception_irq_entry
+armada_370_xp_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+
+	do {
+		irqstat = readl_relaxed(per_cpu_int_base +
+					ARMADA_370_XP_CPU_INTACK_OFFS);
+		irqnr = irqstat & 0x3FF;
+
+		if (irqnr < 1023) {
+			irqnr =
+			    irq_find_mapping(armada_370_xp_mpic_domain, irqnr);
+			handle_IRQ(irqnr, regs);
+			continue;
+		}
+
+		break;
+	} while (1);
+}
+
 static void armada_370_xp_irq_mask(struct irq_data *d)
 {
 	writel(irqd_to_hwirq(d),
@@ -77,8 +99,8 @@ static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static int __init armada_370_xp_mpic_of_init(struct device_node *node,
-					     struct device_node *parent)
+int __init armada_370_xp_mpic_of_init(struct device_node *node,
+				      struct device_node *parent)
 {
 	u32 control;
 
@@ -98,36 +120,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
 
 	irq_set_default_host(armada_370_xp_mpic_domain);
-	return 0;
-}
 
-asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
-							       *regs)
-{
-	u32 irqstat, irqnr;
-
-	do {
-		irqstat = readl_relaxed(per_cpu_int_base +
-					ARMADA_370_XP_CPU_INTACK_OFFS);
-		irqnr = irqstat & 0x3FF;
+	handle_arch_irq = armada_370_xp_handle_irq;
 
-		if (irqnr < 1023) {
-			irqnr =
-			    irq_find_mapping(armada_370_xp_mpic_domain, irqnr);
-			handle_IRQ(irqnr, regs);
-			continue;
-		}
-
-		break;
-	} while (1);
-}
-
-static const struct of_device_id mpic_of_match[] __initconst = {
-	{.compatible = "marvell,mpic", .data = armada_370_xp_mpic_of_init},
-	{},
-};
-
-void __init armada_370_xp_init_irq(void)
-{
-	of_irq_init(mpic_of_match);
+	return 0;
 }
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index f01cf6e..f8fbf00 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -17,6 +17,9 @@ static const struct of_device_id irqchip_of_match[] __initconst = {
 #ifdef CONFIG_ARCH_BCM2835
 	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init },
 #endif
+#ifdef CONFIG_ARCH_MVEBU
+	{.compatible = "marvell,mpic", .data = armada_370_xp_mpic_of_init },
+#endif
 	{},
 };
 
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
index 0e68965..a961ca9 100644
--- a/drivers/irqchip/irqchip.h
+++ b/drivers/irqchip/irqchip.h
@@ -12,5 +12,7 @@
 #define _IRQCHIP_H
 
 int armctrl_of_init(struct device_node *node, struct device_node *parent);
+int armada_370_xp_mpic_of_init(struct device_node *node,
+			       struct device_node *parent);
 
 #endif
-- 
1.7.9.5
