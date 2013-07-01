From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 01 Jul 2013 22:23:14 +0200
Subject: [PATCH] arm: kirkwood: readynas duo v2: Add GMT G762 Fan Controller
 DT bindings
Message-ID: <87sizyuj0t.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that GMT G762 PWM Fan Controller is available upstream, let's add
missing bindings in Netgear ReadyNAS Duo v2 .dts file. Let's also take
the opportunity to fix space issues at the end of the file.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Jason and Andrew,

This one applies and has been tested against Stephen Rothwell tree.
Can you make it flow to Linus tree during the merge window? Thanks
in advance.

Cheers,

a+

 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 54 +++++++++++++++-------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index ad6ade7..796a307 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -52,6 +52,17 @@
 			};
 		};
 
+		clocks {
+		       #address-cells = <1>;
+		       #size-cells = <0>;
+
+		       g762_clk: fixedclk {
+				 compatible = "fixed-clock";
+				 #clock-cells = <0>;
+				 clock-frequency = <8192>;
+		       };
+		};
+
 		i2c at 11000 {
 			status = "okay";
 
@@ -59,6 +70,15 @@
 				compatible = "ricoh,rs5c372a";
 				reg = <0x32>;
 			};
+
+			g762: g762 at 3e {
+				compatible = "gmt,g762";
+				reg = <0x3e>;
+				clocks = <&g762_clk>; /* input clock */
+				fan_gear_mode = <0>;
+				fan_startv = <1>;
+				pwm_polarity = <0>;
+			};
 		};
 
 		serial at 12000 {
@@ -166,21 +186,21 @@
 		};
 	};
 
-        regulators {
-                compatible = "simple-bus";
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                usb_power: regulator at 1 {
-                        compatible = "regulator-fixed";
-                        reg = <1>;
-                        regulator-name = "USB 3.0 Power";
-                        regulator-min-microvolt = <5000000>;
-                        regulator-max-microvolt = <5000000>;
-                        enable-active-high;
-                        regulator-always-on;
-                        regulator-boot-on;
-                        gpio = <&gpio1 14 0>;
-                };
-        };
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB 3.0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 14 0>;
+		};
+	};
 };
-- 
1.8.3.1
