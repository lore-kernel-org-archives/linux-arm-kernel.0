From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Aug 2018 22:50:31 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: v3msk: add eMMC support
In-Reply-To: <1af46bf9-d9e5-8dcf-0ac7-a85e7348a34e@cogentembedded.com>
References: <1af46bf9-d9e5-8dcf-0ac7-a85e7348a34e@cogentembedded.com>
Message-ID: <9da672a2-0269-4860-8912-189414b43d4c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the eMMC chip support for the V3M Started Kit board.

Based on the original (and large) patches by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts |   26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
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
