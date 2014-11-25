From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 25 Nov 2014 15:32:23 +0800
Subject: [PATCH v9 4/4] ARM: dts: rockchip: add suspend settings for
 rk3288-evb-rk808
In-Reply-To: <1416900743-29204-1-git-send-email-zyw@rock-chips.com>
References: <1416900743-29204-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1416900743-29204-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend-voltages and necessary pin-states for suspend on
rk3288-evb-rk808 boards. global_pwroff would be pulled high when
RK3288 entering suspend, this pin is a sleep signal for RK808, so
RK808 could goto sleep mode, and some regulators would be disable.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v9:
- update the subject and description

Changes in v8:
- set vdd_gpu to 1.0v during suspend
- add regulator-on-in-suspend before set suspend voltage

Changes in v7:
- add regulator-state-mem sub node for suspend

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-evb-rk808.dts | 51 +++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index d8c775e6..742bd89 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -31,7 +31,7 @@
 		interrupt-parent = <&gpio0>;
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
+		pinctrl-0 = <&pmic_int &global_pwroff>;
 		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
@@ -50,6 +50,9 @@
 				regulator-min-microvolt = <750000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-name = "vdd_arm";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_gpu: DCDC_REG2 {
@@ -58,12 +61,20 @@
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1250000>;
 				regulator-name = "vdd_gpu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
 			};
 
 			vcc_ddr: DCDC_REG3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-name = "vcc_ddr";
+				regulator-suspend-mem-enabled;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			vcc_io: DCDC_REG4 {
@@ -72,6 +83,10 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc_io";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
 			};
 
 			vccio_pmu: LDO_REG1 {
@@ -80,6 +95,10 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
 			};
 
 			vcc_tp: LDO_REG2 {
@@ -88,6 +107,9 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc_tp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_10: LDO_REG3 {
@@ -96,6 +118,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-name = "vdd_10";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
 			};
 
 			vcc18_lcd: LDO_REG4 {
@@ -104,6 +130,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc18_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vccio_sd: LDO_REG5 {
@@ -112,6 +141,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd10_lcd: LDO_REG6 {
@@ -120,6 +152,9 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-name = "vdd10_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vcc_18: LDO_REG7 {
@@ -128,6 +163,11 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc_18";
+				regulator-suspend-mem-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
 			};
 
 			vcca_codec: LDO_REG8 {
@@ -136,18 +176,27 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcca_codec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vcc_wl: SWITCH_REG1 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-name = "vcc_wl";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			vcc_lcd: SWITCH_REG2 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-name = "vcc_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 		};
 	};
-- 
1.9.1
