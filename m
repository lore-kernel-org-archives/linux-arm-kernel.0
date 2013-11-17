From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:52 +0100
Subject: [PATCH 03/21] ARM: ux500: move MMC/SD/SDIO pin control to the device
 tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the static, device-tied pin control configuration
out of the board file board-mop500-pins.c and into the device
tree. Add entries for SDI1 and SDI2 on the Snowball so that the
WLAN pins on SDI1 can be used further on, and the unused pins
on SDI2 can be put to sleep.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 211 +++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                |  12 ++
 arch/arm/boot/dts/ste-hrefprev60.dtsi          |  17 ++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi         |  12 ++
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi     |  19 +++
 arch/arm/boot/dts/ste-snowball.dts             |  43 +++++
 arch/arm/mach-ux500/board-mop500-pins.c        | 107 -------------
 7 files changed, 314 insertions(+), 107 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index d2e63f3fb687..23583b0546d9 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -214,6 +214,217 @@
 					};
 				};
 			};
+
+			/* Settings for all MMC/SD/SDIO default and sleep states */
+			sdi0 {
+				/* This is the external SD card slot, 4 bits wide */
+				sdi0_default_mode: sdi0_default {
+					default_mux {
+						ste,function = "mc0";
+						ste,pins = "mc0_a_1";
+					};
+					default_cfg1 {
+						ste,pins =
+						"GPIO18_AC2", /* CMDDIR */
+						"GPIO19_AC1", /* DAT0DIR */
+						"GPIO20_AB4"; /* DAT2DIR */
+						ste,config = <&out_hi>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO22_AA3"; /* FBCLK */
+						ste,config = <&in_nopull>;
+					};
+					default_cfg3 {
+						ste,pins = "GPIO23_AA4"; /* CLK */
+						ste,config = <&out_lo>;
+					};
+					default_cfg4 {
+						ste,pins =
+						"GPIO24_AB2", /* CMD */
+						"GPIO25_Y4", /* DAT0 */
+						"GPIO26_Y2", /* DAT1 */
+						"GPIO27_AA2", /* DAT2 */
+						"GPIO28_AA1"; /* DAT3 */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				sdi0_sleep_mode: sdi0_sleep {
+					sleep_cfg1 {
+						ste,pins =
+						"GPIO18_AC2", /* CMDDIR */
+						"GPIO19_AC1", /* DAT0DIR */
+						"GPIO20_AB4"; /* DAT2DIR */
+						ste,config = <&slpm_out_hi_wkup_pdis>;
+					};
+					sleep_cfg2 {
+						ste,pins =
+						"GPIO22_AA3", /* FBCLK */
+						"GPIO24_AB2", /* CMD */
+						"GPIO25_Y4", /* DAT0 */
+						"GPIO26_Y2", /* DAT1 */
+						"GPIO27_AA2", /* DAT2 */
+						"GPIO28_AA1"; /* DAT3 */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+					sleep_cfg3 {
+						ste,pins = "GPIO23_AA4"; /* CLK */
+						ste,config = <&slpm_out_lo_wkup_pdis>;
+					};
+				};
+			};
+
+			sdi1 {
+				/* This is the WLAN SDIO 4 bits wide */
+				sdi1_default_mode: sdi1_default {
+					default_mux {
+						ste,function = "mc1";
+						ste,pins = "mc1_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO208_AH16"; /* CLK */
+						ste,config = <&out_lo>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO209_AG15"; /* FBCLK */
+						ste,config = <&in_nopull>;
+					};
+					default_cfg3 {
+						ste,pins =
+						"GPIO210_AJ15", /* CMD */
+						"GPIO211_AG14", /* DAT0 */
+						"GPIO212_AF13", /* DAT1 */
+						"GPIO213_AG13", /* DAT2 */
+						"GPIO214_AH15"; /* DAT3 */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				sdi1_sleep_mode: sdi1_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO208_AH16"; /* CLK */
+						ste,config = <&slpm_out_lo_wkup_pdis>;
+					};
+					sleep_cfg2 {
+						ste,pins =
+						"GPIO209_AG15", /* FBCLK */
+						"GPIO210_AJ15", /* CMD */
+						"GPIO211_AG14", /* DAT0 */
+						"GPIO212_AF13", /* DAT1 */
+						"GPIO213_AG13", /* DAT2 */
+						"GPIO214_AH15"; /* DAT3 */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
+
+			sdi2 {
+				/* This is the eMMC 8 bits wide, usually PoP eMMC */
+				sdi2_default_mode: sdi2_default {
+					default_mux {
+						ste,function = "mc2";
+						ste,pins = "mc2_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO128_A5"; /* CLK */
+						ste,config = <&out_lo>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO130_C8"; /* FBCLK */
+						ste,config = <&in_nopull>;
+					};
+					default_cfg3 {
+						ste,pins =
+						"GPIO129_B4", /* CMD */
+						"GPIO131_A12", /* DAT0 */
+						"GPIO132_C10", /* DAT1 */
+						"GPIO133_B10", /* DAT2 */
+						"GPIO134_B9", /* DAT3 */
+						"GPIO135_A9", /* DAT4 */
+						"GPIO136_C7", /* DAT5 */
+						"GPIO137_A7", /* DAT6 */
+						"GPIO138_C5"; /* DAT7 */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				sdi2_sleep_mode: sdi2_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO128_A5"; /* CLK */
+						ste,config = <&out_lo_wkup_pdis>;
+					};
+					sleep_cfg2 {
+						ste,pins =
+						"GPIO130_C8", /* FBCLK */
+						"GPIO129_B4"; /* CMD */
+						ste,config = <&in_wkup_pdis_en>;
+					};
+					sleep_cfg3 {
+						ste,pins =
+						"GPIO131_A12", /* DAT0 */
+						"GPIO132_C10", /* DAT1 */
+						"GPIO133_B10", /* DAT2 */
+						"GPIO134_B9", /* DAT3 */
+						"GPIO135_A9", /* DAT4 */
+						"GPIO136_C7", /* DAT5 */
+						"GPIO137_A7", /* DAT6 */
+						"GPIO138_C5"; /* DAT7 */
+						ste,config = <&in_wkup_pdis>;
+					};
+				};
+			};
+
+			sdi4 {
+				/* This is the eMMC 8 bits wide, usually PCB-mounted eMMC */
+				sdi4_default_mode: sdi4_default {
+					default_mux {
+						ste,function = "mc4";
+						ste,pins = "mc4_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO203_AE23"; /* CLK */
+						ste,config = <&out_lo>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO202_AF25"; /* FBCLK */
+						ste,config = <&in_nopull>;
+					};
+					default_cfg3 {
+						ste,pins =
+						"GPIO201_AF24", /* CMD */
+						"GPIO200_AH26", /* DAT0 */
+						"GPIO199_AH23", /* DAT1 */
+						"GPIO198_AG25", /* DAT2 */
+						"GPIO197_AH24", /* DAT3 */
+						"GPIO207_AJ23", /* DAT4 */
+						"GPIO206_AG24", /* DAT5 */
+						"GPIO205_AG23", /* DAT6 */
+						"GPIO204_AF23"; /* DAT7 */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				sdi4_sleep_mode: sdi4_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO203_AE23"; /* CLK */
+						ste,config = <&out_lo_wkup_pdis>;
+					};
+					sleep_cfg2 {
+						ste,pins =
+						"GPIO202_AF25", /* FBCLK */
+						"GPIO201_AF24", /* CMD */
+						"GPIO200_AH26", /* DAT0 */
+						"GPIO199_AH23", /* DAT1 */
+						"GPIO198_AG25", /* DAT2 */
+						"GPIO197_AH24", /* DAT3 */
+						"GPIO207_AJ23", /* DAT4 */
+						"GPIO206_AG24", /* DAT5 */
+						"GPIO205_AG23", /* DAT6 */
+						"GPIO204_AF23"; /* DAT7 */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 1863241c911e..845eb25f5d26 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -125,6 +125,9 @@
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi0_default_mode>;
+			pinctrl-1 = <&sdi0_sleep_mode>;
 
 			cd-gpios  = <&tc3589x_gpio 3 0x4>;
 
@@ -136,6 +139,9 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi1_default_mode>;
+			pinctrl-1 = <&sdi1_sleep_mode>;
 
 			status = "okay";
 		};
@@ -146,6 +152,9 @@
 			max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi2_default_mode>;
+			pinctrl-1 = <&sdi2_sleep_mode>;
 
 			status = "okay";
 		};
@@ -157,6 +166,9 @@
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi4_default_mode>;
+			pinctrl-1 = <&sdi4_sleep_mode>;
 
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 6b271a410d03..cfd7ef306d49 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -55,5 +55,22 @@
 
 			status = "okay";
 		};
+
+		pinctrl {
+			sdi0 {
+				/* This additional pin needed on early MOP500 and HREFs previous to v60 */
+				sdi0_default_mode: sdi0_default {
+					hrefprev60_mux {
+						ste,function = "mc0";
+						ste,pins = "mc0dat31dir_a_1";
+					};
+					hrefprev60_cfg1 {
+						ste,pins = "GPIO21_AB3"; /* DAT31DIR */
+						ste,config = <&out_hi>;
+					};
+
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index aed511b47a9e..452f00c4f7c0 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -66,5 +66,17 @@
 
 			status = "okay";
 		};
+
+		pinctrl {
+			sdi0 {
+				/* SD card detect GPIO pin, extend default state */
+				sdi0_default_mode: sdi0_default {
+					default_hrefv60_cfg1 {
+						ste,pins = "GPIO95_E8";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index efddee9403c4..f213222cf220 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -68,6 +68,13 @@
 		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
 	};
 
+	slpm_out_lo_wkup_pdis: slpm_out_lo_wkup_pdis {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-output = <SLPM_OUTPUT_LOW>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
+	};
+
 	slpm_out_wkup_pdis: slpm_out_wkup_pdis {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-output = <SLPM_DIR_OUTPUT>;
@@ -81,6 +88,18 @@
 		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
 	};
 
+	in_wkup_pdis_en: in_wkup_pdis_en {
+		ste,sleep-input = <SLPM_DIR_INPUT>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_ENABLED>;
+	};
+
+	out_lo_wkup_pdis: out_lo_wkup_pdis {
+		ste,sleep-output = <SLPM_OUTPUT_LOW>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
+	};
+
 	out_hi_wkup_pdis: out_hi_wkup_pdis {
 		ste,sleep-output = <SLPM_OUTPUT_HIGH>;
 		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f8df43e0791d..c2cb3ea637dc 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -137,6 +137,9 @@
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi0_default_mode>;
+			pinctrl-1 = <&sdi0_sleep_mode>;
 
 			cd-gpios  = <&gpio6 26 0x4>; // 218
 			cd-inverted;
@@ -144,6 +147,27 @@
 			status = "okay";
 		};
 
+		// WLAN SDIO channel
+		sdi1_per2 at 80118000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <100000000>;
+			bus-width = <4>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi1_default_mode>;
+			pinctrl-1 = <&sdi1_sleep_mode>;
+
+			status = "okay";
+		};
+
+		// Unused PoP eMMC - register and put it to sleep by default */
+		sdi2_per3 at 80005000 {
+			arm,primecell-periphid = <0x10480180>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdi2_sleep_mode>;
+
+			status = "okay";
+		};
+
 		// On-board eMMC
 		sdi4_per2 at 80114000 {
 			arm,primecell-periphid = <0x10480180>;
@@ -151,6 +175,9 @@
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdi4_default_mode>;
+			pinctrl-1 = <&sdi4_sleep_mode>;
 
 			status = "okay";
 		};
@@ -300,5 +327,21 @@
 				};
 			};
 		};
+
+		pinctrl {
+			sdi0 {
+				sdi0_default_mode: sdi0_default {
+					snowball_mux {
+						ste,function = "mc0";
+						ste,pins = "mc0dat31dir_a_1";
+					};
+					snowball_cfg1 {
+						ste,pins = "GPIO21_AB3"; /* DAT31DIR */
+						ste,config = <&out_hi>;
+					};
+
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 1f1e53972063..0f9a0776cf90 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -63,12 +63,6 @@ BIAS(slpm_out_hi_wkup_pdis, PIN_SLEEPMODE_ENABLED|PIN_SLPM_OUTPUT_HIGH|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_in_pu_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|PIN_SLPM_INPUT_PULLUP|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
-BIAS(out_lo_wkup_pdis, PIN_SLPM_OUTPUT_LOW|
-	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(in_wkup_pdis_en, PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|
-	PIN_SLPM_PDIS_ENABLED);
-BIAS(in_wkup_pdis, PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|
-	PIN_SLPM_PDIS_DISABLED);
 
 /* We use these to define hog settings that are always done on boot */
 #define DB8500_MUX_HOG(group,func) \
@@ -389,99 +383,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_PIN("GPIO69_E2", in_pu, "0-0070"),
 	/* LCD VSI1 sleep state */
 	DB8500_PIN_SLEEP("GPIO69_E2", slpm_in_wkup_pdis, "0-0070"),
-	/* Mux in SDI0 (here called MC0) used for removable MMC/SD/SDIO cards */
-	DB8500_MUX("mc0_a_1", "mc0", "sdi0"),
-	DB8500_PIN("GPIO18_AC2", out_hi, "sdi0"), /* CMDDIR */
-	DB8500_PIN("GPIO19_AC1", out_hi, "sdi0"), /* DAT0DIR */
-	DB8500_PIN("GPIO20_AB4", out_hi, "sdi0"), /* DAT2DIR */
-	DB8500_PIN("GPIO22_AA3", in_nopull, "sdi0"), /* FBCLK */
-	DB8500_PIN("GPIO23_AA4", out_lo, "sdi0"), /* CLK */
-	DB8500_PIN("GPIO24_AB2", in_pu, "sdi0"), /* CMD */
-	DB8500_PIN("GPIO25_Y4", in_pu, "sdi0"), /* DAT0 */
-	DB8500_PIN("GPIO26_Y2", in_pu, "sdi0"), /* DAT1 */
-	DB8500_PIN("GPIO27_AA2", in_pu, "sdi0"), /* DAT2 */
-	DB8500_PIN("GPIO28_AA1", in_pu, "sdi0"), /* DAT3 */
-	/* SDI0 sleep state */
-	DB8500_PIN_SLEEP("GPIO18_AC2", slpm_out_hi_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO19_AC1", slpm_out_hi_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO20_AB4", slpm_out_hi_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO22_AA3", slpm_in_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO23_AA4", slpm_out_lo_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO24_AB2", slpm_in_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO25_Y4", slpm_in_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO26_Y2", slpm_in_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO27_AA2", slpm_in_wkup_pdis, "sdi0"),
-	DB8500_PIN_SLEEP("GPIO28_AA1", slpm_in_wkup_pdis, "sdi0"),
-
-	/* Mux in SDI1 (here called MC1) used for SDIO for CW1200 WLAN */
-	DB8500_MUX("mc1_a_1", "mc1", "sdi1"),
-	DB8500_PIN("GPIO208_AH16", out_lo, "sdi1"), /* CLK */
-	DB8500_PIN("GPIO209_AG15", in_nopull, "sdi1"), /* FBCLK */
-	DB8500_PIN("GPIO210_AJ15", in_pu, "sdi1"), /* CMD */
-	DB8500_PIN("GPIO211_AG14", in_pu, "sdi1"), /* DAT0 */
-	DB8500_PIN("GPIO212_AF13", in_pu, "sdi1"), /* DAT1 */
-	DB8500_PIN("GPIO213_AG13", in_pu, "sdi1"), /* DAT2 */
-	DB8500_PIN("GPIO214_AH15", in_pu, "sdi1"), /* DAT3 */
-	/* SDI1 sleep state */
-	DB8500_PIN_SLEEP("GPIO208_AH16", slpm_out_lo_wkup_pdis, "sdi1"), /* CLK */
-	DB8500_PIN_SLEEP("GPIO209_AG15", slpm_in_wkup_pdis, "sdi1"), /* FBCLK */
-	DB8500_PIN_SLEEP("GPIO210_AJ15", slpm_in_wkup_pdis, "sdi1"), /* CMD */
-	DB8500_PIN_SLEEP("GPIO211_AG14", slpm_in_wkup_pdis, "sdi1"), /* DAT0 */
-	DB8500_PIN_SLEEP("GPIO212_AF13", slpm_in_wkup_pdis, "sdi1"), /* DAT1 */
-	DB8500_PIN_SLEEP("GPIO213_AG13", slpm_in_wkup_pdis, "sdi1"), /* DAT2 */
-	DB8500_PIN_SLEEP("GPIO214_AH15", slpm_in_wkup_pdis, "sdi1"), /* DAT3 */
-
-	/* Mux in SDI2 (here called MC2) used for for PoP eMMC */
-	DB8500_MUX("mc2_a_1", "mc2", "sdi2"),
-	DB8500_PIN("GPIO128_A5", out_lo, "sdi2"), /* CLK */
-	DB8500_PIN("GPIO129_B4", in_pu, "sdi2"), /* CMD */
-	DB8500_PIN("GPIO130_C8", in_nopull, "sdi2"), /* FBCLK */
-	DB8500_PIN("GPIO131_A12", in_pu, "sdi2"), /* DAT0 */
-	DB8500_PIN("GPIO132_C10", in_pu, "sdi2"), /* DAT1 */
-	DB8500_PIN("GPIO133_B10", in_pu, "sdi2"), /* DAT2 */
-	DB8500_PIN("GPIO134_B9", in_pu, "sdi2"), /* DAT3 */
-	DB8500_PIN("GPIO135_A9", in_pu, "sdi2"), /* DAT4 */
-	DB8500_PIN("GPIO136_C7", in_pu, "sdi2"), /* DAT5 */
-	DB8500_PIN("GPIO137_A7", in_pu, "sdi2"), /* DAT6 */
-	DB8500_PIN("GPIO138_C5", in_pu, "sdi2"), /* DAT7 */
-	/* SDI2 sleep state */
-	DB8500_PIN_SLEEP("GPIO128_A5", out_lo_wkup_pdis, "sdi2"), /* CLK */
-	DB8500_PIN_SLEEP("GPIO129_B4", in_wkup_pdis_en, "sdi2"), /* CMD */
-	DB8500_PIN_SLEEP("GPIO130_C8", in_wkup_pdis_en, "sdi2"), /* FBCLK */
-	DB8500_PIN_SLEEP("GPIO131_A12", in_wkup_pdis, "sdi2"), /* DAT0 */
-	DB8500_PIN_SLEEP("GPIO132_C10", in_wkup_pdis, "sdi2"), /* DAT1 */
-	DB8500_PIN_SLEEP("GPIO133_B10", in_wkup_pdis, "sdi2"), /* DAT2 */
-	DB8500_PIN_SLEEP("GPIO134_B9", in_wkup_pdis, "sdi2"), /* DAT3 */
-	DB8500_PIN_SLEEP("GPIO135_A9", in_wkup_pdis, "sdi2"), /* DAT4 */
-	DB8500_PIN_SLEEP("GPIO136_C7", in_wkup_pdis, "sdi2"), /* DAT5 */
-	DB8500_PIN_SLEEP("GPIO137_A7", in_wkup_pdis, "sdi2"), /* DAT6 */
-	DB8500_PIN_SLEEP("GPIO138_C5", in_wkup_pdis, "sdi2"), /* DAT7 */
-
-	/* Mux in SDI4 (here called MC4) used for for PCB-mounted eMMC */
-	DB8500_MUX("mc4_a_1", "mc4", "sdi4"),
-	DB8500_PIN("GPIO197_AH24", in_pu, "sdi4"), /* DAT3 */
-	DB8500_PIN("GPIO198_AG25", in_pu, "sdi4"), /* DAT2 */
-	DB8500_PIN("GPIO199_AH23", in_pu, "sdi4"), /* DAT1 */
-	DB8500_PIN("GPIO200_AH26", in_pu, "sdi4"), /* DAT0 */
-	DB8500_PIN("GPIO201_AF24", in_pu, "sdi4"), /* CMD */
-	DB8500_PIN("GPIO202_AF25", in_nopull, "sdi4"), /* FBCLK */
-	DB8500_PIN("GPIO203_AE23", out_lo, "sdi4"), /* CLK */
-	DB8500_PIN("GPIO204_AF23", in_pu, "sdi4"), /* DAT7 */
-	DB8500_PIN("GPIO205_AG23", in_pu, "sdi4"), /* DAT6 */
-	DB8500_PIN("GPIO206_AG24", in_pu, "sdi4"), /* DAT5 */
-	DB8500_PIN("GPIO207_AJ23", in_pu, "sdi4"), /* DAT4 */
-	/*SDI4 sleep state */
-	DB8500_PIN_SLEEP("GPIO197_AH24", slpm_in_wkup_pdis, "sdi4"), /* DAT3 */
-	DB8500_PIN_SLEEP("GPIO198_AG25", slpm_in_wkup_pdis, "sdi4"), /* DAT2 */
-	DB8500_PIN_SLEEP("GPIO199_AH23", slpm_in_wkup_pdis, "sdi4"), /* DAT1 */
-	DB8500_PIN_SLEEP("GPIO200_AH26", slpm_in_wkup_pdis, "sdi4"), /* DAT0 */
-	DB8500_PIN_SLEEP("GPIO201_AF24", slpm_in_wkup_pdis, "sdi4"), /* CMD */
-	DB8500_PIN_SLEEP("GPIO202_AF25", slpm_in_wkup_pdis, "sdi4"), /* FBCLK */
-	DB8500_PIN_SLEEP("GPIO203_AE23", slpm_out_lo_wkup_pdis, "sdi4"), /* CLK */
-	DB8500_PIN_SLEEP("GPIO204_AF23", slpm_in_wkup_pdis, "sdi4"), /* DAT7 */
-	DB8500_PIN_SLEEP("GPIO205_AG23", slpm_in_wkup_pdis, "sdi4"), /* DAT6 */
-	DB8500_PIN_SLEEP("GPIO206_AG24", slpm_in_wkup_pdis, "sdi4"), /* DAT5 */
-	DB8500_PIN_SLEEP("GPIO207_AJ23", slpm_in_wkup_pdis, "sdi4"), /* DAT4 */
 
 	/* Mux in USB pins, drive STP high */
 	/* USB default state */
@@ -795,10 +696,6 @@ static struct pinctrl_map __initdata mop500_pinmap[] = {
 	DB8500_PIN_SLEEP("GPIO166_A22", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O2 */
 	DB8500_PIN_SLEEP("GPIO167_B24", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O1 */
 	DB8500_PIN_SLEEP("GPIO168_C22", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O0 */
-
-	/* Mux in and drive the SDI0 DAT31DIR line high at runtime */
-	DB8500_MUX("mc0dat31dir_a_1", "mc0", "sdi0"),
-	DB8500_PIN("GPIO21_AB3", out_hi, "sdi0"),
 };
 
 /*
@@ -888,8 +785,6 @@ static struct pinctrl_map __initdata hrefv60_pinmap[] = {
 	/* Accelerometer interrupt lines */
 	DB8500_PIN_HOG("GPIO82_C1", gpio_in_pu), /* ACC_INT1 */
 	DB8500_PIN_HOG("GPIO83_D3", gpio_in_pu), /* ACC_INT2 */
-	/* SD card detect GPIO pin */
-	DB8500_PIN_HOG("GPIO95_E8", gpio_in_pu),
 	/*
 	 * Runtime stuff
 	 * Pull up/down of some sensor GPIO pins, for proximity, HAL sensor
@@ -925,8 +820,6 @@ static struct pinctrl_map __initdata snowball_pinmap[] = {
 	/* Mux in SSP0 connected to AB8500, pull down RXD pin */
 	DB8500_MUX_HOG("ssp0_a_1", "ssp0"),
 	DB8500_PIN_HOG("GPIO145_C13", pd),
-	/* Always drive the MC0 DAT31DIR line high on these boards */
-	DB8500_PIN_HOG("GPIO21_AB3", out_hi),
 	/* Mux in "SM" which is used for the SMSC911x Ethernet adapter */
 	DB8500_MUX_HOG("sm_b_1", "sm"),
 	/* User LED */
-- 
1.8.3.1
