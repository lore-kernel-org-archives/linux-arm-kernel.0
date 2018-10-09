From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon,  8 Oct 2018 20:46:09 -0700
Subject: [PATCH] arm64: dts: allwinner: add backlight regulator for Pinebook
Message-ID: <20181009034609.24892-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Backlight power is controlled by PH6 GPIO, so add corresponding
regulator-fixed node for it. Otherwise backlight won't light up
if bootloader doesn't enable it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 897e60cbe38d..e2e426334cfe 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -22,12 +22,22 @@
 		ethernet0 = &rtl8723cs;
 	};
 
+	vdd_bl: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+		enable-active-high;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 50000 0>;
 		brightness-levels = <0 5 10 15 20 30 40 55 70 85 100>;
 		default-brightness-level = <2>;
 		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
+		power-supply = <&vdd_bl>;
 	};
 
 	chosen {
-- 
2.19.0
