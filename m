From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 Aug 2017 12:05:57 +0200
Subject: [PATCH 4/4 v2] ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685
In-Reply-To: <20170820100557.24991-1-linus.walleij@linaro.org>
References: <20170820100557.24991-1-linus.walleij@linaro.org>
Message-ID: <20170820100557.24991-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the TVE200/TVC TV-encoder and the Ilitek ILI9322 panel
to the DIR-685 device tree.

This brings graphics to this funky router and it is possible to
even run a console on its tiny screen.

Incidentally this requires us to disable the access to the
parallel (NOR) flash, as the communication pins to the panel
are shared with the flash memory.

To access the flash, a separate kernel with the panel disabled
and the flash enabled should be booted. The pin control selecting
whether to use the lines cannot be altered at runtime due to
hardware constraints.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename node from "tvc" to "display-controller"

DRM developers: I will merge this patch through the ARM SoC
tree. It is only included in this series for completion.
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 75 +++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 094a29624b8d..8e4037597a2c 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -46,6 +46,59 @@
 		};
 	};
 
+	vdisp: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "display-power";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+		/* Collides with LCD E */
+		gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Collides with IDE pins, that's cool (we do not use them) */
+		gpio-sck = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		/* Collides with pflash CE1, not so cool */
+		cs-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		panel: display at 0 {
+			compatible = "ilitek,ili9322";
+			reg = <0>;
+			/* 50 ns min period = 20 MHz */
+			spi-max-frequency = <20000000>;
+			spi-cpol; /* Clock active low */
+
+			/* Panel LM918A01-1A SY-B4-091116-E0199 */
+			width-mm = <65>;
+			height-mm = <50>;
+			ilitek,entry-mode = <11>;
+			ilitek,vreg1out-microvolt = <4600>;
+			ilitek,vcom-high-percent = <91>;
+			ilitek,vcom-amplitude-percent = <114>;
+			ilitek,gamma-correction-neg = <0xa>, <0x5>, <0x7>,
+				<0x7>, <0x7>, <0x5>, <0x1>, <0x6>;
+			ilitek,gamma-correction-pos = <0x7>, <0x7>, <0x3>,
+				<0x2>, <0x3>, <0x5>, <0x7>, <0x2>;
+			vcc-supply = <&vdisp>;
+			iovcc-supply = <&vdisp>;
+			vci-supply = <&vdisp>;
+
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&display_out>;
+				};
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led at 7 {
@@ -114,7 +167,16 @@
 
 	soc {
 		flash at 30000000 {
-			status = "okay";
+			/*
+			 * Flash access is by default disabled, because it
+			 * collides with the Chip Enable signal for the display
+			 * panel, that reuse the parallel flash Chip Select 1
+			 * (CS1). Enabling flash makes graphics stop working.
+			 *
+			 * We might be able to hack around this by letting
+			 * GPIO poke around in the flash controller registers.
+			 */
+			/* status = "okay"; */
 			/* 32MB of flash */
 			reg = <0x30000000 0x02000000>;
 
@@ -241,5 +303,16 @@
 		ata at 63000000 {
 			status = "okay";
 		};
+
+		display-controller at 6a000000 {
+			status = "okay";
+
+			port at 0 {
+				reg = <0>;
+				display_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
 	};
 };
-- 
2.13.5
