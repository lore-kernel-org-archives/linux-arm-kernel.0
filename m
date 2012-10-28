From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 10:30:33 +0100
Subject: [PATCH v2 3/4] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351416634-3352-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drivers/irqchip/ directory has a minimal infrastructure
to support the addition of irq controller driver, we move the irq
controller driver for Armada 370 and Armada XP ARM SoCs from the
arch/arm/mach-mvebu/ directory to the drivers/irqchip/ directory and
update the irqchip infrastructure to take into account this new
driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig             |    1 +
 arch/arm/mach-mvebu/Makefile            |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c     |    4 +-
 arch/arm/mach-mvebu/common.h            |    3 -
 arch/arm/mach-mvebu/irq-armada-370-xp.c |  133 -------------------------------
 drivers/irqchip/Makefile                |    1 +
 drivers/irqchip/irq-armada-370-xp.c     |  130 ++++++++++++++++++++++++++++++
 drivers/irqchip/irqchip.c               |    6 ++
 drivers/irqchip/irqchip.h               |    2 +
 9 files changed, 143 insertions(+), 139 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/irq-armada-370-xp.c
 create mode 100644 drivers/irqchip/irq-armada-370-xp.c

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
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
deleted file mode 100644
index 5f5f939..0000000
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * Marvell Armada 370 and Armada XP SoC IRQ handling
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- * Gregory CLEMENT <gregory.clement@free-electrons.com>
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- * Ben Dooks <ben.dooks@codethink.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/irqdomain.h>
-#include <asm/mach/arch.h>
-#include <asm/exception.h>
-
-/* Interrupt Controller Registers Map */
-#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
-#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
-
-#define ARMADA_370_XP_INT_CONTROL		(0x00)
-#define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
-#define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
-
-#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
-
-static void __iomem *per_cpu_int_base;
-static void __iomem *main_int_base;
-static struct irq_domain *armada_370_xp_mpic_domain;
-
-static void armada_370_xp_irq_mask(struct irq_data *d)
-{
-	writel(irqd_to_hwirq(d),
-	       per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
-}
-
-static void armada_370_xp_irq_unmask(struct irq_data *d)
-{
-	writel(irqd_to_hwirq(d),
-	       per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-}
-
-static struct irq_chip armada_370_xp_irq_chip = {
-	.name		= "armada_370_xp_irq",
-	.irq_mask       = armada_370_xp_irq_mask,
-	.irq_mask_ack   = armada_370_xp_irq_mask,
-	.irq_unmask     = armada_370_xp_irq_unmask,
-};
-
-static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-				      unsigned int virq, irq_hw_number_t hw)
-{
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
-
-	irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-				 handle_level_irq);
-	irq_set_status_flags(virq, IRQ_LEVEL);
-	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
-
-	return 0;
-}
-
-static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
-	.map = armada_370_xp_mpic_irq_map,
-	.xlate = irq_domain_xlate_onecell,
-};
-
-static int __init armada_370_xp_mpic_of_init(struct device_node *node,
-					     struct device_node *parent)
-{
-	u32 control;
-
-	main_int_base = of_iomap(node, 0);
-	per_cpu_int_base = of_iomap(node, 1);
-
-	BUG_ON(!main_int_base);
-	BUG_ON(!per_cpu_int_base);
-
-	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
-
-	armada_370_xp_mpic_domain =
-	    irq_domain_add_linear(node, (control >> 2) & 0x3ff,
-				  &armada_370_xp_mpic_irq_ops, NULL);
-
-	if (!armada_370_xp_mpic_domain)
-		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
-
-	irq_set_default_host(armada_370_xp_mpic_domain);
-	return 0;
-}
-
-asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
-							       *regs)
-{
-	u32 irqstat, irqnr;
-
-	do {
-		irqstat = readl_relaxed(per_cpu_int_base +
-					ARMADA_370_XP_CPU_INTACK_OFFS);
-		irqnr = irqstat & 0x3FF;
-
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
-}
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 77adcb1..d1a163c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_USE_IRQCHIP) += irqchip.o
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
+obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
new file mode 100644
index 0000000..140c6b3
--- /dev/null
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -0,0 +1,130 @@
+/*
+ * Marvell Armada 370 and Armada XP SoC IRQ handling
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ * Ben Dooks <ben.dooks@codethink.co.uk>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
+#include <asm/exception.h>
+
+/* Interrupt Controller Registers Map */
+#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
+#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
+
+#define ARMADA_370_XP_INT_CONTROL		(0x00)
+#define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
+#define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
+
+#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
+
+static void __iomem *per_cpu_int_base;
+static void __iomem *main_int_base;
+static struct irq_domain *armada_370_xp_mpic_domain;
+
+static void armada_370_xp_irq_mask(struct irq_data *d)
+{
+	writel(irqd_to_hwirq(d),
+	       per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
+}
+
+static void armada_370_xp_irq_unmask(struct irq_data *d)
+{
+	writel(irqd_to_hwirq(d),
+	       per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+}
+
+static struct irq_chip armada_370_xp_irq_chip = {
+	.name		= "armada_370_xp_irq",
+	.irq_mask       = armada_370_xp_irq_mask,
+	.irq_mask_ack   = armada_370_xp_irq_mask,
+	.irq_unmask     = armada_370_xp_irq_unmask,
+};
+
+static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
+				      unsigned int virq, irq_hw_number_t hw)
+{
+	armada_370_xp_irq_mask(irq_get_irq_data(virq));
+	writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+
+	irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+				 handle_level_irq);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
+	.map = armada_370_xp_mpic_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static asmlinkage void
+armada_370_xp_handle_irq(struct pt_regs *regs);
+
+int __init armada_370_xp_mpic_of_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	u32 control;
+
+	main_int_base = of_iomap(node, 0);
+	per_cpu_int_base = of_iomap(node, 1);
+
+	BUG_ON(!main_int_base);
+	BUG_ON(!per_cpu_int_base);
+
+	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+
+	armada_370_xp_mpic_domain =
+	    irq_domain_add_linear(node, (control >> 2) & 0x3ff,
+				  &armada_370_xp_mpic_irq_ops, NULL);
+
+	if (!armada_370_xp_mpic_domain)
+		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
+
+	irq_set_default_host(armada_370_xp_mpic_domain);
+
+	handle_arch_irq = armada_370_xp_handle_irq;
+
+	return 0;
+}
+
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
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index e2496e4..f36d423 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -20,6 +20,12 @@ static const struct of_device_id irqchip_of_match[] __initconst = {
 		.data = bcm2835_irqchip_init,
 	},
 #endif
+#ifdef CONFIG_ARCH_MVEBU
+	{
+		.compatible = "marvell,mpic",
+		.data = armada_370_xp_mpic_of_init,
+	},
+#endif
 	{},
 };
 
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
index 1075537..0a0d7af 100644
--- a/drivers/irqchip/irqchip.h
+++ b/drivers/irqchip/irqchip.h
@@ -12,5 +12,7 @@
 #define _IRQCHIP_H
 
 int bcm2835_irqchip_init(struct device_node *node, struct device_node *parent);
+int armada_370_xp_mpic_of_init(struct device_node *node,
+			       struct device_node *parent);
 
 #endif
-- 
1.7.9.5
