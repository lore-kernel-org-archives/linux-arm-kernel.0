From: dmitry.rezvanov@yandex.ru (Dmitry Rezvanov)
Date: Sun, 18 Jun 2017 21:40:49 +0900
Subject: [PATCH] ARM: at91: dts: add AC97 support for AT91SAM9G45
In-Reply-To: <20170612194314.19289-1-dmitry.rezvanov@yandex.ru>
References: <20170612194314.19289-1-dmitry.rezvanov@yandex.ru>
Message-ID: <20170618124049.6663-1-dmitry.rezvanov@yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Thanks for the comments, I'm still a newbie and this is my first patch.
I have made corrections in accordance with your recommendations.

P.S. Regarding compatible string - since there are no other changes in
the driver, I changed it to "atmel, at91sam9263-ac97c".
But in my opinion, it's a bit ... weird.
---

AT91SAM9G45 has an AC97 controller, but it is not described in the dts file.
This patch adds AC97 node in device tree.

Signed-off-by: Dmitry Rezvanov <dmitry.rezvanov@yandex.ru>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     | 21 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e567d5fd3f9d..b14fd3a43027 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -445,6 +445,16 @@
 				      >;
 
 				/* shared pinctrl settings */
+				ac97 {
+					pinctrl_ac97: ac97-0 {
+						atmel,pins =
+							<AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD6 periph A AC97RX pin */
+							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD7 periph A AC97TX pin */
+							 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD8 periph A AC97FS pin */
+							 AT91_PIOD 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD9 periph A AC97CK pin */
+					};
+				};
+
 				adc0 {
 					pinctrl_adc0_adtrg: adc0_adtrg {
 						atmel,pins = <AT91_PIOD 28 AT91_PERIPH_A AT91_PINCTRL_NONE>;
@@ -1029,6 +1039,17 @@
 				status = "disabled";
 			};
 
+			ac97: sound at fffac000 {
+				compatible = "atmel,at91sam9263-ac97c";
+				reg = <0xfffac000 0x4000>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 4>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_ac97>;
+				clocks = <&ac97_clk>;
+				clock-names = "ac97_clk";
+				status = "disabled";
+			};
+
 			adc0: adc at fffb0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 2400c99134f7..7ea6225c63ad 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -166,6 +166,10 @@
 				status = "okay";
 			};
 
+			ac97: sound at fffac000 {
+				status = "okay";
+			};
+
 			adc0: adc at fffb0000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <
-- 
2.11.0
