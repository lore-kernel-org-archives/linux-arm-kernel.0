From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jun 2012 18:53:01 +0200
Subject: [PATCH v2 4/8] arm: mach-mvebu: add support for Armada 370 and Armada
 XP with DT
In-Reply-To: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1339433585-28087-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ben.dooks at codethink.co.uk: ensure error check on of_property_read_u32]
[ben.dooks at codethink.co.uk: use mpic address instead of bus-unit's ]
[ben.dooks at codethink.co.uk: BUG_ON() if the of_iomap() fails for mpic]
[ben.dooks at codethink.co.uk: move mpic per-cpu register base ]
[ben.dooks at codethink.co.uk: number fetch should use irqd_to_hwirq()]

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/armada-370-db.dts              |   41 ++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |   66 ++++++
 arch/arm/boot/dts/armada-370.dtsi                |   29 +++
 arch/arm/boot/dts/armada-xp-db.dts               |   40 ++++
 arch/arm/boot/dts/armada-xp.dtsi                 |   49 +++++
 arch/arm/mach-mvebu/Kconfig                      |    7 +
 arch/arm/mach-mvebu/Makefile                     |    1 +
 arch/arm/mach-mvebu/armada-370-xp-dt.c           |   65 ++++++
 arch/arm/mach-mvebu/common.h                     |    4 +
 arch/arm/mach-mvebu/include/mach/armada-370-xp.h |   22 ++
 arch/arm/mach-mvebu/irq-armada-370-xp.c          |  130 ++++++++++++
 arch/arm/mach-mvebu/time-armada-370-xp.c         |  244 ++++++++++++++++++++++
 12 files changed, 698 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-db.dts
 create mode 100644 arch/arm/boot/dts/armada-370-xp.dtsi
 create mode 100644 arch/arm/boot/dts/armada-370.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-db.dts
 create mode 100644 arch/arm/boot/dts/armada-xp.dtsi
 create mode 100644 arch/arm/mach-mvebu/armada-370-xp-dt.c
 create mode 100644 arch/arm/mach-mvebu/include/mach/armada-370-xp.h
 create mode 100644 arch/arm/mach-mvebu/irq-armada-370-xp.c
 create mode 100644 arch/arm/mach-mvebu/time-armada-370-xp.c

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
new file mode 100644
index 0000000..f3cc991
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -0,0 +1,41 @@
+/*
+ * Device Tree file for Marvell Armada 370 evaluation board
+ * (DB-88F6710-BP-DDR3)
+ *
+ *  Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-370.dtsi"
+
+/ {
+	model = "Marvell Armada 370 Evaluation Board";
+	compatible = "marvell,a370-db", "marvell,armada370", "marvell,armada_370_xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <200000000>;
+		};
+		timer at d0020300 {
+			clock-frequency = <600000000>;
+
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
new file mode 100644
index 0000000..649ada1
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -0,0 +1,66 @@
+/*
+ * Device Tree Include file for Marvell Armada 370 and Armada XP SoC
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
+ *
+ * This file contains the definitions that are common to the Armada
+ * 370 and Armada XP SoC.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell Armada 370 and XP SoC";
+	compatible = "marvell,armada_370_xp";
+
+	cpus {
+		cpu at 0 {
+			compatible = "marvell,sheeva-v7";
+		};
+	};
+
+	mpic: interrupt-controller at d0020000 {
+	      compatible = "marvell,mpic";
+	      #interrupt-cells = <1>;
+	      #address-cells = <1>;
+	      #size-cells = <1>;
+	      interrupt-controller;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&mpic>;
+		ranges;
+
+		serial at d0012000 {
+				compatible = "ns16550";
+				reg = <0xd0012000 0x100>;
+				reg-shift = <2>;
+				interrupts = <41>;
+		};
+		serial at d0012100 {
+				compatible = "ns16550";
+				reg = <0xd0012100 0x100>;
+				reg-shift = <2>;
+				interrupts = <42>;
+		};
+
+		timer at d0020300 {
+			       compatible = "marvell,timer";
+			       reg = <0xd0020300 0x30>;
+			       interrupts = <37>, <38>, <39>, <40>;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
new file mode 100644
index 0000000..aefd345
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -0,0 +1,29 @@
+/*
+ * Device Tree Include file for Marvell Armada 370 family SoC
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Contains definitions specific to the Armada 370 SoC that are not
+ * common to all Armada SoCs.
+ */
+
+/include/ "armada-370-xp.dtsi"
+
+/ {
+	model = "Marvell Armada 370 family SoC";
+	compatible = "marvell,armada370", "marvell,armada";
+
+	mpic: interrupt-controller at d0020000 {
+	      reg = <0xd0020a00 0x1d0>,
+		    <0xd0021870 0x58>;
+	};
+
+ };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
new file mode 100644
index 0000000..7db3de2
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -0,0 +1,40 @@
+/*
+ * Device Tree file for Marvell Armada XP evaluation board
+ * (DB-78460-BP)
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-xp.dtsi"
+
+/ {
+	model = "Marvell Armada XP Evaluation Board";
+	compatible = "marvell,axp-db", "marvell,armadaxp", "marvell,armada_370_xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>; /* 2 GB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <250000000>;
+		};
+		serial at d0012100 {
+			clock-frequency = <250000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
new file mode 100644
index 0000000..ea624e0
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -0,0 +1,49 @@
+/*
+ * Device Tree Include file for Marvell Armada XP family SoC
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
+ *
+ * Contains definitions specific to the Armada 370 SoC that are not
+ * common to all Armada SoCs.
+ */
+
+/include/ "armada-370-xp.dtsi"
+
+/ {
+	model = "Marvell Armada XP family SoC";
+	compatible = "marvell,armadaxp", "marvell,armada_370_xp";
+
+	mpic: interrupt-controller at d0020000 {
+	      reg = <0xd0020a00 0x1d0>,
+		    <0xd0021870 0x58>;
+	};
+
+	soc {
+		serial at d0012200 {
+				compatible = "ns16550";
+				reg = <0xd0012200 0x100>;
+				reg-shift = <2>;
+				interrupts = <43>;
+		};
+		serial at d0012300 {
+				compatible = "ns16550";
+				reg = <0xd0012300 0x100>;
+				reg-shift = <2>;
+				interrupts = <44>;
+		};
+
+		timer at d0020300 {
+				marvell,timer-25Mhz;
+		};
+	};
+ };
+
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 72d39e5..ad2faa2 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -2,6 +2,13 @@ if ARCH_MVEBU
 
 menu "Marvell SOC with device tree"
 
+config MACH_ARMADA_370_XP_DT
+	bool "Marvell Armada 370 and Aramada XP boards with device-tree support"
+	help
+
+	  Say 'Y' here if you want your kernel to support boards based on
+	  Marvell Armada 370 or Armada XP with device tree.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index f95691b..f01b2c6 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1 +1,2 @@
 obj-y += common.o
+obj-$(CONFIG_MACH_ARMADA_370_XP_DT) += armada-370-xp-dt.o irq-armada-370-xp.o time-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp-dt.c b/arch/arm/mach-mvebu/armada-370-xp-dt.c
new file mode 100644
index 0000000..71b0cca
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada-370-xp-dt.c
@@ -0,0 +1,65 @@
+/*
+ * Device Tree support for Armada XP platforms.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <asm/mach/arch.h>
+#include <mach/mvebu.h>
+#include <mach/armada-370-xp.h>
+#include "common.h"
+
+#define SOFT_RESET_OUT_EN	0x1
+#define RSTOUTN_MASK_ADDR	(MVEBU_REGS_VIRT_BASE | \
+					ARMADA_370_XP_RSTOUTN_MASK_OFFSET)
+#define SOFT_RESET		0x1
+#define SYSTEM_SOFT_RESET_ADDR	(MVEBU_REGS_VIRT_BASE| \
+					ARMADA_370_XP_SYSTEM_SOFT_RESET_OFFSET)
+
+static void armada_370_xp_restart(char mode, const char *cmd)
+{
+	/*
+	* Enable soft reset to assert RSTOUTn.
+	*/
+	writel(SOFT_RESET_OUT_EN, RSTOUTN_MASK_ADDR);
+	/*
+	* Assert soft reset.
+	*/
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET_ADDR);
+	while (1)
+		;
+}
+
+static void __init armada_370_xp_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const armada_370_xp_dt_board_dt_compat[] = {
+	"marvell,a370-db",
+	"marvell,axp-db",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
+	.init_machine	= armada_370_xp_dt_init,
+	.map_io		= mvebu_map_io,
+	.init_irq	= armada_370_xp_init_irq,
+	.handle_irq     = armada_370_xp_handle_irq,
+	.timer		= &armada_370_xp_timer,
+	.restart	= armada_370_xp_restart,
+	.dt_compat	= armada_370_xp_dt_board_dt_compat,
+MACHINE_END
+
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 7bf0879..7917ab4 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -15,6 +15,10 @@
 #ifndef __ARCH_ARMADA_COMMON_H
 #define __ARCH_ARMADA_COMMON_H
 
+extern struct sys_timer armada_370_xp_timer;
+
 void mvebu_map_io(void);
+void armada_370_xp_init_irq(void);
+asmlinkage void  armada_370_xp_handle_irq(struct pt_regs *regs);
 
 #endif
diff --git a/arch/arm/mach-mvebu/include/mach/armada-370-xp.h b/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
new file mode 100644
index 0000000..e4fc9d4
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
@@ -0,0 +1,22 @@
+/*
+ * Generic definitions for Marvell Armada_370_Xp SoCs
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_ARMADA_370_XP_H
+#define __MACH_ARMADA_370_XP_H
+
+/* Misc registers */
+#define ARMADA_370_XP_RSTOUTN_MASK_OFFSET	0x18260
+#define ARMADA_370_XP_SYSTEM_SOFT_RESET_OFFSET	0x18264
+
+#endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
new file mode 100644
index 0000000..06604e3
--- /dev/null
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -0,0 +1,130 @@
+/*
+ * Marvall Armada 370 and Armada XP SoC IRQ handling
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
+#include <asm/exception.h>
+
+/* Interrupt Controller Registers Map */
+#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
+#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
+
+#define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
+#define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
+
+#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
+
+#define ARMADA_370_XP_NR_IRQS			(115)
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
+static int __init armada_370_xp_mpic_of_init(struct device_node *node,
+					     struct device_node *parent)
+{
+	main_int_base = of_iomap(node, 0);
+	per_cpu_int_base = of_iomap(node, 1);
+
+	BUG_ON(!main_int_base);
+	BUG_ON(!per_cpu_int_base);
+
+	armada_370_xp_mpic_domain =
+	    irq_domain_add_linear(node, ARMADA_370_XP_NR_IRQS,
+				  &armada_370_xp_mpic_irq_ops, NULL);
+
+	if (!armada_370_xp_mpic_domain)
+		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
+
+	irq_set_default_host(armada_370_xp_mpic_domain);
+	return 0;
+}
+
+asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
+							       *regs)
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
+static const struct of_device_id mpic_of_match[] __initconst = {
+	{.compatible = "marvell,mpic", .data = armada_370_xp_mpic_of_init},
+	{},
+};
+
+void __init armada_370_xp_init_irq(void)
+{
+	of_irq_init(mpic_of_match);
+}
diff --git a/arch/arm/mach-mvebu/time-armada-370-xp.c b/arch/arm/mach-mvebu/time-armada-370-xp.c
new file mode 100644
index 0000000..104b88a
--- /dev/null
+++ b/arch/arm/mach-mvebu/time-armada-370-xp.c
@@ -0,0 +1,244 @@
+/*
+ * Marvell Armada SoC timer handling.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Timer 0 is used as free-running clocksource, while timer 1 is
+ * used as clock_event_device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/irq.h>
+#include <asm/sched_clock.h>
+#include <asm/mach/time.h>
+
+/*
+ * Timer block registers.
+ */
+#define TIMER_CTRL_OFF		0x0000
+#define  TIMER0_EN		 0x0001
+#define  TIMER0_RELOAD_EN	 0x0002
+#define  TIMER0_25MHZ            0x0800
+#define  TIMER0_DIV(div)         ((div) << 19)
+#define  TIMER1_EN		 0x0004
+#define  TIMER1_RELOAD_EN	 0x0008
+#define  TIMER1_25MHZ            0x1000
+#define  TIMER1_DIV(div)         ((div) << 22)
+#define TIMER_EVENTS_STATUS	0x0004
+#define  TIMER0_CLR_MASK         (~0x1)
+#define  TIMER1_CLR_MASK         (~0x100)
+#define TIMER0_RELOAD_OFF	0x0010
+#define TIMER0_VAL_OFF		0x0014
+#define TIMER1_RELOAD_OFF	0x0018
+#define TIMER1_VAL_OFF		0x001c
+
+/* Global timers are connected to the coherency fabric clock, and the
+   below divider reduces their incrementing frequency. */
+#define TIMER_DIVIDER_SHIFT     5
+#define TIMER_DIVIDER           (1 << TIMER_DIVIDER_SHIFT)
+
+/*
+ * SoC-specific data.
+ */
+static void __iomem *timer_base;
+static int timer_irq;
+
+/*
+ * Number of timer ticks per jiffy.
+ */
+static u32 ticks_per_jiffy;
+
+static u32 notrace armada_370_xp_read_sched_clock(void)
+{
+	return ~readl(timer_base + TIMER0_VAL_OFF);
+}
+
+/*
+ * Clockevent handling.
+ */
+static int
+armada_370_xp_clkevt_next_event(unsigned long delta,
+				struct clock_event_device *dev)
+{
+	unsigned long flags;
+	u32 u;
+
+	if (delta == 0)
+		return -ETIME;
+
+	local_irq_save(flags);
+
+	/*
+	 * Clear clockevent timer interrupt.
+	 */
+	writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+
+	/*
+	 * Setup new clockevent timer value.
+	 */
+	writel(delta, timer_base + TIMER1_VAL_OFF);
+
+	/*
+	 * Enable the timer.
+	 */
+	u = readl(timer_base + TIMER_CTRL_OFF);
+	u = ((u & ~TIMER1_RELOAD_EN) | TIMER1_EN |
+	     TIMER1_DIV(TIMER_DIVIDER_SHIFT));
+	writel(u, timer_base + TIMER_CTRL_OFF);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static void
+armada_370_xp_clkevt_mode(enum clock_event_mode mode,
+			  struct clock_event_device *dev)
+{
+	unsigned long flags;
+	u32 u;
+
+	local_irq_save(flags);
+	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+		/*
+		 * Setup timer to fire@1/HZ intervals.
+		 */
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
+		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
+
+		/*
+		 * Enable timer.
+		 */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+
+		writel((u | TIMER1_EN | TIMER1_RELOAD_EN |
+			TIMER1_DIV(TIMER_DIVIDER_SHIFT)),
+		       timer_base + TIMER_CTRL_OFF);
+	} else {
+		/*
+		 * Disable timer.
+		 */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
+
+		/*
+		 * ACK pending timer interrupt.
+		 */
+		writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+
+	}
+	local_irq_restore(flags);
+}
+
+static struct clock_event_device armada_370_xp_clkevt = {
+	.name		= "armada_370_xp_tick",
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.shift		= 32,
+	.rating		= 300,
+	.set_next_event	= armada_370_xp_clkevt_next_event,
+	.set_mode	= armada_370_xp_clkevt_mode,
+};
+
+static irqreturn_t armada_370_xp_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * ACK timer interrupt and call event handler.
+	 */
+
+	writel(TIMER1_CLR_MASK, timer_base + TIMER_EVENTS_STATUS);
+	armada_370_xp_clkevt.event_handler(&armada_370_xp_clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction armada_370_xp_timer_irq = {
+	.name		= "armada_370_xp_tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= armada_370_xp_timer_interrupt
+};
+
+static void __init armada_370_xp_time_init(void)
+{
+	u32 u;
+	struct device_node *np;
+	unsigned int timer_clk;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,timer");
+	timer_base = of_iomap(np, 0);
+	WARN_ON(!timer_base);
+
+	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
+		/* The fixed 25MHz timer is available so let's use it */
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u | TIMER0_25MHZ | TIMER1_25MHZ,
+		       timer_base + TIMER_CTRL_OFF);
+		timer_clk = 25000000;
+	} else {
+		u32 clk = 0;
+		ret = of_property_read_u32(np, "clock-frequency", &clk);
+		WARN_ON(!clk || ret < 0);
+		u = readl(timer_base + TIMER_CTRL_OFF);
+		writel(u & ~(TIMER0_25MHZ | TIMER1_25MHZ),
+		       timer_base + TIMER_CTRL_OFF);
+		timer_clk = clk / TIMER_DIVIDER;
+	}
+
+	/* We use timer 0 as clocksource, and timer 1 for
+	   clockevents */
+	timer_irq = irq_of_parse_and_map(np, 1);
+
+	ticks_per_jiffy = (timer_clk + HZ / 2) / HZ;
+
+	/*
+	 * Set scale and timer for sched_clock.
+	 */
+	setup_sched_clock(armada_370_xp_read_sched_clock, 32, timer_clk);
+
+	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled).
+	 */
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+
+	u = readl(timer_base + TIMER_CTRL_OFF);
+
+	writel((u | TIMER0_EN | TIMER0_RELOAD_EN |
+		TIMER0_DIV(TIMER_DIVIDER_SHIFT)), timer_base + TIMER_CTRL_OFF);
+
+	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
+			      "armada_370_xp_clocksource",
+			      timer_clk, 300, 32, clocksource_mmio_readl_down);
+
+	/*
+	 * Setup clockevent timer (interrupt-driven).
+	 */
+	setup_irq(timer_irq, &armada_370_xp_timer_irq);
+	armada_370_xp_clkevt.mult = div_sc(timer_clk, NSEC_PER_SEC,
+					   armada_370_xp_clkevt.shift);
+	armada_370_xp_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
+							&armada_370_xp_clkevt);
+	armada_370_xp_clkevt.min_delta_ns =
+	    clockevent_delta2ns(1, &armada_370_xp_clkevt);
+	armada_370_xp_clkevt.cpumask = cpumask_of(0);
+	clockevents_register_device(&armada_370_xp_clkevt);
+}
+
+struct sys_timer armada_370_xp_timer = {
+	.init = armada_370_xp_time_init,
+};
-- 
1.7.9.5
