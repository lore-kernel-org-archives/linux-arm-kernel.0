From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:54 +0100
Subject: [PATCH 05/21] ARM: ux500: move GPIO217/218 config to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the input-pulled-up setting for GPIO217 as used
on the HREFs prior to v60 from the boardfile to the device
tree. GPIO218 is only used with the TVK UIB so move it to
that .dtsi file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi      | 10 ++++++++++
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi |  5 +++++
 arch/arm/mach-ux500/board-mop500-pins.c    |  7 -------
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 61b180ea92ca..3f31f9206fb3 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -22,6 +22,8 @@
 				reg = <0x44>;
 				interrupt-parent = <&gpio6>;
 				interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&tc35893_tvk_mode>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
@@ -64,5 +66,16 @@
 				};
 			};
 		};
+		pinctrl {
+			/* Pull up this GPIO pin */
+			tc35893 {
+				tc35893_tvk_mode: tc35893_tvk {
+					tvk_cfg {
+						ste,pins = "GPIO218_AH11";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index cfd7ef306d49..6fc94ea65ab9 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -33,6 +33,8 @@
 				reg = <0x42>;
 				interrupt-parent = <&gpio6>;
 				interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&tc35892_hrefprev60_mode>;
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
@@ -71,6 +73,14 @@
 
 				};
 			};
+			tc35892 {
+				tc35892_hrefprev60_mode: tc35892_hrefprev60 {
+					hrefprev60_cfg {
+						ste,pins = "GPIO217_AH12";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index f213222cf220..9aea983e78b5 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -31,6 +31,11 @@
 		ste,output = <OUTPUT_LOW>;
 	};
 
+	gpio_in_pu: gpio_input_pull_up {
+		ste,gpio = <GPIOMODE_ENABLED>;
+		ste,input = <INPUT_PULLUP>;
+	};
+
 	gpio_out_lo: gpio_output_low {
 		ste,gpio = <GPIOMODE_ENABLED>;
 		ste,output = <OUTPUT_LOW>;
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index f7034cbdc630..c032392294a0 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -340,11 +340,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_MUX_HOG("lcdvsi0_a_1", "lcd"),
 	DB8500_PIN_HOG("GPIO68_E1", in_pu),
 	DB8500_PIN_HOG("GPIO84_C2", gpio_in_pu),
-	/*
-	 * STMPE1601/tc35893 keypad IRQ GPIO 218
-	 * TODO: set for snowball and HREF really??
-	 */
-	DB8500_PIN_HOG("GPIO218_AH11", gpio_in_pu),
 	/* Mux in LCD data lines 8 thru 11 and LCDA CLK for MCDE TVOUT */
 	DB8500_MUX("lcd_d8_d11_a_1", "lcd", "mcde-tvout"),
 	DB8500_MUX("lcdaclk_b_1", "lcda", "mcde-tvout"),
@@ -625,8 +620,6 @@ static struct pinctrl_map __initdata mop500_pinmap[] = {
 	DB8500_MUX_HOG("ipgpio1_c_1", "ipgpio"),
 	DB8500_PIN_HOG("GPIO6_AF6", in_pu),
 	DB8500_PIN_HOG("GPIO7_AG5", in_pu),
-	/* TC35892 IRQ, pull up the line, let the driver mux in the pin */
-	DB8500_PIN_HOG("GPIO217_AH12", gpio_in_pu),
 	/*
 	 * Runtime stuff: make it possible to mux in the SKE keypad
 	 * and bias the pins
-- 
1.8.3.1
