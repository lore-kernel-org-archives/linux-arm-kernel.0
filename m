From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:45:32 +0100
Subject: [PATCH 3/6] ARM: nomadik: move GPIO I2C to S8815 board file
In-Reply-To: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
References: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1414788335-28334-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The idea to use two GPIO pins for bit-banged I2C is an S8815
pecularity, so move this over to the board-specific file and
out of the SoC core DTSI file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 24 ------------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index c795ee8a356a..33caad8df276 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -47,6 +47,14 @@
 				};
 			};
 		};
+		gpioi2c {
+			gpioi2c_default_mode: gpioi2c_default {
+				gpioi2c_default_cfg {
+					ste,pins = "GPIO73_C21", "GPIO74_C20";
+					ste,input = <0>;
+				};
+			};
+		};
 		user-led {
 			user_led_default_mode: user_led_default {
 				user_led_default_cfg {
@@ -65,6 +73,23 @@
 		};
 	};
 
+	/* GPIO I2C connected to the USB portions of the STw4811 only */
+	gpio-i2c {
+		compatible = "i2c-gpio";
+		gpios = <&gpio2 10 0>, /* sda */
+			<&gpio2 9 0>; /* scl */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpioi2c_default_mode>;
+
+		stw4811 at 2d {
+			   compatible = "st,stw4811-usb";
+			   reg = <0x2d>;
+		};
+	};
+
+
 	/* Configure card detect for the uSD slot */
 	amba {
 		mmcsd: sdi at 101f6000 {
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 1ee9372191df..49b17c7dfb1b 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -169,14 +169,6 @@
 				};
 			};
 		};
-		i2c2 {
-			i2c2_default_mode: i2c2_default {
-				i2c2_default_cfg {
-					ste,pins = "GPIO73_C21", "GPIO74_C20";
-					ste,input = <0>;
-				};
-			};
-		};
 	};
 
 	src: src at 101e0000 {
@@ -747,22 +739,6 @@
 		};
 	};
 
-	/* I2C2 connected to the USB portions of the STw4811 only */
-	i2c2 {
-		compatible = "i2c-gpio";
-		gpios = <&gpio2 10 0>, /* sda */
-			<&gpio2 9 0>; /* scl */
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_default_mode>;
-
-		stw4811 at 2d {
-			   compatible = "st,stw4811-usb";
-			   reg = <0x2d>;
-		};
-	};
-
 	amba {
 		compatible = "arm,amba-bus";
 		#address-cells = <1>;
-- 
1.9.3
