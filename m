From: ryan@presslab.us (Ryan Press)
Date: Thu, 28 Mar 2013 19:10:24 -0700
Subject: [PATCH] arm: mvebu: Add GPIO LEDs to Mirabox board
Message-ID: <1364523024-20306-1-git-send-email-ryan@presslab.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the three external LED definitions to the device tree file on
the Mirabox.

The Mirabox user guide calls out one as a power LED, and the other
two are defined for WiFi, but as the current mwifiex drivers don't
have LED support, we make them status LEDs.

These have been tested working by writing to the appropriate
/sys/class/leds trigger.

Signed-off-by: Ryan Press <ryan@presslab.us>
---
 arch/arm/boot/dts/armada-370-mirabox.dts | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index dd0c57d..242796e 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -33,6 +33,43 @@
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
+
+		pinctrl {
+			pwr_led_pin: pwr-led-pin {
+				marvell,pins = "mpp63";
+				marvell,function = "gpo";
+			};
+
+			stat_led_pins: stat-led-pins {
+				marvell,pins = "mpp64", "mpp65";
+				marvell,function = "gpio";
+			};
+		};
+
+		gpio_leds {
+			compatible = "gpio-leds";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwr_led_pin &stat_led_pins>;
+
+			green_pwr_led {
+				label = "mirabox:green:pwr";
+				gpios = <&gpio1 31 1>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			blue_stat_led {
+				label = "mirabox:blue:stat";
+				gpios = <&gpio2 0 1>;
+				linux,default-trigger = "cpu0";
+			};
+
+			green_stat_led {
+				label = "mirabox:green:stat";
+				gpios = <&gpio2 1 1>;
+				default-state = "off";
+			};
+		};
+
 		mdio {
 			phy0: ethernet-phy at 0 {
 				reg = <0>;
-- 
1.8.1.2
