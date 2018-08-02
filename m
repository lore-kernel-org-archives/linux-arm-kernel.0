From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Aug 2018 15:11:16 +0200
Subject: [PATCH] arm64: dts: rockchip: add rk809 pmic to px30-evb
Message-ID: <20180802131116.5352-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Add the rk809 pmic and hook it into the needed parts of the board.

Signed-off-by: Liang Chen <cl@rock-chips.com>
[added cpu-supplies for other cores]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
I've dropped that portion when adding the px30-evb due to the rk809 support
not having landed yet. So it should be applied after it does.

Ideally Tony Xie could add this patch to future revisions of his
rk809 series.

 arch/arm64/boot/dts/rockchip/px30-evb.dts | 253 ++++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 263d7f3dbc44..b9313321fd21 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -91,6 +91,22 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
 &display_subsystem {
 	status = "okay";
 };
@@ -114,6 +130,227 @@
 
 &i2c0 {
 	status = "okay";
+
+	rk809: pmic at 20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		pwrkey {
+			status = "okay";
+		};
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v0: DCDC_REG4 {
+				regulator-name = "vcc_3v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_1v0: LDO_REG1 {
+				regulator-name = "vcc_1v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc1v8_soc: LDO_REG2 {
+				regulator-name = "vcc1v8_soc";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd1v0_soc: LDO_REG3 {
+				regulator-name = "vcc1v0_soc";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc3v0_pmu: LDO_REG4 {
+				regulator-name = "vcc3v0_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_sd: LDO_REG6 {
+				regulator-name = "vcc_sd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+
+				};
+			};
+
+			vcc2v8_dvp: LDO_REG7 {
+				regulator-name = "vcc2v8_dvp";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <2800000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG8 {
+				regulator-name = "vcc1v8_dvp";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd1v5_dvp: LDO_REG9 {
+				regulator-name = "vdd1v5_dvp";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcc3v3_sys: DCDC_REG5 {
+				regulator-name = "vcc3v3_sys";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc3v3_lcd: SWITCH_REG1 {
+				regulator-name = "vcc3v3_lcd";
+				regulator-boot-on;
+			};
+
+			vcc5v0_host: SWITCH_REG2 {
+				regulator-name = "vcc5v0_host";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
 };
 
 &i2s1_2ch {
@@ -122,6 +363,12 @@
 
 &io_domains {
 	status = "okay";
+
+	vccio1-supply = <&vcc1v8_soc>;
+	vccio2-supply = <&vccio_sd>;
+	vccio3-supply = <&vcc_3v0>;
+	vccio4-supply = <&vcc3v0_pmu>;
+	vccio5-supply = <&vcc_3v0>;
 };
 
 &pinctrl {
@@ -164,6 +411,9 @@
 
 &pmu_io_domains {
 	status = "okay";
+
+	pmuio1-supply = <&vcc3v0_pmu>;
+	pmuio2-supply = <&vcc3v0_pmu>;
 };
 
 &pwm1 {
@@ -172,6 +422,7 @@
 
 &saradc {
 	status = "okay";
+	vref-supply = <&vcc1v8_soc>;
 };
 
 &sdmmc {
@@ -183,6 +434,8 @@
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
+	vqmmc-supply = <&vccio_sd>;
+	vmmc-supply = <&vcc_sd>;
 	status = "okay";
 };
 
-- 
2.17.0
