From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Nov 2017 17:28:24 +0100
Subject: [PATCH 3/4] ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board
 support
In-Reply-To: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
References: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1511281705-30849-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the i.MX6 Quad variant of the Variscite DART-MX6
SoM Carrier-Board.

This Carrier-Board has the following :
- LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
- HDMI Connector
- USB Host + USB OTG Connector
- 10/100/1000 Mbps Ethernet
- miniPCI-Express slot
- SD Card connector
- Audio Headphone/Line In jack connectors
- On-board DMIC
- CAN bus header
- SPI header
- Camera Interfaces header
- 4xButtons, 2xLeds
- OnBoard RTC with Coin Backup battery socket
- RS232 Header + USB-Serial debug port

Product Page : http://www.variscite.com/products/evaluation-kits/dart-mx6-kits

The board support is done with all on-board and header interfaces enabled.
7" LVDS Touchscreen is enabled by default along HDMI output.
Audio interface is supported with the "simple-card" bindings.

On-Board DMIC and Camera Interfaces are not handled yet.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts | 247 +++++++++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-var-dt6customboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9..148ff15 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -470,6 +470,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-tx6q-11x0-mb7.dtb \
 	imx6q-udoo.dtb \
 	imx6q-utilite-pro.dtb \
+	imx6q-var-dt6customboard.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
 	imx6q-wandboard-revd1.dtb \
diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
new file mode 100644
index 0000000..eb4483d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
@@ -0,0 +1,247 @@
+/*
+ * Support for Variscite DART-MX6 Carrier-board
+ *
+ * Copyright 2017 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-var-dart.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
+
+/ {
+	model = "Variscite DART-MX6 Carrier-board";
+	compatible = "variscite,dt6customboard", "fsl,imx6q";
+
+	backlight_lvds: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 50000>;
+		brightness-levels = <0 4 8 16 32 64 128 248>;
+		default-brightness-level = <7>;
+		status = "okay";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		button at 0 {
+			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			label = "Key Back";
+			linux,input-type = <1>;
+			debounce-interval = <100>;
+			gpio-key,wakeup;
+		};
+
+		button at 1 {
+			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			label = "Key Home";
+			linux,input-type = <1>;
+			debounce-interval = <100>;
+			gpio-key,wakeup;
+		};
+
+		button at 2 {
+			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+			label = "Key Menu";
+			linux,input-type = <1>;
+			debounce-interval = <100>;
+			gpio-key,wakeup;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led2 {
+			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	panel1: lvds-panel {
+		compatible = "sgd,gktw70sdae4se", "panel-lvds";
+		backlight = <&backlight_lvds>;
+
+		width-mm = <153>;
+		height-mm = <86>;
+
+		label = "gktw70sdae4se";
+
+		data-mapping = "jeida-18";
+
+		panel-timing {
+			clock-frequency = <32000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hback-porch = <39>;
+			hfront-porch = <39>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			hsync-len = <47>;
+			vsync-len = <2>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds1_out>;
+			};
+		};
+	};
+
+	reg_usb_h1_vbus: regulator-usbh1vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 28 0>;
+		enable-active-high;
+	};
+
+	reg_usb_otg_vbus: regulator-usbotgvbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 15 0>;
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "dt6-customboard-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_codec>;
+		simple-audio-card,frame-master = <&sound_codec>;
+		simple-audio-card,widgets = "Headphone", "Headphone Jack",
+					    "Line", "Line In";
+		simple-audio-card,routing = "Headphone Jack", "HPLOUT",
+					    "Headphone Jack", "HPROUT",
+					    "LINE1L", "Line In",
+					    "LINE1R", "Line In";
+
+		sound_cpu: simple-audio-card,cpu {
+			sound-dai = <&ssi2>;
+		};
+
+		sound_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clks IMX6QDL_CLK_CKO>;
+		};
+	};
+};
+
+&can1 {
+	status = "okay";
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>,
+		   <&gpio4 10 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&fec {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio1 25 0>;
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c1>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	touchscreen at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	rtc at 68 {
+		compatible = "isil,isl12057";
+		reg = <0x68>;
+	};
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel at 1 {
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds1_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&pcie {
+	reset-gpio    = <&gpio4 11 0>;
+	wake-up-gpio  = <&gpio4 31 1>;
+	disable-gpio  = <&gpio5 5 0>;
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	dr_mode = "otg";
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usdhc2 {
+	cd-gpios = <&gpio1 6 1>;
+	status = "okay";
+};
-- 
2.7.4
