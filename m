From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 11 Apr 2018 11:47:05 +0200
Subject: [PATCH 5/5] ARM: dts: stm32: add joystick support on stm32746g-eval
In-Reply-To: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1523440025-18077-6-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The joystick (B3) on stm32746g-eval uses gpios on STMFX gpio expander.
These gpios need a pin configuration (push-pull and bias-pull-up),
described under stmfxpinctrl node.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index fd03f54..ee9ec55 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -90,6 +90,44 @@
 		};
 	};
 
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&joystick_pins>;
+		pinctrl-names = "default";
+		button at 0 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <0 2>;
+		};
+		button at 1 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <1 2>;
+		};
+		button at 2 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <2 2>;
+		};
+		button at 3 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <3 2>;
+		};
+		button at 4 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <4 2>;
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -127,6 +165,12 @@
 			interrupt-controller;
 			status = "okay";
 		};
+
+		joystick_pins: joystick at 0 {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
+			drive-push-pull;
+			bias-pull-up;
+		};
 	};
 };
 
-- 
2.7.4
