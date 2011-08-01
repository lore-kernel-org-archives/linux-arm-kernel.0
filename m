From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Aug 2011 03:17:32 +0800
Subject: [PATCH v3 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1312226252-8566-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree support for imx51 babbage board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl/boards.txt         |    4 +
 arch/arm/boot/dts/imx51-babbage.dts                |  141 ++++++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |  203 ++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |    9 +
 arch/arm/mach-mx5/Makefile                         |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |    5 +
 arch/arm/mach-mx5/imx51-dt.c                       |  112 +++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |    2 +
 8 files changed, 477 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx51-babbage.dts
 create mode 100644 arch/arm/boot/dts/imx51.dtsi
 create mode 100644 arch/arm/mach-mx5/imx51-dt.c

diff --git a/Documentation/devicetree/bindings/arm/fsl/boards.txt b/Documentation/devicetree/bindings/arm/fsl/boards.txt
index d1e8d6f..e2401cd 100644
--- a/Documentation/devicetree/bindings/arm/fsl/boards.txt
+++ b/Documentation/devicetree/bindings/arm/fsl/boards.txt
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
index 0000000..67fc0bf
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -0,0 +1,141 @@
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
+	aips at 70000000 { /* aips-1 */
+		spba at 70000000 {
+			esdhc at 70004000 { /* ESDHC1 */
+				fsl,cd-internal;
+				fsl,wp-internal;
+			};
+
+			esdhc at 70008000 { /* ESDHC2 */
+				cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
+				wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
+			};
+
+			uart2: uart at 7000c000 { /* UART3 */
+				fsl,uart-has-rtscts;
+			};
+
+			ecspi at 70010000 { /* ECSPI1 */
+				fsl,spi-num-chipselects = <2>;
+				cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
+					   <&gpio3 25 0>; /* GPIO4_25 */
+
+				pmic: mc13892 at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,mc13892";
+					spi-max-frequency = <6000000>;
+					reg = <0>;
+					mc13xxx-irq-gpios = <&gpio0 8 0>; /* GPIO1_8 */
+					fsl,mc13xxx-uses-regulator;
+				};
+
+				flash: at45db321d at 1 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <25000000>;
+					reg = <1>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0x0 0x40000>;
+						read-only;
+					};
+
+					partition at 40000 {
+						label = "Kernel";
+						reg = <0x40000 0x3c0000>;
+					};
+				};
+			};
+
+			esdhc at 70020000 { /* ESDHC3 */
+				status = "disabled";
+			};
+
+			esdhc at 70024000 { /* ESDHC4 */
+				status = "disabled";
+			};
+
+			i2c at 70038000 { /* HS-I2C */
+				status = "disabled";
+			};
+		};
+
+		iomuxc at 73fa8000 {
+			compatible = "fsl,imx51-iomuxc-babbage";
+			reg = <0x73fa8000 0x4000>;
+		};
+
+		uart0: uart at 73fbc000 {
+			fsl,uart-has-rtscts;
+		};
+	};
+
+	aips at 80000000 {	/* aips-2 */
+		ecspi at 83fac000 { /* ECSPI2 */
+			status = "disabled";
+		};
+
+		sdma at 83fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
+		};
+
+		cspi at 83fc0000 {
+			status = "disabled";
+		};
+
+		i2c at 83fc4000 { /* I2C2 */
+			codec: sgtl5000 at 0a {
+				compatible = "fsl,sgtl5000";
+				reg = <0x0a>;
+			};
+		};
+
+		i2c at 83fc8000 { /* I2C1 */
+			status = "disabled";
+		};
+
+		fec at 83fec000 {
+			phy-mode = "mii";
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
index 0000000..f456ebd
--- /dev/null
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -0,0 +1,203 @@
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
+	interrupt-parent = <&tzic>;
+
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
+	aips at 70000000 { /* AIPS1 */
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x70000000 0x10000000>;
+		ranges;
+
+		spba at 70000000 {
+			compatible = "fsl,spba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x70000000 0x40000>;
+			ranges;
+
+			esdhc at 70004000 { /* ESDHC1 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70004000 0x4000>;
+				interrupts = <1>;
+			};
+
+			esdhc at 70008000 { /* ESDHC2 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70008000 0x4000>;
+				interrupts = <2>;
+			};
+
+			uart2: uart at 7000c000 { /* UART3 */
+				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+				reg = <0x7000c000 0x4000>;
+				interrupts = <33>;
+			};
+
+			ecspi at 70010000 { /* ECSPI1 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-ecspi";
+				reg = <0x70010000 0x4000>;
+				interrupts = <36>;
+			};
+
+			esdhc at 70020000 { /* ESDHC3 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70020000 0x4000>;
+				interrupts = <3>;
+			};
+
+			esdhc at 70024000 { /* ESDHC4 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70024000 0x4000>;
+				interrupts = <4>;
+			};
+
+			i2c at 70038000 { /* HS-I2C */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+				reg = <0x70038000 0x4000>;
+				interrupts = <64>;
+				clock-frequency = <400000>;
+			};
+		};
+
+		gpio0: gpio at 73f84000 { /* GPIO1 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f84000 0x4000>;
+			interrupts = <50 51>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio1: gpio at 73f88000 { /* GPIO2 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f88000 0x4000>;
+			interrupts = <52 53>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio at 73f8c000 { /* GPIO3 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f8c000 0x4000>;
+			interrupts = <54 55>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio at 73f90000 { /* GPIO4 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f90000 0x4000>;
+			interrupts = <56 57>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		wdt at 73f98000 { /* WDOG1 */
+			compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+			reg = <0x73f98000 0x4000>;
+			interrupts = <58>;
+		};
+
+		uart0: uart at 73fbc000 {
+			compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+			reg = <0x73fbc000 0x4000>;
+			interrupts = <31>;
+		};
+
+		uart1: uart at 73fc0000 {
+			compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+			reg = <0x73fc0000 0x4000>;
+			interrupts = <32>;
+		};
+	};
+
+	aips at 80000000 {	/* AIPS2 */
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80000000 0x10000000>;
+		ranges;
+
+		ecspi at 83fac000 { /* ECSPI2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-ecspi";
+			reg = <0x83fac000 0x4000>;
+			interrupts = <37>;
+		};
+
+		sdma at 83fb0000 {
+			compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
+			reg = <0x83fb0000 0x4000>;
+			interrupts = <6>;
+		};
+
+		cspi at 83fc0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
+			reg = <0x83fc0000 0x4000>;
+			interrupts = <38>;
+		};
+
+		i2c at 83fc4000 { /* I2C2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+			reg = <0x83fc4000 0x4000>;
+			interrupts = <63>;
+		};
+
+		i2c at 83fc8000 { /* I2C1 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+			reg = <0x83fc8000 0x4000>;
+			interrupts = <62>;
+		};
+
+		fec at 83fec000 {
+			compatible = "fsl,imx51-fec", "fsl,imx27-fec";
+			reg = <0x83fec000 0x4000>;
+			interrupts = <87>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 0ac676c..bda12e8 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -62,6 +62,15 @@ endif # ARCH_MX50_SUPPORTED
 if ARCH_MX51
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
index e400b09..e0cdeae 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -167,6 +167,11 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_CSPI1_SS1__GPIO4_25,
 };
 
+struct iomux_v3_pad_data imx51_babbage_pad_data = {
+	.pads = mx51babbage_pads,
+	.num = ARRAY_SIZE(mx51babbage_pads),
+};
+
 /* Serial ports */
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
new file mode 100644
index 0000000..b28ebeb
--- /dev/null
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -0,0 +1,112 @@
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
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx51.h>
+#include <mach/iomux-mx51.h>
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
+static const struct of_device_id imx51_tzic_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-tzic", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx51_gpio_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-gpio", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx51_iomuxc_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-iomuxc-babbage", .data = &imx51_babbage_pad_data, },
+	{ /* sentinel */ }
+};
+
+static void __init imx51_dt_init(void)
+{
+	int gpio_irq = MXC_INTERNAL_IRQS + ARCH_NR_GPIOS;
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	struct iomux_v3_pad_data *pad_data;
+
+	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
+	if (node) {
+		of_id = of_match_node(imx51_iomuxc_of_match, node);
+		pad_data = (struct iomux_v3_pad_data *) of_id->data;
+		mxc_iomux_v3_setup_multiple_pads(pad_data->pads, pad_data->num);
+		of_node_put(node);
+	}
+
+	irq_domain_generate_simple(imx51_tzic_of_match, MX51_TZIC_BASE_ADDR, 0);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO1_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO2_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO3_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO4_BASE_ADDR, gpio_irq);
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
+	.timer		= &imx51_timer,
+	.init_machine	= imx51_dt_init,
+	.dt_compat	= imx51_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index df6acc0..1a6748b 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -15,6 +15,8 @@
 
 #include <mach/iomux-v3.h>
 
+extern struct iomux_v3_pad_data imx51_babbage_pad_data;
+
 /* Pad control groupings */
 #define MX51_UART_PAD_CTRL	(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_DSE_HIGH | \
 				PAD_CTL_HYS | PAD_CTL_SRE_FAST)
-- 
1.7.4.1
