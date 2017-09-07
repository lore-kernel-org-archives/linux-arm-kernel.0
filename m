From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:27 +0200
Subject: [PATCH 6/9] ARM: dts: TQma53: fix and move regulator to its correct
 location
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-7-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The referenced 3.3 V regulator is a 3.2 V regulator and part of the 'TQma53'
CPU card instead of the development 'mba53' baseboard. So fix the voltage
and move it to where it belongs to.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts   | 10 +---------
 arch/arm/boot/dts/imx53-tqma53.dtsi | 14 +++++++-------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 69733c8473d2b..5b9e9af14aa6c 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -52,14 +52,6 @@
 		startup-delay-us = <5000>;
 	};
 
-	reg_3p2v: base3p2v {
-		compatible = "regulator-fixed";
-		regulator-name = "3P2V";
-		regulator-min-microvolt = <3200000>;
-		regulator-max-microvolt = <3200000>;
-		regulator-always-on;
-	};
-
 	sound {
 		compatible = "tq,imx53-mba53-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -193,7 +185,7 @@
 };
 
 &esdhc2 {
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&reg_3p2v>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index fa5d712bd47b8..02eb3f4b605de 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -20,11 +20,11 @@
 		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
 	};
 
-	reg_3p3v: card3p3v {
+	reg_3p2v: card3p2v {
 		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-name = "3P2V";
+		regulator-min-microvolt = <3200000>;
+		regulator-max-microvolt = <3200000>;
 		regulator-always-on;
 	};
 };
@@ -33,7 +33,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>,
 		    <&pinctrl_esdhc2_cdwp>;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p2v>;
 	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "disabled";
@@ -56,8 +56,8 @@
 &esdhc3 { /* EMMC */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc3>;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&reg_3p2v>;
+	vqmmc-supply = <&reg_3p2v>;
 	non-removable;
 	bus-width = <8>;
 	status = "okay";
-- 
2.11.0
