From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:31 +0300
Subject: [PATCH 09/15] ARM: dts: at91: sama5d2_xplained: Add charger node of
 pmic.
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-10-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add charger device node as a sub-device node of act8945a mfd, move
the charger's properties to this node, and use the "interrupts"
property to replace "active-semi,irq_gpios" to denote the act8945a
charger's irq.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
[claudiu.beznea at microchip.com: replace numbers with pin macros]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index c7e9ccf2bc87..848ca1b025be 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -160,14 +160,6 @@
 					compatible = "active-semi,act8945a";
 					reg = <0x5b>;
 					active-semi,vsel-high;
-					active-semi,chglev-gpios = <&pioA PIN_PA12 GPIO_ACTIVE_HIGH>;
-					active-semi,lbo-gpios = <&pioA PIN_PC8 GPIO_ACTIVE_LOW>;
-					active-semi,irq_gpios = <&pioA PIN_PB13 GPIO_ACTIVE_LOW>;
-					active-semi,input-voltage-threshold-microvolt = <6600>;
-					active-semi,precondition-timeout = <40>;
-					active-semi,total-timeout = <3>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 					status = "okay";
 
 					regulators {
@@ -220,6 +212,21 @@
 							regulator-always-on;
 						};
 					};
+
+					charger {
+						compatible = "active-semi,act8945a-charger";
+						pinctrl-names = "default";
+						pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+						interrupt-parent = <&pioA>;
+						interrupts = <PIN_PB13 GPIO_ACTIVE_LOW>;
+
+						active-semi,chglev-gpios = <&pioA PIN_PA12 GPIO_ACTIVE_HIGH>;
+						active-semi,lbo-gpios = <&pioA PIN_PC8 GPIO_ACTIVE_LOW>;
+						active-semi,input-voltage-threshold-microvolt = <6600>;
+						active-semi,precondition-timeout = <40>;
+						active-semi,total-timeout = <3>;
+						status = "okay";
+					};
 				};
 			};
 
-- 
2.7.4
