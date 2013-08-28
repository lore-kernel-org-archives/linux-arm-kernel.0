From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 21:10:53 +0800
Subject: [PATCH v9 6/7] ARM: hi3xxx: add smp support
In-Reply-To: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1377695454-29109-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>

Enable SMP support on hi3xxx platform

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
Tested-by: Li Xin <li.xin@linaro.org>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 50 +++++++++++++++++
 arch/arm/boot/dts/hi3620-clk.dtsi                  |  4 ++
 arch/arm/boot/dts/hi3620.dtsi                      | 27 +++++++++
 arch/arm/mach-hi3xxx/Kconfig                       |  2 +
 arch/arm/mach-hi3xxx/Makefile                      |  3 +-
 arch/arm/mach-hi3xxx/core.h                        | 13 +++++
 arch/arm/mach-hi3xxx/hi3xxx.c                      |  5 ++
 arch/arm/mach-hi3xxx/platsmp.c                     | 43 ++++++++++++++
 arch/arm/mach-hi3xxx/system.c                      | 65 ++++++++++++++++++++++
 9 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-hi3xxx/core.h
 create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
 create mode 100644 arch/arm/mach-hi3xxx/system.c

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 3be60c8..1462903 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -8,3 +8,53 @@ Required root node properties:
 Hi4511 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3620-hi4511";
+
+
+Hisilicon system controller
+
+Required properties:
+- compatible : "hisilicon,sysctrl"
+- reg : Register address and size
+
+Optional properties:
+- smp-off : offset in sysctrl for notifying slave cpu booting
+		cpu 1, reg;
+		cpu 2, reg + 0x4;
+		cpu 3, reg + 0x8;
+		If reg value is not zero, cpun exit wfi and go
+- resume-off : offset in sysctrl for notifying cpu0 when resume
+- reboot-off : offset in sysctrl for system reboot
+
+Example:
+
+	/* for Hi3716 */
+	sysctrl: system-controller at f8000000 {
+		compatible = "hisilicon,sysctrl";
+		reg = <0xf8000000 0x1000>;
+		smp-off = <0xc0>;
+		reboot-off = <0x4>;
+	};
+
+	/* for Hi3620 */
+	sysctrl: system-controller at fc802000 {
+		compatible = "hisilicon,sysctrl";
+		reg = <0xfc802000 0x1000>;
+		smp-off = <0x31c>;
+		resume-off = <0x308>;
+		reboot-off = <0x4>;
+	};
+
+Hi3716 cpuctrl register
+Hi3716 specific cpuctrl register, control power & clock of cpu and module.
+
+Required properties:
+- compatible : "hisilicon,hi3716-cpuctrl"
+- reg : register address and size
+
+Example:
+
+	/* for Hi3716 */
+	cpuctrl at f8a22000 {
+		compatible = "hisilicon,hi3716-cpuctrl";
+		reg = <0xf8a22000 0x2000>;
+	};
diff --git a/arch/arm/boot/dts/hi3620-clk.dtsi b/arch/arm/boot/dts/hi3620-clk.dtsi
index 78307c6..78a2a8bf 100644
--- a/arch/arm/boot/dts/hi3620-clk.dtsi
+++ b/arch/arm/boot/dts/hi3620-clk.dtsi
@@ -102,6 +102,10 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			smp-off = <0x31c>;
+			resume-off = <0x308>;
+			reboot-off = <0x4>;
+
 			timer0_mux: timer0_mux {
 				compatible = "hisilicon,clk-mux";
 				#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index e05c65c..03c816c 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -34,6 +34,27 @@
 			reg = <0x0>;
 			next-level-cache = <&L2>;
 		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
 	};
 
 	amba {
@@ -110,6 +131,12 @@
 			status = "disabled";
 		};
 
+		timer5: timer at fc000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xfc000600 0x20>;
+			interrupts = <1 13 0xf01>;
+		};
+
 		uart0: uart at fcb00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xfcb00000 0x1000>;
diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
index 68bd26c..d2e7d57 100644
--- a/arch/arm/mach-hi3xxx/Kconfig
+++ b/arch/arm/mach-hi3xxx/Kconfig
@@ -6,6 +6,8 @@ config ARCH_HI3xxx
 	select CACHE_L2X0
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU
+	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
diff --git a/arch/arm/mach-hi3xxx/Makefile b/arch/arm/mach-hi3xxx/Makefile
index d68ebb3..0917f1c 100644
--- a/arch/arm/mach-hi3xxx/Makefile
+++ b/arch/arm/mach-hi3xxx/Makefile
@@ -2,4 +2,5 @@
 # Makefile for Hisilicon Hi36xx/Hi37xx processors line
 #
 
-obj-y	+= hi3xxx.o
+obj-y	+= hi3xxx.o system.o
+obj-$(CONFIG_SMP)		+= platsmp.o
diff --git a/arch/arm/mach-hi3xxx/core.h b/arch/arm/mach-hi3xxx/core.h
new file mode 100644
index 0000000..3a9c50a
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/core.h
@@ -0,0 +1,13 @@
+#ifndef __HISILICON_CORE_H
+#define __HISILICON_CORE_H
+
+#include <linux/reboot.h>
+
+extern void hs_set_cpu_jump(int cpu, void *jump_addr);
+extern int hs_get_cpu_jump(int cpu);
+extern void secondary_startup(void);
+extern void hs_map_io(void);
+extern void hs_restart(enum reboot_mode, const char *cmd);
+extern struct smp_operations hs_smp_ops;
+
+#endif
diff --git a/arch/arm/mach-hi3xxx/hi3xxx.c b/arch/arm/mach-hi3xxx/hi3xxx.c
index e7c54bc..567a0d5 100644
--- a/arch/arm/mach-hi3xxx/hi3xxx.c
+++ b/arch/arm/mach-hi3xxx/hi3xxx.c
@@ -19,8 +19,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include "core.h"
+
 static void __init hi3xxx_timer_init(void)
 {
+	hs_map_io();
 	of_clk_init(NULL);
 	clocksource_of_init();
 }
@@ -33,4 +36,6 @@ static const char *hs_compat[] __initdata = {
 DT_MACHINE_START(HI3xxx, "Hisilicon Hi36xx/Hi37xx (Flattened Device Tree)")
 	.init_time	= hi3xxx_timer_init,
 	.dt_compat	= hs_compat,
+	.smp		= smp_ops(hs_smp_ops),
+	.restart	= hs_restart,
 MACHINE_END
diff --git a/arch/arm/mach-hi3xxx/platsmp.c b/arch/arm/mach-hi3xxx/platsmp.c
new file mode 100644
index 0000000..a76a3cc
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/platsmp.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <asm/smp_scu.h>
+
+#include "core.h"
+
+static void __init hs_smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned long base;
+	void __iomem *scu_base;
+
+	if (scu_a9_has_base()) {
+		base = scu_a9_get_base();
+		scu_base = ioremap(base, SZ_4K);
+		if (!scu_base) {
+			pr_err("ioremap(scu_base) failed\n");
+			return;
+		}
+		scu_enable(scu_base);
+		iounmap(scu_base);
+	}
+}
+
+static int hs_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	hs_set_cpu_jump(cpu, secondary_startup);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	return 0;
+}
+
+struct smp_operations hs_smp_ops __initdata = {
+	.smp_prepare_cpus	= hs_smp_prepare_cpus,
+	.smp_boot_secondary	= hs_boot_secondary,
+};
diff --git a/arch/arm/mach-hi3xxx/system.c b/arch/arm/mach-hi3xxx/system.c
new file mode 100644
index 0000000..1276398
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/system.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/proc-fns.h>
+#include <asm/smp_plat.h>
+
+#include "core.h"
+
+static void __iomem *hs_sysctrl_base;
+static int hs_smp_reg;
+static int hs_resume_reg;
+static int hs_reboot_reg;
+
+void hs_map_io(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
+	if (np) {
+		hs_sysctrl_base = of_iomap(np, 0);
+		if (!hs_sysctrl_base)
+			pr_err("of_iomap(sysctrl_base) failed\n");
+		of_property_read_u32(np, "smp-off", &hs_smp_reg);
+		of_property_read_u32(np, "resume-off", &hs_resume_reg);
+		of_property_read_u32(np, "reboot-off", &hs_reboot_reg);
+	}
+}
+
+void hs_set_cpu_jump(int cpu, void *jump_addr)
+{
+	int offset = hs_smp_reg;
+
+	cpu = cpu_logical_map(cpu);
+	if (cpu > 0)
+		offset +=  0x04 * (cpu - 1);
+	writel_relaxed(virt_to_phys(jump_addr), hs_sysctrl_base + offset);
+}
+
+int hs_get_cpu_jump(int cpu)
+{
+	int offset = hs_smp_reg;
+
+	cpu = cpu_logical_map(cpu);
+	if (cpu > 0)
+		offset +=  0x04 * (cpu - 1);
+	return readl_relaxed(hs_sysctrl_base + offset);
+}
+
+void hs_restart(enum reboot_mode mode, const char *cmd)
+{
+	writel_relaxed(0xdeadbeef, hs_sysctrl_base + hs_reboot_reg);
+
+	while (1)
+		cpu_do_idle();
+}
+
-- 
1.8.1.2
