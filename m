From: kunadt@schleissheimer.de (Ivo Kunadt)
Date: Tue, 11 Jun 2013 13:08:14 +0200
Subject: [PATCH] ARM: dts: imx35: Add kernel oftree support
Message-ID: <1370948894-757-1-git-send-email-kunadt@schleissheimer.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for imx35-based devices to
the kernel.

Signed-off-by: Ivo Kunadt <kunadt@schleissheimer.de>
---
 arch/arm/boot/dts/imx35.dtsi         | 350 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig |   1 +
 arch/arm/mach-imx/Kconfig            |  12 ++
 arch/arm/mach-imx/Makefile           |   1 +
 arch/arm/mach-imx/imx35-dt.c         |  47 +++++
 5 files changed, 411 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx35.dtsi
 create mode 100644 arch/arm/mach-imx/imx35-dt.c

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
new file mode 100644
index 0000000..1f0a58f
--- /dev/null
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -0,0 +1,350 @@
+/*
+ * Copyright 2012 Steffen Trumtrar, Pengutronix
+ *
+ * based on imx27.dtsi
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		usb0 = &usbotg;
+		usb1 = &usbhost1;
+	};
+
+	avic: avic-interrupt-controller at 68000000 {
+		compatible = "fsl,imx35-avic", "fsl,avic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x68000000 0x10000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ckil {
+			compatible = "fsl,imx-ckil", "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		osc {
+			compatible = "fsl,imx-osc", "fixed-clock";
+			clock-frequency = <24000000>;
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
+		l2-cache at 30000000 {
+			compatible = "arm,l210-cache";
+			reg = <0x30000000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		aips at 43f00000 { /* AIPS1 */
+			compatible = "fsl,aips", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x43f00000 0x100000>;
+			ranges;
+
+			i2c1: i2c at 43f80000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
+				reg = <0x43f80000 0x4000>;
+				interrupts = <10>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 43f84000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
+				reg = <0x43f84000 0x4000>;
+				interrupts = <3>;
+				status = "disabled";
+			};
+
+			uart1: serial at 43f90000 {
+				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
+				reg = <0x43f90000 0x4000>;
+				interrupts = <45>;
+				status = "disabled";
+			};
+
+			uart2: serial at 43f94000 {
+				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
+				reg = <0x43f94000 0x4000>;
+				interrupts = <32>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 43f98000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
+				reg = <0x43f98000 0x4000>;
+				interrupts = <4>;
+				status = "disabled";
+			};
+
+			ssi1: ssi at 43fa0000 {
+				compatible = "fsl,imx35-ssi", "fsl,imx21-ssi";
+				reg = <0x43fa0000 0x4000>;
+				interrupts = <11>;
+				fsl,ssi-dma-events = <29 28 27 26>;
+				status = "disabled";
+			};
+
+			cspi at 43fa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx35-cspi";
+				reg = <0x43fa4000 0x1000>;
+				interrupts = <14>;
+				status = "disabled";
+			};
+
+			iomuxc at 43fac000 {
+				compatible = "fsl,imx35-iomuxc";
+				reg = <0x43fac000 0x4000>;
+
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <773 0x1c0 /* MX35_PAD_ATA_DATA12__I2C3_SCL */
+							777 0x1c0>; /* MX35_PAD_ATA_DATA13__I2C3_SDA */
+					};
+				};
+
+				can1 {
+					pinctrl_can1_1: can1grp-1 {
+						fsl,pins = <223 0x1c0 /* MX35_PAD_I2C2_CLK__CAN1_TXCAN */
+							228 0x1c0>; /* MX35_PAD_I2C2_DAT__CAN1_RXCAN */
+					};
+				};
+
+				can2 {
+					pinctrl_can2_1: can2grp-1 {
+						fsl,pins = <291 0x1c0 /* MX35_PAD_TX5_RX0__CAN2_TXCAN */
+							298 0x1c0>; /* MX35_PAD_TX4_RX1__CAN2_RXCAN */
+					};
+				};
+
+				cspi1 {
+					pinctrl_cspi1_1: cspi1grp-1 {
+						fsl,pins = <331 0x1c0 /* MX35_PAD_CSPI1_MOSI__CSPI1_MOSI */
+							334 0x1c0 /* MX35_PAD_CSPI1_MISO__CSPI1_MISO */
+							340 0x1c0 /* MX35_PAD_CSPI1_SS0__GPIO1_18 */
+							345 0x1c0 /* MX35_PAD_CSPI1_SCLK__CSPI1_SCLK */
+							352 0x1c0>; /* MX35_PAD_CSPI1_SPI_RDY__CSPI1_RDY */
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <356 0x1c0 /* MX35_PAD_RXD1__UART1_RXD_MUX */
+							361 0x1c0>; /* MX35_PAD_TXD1__UART1_TXD_MUX */
+					};
+				};
+
+				uart2 {
+					pinctrl_uart2_1: uart2grp-1 {
+						fsl,pins = <382 0x1c0 /* MX35_PAD_RXD2__UART2_RXD_MUX */
+						385 0x1c0 /* MX35_PAD_TXD2__UART2_TXD_MUX */
+						389 0x1c0 /* 0x1c0 /* MX35_PAD_RTS2__UART2_RTS */
+						397 0x1c0>; /* MX35_PAD_CTS2__UART2_CTS */
+					};
+				};
+
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <763 0x1c0 /* MX35_PAD_ATA_DATA10__UART3_RXD_MUX */
+							768 0x1c0>; /* MX35_PAD_ATA_DATA11__UART3_TXD_MUX */
+					};
+				};
+			};
+
+			spba at 50000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x50000000 0x100000>;
+				ranges;
+
+				uart3: serial at 5000c000 {
+					compatible = "fsl,imx35-uart", "fsl,imx21-uart";
+					reg = <0x5000c000 0x4000>;
+					interrupts = <18>;
+					status = "disabled";
+				};
+
+				cspi at 50010000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx35-cspi";
+					reg = <0x50010000 0x1000>;
+					interrupts = <13>;
+					status = "disabled";
+				};
+
+				fec at 50038000 {
+					compatible = "fsl,imx35-fec", "fsl,imx27-fec";
+					reg = <0x50038000 0x4000>;
+					interrupts = <57>;
+					status = "disabled";
+				};
+			};
+		};
+
+		aips at 53f00000 { /* AIPS2 */
+			compatible = "fsl,aips", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x53f00000 0x100000>;
+			ranges;
+
+			gpio3: gpio at 0x53fa4000 {
+				compatible = "fsl,imx35-gpio";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <56>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			esdhc1: esdhc at 53fb4000 {
+				compatible = "fsl,imx35-esdhc";
+				reg = <0x53fb4000 0x4000>;
+				interrupts = <7>;
+				status = "disabled";
+			};
+
+			esdhc2: esdhc at 53fb8000 {
+				compatible = "fsl,imx35-esdhc";
+				reg = <0x53fb8000 0x4000>;
+				interrupts = <8>;
+				status = "disabled";
+			};
+
+			esdhc3: esdhc at 53fbc000 {
+				compatible = "fsl,imx35-esdhc";
+				reg = <0x53fbc000 0x4000>;
+				interrupts = <9>;
+				status = "disabled";
+			};
+
+			gpio1: gpio at 0x53fcc000 {
+				compatible = "fsl,imx35-gpio";
+				reg = <0x53fcc000 0x4000>;
+				interrupts = <52>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio at 0x53fd0000 {
+				compatible = "fsl,imx35-gpio";
+				reg = <0x53fd0000 0x4000>;
+				interrupts = <51>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			wdog at 53fdc000 {
+				compatible = "fsl,imx35-wdt", "fsl,imx2-wdt";
+				reg = <0x53fdc000 0x4000>;
+				interrupts = <55>;
+			};
+
+			can at 53fe4000 {
+				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fe4000 0x1000>;
+				interrupts = <43>;
+				status = "disabled";
+			};
+
+			can at 53fe8000 {
+				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fe8000 0x1000>;
+				interrupts = <44>;
+				status = "disabled";
+			};
+
+			usbphy1: usbphy at 1 {
+				compatible = "nop-usbphy";
+				status = "disabled";
+			};
+
+			usbphy2: usbphy at 2 {
+				compatible = "nop-usbphy";
+				status = "disabled";
+			};
+
+			usbotg: usb at 53ff4000 {
+				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
+				reg = <0x53ff4000 0x0200>;
+				interrupts = <37>;
+				dr_mode = "otg";
+				fsl,usbmisc = <&usbmisc 0>;
+				status = "disabled";
+			};
+
+			usbhost1: usb at 53ff4400 {
+				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
+				reg = <0x53ff4400 0x0200>;
+				dr_mode = "host";
+				interrupts = <35>;
+				fsl,usbmisc = <&usbmisc 1>;
+				status = "disabled";
+			};
+
+			usbmisc: usbmisc at 53ff4600 {
+				#index-cells = <1>;
+				compatible = "fsl,imx35-usbmisc";
+				reg = <0x53ff4600 0x00f>;
+				status = "disabled";
+			};
+		};
+
+		emi at 80000000 { /* External Memory Interface */
+			compatible = "fsl,emi", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80000000 0x40000000>;
+			ranges;
+
+			nand at bb000000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				nand-ecc-mode = "hw";
+				compatible = "fsl,imx35-nand", "fsl,imx25-nand";
+				reg = <0xbb000000 0x2000>;
+				interrupts = <33>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6ec010f..f84721a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -33,6 +33,7 @@ CONFIG_MACH_KZM_ARM11_01=y
 CONFIG_MACH_PCM043=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_VPR200=y
+CONFIG_MACH_IMX35_DT=y
 CONFIG_MACH_IMX51_DT=y
 CONFIG_MACH_EUKREA_CPUIMX51SD=y
 CONFIG_SOC_IMX53=y
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ba44328..28eb972 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -713,6 +713,18 @@ config MACH_VPR200
	  Include support for VPR200 platform. This includes specific
	  configurations for the board and its peripherals.

+
+config MACH_IMX35_DT
+	bool "Support i.MX35 platforms from device tree"
+	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select PINCTRL
+	select PINCTRL_IMX35
+	help
+	  Include support for Freescale i.MX35 based platforms
+	  using the device tree for discovery
+
 endif

 if ARCH_MULTI_V7
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 70ae7c4..823fda3 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
+obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o

 obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
new file mode 100644
index 0000000..fd1023f
--- /dev/null
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2012 Steffen Trumtrar, Pengutronix
+ *
+ * based on imx27-dt.c
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/irq.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+#include "mx35.h"
+
+static void __init imx35_dt_init(void)
+{
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	platform_device_register_full(&devinfo);
+}
+
+static void __init imx35_timer_init(void)
+{
+	mx35_clocks_init();
+}
+
+static const char *imx35_dt_board_compat[] __initdata = {
+	"fsl,imx35",
+	NULL
+};
+
+DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
+	.map_io		= mx35_map_io,
+	.init_early	= imx35_init_early,
+	.init_irq	= mx35_init_irq,
+	.handle_irq	= imx35_handle_irq,
+	.init_time	= imx35_timer_init,
+	.init_machine	= imx35_dt_init,
+	.dt_compat	= imx35_dt_board_compat,
+	.restart	= mxc_restart,
+MACHINE_END
--
1.8.2.3
