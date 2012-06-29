From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Jun 2012 16:04:46 -0600
Subject: [PATCH V2] ARM: dt: tegra: ventana: add regulators
Message-ID: <1341007486-16429-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Ventana uses a TPS6586x regulator. Instantiate this, and hook up a
couple of fixed GPIO-controlled regulators too.

The data was chosen to match the PMIC HW defaults, with the following
exception:

ldo0: The HW default is 1.2v. On similar board designs, this rail is
typically used for the PCIe clock which requires 3.3v. Note that this
rail isn't actually used on this board.

ldo6: The HW default is 2.85v. The schematics are unlabelled. Internal
research indicates that 1.8v is correct. Our downstream kernel also uses
1.8v.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Made all constraints match the HW defaults to avoid behavior changes,
  with exceptions noted above.
* Removed vin-supply properties from LDO nodes; the driver and binding
  need to be updated to support specifying the parent regulators before
  we can put these into DT.
* Rename vdd_pnl regulator-name to match schematic.
* Added vdd_bl regulator.
* Fix typo in regulator at 3 reg property.
* Use the enumerated-bus compatible value for the /regulators node.
* Enhanced all regulator-name properties to list all signal names directly
  derived from the regulator pins.
* Added ldo_rtc regulator.
---
 arch/arm/boot/dts/tegra20-ventana.dts |  184 +++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index be90544..2934fe1 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -289,6 +289,145 @@
 	i2c at 7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
+
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
+					regulator-name = "vdd_sm0,vdd_core";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				regulator at 1 {
+					reg = <1>;
+					regulator-compatible = "sm1";
+					regulator-name = "vdd_sm1,vdd_cpu";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				sm2_reg: regulator at 2 {
+					reg = <2>;
+					regulator-compatible = "sm2";
+					regulator-name = "vdd_sm2,vin_ldo*";
+					regulator-min-microvolt = <3700000>;
+					regulator-max-microvolt = <3700000>;
+					regulator-always-on;
+				};
+
+				regulator at 3 {
+					reg = <3>;
+					regulator-compatible = "ldo0";
+					regulator-name = "vdd_ldo0";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 4 {
+					reg = <4>;
+					regulator-compatible = "ldo1";
+					regulator-name = "vdd_ldo1,avdd_pll*";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				regulator at 5 {
+					reg = <5>;
+					regulator-compatible = "ldo2";
+					regulator-name = "vdd_ldo2,vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				regulator at 6 {
+					reg = <6>;
+					regulator-compatible = "ldo3";
+					regulator-name = "vdd_ldo3,avdd_usb*";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 7 {
+					reg = <7>;
+					regulator-compatible = "ldo4";
+					regulator-name = "vdd_ldo4,avdd_osc,vddio_sys";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				regulator at 8 {
+					reg = <8>;
+					regulator-compatible = "ldo5";
+					regulator-name = "vdd_ldo5,vcore_mmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 9 {
+					reg = <9>;
+					regulator-compatible = "ldo6";
+					regulator-name = "vdd_ldo6,avdd_vdac";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 10 {
+					reg = <10>;
+					regulator-compatible = "ldo7";
+					regulator-name = "vdd_ldo7,avdd_hdmi,vdd_fuse";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 11 {
+					reg = <11>;
+					regulator-compatible = "ldo8";
+					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 12 {
+					reg = <12>;
+					regulator-compatible = "ldo9";
+					regulator-name = "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 13 {
+					reg = <13>;
+					regulator-compatible = "ldo_rtc";
+					regulator-name = "vdd_rtc_out,vdd_cell";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
+	pmc {
+		nvidia,invert-interrupt;
 	};
 
 	usb at c5000000 {
@@ -317,6 +456,51 @@
 		bus-width = <8>;
 	};
 
+	regulators {
+		compatible = "enumerated-bus";
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
+
+		regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "vdd_pnl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio 22 0>; /* gpio PC6 */
+			enable-active-high;
+		};
+
+		regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_bl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio 176 0>; /* gpio PW0 */
+			enable-active-high;
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-ventana",
 			     "nvidia,tegra-audio-wm8903";
-- 
1.7.0.4
