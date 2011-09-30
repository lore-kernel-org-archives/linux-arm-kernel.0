From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Sep 2011 21:35:47 +0800
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree support for imx51 babbage board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    4 +
 arch/arm/boot/dts/imx51-babbage.dts           |  135 +++++++++++++++
 arch/arm/boot/dts/imx51.dtsi                  |  221 +++++++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                     |    9 +
 arch/arm/mach-mx5/Makefile                    |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c        |    9 +-
 arch/arm/mach-mx5/imx51-dt.c                  |  116 +++++++++++++
 arch/arm/plat-mxc/include/mach/common.h       |    1 +
 8 files changed, 494 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx51-babbage.dts
 create mode 100644 arch/arm/boot/dts/imx51.dtsi
 create mode 100644 arch/arm/mach-mx5/imx51-dt.c

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index d1e8d6f..e2401cd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -1,3 +1,7 @@
+i.MX51 Babbage Board
+Required root node properties:
+    - compatible = "fsl,imx51-babbage", "fsl,imx51";
+
 i.MX53 Automotive Reference Design Board
 Required root node properties:
     - compatible = "fsl,imx53-ard", "fsl,imx53";
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
new file mode 100644
index 0000000..f8766af
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -0,0 +1,135 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx51.dtsi"
+
+/ {
+	model = "Freescale i.MX51 Babbage Board";
+	compatible = "fsl,imx51-babbage", "fsl,imx51";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
+	memory {
+		reg = <0x90000000 0x20000000>;
+	};
+
+	soc {
+		aips at 70000000 { /* aips-1 */
+			spba at 70000000 {
+				esdhc at 70004000 { /* ESDHC1 */
+					fsl,cd-internal;
+					fsl,wp-internal;
+					status = "okay";
+				};
+
+				esdhc at 70008000 { /* ESDHC2 */
+					cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
+					wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
+					status = "okay";
+				};
+
+				uart2: uart at 7000c000 { /* UART3 */
+					fsl,uart-has-rtscts;
+					status = "okay";
+				};
+
+				ecspi at 70010000 { /* ECSPI1 */
+					fsl,spi-num-chipselects = <2>;
+					cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
+						   <&gpio3 25 0>; /* GPIO4_25 */
+					status = "okay";
+
+					pmic: mc13892 at 0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						compatible = "fsl,mc13892";
+						spi-max-frequency = <6000000>;
+						reg = <0>;
+						mc13xxx-irq-gpios = <&gpio0 8 0>; /* GPIO1_8 */
+						fsl,mc13xxx-uses-regulator;
+					};
+
+					flash: at45db321d at 1 {
+						#address-cells = <1>;
+						#size-cells = <1>;
+						compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+						spi-max-frequency = <25000000>;
+						reg = <1>;
+
+						partition at 0 {
+							label = "U-Boot";
+							reg = <0x0 0x40000>;
+							read-only;
+						};
+
+						partition at 40000 {
+							label = "Kernel";
+							reg = <0x40000 0x3c0000>;
+						};
+					};
+				};
+			};
+
+			wdog at 73f98000 { /* WDOG1 */
+				status = "okay";
+			};
+
+			iomuxc at 73fa8000 {
+				compatible = "fsl,imx51-iomuxc-babbage";
+				reg = <0x73fa8000 0x4000>;
+			};
+
+			uart0: uart at 73fbc000 {
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+
+			uart1: uart at 73fc0000 {
+				status = "okay";
+			};
+		};
+
+		aips at 80000000 {	/* aips-2 */
+			sdma at 83fb0000 {
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
+			};
+
+			i2c at 83fc4000 { /* I2C2 */
+				status = "okay";
+
+				codec: sgtl5000 at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+				};
+			};
+
+			fec at 83fec000 {
+				phy-mode = "mii";
+				status = "okay";
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio1 21 0>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
new file mode 100644
index 0000000..dfef00f
--- /dev/null
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -0,0 +1,221 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
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
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	tzic: tz-interrupt-controller at e0000000 {
+		compatible = "fsl,imx51-tzic", "fsl,tzic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xe0000000 0x4000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&tzic>;
+		ranges;
+
+		aips at 70000000 { /* AIPS1 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x70000000 0x10000000>;
+			ranges;
+
+			spba at 70000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x70000000 0x40000>;
+				ranges;
+
+				esdhc at 70004000 { /* ESDHC1 */
+					compatible = "fsl,imx51-esdhc";
+					reg = <0x70004000 0x4000>;
+					interrupts = <1>;
+					status = "disabled";
+				};
+
+				esdhc at 70008000 { /* ESDHC2 */
+					compatible = "fsl,imx51-esdhc";
+					reg = <0x70008000 0x4000>;
+					interrupts = <2>;
+					status = "disabled";
+				};
+
+				uart2: uart at 7000c000 { /* UART3 */
+					compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+					reg = <0x7000c000 0x4000>;
+					interrupts = <33>;
+					status = "disabled";
+				};
+
+				ecspi at 70010000 { /* ECSPI1 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx51-ecspi";
+					reg = <0x70010000 0x4000>;
+					interrupts = <36>;
+					status = "disabled";
+				};
+
+				esdhc at 70020000 { /* ESDHC3 */
+					compatible = "fsl,imx51-esdhc";
+					reg = <0x70020000 0x4000>;
+					interrupts = <3>;
+					status = "disabled";
+				};
+
+				esdhc at 70024000 { /* ESDHC4 */
+					compatible = "fsl,imx51-esdhc";
+					reg = <0x70024000 0x4000>;
+					interrupts = <4>;
+					status = "disabled";
+				};
+			};
+
+			gpio0: gpio at 73f84000 { /* GPIO1 */
+				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				reg = <0x73f84000 0x4000>;
+				interrupts = <50 51>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio1: gpio at 73f88000 { /* GPIO2 */
+				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				reg = <0x73f88000 0x4000>;
+				interrupts = <52 53>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio2: gpio at 73f8c000 { /* GPIO3 */
+				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				reg = <0x73f8c000 0x4000>;
+				interrupts = <54 55>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio3: gpio at 73f90000 { /* GPIO4 */
+				compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+				reg = <0x73f90000 0x4000>;
+				interrupts = <56 57>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			wdog at 73f98000 { /* WDOG1 */
+				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				reg = <0x73f98000 0x4000>;
+				interrupts = <58>;
+				status = "disabled";
+			};
+
+			wdog at 73f9c000 { /* WDOG2 */
+				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+				reg = <0x73f9c000 0x4000>;
+				interrupts = <59>;
+				status = "disabled";
+			};
+
+			uart0: uart at 73fbc000 {
+				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+				reg = <0x73fbc000 0x4000>;
+				interrupts = <31>;
+				status = "disabled";
+			};
+
+			uart1: uart at 73fc0000 {
+				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+				reg = <0x73fc0000 0x4000>;
+				interrupts = <32>;
+				status = "disabled";
+			};
+		};
+
+		aips at 80000000 {	/* AIPS2 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80000000 0x10000000>;
+			ranges;
+
+			ecspi at 83fac000 { /* ECSPI2 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-ecspi";
+				reg = <0x83fac000 0x4000>;
+				interrupts = <37>;
+				status = "disabled";
+			};
+
+			sdma at 83fb0000 {
+				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
+				reg = <0x83fb0000 0x4000>;
+				interrupts = <6>;
+			};
+
+			cspi at 83fc0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
+				reg = <0x83fc0000 0x4000>;
+				interrupts = <38>;
+				status = "disabled";
+			};
+
+			i2c at 83fc4000 { /* I2C2 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+				reg = <0x83fc4000 0x4000>;
+				interrupts = <63>;
+				status = "disabled";
+			};
+
+			i2c at 83fc8000 { /* I2C1 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+				reg = <0x83fc8000 0x4000>;
+				interrupts = <62>;
+				status = "disabled";
+			};
+
+			fec at 83fec000 {
+				compatible = "fsl,imx51-fec", "fsl,imx27-fec";
+				reg = <0x83fec000 0x4000>;
+				interrupts = <87>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 6600742..d48f78a 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -57,6 +57,15 @@ config MACH_MX50_RDP
 
 comment "i.MX51 machines:"
 
+config MACH_IMX51_DT
+	bool "Support i.MX51 platforms from device tree"
+	select SOC_IMX51
+	select USE_OF
+	select MACH_MX51_BABBAGE
+	help
+	  Include support for Freescale i.MX51 based platforms
+	  using the device tree for discovery
+
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
 	select SOC_IMX51
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 3dbe5e2..a3c75f3 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -23,4 +23,5 @@ obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
 obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
 obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
 
+obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 4bd5e87..df6f0f1 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -351,6 +351,12 @@ static const struct esdhc_platform_data mx51_babbage_sd2_data __initconst = {
 	.wp_type = ESDHC_WP_GPIO,
 };
 
+void __init imx51_babbage_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
+					 ARRAY_SIZE(mx51babbage_pads));
+}
+
 /*
  * Board specific initialization.
  */
@@ -365,8 +371,7 @@ static void __init mx51_babbage_init(void)
 #if defined(CONFIG_CPU_FREQ_IMX)
 	get_cpu_op = mx51_get_cpu_op;
 #endif
-	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
-					ARRAY_SIZE(mx51babbage_pads));
+	imx51_babbage_common_init();
 
 	imx51_add_imx_uart(0, &uart_pdata);
 	imx51_add_imx_uart(1, NULL);
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
new file mode 100644
index 0000000..0878441
--- /dev/null
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2011 Linaro Ltd.
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
+#include <mach/mx51.h>
+
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART1_BASE_ADDR, "imx21-uart.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART2_BASE_ADDR, "imx21-uart.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART3_BASE_ADDR, "imx21-uart.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-fec", MX51_FEC_BASE_ADDR, "imx27-fec.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx51.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx51.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx51.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx51.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-cspi", MX51_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-sdma", MX51_SDMA_BASE_ADDR, "imx35-sdma", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-wdt", MX51_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
+	{ /* sentinel */ }
+};
+
+static void __init imx51_tzic_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	irq_domain_add_simple(np, 0);
+}
+
+static void __init imx51_gpio_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
+				   32 * 4; /* imx51 gets 4 gpio ports */
+
+	irq_domain_add_simple(np, gpio_irq_base);
+	gpio_irq_base += 32;
+}
+
+static const struct of_device_id imx51_irq_match[] __initconst = {
+	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_add_irq_domain, },
+	{ .compatible = "fsl,imx51-gpio", .data = imx51_gpio_add_irq_domain, },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx51_iomuxc_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-iomuxc-babbage", .data = imx51_babbage_common_init, },
+	{ /* sentinel */ }
+};
+
+static void __init imx51_dt_init(void)
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	void (*func)(void);
+
+	of_irq_init(imx51_irq_match);
+
+	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
+	if (node) {
+		of_id = of_match_node(imx51_iomuxc_of_match, node);
+		func = of_id->data;
+		func();
+		of_node_put(node);
+	}
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx51_auxdata_lookup, NULL);
+}
+
+static void __init imx51_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer imx51_timer = {
+	.init = imx51_timer_init,
+};
+
+static const char *imx51_dt_board_compat[] __initdata = {
+	"fsl,imx51-babbage",
+	NULL
+};
+
+DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
+	.map_io		= mx51_map_io,
+	.init_early	= imx51_init_early,
+	.init_irq	= mx51_init_irq,
+	.handle_irq	= imx51_handle_irq,
+	.timer		= &imx51_timer,
+	.init_machine	= imx51_dt_init,
+	.dt_compat	= imx51_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 2bd8f84..4a42d84 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -72,6 +72,7 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern void imx51_babbage_common_init(void);
 extern void imx53_ard_common_init(void);
 extern void imx53_evk_common_init(void);
 extern void imx53_qsb_common_init(void);
-- 
1.7.4.1
