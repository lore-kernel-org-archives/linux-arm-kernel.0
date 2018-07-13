From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 23:19:35 +0200
Subject: [PATCH 2/3 v4] ARM: dts: Att Vitesse G5e switch to the Gemini SQ201
In-Reply-To: <20180713211936.31820-1-linus.walleij@linaro.org>
References: <20180713211936.31820-1-linus.walleij@linaro.org>
Message-ID: <20180713211936.31820-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Vitesse G5e ethernet switch to the Square
One Itian SQ201 router device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Restore a lost comment change from v1 (sorry for the mess)
ChangeLog v2->v3:
- Use a fixed link for the ethernet port to the Vitesse
  DSA router chip.
ChangeLog v1->v2:
- Drop unrelated roofs mount point change.
---
 arch/arm/boot/dts/gemini-sq201.dts | 77 +++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index a57a03e2953b..3787cf3763c4 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -69,6 +69,61 @@
 		};
 	};
 
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* Check pin collisions */
+		gpio-sck = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		switch at 0 {
+			compatible = "vitesse,vsc7395";
+			reg = <0>;
+			/* Specified for 2.5 MHz or below */
+			spi-max-frequency = <2500000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					label = "lan1";
+				};
+				port at 1 {
+					reg = <1>;
+					label = "lan2";
+				};
+				port at 2 {
+					reg = <2>;
+					label = "lan3";
+				};
+				port at 3 {
+					reg = <3>;
+					label = "lan4";
+				};
+				vsc: port at 6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+			};
+		};
+	};
+
+
 	soc {
 		flash at 30000000 {
 			/*
@@ -134,6 +189,16 @@
 						"gpio0kgrp";
 					};
 				};
+				/*
+				 * gpio0dgrp cover lines used by the SPI
+				 * to the Vitesse G5x chip.
+				 */
+				gpio1_default_pins: pinctrl-gpio1 {
+					mux {
+						function = "gpio1";
+						groups = "gpio1dgrp";
+					};
+				};
 				pinctrl-gmii {
 					mux {
 						function = "gmii";
@@ -204,6 +269,11 @@
 			pinctrl-0 = <&gpio0_default_pins>;
 		};
 
+		gpio1: gpio at 4e000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio1_default_pins>;
+		};
+
 		pci at 50000000 {
 			status = "okay";
 			interrupt-map-mask = <0xf800 0 0 7>;
@@ -234,7 +304,12 @@
 				phy-handle = <&phy0>;
 			};
 			ethernet-port at 1 {
-				/* Used for the Vitesse G5 chip, add later */
+				phy-mode = "rgmii";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+					pause;
+				};
 			};
 		};
 
-- 
2.17.1
