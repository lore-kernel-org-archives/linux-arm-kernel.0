From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 17:06:13 +0100
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <1387469182-14398-1-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
Message-ID: <1387469182-14398-2-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also adds the vmmc-supply property to the SDMMC node on Venice2.
Otherwise the core will turn the regulator off automatically because it
is unused.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note: This was taken from a ChromeOS tree.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 182 +++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index d6bb25c78c62..5dc0c64b7682 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -392,6 +392,176 @@
 	i2c at 7000d000 {
 		status = "okay";
 		clock-frequency = <100000>;
+
+		pmic: pmic at 40 {
+			compatible = "ams,as3722";
+			reg = <0x40>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&as3722_default>;
+
+			as3722_default: pinmux {
+				gpio0 {
+					pins = "gpio0";
+					function = "gpio";
+					bias-pull-down;
+				};
+
+				gpio1_2_4_7 {
+					pins = "gpio1", "gpio2", "gpio4",
+					       "gpio7";
+					function = "gpio";
+					bias-pull-up;
+				};
+
+				gpio3_6 {
+					pins = "gpio3", "gpio6";
+					function = "gpio";
+					bias-high-impedance;
+				};
+
+				gpio5 {
+					pins = "gpio5";
+					function = "clk32k-out";
+					bias-pull-up;
+				};
+			};
+
+			regulators {
+				vsup-sd2-supply = <&sys_5v_reg>;
+				vsup-sd3-supply = <&sys_5v_reg>;
+				vsup-sd4-supply = <&sys_5v_reg>;
+				vsup-sd5-supply = <&sys_5v_reg>;
+				vin-ldo0-supply = <&as3722_sd2>;
+				vin-ldo1-6-supply = <&sys_5v_reg>;
+				vin-ldo2-5-7-supply = <&vddio_1v8>;
+				vin-ldo3-4-supply = <&sys_5v_reg>;
+				vin-ldo9-10-supply = <&sys_5v_reg>;
+				vin-ldo11-supply = <&sys_5v_reg>;
+
+				sd0 {
+					regulator-name = "vdd_cpu";
+					regulator-min-microvolt = <700000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+					ams,ext-control = <2>;
+				};
+
+				sd1 {
+					regulator-name = "vdd_core";
+					regulator-min-microvolt = <700000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-max-microamp = <3500000>;
+					regulator-always-on;
+					ams,ext-control = <1>;
+				};
+
+				as3722_sd2: sd2 {
+					regulator-name = "vddio_ddr";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+				};
+
+				sd4 {
+					regulator-name = "avdd-hdmi-pex";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+				};
+
+				vddio_1v8: sd5 {
+					regulator-name = "vdd-1v8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				sd6 {
+					regulator-name = "vdd_gpu";
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo0 {
+					regulator-name = "avdd-pll";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					ams,ext-control = <1>;
+				};
+
+				ldo1 {
+					regulator-name = "vdd_cam";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				ldo2 {
+					regulator-name = "vddio_hsic";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				ldo3 {
+					regulator-name = "vdd_rtc";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+					ams,enable-tracking;
+				};
+
+				ldo4 {
+					regulator-name = "avdd_cam";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				ldo5 {
+					regulator-name = "vdig";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				ldo6 {
+					regulator-name = "vddio_sdmmc";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo7 {
+					regulator-name = "vdd_cam1";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+				};
+
+				ldo9 {
+					regulator-name = "avdd";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				ldo10 {
+					regulator-name = "avdd_af1_cam";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				ldo11 {
+					regulator-name = "vpp_fuse";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+			};
+		};
 	};
 
 	pmc at 7000e400 {
@@ -436,6 +606,18 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sys_5v_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "sys_5v";
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-max98090-venice2",
 			     "nvidia,tegra-audio-max98090";
-- 
1.8.4.2
