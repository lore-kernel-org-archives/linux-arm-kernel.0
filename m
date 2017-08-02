From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:59:54 +0800
Subject: [PATCH v2 22/23] ARM: dts: rockchip: add pmic rk805 dt node for
 rv1108 evb
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501664394-12993-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK805 is used as the voltage regulator on rv1108 evaluation
board. Add device tree node for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108-evb.dts | 108 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 77ce707..a1bd95e 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -94,6 +94,114 @@
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <200>;
 	};
+
+	vcc_sys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <275>;
+	i2c-scl-falling-time-ns = <16>;
+	clock-frequency = <400000>;
+
+	rk805: pmic at 18 {
+		compatible = "rockchip,rk805";
+		reg = <0x18>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		rockchip,system-power-controller;
+
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc5-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+
+		regulators {
+			vdd_core: DCDC_REG1 {
+				regulator-name= "vdd_core";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <900000>;
+				};
+			};
+
+			vdd_cam: DCDC_REG2 {
+				regulator-name= "vdd_cam";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name= "vcc_ddr";
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+				};
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-name= "vcc_io";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <3300000>;
+				};
+			};
+
+			vdd_10: LDO_REG1 {
+				regulator-name= "vdd_10";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vcc_18: LDO_REG2 {
+				regulator-name= "vcc_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vdd10_pmu: LDO_REG3 {
+				regulator-name= "vdd10_pmu";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <1000000>;
+				};
+			};
+		};
+	};
 };
 
 &pwm0 {
-- 
2.7.4
