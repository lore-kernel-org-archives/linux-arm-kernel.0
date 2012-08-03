From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  3 Aug 2012 12:08:50 -0600
Subject: [PATCH V3] ARM: dt: tegra: seaboard: add regulators
Message-ID: <1344017330-29306-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Seaboard uses a TPS6586x regulator. Instantiate this, and hook up a
couple of fixed GPIO-controlled regulators too.

Two data sources were used for the data encoded here:
* The HW defaults, as extracted from real HW.
* The schematic, which specifies a voltage for each LDO rail.

In most cases these sources matched. The only differences is:

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

Portions based on work by Laxman Dewangan <ldewangan@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v3:
* Switch back to simple-bus compatible value for the /regulators node.
* Added supply properties for all TPS6586x regulators.
* Made SM* children of the new SYS regulator.
* Removed ldo0 configuration, since it isn't used.
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
 arch/arm/boot/dts/tegra20-seaboard.dts |  184 ++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 85e621a..92deb36 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -374,6 +374,152 @@
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
+			sys-supply = <&vdd_5v0_reg>;
+			vin-sm0-supply = <&sys_reg>;
+			vin-sm1-supply = <&sys_reg>;
+			vin-sm2-supply = <&sys_reg>;
+			vinldo01-supply = <&sm2_reg>;
+			vinldo23-supply = <&sm2_reg>;
+			vinldo4-supply = <&sm2_reg>;
+			vinldo678-supply = <&sm2_reg>;
+			vinldo9-supply = <&sm2_reg>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sys_reg: regulator at 0 {
+					reg = <0>;
+					regulator-compatible = "sys";
+					regulator-name = "vdd_sys";
+					regulator-always-on;
+				};
+
+				regulator at 1 {
+					reg = <1>;
+					regulator-compatible = "sm0";
+					regulator-name = "vdd_sm0,vdd_core";
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-always-on;
+				};
+
+				regulator at 2 {
+					reg = <2>;
+					regulator-compatible = "sm1";
+					regulator-name = "vdd_sm1,vdd_cpu";
+					regulator-min-microvolt = <1125000>;
+					regulator-max-microvolt = <1125000>;
+					regulator-always-on;
+				};
+
+				sm2_reg: regulator at 3 {
+					reg = <3>;
+					regulator-compatible = "sm2";
+					regulator-name = "vdd_sm2,vin_ldo*";
+					regulator-min-microvolt = <3700000>;
+					regulator-max-microvolt = <3700000>;
+					regulator-always-on;
+				};
+
+				/* LDO0 is not connected to anything */
+
+				regulator at 5 {
+					reg = <5>;
+					regulator-compatible = "ldo1";
+					regulator-name = "vdd_ldo1,avdd_pll*";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				regulator at 6 {
+					reg = <6>;
+					regulator-compatible = "ldo2";
+					regulator-name = "vdd_ldo2,vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				regulator at 7 {
+					reg = <7>;
+					regulator-compatible = "ldo3";
+					regulator-name = "vdd_ldo3,avdd_usb*";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 8 {
+					reg = <8>;
+					regulator-compatible = "ldo4";
+					regulator-name = "vdd_ldo4,avdd_osc,vddio_sys";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				regulator at 9 {
+					reg = <9>;
+					regulator-compatible = "ldo5";
+					regulator-name = "vdd_ldo5,vcore_mmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 10 {
+					reg = <10>;
+					regulator-compatible = "ldo6";
+					regulator-name = "vdd_ldo6,avdd_vdac,vddio_vi,vddio_cam";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 11 {
+					reg = <11>;
+					regulator-compatible = "ldo7";
+					regulator-name = "vdd_ldo7,avdd_hdmi,vdd_fuse";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 12 {
+					reg = <12>;
+					regulator-compatible = "ldo8";
+					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 13 {
+					reg = <13>;
+					regulator-compatible = "ldo9";
+					regulator-name = "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 14 {
+					reg = <14>;
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
@@ -387,6 +533,10 @@
 		};
 	};
 
+	pmc {
+		nvidia,invert-interrupt;
+	};
+
 	memory-controller at 0x7000f400 {
 		emc-table at 190000 {
 			reg = <190000>;
@@ -473,6 +623,40 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_5v0_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vdd_5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_1v5";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			gpio = <&pmic 0 0>;
+		};
+
+		regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
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
