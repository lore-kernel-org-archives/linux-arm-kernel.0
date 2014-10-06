From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon,  6 Oct 2014 14:40:07 +0200
Subject: [PATCH 1/1] ARM: at91/dt: sam9263: Add CAN device nodes
Message-ID: <1412599207-15676-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing CAN devices node including their pin muxing. The required
clock node already exists.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index bb23c2d..174ab77 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -672,6 +672,14 @@
 					};
 				};
 
+				can {
+					pinctrl_can_rx_tx: can_rx_tx {
+						atmel,pins =
+							<AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_NONE	/* CANRX, conflicts with IRQ0 */
+							 AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* CANTX, conflicts with PCK0 */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -898,6 +906,17 @@
 				clock-names = "pwm_clk";
 				status = "disabled";
 			};
+
+			can: can at fffac000 {
+				compatible = "atmel,at91sam9263-can";
+				reg = <0xfffac000 0x300>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_can_rx_tx>;
+				clocks = <&can_clk>;
+				clock-names = "can_clk";
+				status = "disabled";
+			};
 		};
 
 		fb0: fb at 0x00700000 {
-- 
2.0.4
