From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:53 +0100
Subject: [PATCH 34/52] ARM: dts: lager: use demuxer for IIC3/I2C3
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <e6081b21a19156c982f757cb1b6753cfb7e93ebc.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Create a separate bus for da9063 PMIC and da9210 regulator
related I2C slaves.

Based on similar work for HDMI by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased, corrected chip name in commit msg, updated aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 84 +++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9f511d4fac10..20c1b4f224b8 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -55,6 +55,7 @@
 		i2c10 = &i2cexio0;
 		i2c11 = &i2cexio1;
 		i2c12 = &i2chdmi;
+		i2c13 = &i2cpwr;
 	};
 
 	chosen {
@@ -418,6 +419,46 @@
 			};
 		};
 	};
+
+	/*
+	 * IIC3 and I2C3 may be switched using pinmux.
+	 * IIC3/I2C3 does not appear to support fallback to GPIO.
+	 */
+	i2cpwr: i2c-13 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic3>, <&i2c3>;
+		i2c-bus-name = "i2c-pwr";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic at 58 {
+			compatible = "dlg,da9063";
+			reg = <0x58>;
+			interrupt-parent = <&irqc0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+
+			rtc {
+				compatible = "dlg,da9063-rtc";
+			};
+
+			wdt {
+				compatible = "dlg,da9063-watchdog";
+			};
+		};
+
+		vdd_dvfs: regulator at 68 {
+			compatible = "dlg,da9210";
+			reg = <0x68>;
+			interrupt-parent = <&irqc0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
 };
 
 &du {
@@ -557,6 +598,11 @@
 		function = "iic2";
 	};
 
+	i2c3_pins: i2c3 {
+		groups = "i2c3";
+		function = "i2c3";
+	};
+
 	iic3_pins: iic3 {
 		groups = "iic3";
 		function = "iic3";
@@ -772,38 +818,14 @@
 	clock-frequency = <100000>;
 };
 
-&iic3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&iic3_pins>;
-	status = "okay";
-
-	pmic at 58 {
-		compatible = "dlg,da9063";
-		reg = <0x58>;
-		interrupt-parent = <&irqc0>;
-		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-
-		rtc {
-			compatible = "dlg,da9063-rtc";
-		};
-
-		wdt {
-			compatible = "dlg,da9063-watchdog";
-		};
-	};
-
-	vdd_dvfs: regulator at 68 {
-		compatible = "dlg,da9210";
-		reg = <0x68>;
-		interrupt-parent = <&irqc0>;
-		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+&i2c3	{
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "i2c-pwr";
+};
 
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <1000000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
+&iic3	{
+	pinctrl-0 = <&iic3_pins>;
+	pinctrl-names = "i2c-pwr";
 };
 
 &pci0 {
-- 
2.11.0
