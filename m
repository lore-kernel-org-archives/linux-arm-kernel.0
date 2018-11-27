From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Tue, 27 Nov 2018 11:57:21 +0000
Subject: [PATCH v2 4/5] ARM: dts: at91: sama5d2_xplained: Add proper regulator
 states for suspend-to-mem
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1543319801-19100-5-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

When entering suspend-to-mem, all PMIC outputs are disabled except
VDDIODDR which is put in power saving mode, and whose voltage is
increased (probably to counter the poor accuracy of power saving mode).

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea at microchip.com: use regulator-changeable-in-suspend,
 regulator-suspend-max-microvolt, regulator-suspend-max-microvolt,
 use macros for regulators' states, add regulator-inital-state]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 54 +++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 518e2b095ccf..438e6576cf7c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -47,6 +47,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
 
 / {
 	model = "Atmel SAMA5D2 Xplained";
@@ -181,49 +182,102 @@
 							regulator-name = "VDD_1V35";
 							regulator-min-microvolt = <1350000>;
 							regulator-max-microvolt = <1350000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-on-in-suspend;
+								regulator-suspend-min-microvolt=<1400000>;
+								regulator-suspend-max-microvolt=<1400000>;
+								regulator-changeable-in-suspend;
+								regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							};
 						};
 
 						vdd_1v2_reg: REG_DCDC2 {
 							regulator-name = "VDD_1V2";
 							regulator-min-microvolt = <1100000>;
 							regulator-max-microvolt = <1300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_reg: REG_DCDC3 {
 							regulator-name = "VDD_3V3";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_fuse_reg: REG_LDO1 {
 							regulator-name = "VDD_FUSE";
 							regulator-min-microvolt = <2500000>;
 							regulator-max-microvolt = <2500000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_3v3_lp_reg: REG_LDO2 {
 							regulator-name = "VDD_3V3_LP";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_led_reg: REG_LDO3 {
 							regulator-name = "VDD_LED";
 							regulator-min-microvolt = <3300000>;
 							regulator-max-microvolt = <3300000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 
 						vdd_sdhc_1v8_reg: REG_LDO4 {
 							regulator-name = "VDD_SDHC_1V8";
 							regulator-min-microvolt = <1800000>;
 							regulator-max-microvolt = <1800000>;
+							regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
+										  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
+							regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
 							regulator-always-on;
+
+							regulator-state-mem {
+								regulator-off-in-suspend;
+							};
 						};
 					};
 
-- 
2.7.4
