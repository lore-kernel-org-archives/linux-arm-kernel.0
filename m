From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Jun 2012 16:04:24 -0600
Subject: [PATCH V2] ARM: dt: tegra: seaboard: add regulators
Message-ID: <1341007464-16391-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Seaboard uses a TPS6586x regulator. Instantiate this, and hook up a
couple of fixed GPIO-controlled regulators too.

Two data sources were used for the data encoded here:
* The HW defaults, as extracted from real HW.
* The schematic, which specifies a voltage for each LDO rail.

In most cases these sources matched. Differences are:

ldo0: The HW default is 1.2v. The schematic states this should be 3.3v.
On similar board designs, this rail is typically used for the PCIe clock
which requires 3.3v. Note that this rail isn't actually used on this
board.

ldo6: The HW default on Springbank is 2.85v. The HW default on Seaboard
is 1.8v. The schematics for both Springbank and Seaboard match at 2.85v.
However, internal research indicates that the schematics are incorrectly
labelled, and 1.8v is correct. The ChromeOS kernel also uses 1.8v.

Note that these settings don't entirely match those in the ChromeOS
kernel found at the URL below. However, the selected values generally
cause no behavior change in the kernel, and so were picked to avoid
regressions.

repo http://git.chromium.org/chromiumos/third_party/kernel.git
branch chromeos-3.2
file arch/arm/mach-tegra/board-seaboard-power.c

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Made all constraints match the HW defaults to avoid behavior changes,
  with exceptions noted above.
* Removed vin-supply properties from LDO nodes; the driver and binding
  need to be updated to support specifying the parent regulators before
  we can put these into DT.
* Use the enumerated-bus compatible value for the /regulators node.
* Enhanced all regulator-name properties to list all signal names directly
  derived from the regulator pins.
* Added ldo_rtc regulator.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |  164 ++++++++++++++++++++++++++++++++
 1 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 85e621a..3dad941 100644
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
+					regulator-name = "vdd_sm0,vdd_core";
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-always-on;
+				};
+
+				regulator at 1 {
+					reg = <1>;
+					regulator-compatible = "sm1";
+					regulator-name = "vdd_sm1,vdd_cpu";
+					regulator-min-microvolt = <1125000>;
+					regulator-max-microvolt = <1125000>;
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
+					regulator-name = "vdd_ldo6,avdd_vdac,vddio_vi,vddio_cam";
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
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-seaboard",
 			     "nvidia,tegra-audio-wm8903";
-- 
1.7.0.4
