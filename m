From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Sep 2018 16:37:08 +0200
Subject: [PATCH] ARM: dts: Augment Nomadik NHK15 panel setting
Message-ID: <20180925143708.20134-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NHK15 panel is specified inside the display controller,
which works for the DPI-type DT parsing the old fbdev code
used, but for the DRM driver it needs to be spawn as its own
device, so we move it out of the display controller.

We also drop the panel timings: this should be determined
by the hardware or a device-specific compatible string, not
by this type of encoding into the device tree. It turns out
that this hardware is strapped to the right configuration
at boot already and we the driver just reads out the
hardware-specified resolution and timings. Drop the
"panel,dpi" compatible string altogether.

Fix a comment error in the DTS file while we're at it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 86 +++++++++++++++----------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 12afdc7467e7..cd33bb257f6b 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree for the ST-Ericsson Nomadik S8815 board
- * Produced by Calao Systems
+ * Device Tree for the ST Microelectronics Nomadik NHK8815 board
  */
 
 /dts-v1/;
@@ -182,43 +181,12 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&clcd_24bit_mux>;
 			port {
-				nomadik_clcd_pads: endpoint {
+				nomadik_clcd: endpoint {
 					remote-endpoint = <&nomadik_clcd_panel>;
 					arm,pl11x,tft-r0g0b0-pads = <16 8 0>;
 				};
 			};
 
-			/*
-			 * WVGA connector 21
-			 * WVGA (800x480): 4.3" TPG110 TDO43MTEA2 24-bit RGB
-			 * with TPO touch screen.
-			 */
-			panel {
-				compatible = "tpo,tpg110", "panel-dpi";
-				grestb-gpios = <&stmpe_gpio44 5 GPIO_ACTIVE_LOW>;
-				scen-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-				scl-gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
-				sda-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-				backlight = <&bl>;
-
-				port {
-					nomadik_clcd_panel: endpoint {
-						remote-endpoint = <&nomadik_clcd_pads>;
-					};
-				};
-
-				panel-timing {
-					clock-frequency = <33200000>;
-					hactive = <800>;
-					hback-porch = <216>;
-					hfront-porch = <40>;
-					hsync-len = <1>;
-					vactive = <480>;
-					vback-porch = <35>;
-					vfront-porch = <10>;
-					vsync-len = <1>;
-				};
-			};
 		};
 
 		/* Activate RX/TX and CTS/RTS on UART 0 */
@@ -233,6 +201,56 @@
 		};
 	};
 
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * As we're dealing with 3wire SPI, we only define SCK
+		 * and MOSI (in the spec MOSI is called "SDA").
+		 */
+		gpio-sck = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		/*
+		 * It's not actually active high, but the frameworks assume
+		 * the polarity of the passed-in GPIO is "normal" (active
+		 * high) then actively drives the line low to select the
+		 * chip.
+		 */
+		cs-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		/*
+		 * WVGA connector 21
+		 * WVGA (800x480): 4.3" TPG110 TDO43MTEA2 24-bit RGB
+		 * with TPO touch screen.
+		  */
+		panel: display at 0 {
+			/*
+			 * The TPO display driver is connected to a
+			 * 5.7" OSD OSD057VA01CT TFT display.
+			 */
+			compatible = "tpo,tpg110";
+			reg = <0>;
+			spi-3wire;
+			spi-3wire-high-impedance-turn-around;
+			/* 320 ns min period ~= 3 MHz */
+			spi-max-frequency = <3000000>;
+			/* Width and height from the OSD data sheet */
+			width-mm = <116>;
+			height-mm = <87>;
+			grestb-gpios = <&stmpe_gpio44 5 GPIO_ACTIVE_LOW>;
+			backlight = <&bl>;
+
+			port {
+				nomadik_clcd_panel: endpoint {
+					remote-endpoint = <&nomadik_clcd>;
+				};
+			};
+		};
+	};
+
 	bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&stmpe0_pwm 0 500000>;
-- 
2.17.1
