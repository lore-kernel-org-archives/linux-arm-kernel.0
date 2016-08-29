From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 29 Aug 2016 22:18:32 +0800
Subject: [PATCH v3] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
Message-ID: <20160829141832.10566-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
on iNet D978 Rev2 board.

Enable the UART1 to make it possible to use the modified hciattach by
Realtek to drive the BT part of RTL8723BS.

On the board no r_uart pins are found now (the onboard RX/TX pins are
wired to PF2/PF4, which is muxed with mmc0), so also disabled it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Deleted r_uart.
- Added the pinmux of uart1 at PG.
Changes since v2:
- Rename uart0_cts_rts at 0 to uart0-cts-rts at 0.

 arch/arm/boot/dts/sun8i-a23-a33.dtsi           | 14 ++++++++++++++
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7e05e09..d236104 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -361,6 +361,20 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			uart1_pins_a: uart1 at 0 {
+				allwinner,pins = "PG6", "PG7";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_pins_cts_rts_a: uart1-cts-rts at 0 {
+				allwinner,pins = "PG8", "PG9";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2",
 						 "PF3", "PF4", "PF5";
diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index 0f52cd9..a1f654a8 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -49,6 +49,15 @@
 	model = "INet-D978 Rev 02";
 	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
 
+	aliases {
+		/delete-property/serial0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		/delete-property/stdout-path;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -86,3 +95,14 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&r_uart {
+	status = "disabled";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>,
+		    <&uart1_pins_cts_rts_a>;
+	status = "okay";
+};
-- 
2.9.3
