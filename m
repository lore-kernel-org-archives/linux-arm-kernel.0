From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:20:52 +0100
Subject: [PATCH 1/3] ARM i.MX27: Add devicetree support
In-Reply-To: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1330503654-2197-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic devicetree support for i.MX27 based SoCs.
Only the bindings for which drivers exist are added here:

- UART
- fec
- CSPI
- I2C
- watchdog
- gpio

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi            |  217 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig               |    8 +
 arch/arm/mach-imx/Makefile              |    1 +
 arch/arm/mach-imx/clock-imx27.c         |   18 +++
 arch/arm/mach-imx/imx27-dt.c            |   89 +++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 6 files changed, 334 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27.dtsi
 create mode 100644 arch/arm/mach-imx/imx27-dt.c

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
new file mode 100644
index 0000000..bc5e7d5
--- /dev/null
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -0,0 +1,217 @@
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
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+	};
+
+	avic: avic-interrupt-controller at e0000000 {
+		compatible = "fsl,imx27-avic", "fsl,avic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x10040000 0x1000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc26m {
+			compatible = "fsl,imx-osc26m", "fixed-clock";
+			clock-frequency = <26000000>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&avic>;
+		ranges;
+
+		aipi at 10000000 { /* AIPI1 */
+			compatible = "fsl,aipi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x10000000 0x10000000>;
+			ranges;
+
+			wdog at 10002000 {
+				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
+				reg = <0x10002000 0x4000>;
+				interrupts = <27>;
+				status = "disabled";
+			};
+
+			uart1: uart at 1000a000 {
+				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+				reg = <0x1000a000 0x1000>;
+				interrupts = <20>;
+				status = "disabled";
+			};
+
+			uart2: uart at 1000b000 {
+				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+				reg = <0x1000b000 0x1000>;
+				interrupts = <19>;
+				status = "disabled";
+			};
+
+			uart3: uart at 1000c000 {
+				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+				reg = <0x1000c000 0x1000>;
+				interrupts = <18>;
+				status = "disabled";
+			};
+
+			uart4: uart at 1000d000 {
+				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+				reg = <0x1000d000 0x1000>;
+				interrupts = <17>;
+				status = "disabled";
+			};
+
+			cspi1: cspi at 1000e000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx27-cspi";
+				reg = <0x1000e000 0x1000>;
+				interrupts = <16>;
+				status = "disabled";
+			};
+
+			cspi2: cspi at 1000f000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx27-cspi";
+				reg = <0x1000f000 0x1000>;
+				interrupts = <15>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 10012000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx27-i2c", "fsl,imx1-i2c";
+				reg = <0x10012000 0x1000>;
+				interrupts = <12>;
+				status = "disabled";
+			};
+
+			gpio1: gpio at 10015000 {
+				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
+				reg = <0x10015000 0x100>;
+				interrupts = <8>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio2: gpio at 10015100 {
+				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
+				reg = <0x10015100 0x100>;
+				interrupts = <8>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio3: gpio at 10015200 {
+				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
+				reg = <0x10015200 0x100>;
+				interrupts = <8>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio4: gpio at 10015300 {
+				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
+				reg = <0x10015300 0x100>;
+				interrupts = <8>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio5: gpio at 10015400 {
+				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
+				reg = <0x10015400 0x100>;
+				interrupts = <8>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio6: gpio at 10015500 {
+				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
+				reg = <0x10015500 0x100>;
+				interrupts = <8>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			cspi3: cspi at 10017000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx27-cspi";
+				reg = <0x10017000 0x1000>;
+				interrupts = <6>;
+				status = "disabled";
+			};
+
+			uart5: uart at 1001b000 {
+				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+				reg = <0x1001b000 0x1000>;
+				interrupts = <49>;
+				status = "disabled";
+			};
+
+			uart6: uart at 1001c000 {
+				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+				reg = <0x1001c000 0x1000>;
+				interrupts = <48>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 1001d000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx27-i2c", "fsl,imx1-i2c";
+				reg = <0x1001d000 0x1000>;
+				interrupts = <1>;
+				status = "disabled";
+			};
+
+			fec: fec at 1002b000 {
+				compatible = "fsl,imx27-fec";
+				reg = <0x1002b000 0x4000>;
+				interrupts = <50>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..85433b9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -376,6 +376,14 @@ config MACH_IMX27IPCAM
 	  Include support for IMX27 IPCAM platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_IMX27_DT
+	bool "Support i.MX27 platforms from device tree"
+	select SOC_IMX27
+	select USE_OF
+	help
+	  Include support for Freescale i.MX27 based platforms
+	  using the device tree for discovery
+
 endif
 
 if ARCH_IMX_V6_V7
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 55db9c4..4ffeca7 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
 obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
 obj-$(CONFIG_MACH_MXT_TD60) += mach-mxt_td60.o
 obj-$(CONFIG_MACH_IMX27IPCAM) += mach-imx27ipcam.o
+obj-$(CONFIG_MACH_IMX27_DT) += imx27-dt.o
 
 # i.MX31 based machines
 obj-$(CONFIG_MACH_MX31ADS) += mach-mx31ads.o
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 88fe00a..01ae3a4 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/clkdev.h>
+#include <linux/of.h>
 
 #include <asm/div64.h>
 
@@ -764,3 +765,20 @@ int __init mx27_clocks_init(unsigned long fref)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+int __init mx27_clocks_init_dt(void)
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
+	return mx27_clocks_init(fref);
+}
+#endif
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
new file mode 100644
index 0000000..861ceb8
--- /dev/null
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -0,0 +1,89 @@
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
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx27.h>
+
+static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART1_BASE_ADDR, "imx21-uart.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART2_BASE_ADDR, "imx21-uart.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART3_BASE_ADDR, "imx21-uart.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-fec", MX27_FEC_BASE_ADDR, "imx27-fec.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-i2c", MX27_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-i2c", MX27_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI1_BASE_ADDR, "imx27-cspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI2_BASE_ADDR, "imx27-cspi.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI3_BASE_ADDR, "imx27-cspi.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-wdt", MX27_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
+	{ /* sentinel */ }
+};
+
+static int __init imx27_avic_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	irq_domain_add_simple(np, 0);
+	return 0;
+}
+
+static int __init imx27_gpio_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
+
+	irq_domain_add_simple(np, gpio_irq_base);
+
+	return 0;
+}
+
+static const struct of_device_id imx27_irq_match[] __initconst = {
+	{ .compatible = "fsl,imx27-avic", .data = imx27_avic_add_irq_domain, },
+	{ .compatible = "fsl,imx27-gpio", .data = imx27_gpio_add_irq_domain, },
+	{ /* sentinel */ }
+};
+
+static void __init imx27_dt_init(void)
+{
+	of_irq_init(imx27_irq_match);
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx27_auxdata_lookup, NULL);
+}
+
+static void __init imx27_timer_init(void)
+{
+	mx27_clocks_init_dt();
+}
+
+static struct sys_timer imx27_timer = {
+	.init = imx27_timer_init,
+};
+
+static const char *imx27_dt_board_compat[] __initdata = {
+	"fsl,imx27",
+	NULL
+};
+
+DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
+	.map_io		= mx27_map_io,
+	.init_early	= imx27_init_early,
+	.init_irq	= mx27_init_irq,
+	.handle_irq	= imx27_handle_irq,
+	.timer		= &imx27_timer,
+	.init_machine	= imx27_dt_init,
+	.dt_compat	= imx27_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 1bf0df8..16d10a8 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -65,6 +65,7 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
+extern int mx27_clocks_init_dt(void);
 extern int mx51_clocks_init_dt(void);
 extern int mx53_clocks_init_dt(void);
 extern int mx6q_clocks_init(void);
-- 
1.7.9.1
