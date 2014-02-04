From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:21 +0100
Subject: [PATCH 05/10] ARM: ux500: move AB8500 USB UICC settings to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the set-up of the USB UICC (InteChip USB) from the
board file to the device tree.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 19 ++++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c |  9 ---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 3aae4ec5bcc9..9cf12d5d0923 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -34,7 +34,8 @@
 						    <&gpio35_default_mode>,
 						    <&ycbcr_default_mode>,
 						    <&pwm_default_mode>,
-						    <&adi1_default_mode>;
+						    <&adi1_default_mode>,
+						    <&usbuicc_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -301,6 +302,22 @@
 							};
 						};
 					};
+					/* This sets up the USB UICC pins */
+					usbuicc {
+						usbuicc_default_mode: usbuicc_default {
+							default_mux {
+								ste,function = "usbuicc";
+								ste,pins = "usbuicc_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO21_H19",
+									 "GPIO22_G20",
+									 "GPIO23_G19";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index d0b262242ab7..443b1f4b828a 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -57,15 +57,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
 	/*
-	 * pins 21,22 and 23 are muxed in USB UICC
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("usbuicc_d_1", "usbuicc"),
-	AB8500_PIN_HOG("GPIO21_H19", in_pd),
-	AB8500_PIN_HOG("GPIO22_G20", in_pd),
-	AB8500_PIN_HOG("GPIO23_G19", in_pd),
-
-	/*
 	 * pins 27,28 are muxed in DMIC12
 	 * configured in INPUT PULL DOWN
 	 */
-- 
1.8.5.3
