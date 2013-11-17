From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:01 +0100
Subject: [PATCH 12/21] ARM: ux500: move old HREF ipgpio to the device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-13-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old HREFs (MOP500) were controlling an image-processor
GPIO (IPGPIO) by using hogs. Do the same thing with device tree
and get rid of the mop500_pins setting.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefprev60.dtsi   | 16 ++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c | 24 ------------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 32295e396ff8..b0f5def8e2a8 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -68,6 +68,10 @@
 		};
 
 		pinctrl {
+			/* Set this up using hogs */
+			pinctrl-names = "default";
+			pinctrl-0 = <&ipgpio_hrefprev60_mode>;
+
 			ssp0 {
 				ssp0_hrefprev60_mode: ssp0_hrefprev60_default {
 					hrefprev60_mux {
@@ -103,6 +107,18 @@
 					};
 				};
 			};
+			ipgpio {
+				 ipgpio_hrefprev60_mode: ipgpio_hrefprev60 {
+					hrefprev60_mux {
+						ste,function = "ipgpio";
+						ste,pins = "ipgpio0_c_1", "ipgpio1_c_1";
+					};
+					hrefprev60_cfg1 {
+						ste,pins = "GPIO6_AF6", "GPIO7_AG5";
+						ste,config = <&in_pu>;
+					};
+				 };
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index c311d11d6c3d..257c97a214a5 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -312,28 +312,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 };
 
 /*
- * These are specifically for the MOP500 and HREFP (pre-v60) version of the
- * board, which utilized a TC35892 GPIO expander instead of using a lot of
- * on-chip pins as the HREFv60 and later does.
- */
-static struct pinctrl_map __initdata mop500_pinmap[] = {
-	/*
-	 * XENON Flashgun on image processor GPIO (controlled from image
-	 * processor firmware), mux in these image processor GPIO lines 0
-	 * (XENON_FLASH_ID) and 1 (XENON_READY) on altfunction C and pull up
-	 * the pins.
-	 */
-	DB8500_MUX_HOG("ipgpio0_c_1", "ipgpio"),
-	DB8500_MUX_HOG("ipgpio1_c_1", "ipgpio"),
-	DB8500_PIN_HOG("GPIO6_AF6", in_pu),
-	DB8500_PIN_HOG("GPIO7_AG5", in_pu),
-	/*
-	 * Runtime stuff: make it possible to mux in the SKE keypad
-	 * and bias the pins
-	 */
-};
-
-/*
  * The HREFv60 series of platforms is using available pins on the DB8500
  * insteaf of the Toshiba I2C GPIO expander, reusing some pins like the SSP0
  * and SSP1 ports (previously connected to the AB8500) as generic GPIO lines.
@@ -496,8 +474,6 @@ static void __init mop500_href_family_pinmaps_init(void)
 
 void __init mop500_pinmaps_init(void)
 {
-	pinctrl_register_mappings(mop500_pinmap,
-				  ARRAY_SIZE(mop500_pinmap));
 	mop500_href_family_pinmaps_init();
 	if (machine_is_u8520())
 		pinctrl_register_mappings(ab8505_pinmap,
-- 
1.8.3.1
