From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Feb 2015 12:03:54 -0600
Subject: [PATCH 1/2] arm: boot: dts: am437x-idk: fix TPS62362 i2c bus
Message-ID: <1424369035-26423-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it turns out, tps62362 is actually on I2C bus0,
not bus1. This has gone unnoticed because Linux
doesn't use (as of now) that regulator at all, it's
setup by the bootloader and left as is.

While at that, also add missing reg property for
our regulator.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index f9a17e2ca8cb..2471f1ebd4ed 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -133,20 +133,6 @@
 		>;
 	};
 
-	i2c1_pins_default: i2c1_pins_default {
-		pinctrl-single,pins = <
-			0x15c (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2) /* spi0_cs0.i2c1_scl */
-			0x158 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2) /* spi0_d1.i2c1_sda */
-		>;
-	};
-
-	i2c1_pins_sleep: i2c1_pins_sleep {
-		pinctrl-single,pins = <
-			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE7) /* spi0_cs0.i2c1_scl */
-			0x158 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* spi0_d1.i2c1_sda */
-		>;
-	};
-
 	mmc1_pins_default: pinmux_mmc1_pins_default {
 		pinctrl-single,pins = <
 			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
@@ -262,17 +248,10 @@
 		pagesize = <64>;
 		reg = <0x50>;
 	};
-};
-
-&i2c1 {
-	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&i2c1_pins_default>;
-	pinctrl-1 = <&i2c1_pins_default>;
-	clock-frequency = <400000>;
 
 	tps: tps62362 at 60 {
 		compatible = "ti,tps62362";
+		reg = <0x60>;
 		regulator-name = "VDD_MPU";
 		regulator-min-microvolt = <950000>;
 		regulator-max-microvolt = <1330000>;
-- 
2.3.0
