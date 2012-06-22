From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Jun 2012 17:14:00 -0600
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
Message-ID: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Seaboard uses a TPS6586x regulator. Instantiate this, and hook up a
couple of fixed GPIO-controlled regulators too.

The regulator configurations were mostly taken from the ChromeOS 3.2
kernel. Exceptions are:

* The schematic lists a fixed voltage for each rail, whereas the ChromeOS
  kernel lists a range for many rails. I used the values from the ChromeOS
  kernel in all cases, since I know the board file there is the most
  complete available for this hardware.

* The vdd_1v2 fixed regulator is present only in the schematic. So, I added
  this based on the schematic.

* A 3.3v fixed regulator using GPIO3 of the TPS6586x is present in the
  ChromeOS kernel, but not in the schematic. So, I dropped this based on
  the schematic.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |  164 ++++++++++++++++++++++++++++++++
 1 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 85e621a..fe2bdd0 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -374,6 +374,141 @@
 		status = "okay";
 		clock-frequency = <400000>;
 
+		pmic: tps6586x at 34 {
+			compatible = "ti,tps6586x";
+			reg = <0x34>;
+			interrupts = <0 86 0x4>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				regulator at 0 {
+					reg = <0>;
+					regulator-compatible = "sm0";
+					regulator-name = "vdd_sm0";
+					regulator-min-microvolt = < 950000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-always-on;
+				};
+
+				regulator at 1 {
+					reg = <1>;
+					regulator-compatible = "sm1";
+					regulator-name = "vdd_sm1";
+					regulator-min-microvolt = < 750000>;
+					regulator-max-microvolt = <1275000>;
+					regulator-always-on;
+				};
+
+				sm2_reg: regulator at 2 {
+					reg = <2>;
+					regulator-compatible = "sm2";
+					regulator-name = "vdd_sm2";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <4550000>;
+					regulator-always-on;
+				};
+
+				regulator at 3 {
+					reg = <3>;
+					regulator-compatible = "ldo0";
+					regulator-name = "vdd_ldo0";
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 4 {
+					reg = <4>;
+					regulator-compatible = "ldo1";
+					regulator-name = "vdd_ldo1";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 5 {
+					reg = <5>;
+					regulator-compatible = "ldo2";
+					regulator-name = "vdd_ldo2";
+					regulator-min-microvolt = < 900000>;
+					regulator-max-microvolt = <1300000>;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 6 {
+					reg = <6>;
+					regulator-compatible = "ldo3";
+					regulator-name = "vdd_ldo3";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 7 {
+					reg = <7>;
+					regulator-compatible = "ldo4";
+					regulator-name = "vdd_ldo4";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 8 {
+					reg = <8>;
+					regulator-compatible = "ldo5";
+					regulator-name = "vdd_ldo5";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 9 {
+					reg = <9>;
+					regulator-compatible = "ldo6";
+					regulator-name = "vdd_ldo6";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 10 {
+					reg = <10>;
+					regulator-compatible = "ldo7";
+					regulator-name = "vdd_ldo7";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 11 {
+					reg = <11>;
+					regulator-compatible = "ldo8";
+					regulator-name = "vdd_ldo8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					vin-supply = <&sm2_reg>;
+				};
+
+				regulator at 12 {
+					reg = <12>;
+					regulator-compatible = "ldo9";
+					regulator-name = "vdd_ldo9";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+					vin-supply = <&sm2_reg>;
+				};
+			};
+		};
+
 		temperature-sensor at 4c {
 			compatible = "nct1008";
 			reg = <0x4c>;
@@ -387,6 +522,10 @@
 		};
 	};
 
+	pmc {
+		nvidia,invert-interrupt;
+	};
+
 	memory-controller at 0x7000f400 {
 		emc-table at 190000 {
 			reg = <190000>;
@@ -473,6 +612,31 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vdd_1v5";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			gpio = <&pmic 0 0>;
+		};
+
+		regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_1v2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			gpio = <&pmic 1 0>;
+			enable-active-high;
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-seaboard",
 			     "nvidia,tegra-audio-wm8903";
-- 
1.7.0.4
