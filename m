From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:05 +0100
Subject: [PATCH 16/21] ARM: ux500: move final HREFv60 LCD pins to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-17-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put two extra configs into the device tree to handle the default
configuration of the display reset signals on the HREFv60plus,
move this over from the board file to the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dtsi  | 17 +++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c |  7 -------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index ecd26848f24f..25b4848e9a6a 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -102,6 +102,23 @@
 					};
 				 };
 			};
+			mcde {
+				lcd_hrefv60_mode: lcd_hrefv60 {
+					/*
+					 * Display Interface 1 uses GPIO 65 for RST (reset).
+					 * Display Interface 2 uses GPIO 66 for RST (reset).
+					 * Drive DISP1 reset high (not reset), driver DISP2 reset low (reset)
+					 */
+					hrefv60_cfg1 {
+						ste,pins ="GPIO65_F1";
+						ste,config = <&gpio_out_hi>;
+					};
+					hrefv60_cfg2 {
+						ste,pins ="GPIO66_G3";
+						ste,config = <&gpio_out_lo>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index e208dddfeda9..6cc71d02957f 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -309,13 +309,6 @@ static struct pinctrl_map __initdata hrefv60_pinmap[] = {
 	DB8500_PIN_HOG("GPIO31_V3", gpio_in_pu), /* EN1 */
 	DB8500_PIN_HOG("GPIO32_V2", gpio_in_pd), /* DRDY */
 	/*
-	 * Display Interface 1 uses GPIO 65 for RST (reset).
-	 * Display Interface 2 uses GPIO 66 for RST (reset).
-	 * Drive DISP1 reset high (not reset), driver DISP2 reset low (reset)
-	 */
-	DB8500_PIN_HOG("GPIO65_F1", gpio_out_hi), /* DISP1 NO RST */
-	DB8500_PIN_HOG("GPIO66_G3", gpio_out_lo), /* DISP2 RST */
-	/*
 	 * Touch screen uses GPIO 143 for RST1, GPIO 146 for RST2 and
 	 * GPIO 67 for interrupts. Pull-up the IRQ line and drive both
 	 * reset signals low.
-- 
1.8.3.1
