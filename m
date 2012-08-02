From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  2 Aug 2012 12:36:33 -0600
Subject: [PATCH] ARM: dt: tegra: paz00: add regulators
Message-ID: <1343932593-999-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Toshiba AC100/PAZ00 uses a TPS6586x regulator. Instantiate this.

Three data sources were used for the data encoded here:
* The HW defaults, as extracted from real HW.
* The schematic, which specifies a voltage for each rail in the signal
  names.
* The AC100 kernel used by the Ubuntu port:

  repo git://gitorious.org/~marvin24/ac100/marvin24s-kernel.git
  branch chromeos-ac100-3.0
  file arch/arm/mach-tegra/board-paz00-power.c

  For many rails, the constraints in that tree specified differing min
  and max voltages. In all cases, the min value was ignored, since
  there's no need currently to vary any of the voltages at run-time.
  DVFS might change this in the future.

In most cases these sources all matched. Differences are:

sm0: HW defaults and schematic match at 1.2v. marvin24's kernel had a max
of 1.3v, but this higher voltage was only applied to HW by DVFS code,
which isn't currently supported in mainline.

sm1: HW defaults and schematic match at 1.0v. marvin24's kernel had a max
of 1.125v, but this higher voltage was only applied to HW by DVFS code,
which isn't currently supported in mainline.

ldo3: The HW default is on. marvin24's kernel didn't specify always-on,
but since the board wasn't marked as having fully constrained regulators,
the rail was not turned off, so the difference had no effect. The rail
is needed for USB.

ldo6: The HW default is 2.85v. The schematics indicate 2.85v. However,
since this regulator is used for the same purpose as on other boards that
require 1.8v, this is set to 1.8v. Note that this regulator feeds the CRT
VDAC on Tegra, and so in practice is unlikely to be used, even though it
is actaully hooked up in HW.

Portions based on work by Laxman Dewangan <ldewangan@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Marc Dietrich <marvin24@gmx.de> # v2
---
Laxman, note that I have similar patches for Seaboard and Ventana too, but
since the structure of all 3 is basically the same, I figured I'd only send
1 for review first to get any issues sorted, then post the other 2 later.

v4:
* Added supply properties for all TPS6586x regulators.
* Made SM* supplied by the new SYS regulator.
* Removed ldo0 configuration, since it isn't used. Clarified ldo6 usage in
  commit description.
v3:
* Slight rewording of sm0/sm1 data source resolution description.
* Adjusted ldo6 to 1.8v to match other boards using it for the same thing.
* Enhanced all regulator-name properties to also list the Tegra20 pins
  driven by the regulators. Thus, the regulator-name properties mostly match
  Seaboard and Ventana. Note that the AC100 schematics don't actually name
  the signals themselves after the pins, like Seaboard/Ventana do.
* Added ldo_rtc regulator.
v2:
* Made all constraints specify a single voltage rather than different
  min/max, per description above.
* Removed vin-supply properties from LDO nodes; the driver and binding
  need to be updated to support specifying the parent regulators before
  we can put these into DT.
---
 arch/arm/boot/dts/tegra20-paz00.dts |  173 +++++++++++++++++++++++++++++++++++
 1 files changed, 173 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 684a9e1..ddf287f 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -272,12 +272,170 @@
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
+			sys-supply = <&p5valw_reg>;
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
+					regulator-name = "+1.2vs_sm0,vdd_core";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				regulator at 2 {
+					reg = <2>;
+					regulator-compatible = "sm1";
+					regulator-name = "+1.0vs_sm1,vdd_cpu";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				sm2_reg: regulator at 3 {
+					reg = <3>;
+					regulator-compatible = "sm2";
+					regulator-name = "+3.7vs_sm2,vin_ldo*";
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
+					regulator-name = "+1.1vs_ldo1,avdd_pll*";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				regulator at 6 {
+					reg = <6>;
+					regulator-compatible = "ldo2";
+					regulator-name = "+1.2vs_ldo2,vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				regulator at 7 {
+					reg = <7>;
+					regulator-compatible = "ldo3";
+					regulator-name = "+3.3vs_ldo3,avdd_usb*";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 8 {
+					reg = <8>;
+					regulator-compatible = "ldo4";
+					regulator-name = "+1.8vs_ldo4,avdd_osc,vddio_sys";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				regulator at 9 {
+					reg = <9>;
+					regulator-compatible = "ldo5";
+					regulator-name = "+2.85vs_ldo5,vcore_mmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 10 {
+					reg = <10>;
+					regulator-compatible = "ldo6";
+					/*
+					 * Research indicates this should be
+					 * 1.8v; other boards that use this
+					 * rail for the same purpose need it
+					 * set to 1.8v. The schematic signal
+					 * name is incorrect; perhaps copied
+					 * from an incorrect NVIDIA reference.
+					 */
+					regulator-name = "+2.85vs_ldo6,avdd_vdac";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 11 {
+					reg = <11>;
+					regulator-compatible = "ldo7";
+					regulator-name = "+3.3vs_ldo7,avdd_hdmi";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 12 {
+					reg = <12>;
+					regulator-compatible = "ldo8";
+					regulator-name = "+1.8vs_ldo8,avdd_hdmi_pll";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 13 {
+					reg = <13>;
+					regulator-compatible = "ldo9";
+					regulator-name = "+2.85vs_ldo9,vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 14 {
+					reg = <14>;
+					regulator-compatible = "ldo_rtc";
+					regulator-name = "+3.3vs_rtc";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+			};
+		};
+
 		adt7461 at 4c {
 			compatible = "adi,adt7461";
 			reg = <0x4c>;
 		};
 	};
 
+	pmc {
+		nvidia,invert-interrupt;
+	};
+
 	usb at c5000000 {
 		status = "okay";
 	};
@@ -325,6 +483,21 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		p5valw_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "+5valw";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-alc5632-paz00",
 			"nvidia,tegra-audio-alc5632";
-- 
1.7.0.4
