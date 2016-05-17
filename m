From: marek@goldelico.com (Marek Belisko)
Date: Tue, 17 May 2016 21:48:47 +0200
Subject: [PATCH 1/5] ARM: dts: omap3-gta04: Add backlight support
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Message-ID: <1463514531-7235-2-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define pwm backlight node which is using dmtimer pwm.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ab9fb8f..cef8b23 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -100,6 +100,22 @@
 		};
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm11 0 2000000 0>;
+		pwm-names = "backlight";
+		brightness-levels = <0 11 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <9>;	/* => 90 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+	};
+
+	pwm11: dmtimer-pwm at 11 {
+		compatible = "ti,omap-dmtimer-pwm";
+		ti,timers = <&timer11>;
+		#pwm-cells = <3>;
+	};
+
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
@@ -190,6 +206,12 @@
 		>;
 	};
 
+	backlight_pins: backlight_pins_pimnux {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20ba, MUX_MODE3)		/* gpt11/gpio57 */
+		>;
+	};
+
 	dss_dpi_pins: pinmux_dss_dpi_pins {
                pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
-- 
2.5.0
