From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Mar 2013 00:49:34 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7790 SoC support
In-Reply-To: <20130327154925.10876.40575.sendpatchset@w520>
References: <20130327154925.10876.40575.sendpatchset@w520>
Message-ID: <20130327154934.10876.32748.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add initial support for the r8a7790 SoC including:
 - Single Cortex-A15 CPU Core
 - GIC
 - Architecture timer

No static virtual mappings are used, all the components
make use of ioremap(). DT_MACHINE_START is still wrapped
in CONFIG_USE_OF to match other mach-shmobile code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi                |   54 ++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                |    7 ++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/clock-r8a7790.c        |   61 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    7 ++
 arch/arm/mach-shmobile/setup-r8a7790.c        |   51 ++++++++++++++++++++
 6 files changed, 181 insertions(+)

--- /dev/null
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-03-20 23:05:42.000000000 +0900
@@ -0,0 +1,54 @@
+/*
+ * Device Tree Source for the r8a7790 SoC
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,r8a7790";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+			clock-frequency = <1300000000>;
+		};
+	};
+
+	gic: interrupt-controller at f1001000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xf1001000 0x1000>,
+			<0xf1002000 0x1000>,
+			<0xf1004000 0x2000>,
+			<0xf1006000 0x2000>;
+		interrupts = <1 9 0xf04>;
+
+		gic-cpuif at 4 {
+			compatible = "arm,gic-cpuif";
+			cpuif-id = <4>;
+			cpu = <&cpu0>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+				<1 14 0xf08>,
+				<1 11 0xf08>,
+				<1 10 0xf08>;
+	};
+};
--- 0011/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-20 23:05:41.000000000 +0900
@@ -43,6 +43,13 @@ config ARCH_R8A7779
 	select USB_ARCH_HAS_OHCI
 	select RENESAS_INTC_IRQPIN
 
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+	select ARM_GIC
+	select CPU_V7
+	select ARM_ARCH_TIMER
+	select SH_CLK_CPG
+
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
--- 0009/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-03-20 23:05:41.000000000 +0900
@@ -11,6 +11,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o clock-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o clock-r8a7740.o intc-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o clock-r8a7790.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
 
 # SMP objects
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2013-03-20 23:05:42.000000000 +0900
@@ -0,0 +1,61 @@
+/*
+ * r8a7790 clock framework support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/sh_clk.h>
+#include <linux/clkdev.h>
+#include <mach/common.h>
+
+#define CPG_BASE 0xe6150000
+#define CPG_LEN 0x1000
+
+static struct clk_mapping cpg_mapping = {
+	.phys   = CPG_BASE,
+	.len    = CPG_LEN,
+};
+
+static struct clk *main_clks[] = {
+};
+
+enum { MSTP_NR };
+static struct clk mstp_clks[MSTP_NR] = {
+};
+
+static struct clk_lookup lookups[] = {
+};
+
+void __init r8a7790_clock_init(void)
+{
+	int k, ret = 0;
+
+	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
+		ret = clk_register(main_clks[k]);
+
+	if (!ret)
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	if (!ret)
+		shmobile_clk_init();
+	else
+		panic("failed to setup r8a7790 clocks\n");
+}
--- /dev/null
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-03-20 23:14:00.000000000 +0900
@@ -0,0 +1,7 @@
+#ifndef __ASM_R8A7790_H__
+#define __ASM_R8A7790_H__
+
+void r8a7790_add_standard_devices(void);
+void r8a7790_clock_init(void);
+
+#endif /* __ASM_R8A7790_H__ */
--- /dev/null
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-03-20 23:05:42.000000000 +0900
@@ -0,0 +1,51 @@
+/*
+ * r8a7790 processor support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <mach/r8a7790.h>
+#include <asm/mach/arch.h>
+
+void __init r8a7790_add_standard_devices(void)
+{
+}
+
+#ifdef CONFIG_USE_OF
+void __init r8a7790_add_standard_devices_dt(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *r8a7790_boards_compat_dt[] __initdata = {
+	"renesas,r8a7790",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.init_irq	= irqchip_init,
+	.init_machine	= r8a7790_add_standard_devices_dt,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= r8a7790_boards_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
