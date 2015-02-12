From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 12 Feb 2015 16:06:23 +0800
Subject: [PATCH 1/4] ARM: at91: at91sam9x5/dts: add ISI dt support,
 include isi node, pinctrls
In-Reply-To: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
References: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1423728386-24544-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new file: at91sam9x5_isi.dtsi, which includes ISI node and
pinctrls.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/at91sam9g25.dtsi    |  1 +
 arch/arm/boot/dts/at91sam9x5_isi.dtsi | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index 17b8799..a7da0dd 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "at91sam9x5.dtsi"
+#include "at91sam9x5_isi.dtsi"
 #include "at91sam9x5_usart3.dtsi"
 #include "at91sam9x5_macb0.dtsi"
 
diff --git a/arch/arm/boot/dts/at91sam9x5_isi.dtsi b/arch/arm/boot/dts/at91sam9x5_isi.dtsi
index 98bc877..be6be94 100644
--- a/arch/arm/boot/dts/at91sam9x5_isi.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_isi.dtsi
@@ -13,6 +13,37 @@
 / {
 	ahb {
 		apb {
+			pinctrl at fffff400 {
+				isi {
+					pinctrl_isi_data_0_7: isi-0-data-0-7 {
+						atmel,pins =
+							<AT91_PIOC 0 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC0 periph B ISI_D0, conflicts with LCDDAT0 */
+							AT91_PIOC 1 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC1 periph B ISI_D1, conflicts with LCDDAT1 */
+							AT91_PIOC 2 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC2 periph B ISI_D2, conflicts with LCDDAT2 */
+							AT91_PIOC 3 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC3 periph B ISI_D3, conflicts with LCDDAT3 */
+							AT91_PIOC 4 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC4 periph B ISI_D4, conflicts with LCDDAT4 */
+							AT91_PIOC 5 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC5 periph B ISI_D5, conflicts with LCDDAT5 */
+							AT91_PIOC 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC6 periph B ISI_D6, conflicts with LCDDAT6 */
+							AT91_PIOC 7 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC7 periph B ISI_D7, conflicts with LCDDAT7 */
+							AT91_PIOC 12 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC12 periph B ISI_PCK, conflicts with LCDDAT12 */
+							AT91_PIOC 14 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC14 periph B ISI_HSYNC, conflicts with LCDDAT14 */
+							AT91_PIOC 13 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC13 periph B ISI_VSYNC, conflicts with LCDDAT13 */
+					};
+
+					pinctrl_isi_data_8_9: isi-0-data-8-9 {
+						atmel,pins =
+							<AT91_PIOC 8 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC8 periph B ISI_D8, conflicts with LCDDAT8 */
+							AT91_PIOC 9 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC9 periph B ISI_D9, conflicts with LCDDAT9 */
+					};
+
+					pinctrl_isi_data_10_11: isi-0-data-10-11 {
+						atmel,pins =
+							<AT91_PIOC 10 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PC10 periph B ISI_D10, conflicts with LCDDAT10 */
+							AT91_PIOC 11 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC11 periph B ISI_D11, conflicts with LCDDAT11 */
+					};
+				};
+			};
+
 			pmc: pmc at fffffc00 {
 				periphck {
 					isi_clk: isi_clk {
@@ -22,5 +53,20 @@
 				};
 			};
 		};
+
+		isi: isi at f8048000 {
+			compatible = "atmel,at91sam9g45-isi";
+			reg = <0xf8048000 0x4000>;
+			interrupts = <25 IRQ_TYPE_LEVEL_HIGH 5>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_isi_data_0_7>;
+			clocks = <&isi_clk>;
+			clock-names = "isi_clk";
+			status = "disabled";
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
 	};
 };
-- 
1.9.1
