From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 20:13:20 +0800
Subject: [PATCH 3/3] ARM: sun8i: v3s: add backlight device node for Lichee Pi
 Zero LCD
In-Reply-To: <20170524121320.4171-1-icenowy@aosc.io>
References: <20170524121320.4171-1-icenowy@aosc.io>
Message-ID: <20170524121320.4171-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 40-pin LCD connector on Lichee Pi Zero has backlight pins, which is
controlled by the PWM0 controller of the V3s SoC, and the controlling
part is on the board.

Add the PWM and backlight device nodes in the device tree file, but
leave them disabled, as they can only be useful when the LCD is
attached. The LCD device tree overlay files can enable these controllers
and make use of them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
index 387fc2aa546d..e0721bf725d1 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
@@ -52,6 +52,14 @@
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 0>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		status = "disabled";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -86,6 +94,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins_a>;
 	pinctrl-names = "default";
-- 
2.12.2
