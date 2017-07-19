From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 20 Jul 2017 00:10:19 +0800
Subject: [PATCH 5/5] arm: allwinner: a64: drop vcc3v3 and vcc1v8 dummy
 regulators for SoPine
In-Reply-To: <20170719161019.62133-1-icenowy@aosc.io>
References: <20170719161019.62133-1-icenowy@aosc.io>
Message-ID: <20170719161019.62133-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree of SoPine SoM and its baseboard used to contain two
dummy regulators: vcc3v3 and vcc1v8.

As proper AXP803 regulator support is added, drop the dummy regulators,
and use the correct ones.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 11 ++---------
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi          | 11 +----------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 834a5d249bb2..58346381e486 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -59,13 +59,6 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-
-	reg_vcc1v8: vcc1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
 };
 
 &ehci0 {
@@ -95,8 +88,8 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc1v8>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_eldo1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 7adfd013fd60..a7eb9c197023 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -45,19 +45,10 @@
 
 #include "sun50i-a64.dtsi"
 
-/ {
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	non-removable;
 	disable-wp;
 	bus-width = <4>;
-- 
2.13.0
