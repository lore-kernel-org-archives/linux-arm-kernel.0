From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:30 +0200
Subject: [PATCH 9/9] ARM: dts: TQma53: describe the full power supply tree
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-10-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

       |<--- mba53 devel baseboard --->|<----- TQma53 CPU card ----->|
       |                               |                             |
+12 V -|-o--> 3.3 V ----> internal use |                             |
       | |                             |                             |
       | \--> 5.0 V -o--> internal use | /--> 3.8 V --> PMIC         |
       |             |                 | |                           |
       |             \---------------->|-o--> 3.2 V --> internal use |
       |                               |

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts   | 36 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx53-tqma53.dtsi |  9 +++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index fb50ed8cc8f47..b5e1b9b373bf5 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -44,6 +44,32 @@
 		};
 	};
 
+	main_power_in_12p0v: mainpowerin {
+		/* external power-in */
+		compatible = "regulator-fixed";
+		regulator-name = "12P0V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	reg_5p0v: base5p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_power_in_12p0v>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: base3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&main_power_in_12p0v>;
+		regulator-always-on;
+	};
 
 	reg_backlight: backlight {
 		compatible = "regulator-fixed";
@@ -67,6 +93,14 @@
 	};
 };
 
+&reg_3p2v {
+	vin-supply = <&reg_5p0v>;
+};
+
+&reg_3p8v {
+	vin-supply = <&reg_5p0v>;
+};
+
 &ldb {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lvds1_1>;
@@ -192,7 +226,7 @@
 };
 
 &esdhc2 {
-	vmmc-supply = <&reg_3p2v>;
+	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 1ab5fbab1d728..ff4608b7318f4 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -27,6 +27,14 @@
 		regulator-max-microvolt = <3200000>;
 		regulator-always-on;
 	};
+
+	reg_3p8v: card3p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P8V";
+		regulator-min-microvolt = <3800000>;
+		regulator-max-microvolt = <3800000>;
+		regulator-always-on;
+	};
 };
 
 &esdhc2 {
@@ -264,6 +272,7 @@
 		fsl,mc13xxx-uses-rtc;
 		interrupt-parent = <&gpio2>;
 		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+		/* power supply input is &reg_3p8v */
 	};
 
 	sensor1: lm75 at 48 {
-- 
2.11.0
