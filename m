From: sz.lin@moxa.com (SZ Lin)
Date: Thu, 16 Nov 2017 22:58:57 +0800
Subject: [PATCH] arm, ls1021a: add support for Moxa UC-8410A open platform
Message-ID: <20171116145858.25966-1-sz.lin@moxa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Moxa UC-8410A open platform

The UC-8410A computing platform is designed
for embedded communication-centric industrial applications

The features of UC-8410A are:
* QSPI flash
* SD slot
* 3x LAN
* 8x RS-232/422/485 ports, software-selectable
* Mini PCIe form factor with PCIe/USB signal
* 2x USB host
* TPM
* Watchdog
* RTC
* User LEDs
* Beeper

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
Signed-off-by: Harry YJ Jhou <harryyj.jhou@moxa.com>
Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 230 ++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eff87a344566..0165fbcb1d10 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -495,6 +495,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-warp.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
+	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
 	ls1021a-twr.dtb
 dtb-$(CONFIG_SOC_VF610) += \
diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
new file mode 100644
index 000000000000..4896b551505b
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2017 Moxa Inc. - https://www.moxa.com/
+ *
+ * Author: Harry YJ Jhou (???) <harryyj.jhou@moxa.com>
+ *         Jimmy Chen (???)    <jimmy.chen@moxa.com>
+ *         SZ Lin (???)        <sz.lin@moxa.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "ls1021a.dtsi"
+
+/ {
+	model = "Moxa UC-8410A";
+
+	aliases {
+		enet0_rgmii_phy = &rgmii_phy0;
+		enet1_rgmii_phy = &rgmii_phy1;
+		enet2_rgmii_phy = &rgmii_phy2;
+	};
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		cel_pwr {
+			label = "UC8410A:CEL_PWR";
+			gpios = <&gpio3 23 1>;
+			default-state = "off";
+		};
+
+		cel_reset {
+			label = "UC8410A:CEL_RESET";
+			gpios = <&gpio3 24 1>;
+			default-state = "off";
+		};
+
+		str_led {
+			label = "UC8410A:RED:PROG";
+			gpios = <&gpio0 16 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		sw_ready {
+			label = "UC8410A:GREEN:SWRDY";
+			gpios = <&gpio0 18 0>;
+			default-state = "on";
+		};
+
+		beeper {
+			label = "UC8410A:BEEP";
+			gpios = <&gpio0 20 0>;
+			default-state = "off";
+		};
+
+		prog_led0 {
+			label = "UC8410A:GREEN:PROG2";
+			gpios = <&gpio3 14 0>;
+			default-state = "off";
+		};
+
+		prog_led1 {
+			label = "UC8410A:GREEN:PROG1";
+			gpios = <&gpio3 15 0>;
+			default-state = "off";
+		};
+
+		prog_led2 {
+			label = "UC8410A:GREEN:PROG0";
+			gpios = <&gpio3 16 0>;
+			default-state = "off";
+		};
+
+		wifi_signal0 {
+			label = "UC8410A:GREEN:CEL2";
+			gpios = <&gpio3 17 0>;
+			default-state = "off";
+		};
+
+		wifi_signal1 {
+			label = "UC8410A:GREEN:CEL1";
+			gpios = <&gpio3 18 0>;
+			default-state = "off";
+		};
+
+		wifi_signal2 {
+			label = "UC8410A:GREEN:CEL0";
+			gpios = <&gpio3 19 0>;
+			default-state = "off";
+		};
+
+		cpu_diag_red {
+			label = "UC8410A:RED:DIA";
+			gpios = <&gpio3 20 0>;
+			default-state = "off";
+		};
+
+		cpu_diag_green {
+			label = "UC8410A:GREEN:DIA";
+			gpios = <&gpio3 21 0>;
+			default-state = "off";
+		};
+
+		cpu_diag_yellow {
+			label = "UC8410A:YELLOW:DIA";
+			gpios = <&gpio3 22 0>;
+			default-state = "off";
+		};
+	};
+};
+
+&enet0 {
+	phy-handle = <&rgmii_phy0>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
+&enet1 {
+	phy-handle = <&rgmii_phy1>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
+&enet2 {
+	phy-handle = <&rgmii_phy2>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	rtc: rtc at 68 {
+		compatible = "dallas,ds1374";
+		reg = <0x68>;
+	};
+
+	tpm: tpm at 20 {
+		compatible = "infineon,slb9635tt";
+		reg = <0x20>;
+	};
+};
+
+&lpuart0 {
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy at 0 {
+		compatible = "marvell,88e1118";
+		reg = <0x0>;
+		marvell,reg-init =
+			<3 0x11 0 0x4415>, /* Reg 3,17 */
+			<3 0x10 0 0x77>; /* Reg 3,16 */
+	};
+	rgmii_phy1: ethernet-phy at 1 {
+		compatible = "marvell,88e1118";
+		reg = <0x1>;
+		marvell,reg-init =
+			<3 0x11 0 0x4415>, /* Reg 3,17 */
+			<3 0x10 0 0x77>; /* Reg 3,16 */
+	};
+	rgmii_phy2: ethernet-phy at 2 {
+		compatible = "marvell,88e1118";
+		reg = <0x2>;
+		marvell,reg-init =
+			<3 0x11 0 0x4415>, /* Reg 3,17 */
+			<3 0x10 0 0x77>; /* Reg 3,16 */
+	};
+};
+
+&qspi {
+	status = "okay";
+	bus-num = <0>;
+	fsl,spi-num-chipselects = <2>;
+	fsl,spi-flash-chipselects = <0>;
+	fsl,qspi-has-second-chip;
+	flash: flash at 0 {
+		compatible = "spansion,s25fl064l", "spansion,s25fl164k";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+
+		partitions at 0 {
+			label = "U-Boot";
+			reg = <0x0 0x180000>;
+		};
+		partitions at 1 {
+			label = "U-Boot Env";
+			reg = <0x180000 0x680000>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.15.0
