From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:06:57 +0900
Subject: [PATCH 01/30] ARM: shmobile: Initial r8a73a4 SoC support V3
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

V3 of initial support for the r8a73a4 SoC including:
 - Single Cortex-A15 CPU Core
 - GIC
 - Architecture timer

No static virtual mappings are used, all the components
make use of ioremap(). DT_MACHINE_START is still wrapped
in CONFIG_USE_OF to match other mach-shmobile code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi                |   55 +++++++++++++++
 arch/arm/mach-shmobile/Kconfig                |    7 ++
 arch/arm/mach-shmobile/Makefile               |    1 +
 arch/arm/mach-shmobile/clock-r8a73a4.c        |   91 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    7 ++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   50 ++++++++++++++
 6 files changed, 211 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a73a4.dtsi
 create mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
 create mode 100644 arch/arm/mach-shmobile/include/mach/r8a73a4.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a73a4.c

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
new file mode 100644
index 0000000..72c58c1
--- /dev/null
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -0,0 +1,55 @@
+/*
+ * Device Tree Source for the r8a73a4 SoC
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Magnus Damm
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,r8a73a4";
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
+			clock-frequency = <1500000000>;
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
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 75d413c..663d27b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -18,6 +18,13 @@ config ARCH_SH73A0
 	select SH_CLK_CPG
 	select RENESAS_INTC_IRQPIN
 
+config ARCH_R8A73A4
+	bool "R-Mobile APE6 (R8A73A40)"
+	select ARM_GIC
+	select CPU_V7
+	select ARM_ARCH_TIMER
+	select SH_CLK_CPG
+
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b646ff4..c5a43ef 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -8,6 +8,7 @@ obj-y				:= timer.o console.o clock.o
 # CPU objects
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
+obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o clock-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o clock-r8a7740.o intc-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
new file mode 100644
index 0000000..15d479d
--- /dev/null
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -0,0 +1,91 @@
+/*
+ * r8a73a4 clock framework support
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
+#define CPG_LEN 0x270
+
+#define MPCKCR 0xe6150080
+
+static struct clk_mapping cpg_mapping = {
+	.phys   = CPG_BASE,
+	.len    = CPG_LEN,
+};
+
+static struct clk extalr_clk = {
+	.rate	= 32768,
+	.mapping	= &cpg_mapping,
+};
+
+static struct clk extal1_clk = {
+	.rate	= 26000000,
+	.mapping	= &cpg_mapping,
+};
+
+static struct clk extal2_clk = {
+	.rate	= 48000000,
+	.mapping	= &cpg_mapping,
+};
+
+static struct clk *main_clks[] = {
+	&extalr_clk,
+	&extal1_clk,
+	&extal2_clk,
+};
+
+enum { MSTP_NR };
+static struct clk mstp_clks[MSTP_NR] = {
+};
+
+static struct clk_lookup lookups[] = {
+};
+
+void __init r8a73a4_clock_init(void)
+{
+	void __iomem *cpg_base, *reg;
+	int k, ret = 0;
+
+	/* fix MPCLK to EXTAL2 for now.
+	 * this is needed until more detailed clock topology is supported
+	 */
+	cpg_base = ioremap_nocache(CPG_BASE, CPG_LEN);
+	BUG_ON(!cpg_base);
+	reg = cpg_base + (MPCKCR - CPG_BASE);
+	iowrite32(ioread32(reg) | 1 << 7 | 0x0c, reg); /* set CKSEL */
+	iounmap(cpg_base);
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
+		panic("failed to setup r8a73a4 clocks\n");
+}
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
new file mode 100644
index 0000000..6db3495
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_R8A73A4_H__
+#define __ASM_R8A73A4_H__
+
+void r8a73a4_add_standard_devices(void);
+void r8a73a4_clock_init(void);
+
+#endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
new file mode 100644
index 0000000..69156bc
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -0,0 +1,50 @@
+/*
+ * r8a73a4 processor support
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
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <mach/r8a73a4.h>
+#include <asm/mach/arch.h>
+
+void __init r8a73a4_add_standard_devices(void)
+{
+}
+
+#ifdef CONFIG_USE_OF
+void __init r8a73a4_add_standard_devices_dt(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *r8a73a4_boards_compat_dt[] __initdata = {
+	"renesas,r8a73a4",
+	NULL,
+};
+
+DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
+	.init_irq	= irqchip_init,
+	.init_machine	= r8a73a4_add_standard_devices_dt,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= r8a73a4_boards_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
-- 
1.7.10.4
