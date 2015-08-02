From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  2 Aug 2015 23:56:21 +0200
Subject: [PATCH 2/4] ARM: nomadik: selectively enable UART0 on boards
Message-ID: <1438552581-4531-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S8815 board is using RX/TX on UART0, and the NHK8815 is
using RX/TX and CTS/RTS (the latter connected to a Bluetooth
chip). Activate the right groups with the u0 UART0 function
on each board and undisable it. Get rid of the old erroneous
default definition from the SoC file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts    | 16 ++++++++++++++++
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 18 +++++++++++++++++-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 10 ----------
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 0e167ed2857b..9d888b0e75af 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -17,12 +17,22 @@
 	};
 
 	aliases {
+		serial0 = &uart0;
 		serial1 = &uart1;
 		stmpe-i2c0 = &stmpe0;
 		stmpe-i2c1 = &stmpe1;
 	};
 
 	pinctrl {
+		uart0 {
+			uart0_nhk_mode: uart0_mux {
+				u0_default_mux {
+					function = "u0";
+					groups = "u0txrx_a_1", "u0ctsrts_a_1";
+				};
+			};
+		};
+
 		stmpe2401_1 {
 			stmpe2401_1_nhk_mode: stmpe2401_1_nhk {
 				nhk_cfg1 {
@@ -146,6 +156,12 @@
 	};
 
 	amba {
+		/* Activate RX/TX and CTS/RTS on UART 0 */
+		uart0: uart at 101fd000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_nhk_mode>;
+			status = "okay";
+		};
 		mmcsd: sdi at 101f6000 {
 			cd-gpios = <&stmpe_gpio44 7 GPIO_ACTIVE_LOW>;
 			wp-gpios = <&stmpe_gpio44 18 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index edcfe2413ee7..11b5e34150b8 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -16,6 +16,7 @@
 	};
 
 	aliases {
+		serial0 = &uart0;
 		serial1 = &uart1;
 	};
 
@@ -40,6 +41,15 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&cd_default_mode>;
 
+		uart0 {
+			/* Only use RX/TX pins */
+			uart0_s8815_mode: uart0_mux {
+				u0_default_mux {
+					function = "u0";
+					groups = "u0txrx_a_1";
+				};
+			};
+		};
 		mmcsd-cd {
 			cd_default_mode: cd_default {
 				cd_default_cfg1 {
@@ -112,8 +122,14 @@
 	};
 
 
-	/* Configure card detect for the uSD slot */
 	amba {
+		/* Activate RXTX on UART 0 */
+		uart0: uart at 101fd000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_s8815_mode>;
+			status = "okay";
+		};
+		/* Configure card detect for the uSD slot */
 		mmcsd: sdi at 101f6000 {
 			cd-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 8e601d02ca8c..0edab6d23211 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -103,14 +103,6 @@
 		compatible = "stericsson,stn8815-pinctrl";
 		nomadik-gpio-chips = <&gpio0>, <&gpio1>, <&gpio2>, <&gpio3>;
 		/* Pin configurations */
-		uart0 {
-			uart0_default_mux: uart0_mux {
-				u0_default_mux {
-					function = "u0";
-					groups = "u0_a_1";
-				};
-			};
-		};
 		uart1 {
 			uart1_default_mux: uart1_mux {
 				u1_default_mux {
@@ -761,8 +753,6 @@
 			interrupts = <12>;
 			clocks = <&uart0clk>, <&pclkuart0>;
 			clock-names = "uartclk", "apb_pclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_default_mux>;
 			status = "disabled";
 		};
 
-- 
2.4.3
