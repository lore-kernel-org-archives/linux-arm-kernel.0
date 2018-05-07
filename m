From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  7 May 2018 23:18:17 +0800
Subject: [PATCH 5/5] arm64: allwinner: h6: enable USB3 port on Pine H64
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Message-ID: <20180507151817.55663-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine H64 board have a USB3 port, which is connected to the USB3 pins of
the H6 SoC, and the 5V power supply is controlled via GPIO (shared with
the power USB ports).

Enable this port.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index b6f2d6b2ecae..e2e262b4e3d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -20,6 +20,20 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb_vbus: vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <100000>;
+		gpio = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&dwc3 {
+	status = "okay";
 };
 
 &r_i2c {
@@ -37,3 +51,12 @@
 	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3phy {
+	phy-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
-- 
2.17.0
