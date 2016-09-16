From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 16 Sep 2016 23:16:42 +0800
Subject: [PATCH v4 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160916151642.27907-1-icenowy@aosc.xyz>
References: <20160916151642.27907-1-icenowy@aosc.xyz>
Message-ID: <20160916151642.27907-2-icenowy@aosc.xyz>
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
Changes since v4:
- Split the pinmux part into another patch.
Changes since v3:
- Change bluetooth to serial0.
Changes since v2:
- Remove stdout-path.

 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index 0f52cd9..fb46655 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -49,6 +49,15 @@
 	model = "INet-D978 Rev 02";
 	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
 
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		/* Delete debug UART as serial0 is the UART for bluetooth */
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
