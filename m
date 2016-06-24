From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 24 Jun 2016 15:32:05 +0800
Subject: [PATCH] ARM: at91/dt: sama5d2_xplained: Update the pmic node
Message-ID: <1466753525-4742-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to introducing the new driver - ACT8945A MFD drive,
change the pmic device node to align with the ACT8945A
regulator and charger drivers.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 41 ++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index eb4f1ac..0b9a59d 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -158,56 +158,64 @@
 				i2c-sda-hold-time-ns = <350>;
 				status = "okay";
 
-				pmic: act8865 at 5b {
-					compatible = "active-semi,act8865";
+				pmic at 5b {
+					compatible = "active-semi,act8945a";
 					reg = <0x5b>;
 					active-semi,vsel-high;
+					active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+					active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+					active-semi,irq_gpios = <&pioA 45 GPIO_ACTIVE_LOW>;
+					active-semi,input-voltage-threshold-microvolt = <6600>;
+					active-semi,precondition-timeout = <40>;
+					active-semi,total-timeout = <3>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 					status = "okay";
 
 					regulators {
-						vdd_1v35_reg: DCDC_REG1 {
+						vdd_1v35_reg: REG_DCDC1 {
 							regulator-name = "VDD_1V35";
 							regulator-min-microvolt = <1350000>;
 							regulator-max-microvolt = <1350000>;
 							regulator-always-on;
 						};
 
-						vdd_1v2_reg: DCDC_REG2 {
+						vdd_1v2_reg: REG_DCDC2 {
 							regulator-name = "VDD_1V2";
 							regulator-min-microvolt = <1100000>;
 							regulator-max-microvolt = <1300000>;
 							regulator-always-on;
 						};
 
-						vdd_3v3_reg: DCDC_REG3 {
+						vdd_3v3_reg: REG_DCDC3 {
 							regulator-name = "VDD_3V3";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
 						};
 
-						vdd_fuse_reg: LDO_REG1 {
+						vdd_fuse_reg: REG_LDO1 {
 							regulator-name = "VDD_FUSE";
 							regulator-min-microvolt = <2500000>;
 							regulator-max-microvolt = <2500000>;
 							regulator-always-on;
 						};
 
-						vdd_3v3_lp_reg: LDO_REG2 {
+						vdd_3v3_lp_reg: REG_LDO2 {
 							regulator-name = "VDD_3V3_LP";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
 						};
 
-						vdd_led_reg: LDO_REG3 {
+						vdd_led_reg: REG_LDO3 {
 							regulator-name = "VDD_LED";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
 							regulator-always-on;
 						};
 
-						vdd_sdhc_1v8_reg: LDO_REG4 {
+						vdd_sdhc_1v8_reg: REG_LDO4 {
 							regulator-name = "VDD_SDHC_1V8";
 							regulator-min-microvolt = <1800000>;
 							regulator-max-microvolt = <1800000>;
@@ -309,6 +317,21 @@
 					bias-disable;
 				};
 
+				pinctrl_charger_chglev: charger_chglev {
+					pinmux = <PIN_PA12__GPIO>;
+					bias-disable;
+				};
+
+				pinctrl_charger_irq: charger_irq {
+					pinmux = <PIN_PB13__GPIO>;
+					bias-disable;
+				};
+
+				pinctrl_charger_lbo: charger_lbo {
+					pinmux = <PIN_PC8__GPIO>;
+					bias-pull-up;
+				};
+
 				pinctrl_flx0_default: flx0_default {
 					pinmux = <PIN_PB28__FLEXCOM0_IO0>,
 						 <PIN_PB29__FLEXCOM0_IO1>;
-- 
2.7.4
