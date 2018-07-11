From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jul 2018 21:47:19 +0200
Subject: [PATCH 2/3 v3] ARM: dts: Att Vitesse G5e switch to the Gemini SQ201
In-Reply-To: <20180711194720.25266-1-linus.walleij@linaro.org>
References: <20180711194720.25266-1-linus.walleij@linaro.org>
Message-ID: <20180711194720.25266-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Vitesse G5e ethernet switch to the Square
One Itian SQ201 router device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Use a fixed link for the ethernet port to the Vitesse
  DSA router chip.
ChangeLog v1->v2:
- Drop unrelated roofs mount point change.
---
 arch/arm/boot/dts/gemini-sq201.dts | 76 +++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index cc693e64faaf..c7a0788ef8c1 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -70,6 +70,61 @@
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
@@ -135,6 +190,15 @@
 						"gpio0kgrp";
 					};
 				};
+				/*
+				 * gpio0kgrp cover line 31 used by USB LED
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
@@ -205,6 +269,11 @@
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
@@ -235,7 +304,12 @@
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
