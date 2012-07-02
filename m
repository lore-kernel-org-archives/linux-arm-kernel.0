From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  2 Jul 2012 13:33:24 +0200
Subject: [PATCH 4/9] arm: mach-mvebu: add support for Armada 370 and Armada XP
 with DT
In-Reply-To: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1341228809-17824-5-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/armada-370-db.dts              |   42 +++++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |   68 +++++++++++
 arch/arm/boot/dts/armada-370.dtsi                |   35 ++++++
 arch/arm/boot/dts/armada-xp-db.dts               |   50 +++++++++
 arch/arm/boot/dts/armada-xp.dtsi                 |   55 +++++++++
 arch/arm/mach-mvebu/Kconfig                      |    9 ++
 arch/arm/mach-mvebu/Makefile                     |    1 +
 arch/arm/mach-mvebu/armada-370-xp.c              |   63 +++++++++++
 arch/arm/mach-mvebu/common.h                     |    3 +
 arch/arm/mach-mvebu/include/mach/armada-370-xp.h |   22 ++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c          |  130 ++++++++++++++++++++++
 11 files changed, 478 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-db.dts
 create mode 100644 arch/arm/boot/dts/armada-370-xp.dtsi
 create mode 100644 arch/arm/boot/dts/armada-370.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-db.dts
 create mode 100644 arch/arm/boot/dts/armada-xp.dtsi
 create mode 100644 arch/arm/mach-mvebu/armada-370-xp.c
 create mode 100644 arch/arm/mach-mvebu/include/mach/armada-370-xp.h
 create mode 100644 arch/arm/mach-mvebu/irq-armada-370-xp.c

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
new file mode 100644
index 0000000..fffd5c2
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -0,0 +1,42 @@
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
+	compatible = "marvell,a370-db", "marvell,armada370", "marvell,armada-370-xp";
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
+			status = "okay";
+		};
+		timer at d0020300 {
+			clock-frequency = <600000000>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
new file mode 100644
index 0000000..9b55f01
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -0,0 +1,68 @@
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
+				status = "disabled";
+		};
+		serial at d0012100 {
+				compatible = "ns16550";
+				reg = <0xd0012100 0x100>;
+				reg-shift = <2>;
+				interrupts = <42>;
+				status = "disabled";
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
index 0000000..3228ccc
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -0,0 +1,35 @@
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
+	compatible = "marvell,armada370", "marvell,armada-370-xp";
+
+	mpic: interrupt-controller at d0020000 {
+	      reg = <0xd0020a00 0x1d0>,
+		    <0xd0021870 0x58>;
+	};
+
+	soc {
+		system-controller at d0018200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0xd0018200 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
new file mode 100644
index 0000000..f97040d
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -0,0 +1,50 @@
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
+	compatible = "marvell,axp-db", "marvell,armadaxp", "marvell,armada-370-xp";
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
+			status = "okay";
+		};
+		serial at d0012100 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+		serial at d0012200 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+		serial at d0012300 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
new file mode 100644
index 0000000..e1fa7e6
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -0,0 +1,55 @@
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
+	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
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
+				status = "disabled";
+		};
+		serial at d0012300 {
+				compatible = "ns16550";
+				reg = <0xd0012300 0x100>;
+				reg-shift = <2>;
+				interrupts = <44>;
+				status = "disabled";
+		};
+
+		timer at d0020300 {
+				marvell,timer-25Mhz;
+		};
+
+		system-controller at d0018200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0xd0018200 0x500>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 72d39e5..caa2c5e 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -2,6 +2,15 @@ if ARCH_MVEBU
 
 menu "Marvell SOC with device tree"
 
+config MACH_ARMADA_370_XP
+	bool "Marvell Armada 370 and Aramada XP boards"
+	select ARMADA_370_XP_TIMER
+	select CPU_V7
+	help
+
+	  Say 'Y' here if you want your kernel to support boards based on
+	  Marvell Armada 370 or Armada XP with device tree.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 7366ae7..e61d2b8 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1 +1,2 @@
 obj-y += system-controller.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
new file mode 100644
index 0000000..4ef923b
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -0,0 +1,63 @@
+/*
+ * Device Tree support for Armada 370 and XP platforms.
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
+#include <linux/time-armada-370-xp.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <mach/armada-370-xp.h>
+#include "common.h"
+
+static struct map_desc armada_370_xp_io_desc[] __initdata = {
+	{
+		.virtual	= ARMADA_370_XP_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(ARMADA_370_XP_REGS_PHYS_BASE),
+		.length		= ARMADA_370_XP_REGS_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+void __init armada_370_xp_map_io(void)
+{
+	iotable_init(armada_370_xp_io_desc, ARRAY_SIZE(armada_370_xp_io_desc));
+}
+
+struct sys_timer armada_370_xp_timer = {
+	.init		= armada_370_xp_timer_init,
+};
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
+	.map_io		= armada_370_xp_map_io,
+	.init_irq	= armada_370_xp_init_irq,
+	.handle_irq     = armada_370_xp_handle_irq,
+	.timer		= &armada_370_xp_timer,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_370_xp_dt_board_dt_compat,
+MACHINE_END
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index f0eaa21..02f89ea 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -17,4 +17,7 @@
 
 void mvebu_restart(char mode, const char *cmd);
 
+void armada_370_xp_init_irq(void);
+void armada_370_xp_handle_irq(struct pt_regs *regs);
+
 #endif
diff --git a/arch/arm/mach-mvebu/include/mach/armada-370-xp.h b/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
new file mode 100644
index 0000000..25f0ca8
--- /dev/null
+++ b/arch/arm/mach-mvebu/include/mach/armada-370-xp.h
@@ -0,0 +1,22 @@
+/*
+ * Generic definitions for Marvell Armada_370_XP SoCs
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
+#define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
+#define ARMADA_370_XP_REGS_VIRT_BASE	0xfeb00000
+#define ARMADA_370_XP_REGS_SIZE		SZ_1M
+
+#endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
new file mode 100644
index 0000000..645a8d3
--- /dev/null
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
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
-- 
1.7.9.5
