From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:50 +0100
Subject: [PATCH 01/21] ARM: ux500: move UART pin control to the device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the static, device-tied pin control configuration
out of the board file board-mop500-pins.c and into the device
tree.

We create a new .dtsi-file to be shared between all the
MOP500-related boards, that include all HREF variants and
the Snowball board. Assign pin states for HREF and Snowball
boards alike.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 114 +++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                |  10 +++
 arch/arm/boot/dts/ste-snowball.dts             |  10 +++
 arch/arm/mach-ux500/board-mop500-pins.c        |  52 -----------
 4 files changed, 134 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
new file mode 100644
index 000000000000..d979de27b6e1
--- /dev/null
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2013 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "ste-nomadik-pinctrl.dtsi"
+
+/ {
+	soc {
+		pinctrl {
+			/* Settings for all UART default and sleep states */
+			uart0 {
+				uart0_default_mode: uart0_default {
+					default_mux {
+						ste,function = "u0";
+						ste,pins = "u0_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
+						ste,config = <&in_pu>;
+					};
+
+					default_cfg2 {
+						ste,pins = "GPIO1_AJ3", "GPIO3_AH3"; /* RTS+TXD */
+						ste,config = <&out_hi>;
+					};
+				};
+
+				uart0_sleep_mode: uart0_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO0_AJ5", "GPIO2_AH4"; /* CTS+RXD */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+
+					sleep_cfg2 {
+						ste,pins = "GPIO1_AJ3"; /* RTS */
+						ste,config = <&slpm_out_hi_wkup_pdis>;
+					};
+
+					sleep_cfg3 {
+						ste,pins = "GPIO3_AH3"; /* TXD */
+						ste,config = <&slpm_out_wkup_pdis>;
+					};
+				};
+			};
+
+			uart1 {
+				uart1_default_mode: uart1_default {
+					default_mux {
+						ste,function = "u1";
+						ste,pins = "u1rxtx_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO4_AH6"; /* RXD */
+						ste,config = <&in_pu>;
+					};
+
+					default_cfg2 {
+						ste,pins = "GPIO5_AG6"; /* TXD */
+						ste,config = <&out_hi>;
+					};
+				};
+
+				uart1_sleep_mode: uart1_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO4_AH6"; /* RXD */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+
+					sleep_cfg2 {
+						ste,pins = "GPIO5_AG6"; /* TXD */
+						ste,config = <&slpm_out_wkup_pdis>;
+					};
+				};
+			};
+
+			uart2 {
+				uart2_default_mode: uart2_default {
+					default_mux {
+						ste,function = "u2";
+						ste,pins = "u2rxtx_c_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO29_W2"; /* RXD */
+						ste,config = <&in_pu>;
+					};
+
+					default_cfg2 {
+						ste,pins = "GPIO30_W3"; /* TXD */
+						ste,config = <&out_hi>;
+					};
+				};
+
+				uart2_sleep_mode: uart2_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO29_W2"; /* RXD */
+						ste,config = <&in_wkup_pdis>;
+					};
+
+					sleep_cfg2 {
+						ste,pins = "GPIO30_W3"; /* TXD */
+						ste,config = <&out_wkup_pdis>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index aa3f02060fdd..914a5f4399e5 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "ste-dbx5x0.dtsi"
+#include "ste-href-family-pinctrl.dtsi"
 
 / {
 	memory {
@@ -30,14 +31,23 @@
 
 	soc {
 		uart at 80120000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&uart0_default_mode>;
+			pinctrl-1 = <&uart0_sleep_mode>;
 			status = "okay";
 		};
 
 		uart at 80121000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&uart1_default_mode>;
+			pinctrl-1 = <&uart1_sleep_mode>;
 			status = "okay";
 		};
 
 		uart at 80007000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&uart2_default_mode>;
+			pinctrl-1 = <&uart2_sleep_mode>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f0b39f835914..16d28863ef6e 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "ste-dbx5x0.dtsi"
+#include "ste-href-family-pinctrl.dtsi"
 
 / {
 	model = "Calao Systems Snowball platform with device tree";
@@ -155,14 +156,23 @@
 		};
 
 		uart at 80120000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&uart0_default_mode>;
+			pinctrl-1 = <&uart0_sleep_mode>;
 			status = "okay";
 		};
 
 		uart at 80121000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&uart1_default_mode>;
+			pinctrl-1 = <&uart1_sleep_mode>;
 			status = "okay";
 		};
 
 		uart at 80007000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&uart2_default_mode>;
+			pinctrl-1 = <&uart2_sleep_mode>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0efb1560fc35..c6225191141f 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -65,16 +65,12 @@ BIAS(slpm_in_nopull_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_INPUT_NOPULL|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_in_pu_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|PIN_SLPM_INPUT_PULLUP|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
-BIAS(slpm_out_wkup_pdis, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_DIR_OUTPUT|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(out_lo_wkup_pdis, PIN_SLPM_OUTPUT_LOW|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(in_wkup_pdis_en, PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|
 	PIN_SLPM_PDIS_ENABLED);
 BIAS(in_wkup_pdis, PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|
 	PIN_SLPM_PDIS_DISABLED);
-BIAS(out_wkup_pdis, PIN_SLPM_DIR_OUTPUT|PIN_SLPM_WAKEUP_ENABLE|
-	PIN_SLPM_PDIS_DISABLED);
 
 /* We use these to define hog settings that are always done on boot */
 #define DB8500_MUX_HOG(group,func) \
@@ -376,50 +372,10 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	 */
 	DB8500_PIN_HOG("GPIO218_AH11", gpio_in_pu),
 	/*
-	 * UART0, we do not mux in u0 here.
-	 * uart-0 pins gpio configuration should be kept intact to prevent
-	 * a glitch in tx line when the tty dev is opened. Later these pins
-	 * are configured by uart driver
-	 */
-	DB8500_PIN_HOG("GPIO0_AJ5", in_pu), /* CTS */
-	DB8500_PIN_HOG("GPIO1_AJ3", out_hi), /* RTS */
-	DB8500_PIN_HOG("GPIO2_AH4", in_pu), /* RXD */
-	DB8500_PIN_HOG("GPIO3_AH3", out_hi), /* TXD */
-	/*
-	 * Mux in UART2 on altfunction C and set pull-ups.
-	 * TODO: is this used on U8500 variants and Snowball really?
-	 * The setting on GPIO31 conflicts with magnetometer use on hrefv60
-	 */
-	/* default state for UART2 */
-	DB8500_MUX("u2rxtx_c_1", "u2", "uart2"),
-	DB8500_PIN("GPIO29_W2", in_pu, "uart2"), /* RXD */
-	DB8500_PIN("GPIO30_W3", out_hi, "uart2"), /* TXD */
-	/* Sleep state for UART2 */
-	DB8500_PIN_SLEEP("GPIO29_W2", in_wkup_pdis, "uart2"),
-	DB8500_PIN_SLEEP("GPIO30_W3", out_wkup_pdis, "uart2"),
-	/*
 	 * The following pin sets were known as "runtime pins" before being
 	 * converted to the pinctrl model. Here we model them as "default"
 	 * states.
 	 */
-	/* Mux in UART0 after initialization */
-	DB8500_MUX("u0_a_1", "u0", "uart0"),
-	DB8500_PIN("GPIO0_AJ5", in_pu, "uart0"), /* CTS */
-	DB8500_PIN("GPIO1_AJ3", out_hi, "uart0"), /* RTS */
-	DB8500_PIN("GPIO2_AH4", in_pu, "uart0"), /* RXD */
-	DB8500_PIN("GPIO3_AH3", out_hi, "uart0"), /* TXD */
-	/* Sleep state for UART0 */
-	DB8500_PIN_SLEEP("GPIO0_AJ5", slpm_in_wkup_pdis, "uart0"),
-	DB8500_PIN_SLEEP("GPIO1_AJ3", slpm_out_hi_wkup_pdis, "uart0"),
-	DB8500_PIN_SLEEP("GPIO2_AH4", slpm_in_wkup_pdis, "uart0"),
-	DB8500_PIN_SLEEP("GPIO3_AH3", slpm_out_wkup_pdis, "uart0"),
-	/* Mux in UART1 after initialization */
-	DB8500_MUX("u1rxtx_a_1", "u1", "uart1"),
-	DB8500_PIN("GPIO4_AH6", in_pu, "uart1"), /* RXD */
-	DB8500_PIN("GPIO5_AG6", out_hi, "uart1"), /* TXD */
-	/* Sleep state for UART1 */
-	DB8500_PIN_SLEEP("GPIO4_AH6", slpm_in_wkup_pdis, "uart1"),
-	DB8500_PIN_SLEEP("GPIO5_AG6", slpm_out_wkup_pdis, "uart1"),
 	/* MSP1 for ALSA codec */
 	DB8500_MUX_HOG("msp1txrx_a_1", "msp1"),
 	DB8500_MUX_HOG("msp1_a_1", "msp1"),
@@ -822,10 +778,6 @@ static struct pinctrl_map __initdata mop500_pinmap[] = {
 	DB8500_PIN_HOG("GPIO7_AG5", in_pu),
 	/* TC35892 IRQ, pull up the line, let the driver mux in the pin */
 	DB8500_PIN_HOG("GPIO217_AH12", gpio_in_pu),
-	/* Mux in UART1 and set the pull-ups */
-	DB8500_MUX_HOG("u1rxtx_a_1", "u1"),
-	DB8500_PIN_HOG("GPIO4_AH6", in_pu), /* RXD */
-	DB8500_PIN_HOG("GPIO5_AG6", out_hi), /* TXD */
 	/*
 	 * Runtime stuff: make it possible to mux in the SKE keypad
 	 * and bias the pins
@@ -971,10 +923,6 @@ static struct pinctrl_map __initdata hrefv60_pinmap[] = {
 };
 
 static struct pinctrl_map __initdata u9500_pinmap[] = {
-	/* Mux in UART1 (just RX/TX) and set the pull-ups */
-	DB8500_MUX_HOG("u1rxtx_a_1", "u1"),
-	DB8500_PIN_HOG("GPIO4_AH6", in_pu),
-	DB8500_PIN_HOG("GPIO5_AG6", out_hi),
 	/* WLAN_IRQ line */
 	DB8500_PIN_HOG("GPIO144_B13", gpio_in_pu),
 	/* HSI */
-- 
1.8.3.1
