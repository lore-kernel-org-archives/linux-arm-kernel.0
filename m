From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:14 +0200
Subject: [PATCH 19/58] arm64: dts: renesas: v3msk: add eMMC support
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <8d9923b3a2f6c0e4ad3f9d9cad6e9010cf0d67e6.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the eMMC chip support for the V3M Started Kit board.

Based on the original (and large) patches by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index 8eac8ca6550b..0dbcb4cccc18 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -51,6 +51,15 @@
 		regulator-always-on;
 	};
 
+	vcc_vddq_vin0: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_VDDQ_VIN0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	lvds-decoder {
 		compatible = "thine,thc63lvd1024";
 		vcc-supply = <&vcc_d3_3v>;
@@ -128,6 +137,12 @@
 		function = "i2c0";
 	};
 
+	mmc_pins: mmc_3_3v {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+		power-source = <3300>;
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
@@ -192,6 +207,17 @@
 	};
 };
 
+&mmc0 {
+	pinctrl-0 = <&mmc_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_d3_3v>;
+	vqmmc-supply = <&vcc_vddq_vin0>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
-- 
2.11.0
