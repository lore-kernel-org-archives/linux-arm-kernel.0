From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:01 +0200
Subject: [PATCH 05/30] arm64: dts: r8a7795: salvator-x: enable usb2_phy of
 channel 0
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <a905b72ce9216a501d8239a1f1790817b5645ef9.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch also adds a regulator node for USB2.0 to handle VBUS on/off
by the phy-rcar-gen3-usb2 driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 98f02631a0f0..8c8bfdccdc2b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -110,6 +110,17 @@
 			  1800000 0>;
 	};
 
+	vbus0_usb2: regulator-vbus0-usb2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB20_VBUS0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	audio_clkout: audio_clkout {
 		/*
 		 * This is same as <&rcar_sound 0>
@@ -193,6 +204,11 @@
 		function = "audio_clk";
 	};
 
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
+
 	usb1_pins: usb1 {
 		groups = "usb1";
 		function = "usb1";
@@ -369,6 +385,14 @@
 	status = "okay";
 };
 
+&usb2_phy0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+
+	vbus-supply = <&vbus0_usb2>;
+	status = "okay";
+};
+
 &usb2_phy1 {
 	pinctrl-0 = <&usb1_pins>;
 	pinctrl-names = "default";
-- 
2.7.0.rc3.207.g0ac5344
