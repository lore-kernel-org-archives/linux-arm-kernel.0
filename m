From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Nov 2018 14:03:07 +0100
Subject: [PATCH 05/16] ARM: dts: iwg23s-sbc: Add uSD and eMMC support
In-Reply-To: <cover.1543409901.git.horms+renesas@verge.net.au>
References: <cover.1543409901.git.horms+renesas@verge.net.au>
Message-ID: <9eb36b945b5c21d57c02a26cc629dd9484ced9aa.1543409901.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add uSD card and eMMC support to the iwg23s single board
computer powered by the RZ/G1C SoC (a.k.a. r8a77470).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 76 +++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 22da819f186b..e5cfb50ddce3 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -6,6 +6,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "r8a77470.dtsi"
 / {
 	model = "iWave iW-RainboW-G23S single board computer based on RZ/G1C";
@@ -25,6 +26,37 @@
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x20000000>;
 	};
+
+	reg_1p8v: reg-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: reg-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vccq_sdhi2: regulator-vccq-sdhi2 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI2 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &avb {
@@ -46,10 +78,28 @@
 };
 
 &pfc {
+	mmc_pins_uhs: mmc_uhs {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
 	scif1_pins: scif1 {
 		groups = "scif1_data_b";
 		function = "scif1";
 	};
+
+	sdhi2_pins: sd2 {
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <3300>;
+	};
+
+	sdhi2_pins_uhs: sd2_uhs {
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <1800>;
+	};
 };
 
 &scif1 {
@@ -58,3 +108,29 @@
 
 	status = "okay";
 };
+
+&sdhi1 {
+	pinctrl-0 = <&mmc_pins_uhs>;
+	pinctrl-names = "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	status = "okay";
+};
+
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-1 = <&sdhi2_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vccq_sdhi2>;
+	bus-width = <4>;
+	cd-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
+	status = "okay";
+};
-- 
2.11.0
