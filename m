From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Tue, 27 Nov 2018 11:57:25 +0000
Subject: [PATCH v2 5/5] regulator: add documentation for regulator modes and
 suspend states
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for regulator modes and suspend states.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
index ac955dea00d1..4017527619ab 100644
--- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -15,11 +15,17 @@ Optional input supply properties:
   - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
 
 Any standard regulator properties can be used to configure the single regulator.
+regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
+specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
+file.
 
 The valid names for regulators are:
 	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
 
 Example:
+
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
+
 	pmic at 5b {
 		compatible = "active-semi,act8945a";
 		reg = <0x5b>;
@@ -32,6 +38,18 @@ Example:
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-min-microvolt=<1400000>;
+					regulator-suspend-max-microvolt=<1400000>;
+					regulator-changeable-in-suspend;
+					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				};
 			};
 
 			vdd_1v2_reg: REG_DCDC2 {
@@ -39,6 +57,14 @@ Example:
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_3v3_reg: REG_DCDC3 {
@@ -53,6 +79,14 @@ Example:
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
+
+				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vdd_3v3_lp_reg: REG_LDO2 {
-- 
2.7.4
