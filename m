From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Nov 2012 15:59:27 +0100
Subject: [PATCH V6 2/5] arm: mvebu: Add initial support for power managmement
 service unit
In-Reply-To: <1353509970-5237-1-git-send-email-gregory.clement@free-electrons.com>
References: <1353509970-5237-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1353509970-5237-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP SOCs have a power management service unit
which is responsible for powering down and waking up CPUs and other
SOC units. This patch adds support for this unit.

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 ++++++
 arch/arm/boot/dts/armada-xp.dtsi                   |    6 ++
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/common.h                       |    1 +
 arch/arm/mach-mvebu/pmsu.c                         |   75 ++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   16 +++++
 6 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
 create mode 100644 arch/arm/mach-mvebu/pmsu.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.h

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
new file mode 100644
index 0000000..926b4d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -0,0 +1,20 @@
+Power Management Service Unit(PMSU)
+-----------------------------------
+Available on Marvell SOCs: Armada 370 and Armada XP
+
+Required properties:
+
+- compatible: "marvell,armada-370-xp-pmsu"
+
+- reg: Should contain PMSU registers location and length. First pair
+  for the per-CPU SW Reset Control registers, second pair for the
+  Power Management Service Unit.
+
+Example:
+
+armada-370-xp-pmsu at d0022000 {
+	compatible = "marvell,armada-370-xp-pmsu";
+	reg = <0xd0022100 0x430>,
+	      <0xd0020800 0x20>;
+};
+
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index f51554e..1f95e22 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -27,6 +27,12 @@
 		    <0xd0021870 0x58>;
 	};
 
+	armada-370-xp-pmsu at d0022000 {
+		compatible = "marvell,armada-370-xp-pmsu";
+		reg = <0xd0022100 0x430>,
+		      <0xd0020800 0x20>;
+	};
+
 	soc {
 		serial at d0012200 {
 				compatible = "ns16550";
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 5ce4b42..2e3ec11 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -2,4 +2,4 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
 obj-y += system-controller.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index ba6b62a..9285d04 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -21,4 +21,5 @@ void armada_370_xp_init_irq(void);
 void armada_370_xp_handle_irq(struct pt_regs *regs);
 
 int armada_370_xp_coherency_init(void);
+int armada_370_xp_pmsu_init(void);
 #endif
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
new file mode 100644
index 0000000..3cc4bef
--- /dev/null
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -0,0 +1,75 @@
+/*
+ * Power Management Service Unit(PMSU) support for Armada 370/XP platforms.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory Clement <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The Armada 370 and Armada XP SOCs have a power management service
+ * unit which is responsible for powering down and waking up CPUs and
+ * other SOC units
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/smp.h>
+#include <asm/smp_plat.h>
+
+static void __iomem *pmsu_mp_base;
+static void __iomem *pmsu_reset_base;
+
+#define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
+#define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
+
+static struct of_device_id of_pmsu_table[] = {
+	{.compatible = "marvell,armada-370-xp-pmsu"},
+	{ /* end of list */ },
+};
+
+#ifdef CONFIG_SMP
+int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
+{
+	int reg, hw_cpu;
+
+	if (!pmsu_mp_base || !pmsu_reset_base) {
+		pr_warn("Can't boot CPU. PMSU is uninitialized\n");
+		return 1;
+	}
+
+	hw_cpu = cpu_logical_map(cpu_id);
+
+	writel(virt_to_phys(boot_addr), pmsu_mp_base +
+			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+
+	/* Release CPU from reset by clearing reset bit*/
+	reg = readl(pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
+	reg &= (~0x1);
+	writel(reg, pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
+
+	return 0;
+}
+#endif
+
+int __init armada_370_xp_pmsu_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, of_pmsu_table);
+	if (np) {
+		pr_info("Initializing Power Management Service Unit\n");
+		pmsu_mp_base = of_iomap(np, 0);
+		pmsu_reset_base = of_iomap(np, 1);
+	}
+
+	return 0;
+}
+
+early_initcall(armada_370_xp_pmsu_init);
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
new file mode 100644
index 0000000..07a737c
--- /dev/null
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -0,0 +1,16 @@
+/*
+ * Power Management Service Unit (PMSU) support for Armada 370/XP platforms.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_MVEBU_PMSU_H
+#define __MACH_MVEBU_PMSU_H
+
+int armada_xp_boot_cpu(unsigned int cpu_id, void *phys_addr);
+
+#endif	/* __MACH_370_XP_PMSU_H */
-- 
1.7.9.5
