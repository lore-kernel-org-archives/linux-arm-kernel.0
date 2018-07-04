From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jul 2018 21:17:58 +0200
Subject: [PATCH 2/3] ARM: dts: Att Vitesse G5e switch to the Gemini SQ201
In-Reply-To: <20180704191759.12577-1-linus.walleij@linaro.org>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
Message-ID: <20180704191759.12577-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Vitesse G5e ethernet switch to the Square
One Itian SQ201 router device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-sq201.dts | 75 +++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 2706b86e06f1..830c167012a0 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -20,7 +20,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200n8";
+		bootargs = "console=ttyS0,115200n8 root=/dev/sda1 rw rootwait";
 		stdout-path = &uart0;
 	};
 
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
@@ -135,6 +190,16 @@
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
@@ -205,6 +270,11 @@
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
@@ -235,7 +305,8 @@
 				phy-handle = <&phy0>;
 			};
 			ethernet-port at 1 {
-				/* Used for the Vitesse G5 chip, add later */
+				phy-mode = "rgmii";
+				phy-handle = <&vsc>;
 			};
 		};
 
-- 
2.17.1
