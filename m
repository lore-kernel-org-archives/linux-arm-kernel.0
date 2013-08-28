From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 28 Aug 2013 13:06:35 +0200
Subject: [PATCH 5/9] ARM: at91/dt: add mmc0 slot0 support to at91rm9200ek board
In-Reply-To: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1377687995-10758-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add slot0 of mmc0 pinctrl pins definitions:
 - detect pin
 - write protect pin
 - enable slot0 pin: this pin is connected to an external switch which
   enable mmc0 slot0 or spi dataflash connected to cs3

The mmc0 device is not enabled, as it depends on the choosen functionnality
(spi cs3 or mmc0 slot0).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index f2d6d79..2bad423 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -39,6 +39,23 @@
 						atmel,pins = <AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
 					};
 				};
+
+				mmc0 {
+					pinctrl_mmc0_slot0_detect: mmc0_slot0_detect-0 {
+						atmel,pins =
+							<AT91_PIOB 27 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+					};
+
+					pinctrl_mmc0_slot0_write_protect: mmc0_slot0_write_protect-0 {
+						atmel,pins =
+							<AT91_PIOA 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_mmc0_slot0_switch: mmc0_slot0_switch-0 {
+						atmel,pins =
+							<AT91_PIOB 22 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(1))>;
+					};
+				};
 			};
 
 			dbgu: serial at fffff200 {
@@ -84,6 +101,24 @@
 					reg = <0>;
 				};
 			};
+
+			mmc0: mmc at fffb4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&pinctrl_mmc0_clk
+					     &pinctrl_mmc0_slot0_cmd_dat0
+					     &pinctrl_mmc0_slot0_dat1_3
+					     &pinctrl_mmc0_slot0_detect
+					     &pinctrl_mmc0_slot0_write_protect
+					     &pinctrl_mmc0_slot0_switch>;
+
+				slot0: slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
+					wp-gpios = <&pioA 17 GPIO_ACTIVE_HIGH>;
+				};
+			};
 		};
 
 		usb0: ohci at 00300000 {
-- 
1.7.9.5
