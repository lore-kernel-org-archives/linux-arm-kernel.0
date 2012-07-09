From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Mon,  9 Jul 2012 21:39:12 +0200
Subject: [PATCH 1/2] ARM i.MX31: Add devicetree support
In-Reply-To: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
References: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <1341862753-14848-2-git-send-email-GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic devicetree support for i.MX31 based SoCs.

Only the UART and interrupts bindings are added.

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 arch/arm/boot/dts/imx31.dtsi            |   88 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig               |    8 +++
 arch/arm/mach-imx/Makefile              |    1 +
 arch/arm/mach-imx/clk-imx31.c           |   19 +++++++
 arch/arm/mach-imx/imx31-dt.c            |   63 ++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 6 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx31.dtsi
 create mode 100644 arch/arm/mach-imx/imx31-dt.c

diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
new file mode 100644
index 0000000..eef7099
--- /dev/null
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2012 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+	};
+
+	avic: avic-interrupt-controller at 60000000 {
+		compatible = "fsl,imx31-avic", "fsl,avic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x60000000 0x100000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&avic>;
+		ranges;
+
+		aips at 43f00000 { /* AIPS1 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x43f00000 0x100000>;
+			ranges;
+
+			uart1: serial at 43f90000 {
+				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+				reg = <0x43f90000 0x4000>;
+				interrupts = <45>;
+				status = "disabled";
+			};
+
+			uart2: serial at 43f94000 {
+				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+				reg = <0x43f94000 0x4000>;
+				interrupts = <32>;
+				status = "disabled";
+			};
+
+			uart4: serial at 43fb0000 {
+				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+				reg = <0x43fb0000 0x4000>;
+				interrupts = <46>;
+				status = "disabled";
+			};
+
+			uart5: serial at 43fb4000 {
+				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+				reg = <0x43fb4000 0x4000>;
+				interrupts = <47>;
+				status = "disabled";
+			};
+		};
+
+		spba at 50000000 {
+			compatible = "fsl,spba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x50000000 0x100000>;
+			ranges;
+
+			uart3: serial at 5000c000 {
+				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+				reg = <0x5000c000 0x4000>;
+				interrupts = <18>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f4b1709..871a3c4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -558,6 +558,14 @@ config MACH_BUG
 	  Include support for BUGBase 1.3 platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_IMX31_DT
+	bool "Support i.MX31 platforms from device tree"
+	select SOC_IMX31
+	select USE_OF
+	help
+	  Include support for Freescale i.MX31 based platforms
+	  using the device tree for discovery.
+
 comment "MX35 platforms:"
 
 config MACH_PCM043
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ff29421..07f7c22 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_MACH_QONG) += mach-qong.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_KZM_ARM11_01) += mach-kzm_arm11_01.o
 obj-$(CONFIG_MACH_BUG) += mach-bug.o
+obj-$(CONFIG_MACH_IMX31_DT) += imx31-dt.o
 
 # i.MX35 based machines
 obj-$(CONFIG_MACH_PCM043) += mach-pcm043.o
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index c9a06d8..f87a48f 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -20,6 +20,7 @@
 #include <linux/clkdev.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <mach/hardware.h>
 #include <mach/mx31.h>
@@ -179,3 +180,21 @@ int __init mx31_clocks_init(unsigned long fref)
 
 	return 0;
 }
+
+#ifdef CONFIG_OF
+int __init mx31_clocks_init_dt(void)
+{
+	struct device_node *np;
+	u32 fref = 26000000; /* default */
+
+	for_each_compatible_node(np, NULL, "fixed-clock") {
+		if (!of_device_is_compatible(np, "fsl,imx-osc26m"))
+			continue;
+
+		if (!of_property_read_u32(np, "clock-frequency", &fref))
+			break;
+	}
+
+	return mx31_clocks_init(fref);
+}
+#endif
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
new file mode 100644
index 0000000..a68ba20
--- /dev/null
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright 2012 Sascha Hauer, Pengutronix
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/irq.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx31.h>
+
+static const struct of_dev_auxdata imx31_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART1_BASE_ADDR,
+			"imx21-uart.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART2_BASE_ADDR,
+			"imx21-uart.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART3_BASE_ADDR,
+			"imx21-uart.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART4_BASE_ADDR,
+			"imx21-uart.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART5_BASE_ADDR,
+			"imx21-uart.4", NULL),
+	{ /* sentinel */ }
+};
+
+static void __init imx31_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx31_auxdata_lookup, NULL);
+}
+
+static void __init imx31_timer_init(void)
+{
+	mx31_clocks_init_dt();
+}
+
+static struct sys_timer imx31_timer = {
+	.init = imx31_timer_init,
+};
+
+static const char *imx31_dt_board_compat[] __initdata = {
+	"fsl,imx31",
+	NULL
+};
+
+DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
+	.map_io		= mx31_map_io,
+	.init_early	= imx31_init_early,
+	.init_irq	= mx31_init_irq,
+	.handle_irq	= imx31_handle_irq,
+	.timer		= &imx31_timer,
+	.init_machine	= imx31_dt_init,
+	.dt_compat	= imx31_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 7ca1504..7128e97 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -68,6 +68,7 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern int mx27_clocks_init_dt(void);
+extern int mx31_clocks_init_dt(void);
 extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
 extern int mx6q_clocks_init(void);
-- 
1.7.4.1
