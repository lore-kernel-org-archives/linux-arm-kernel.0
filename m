From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  6 Nov 2016 19:11:19 +0800
Subject: [RFC PATCH] ARM: dts: add panel and tcon nodes to Allwinner A33 Q8
 tablet dts
Message-ID: <20161106111119.14927-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All A33 Q8 tablets features a LCD panel, with a resolution of either
800x480 or 1024x600.

Add "bone" device nodes to the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---

Maybe it will be better to add them to sun8i-q8-reference-tablet.dtsi, as
these pin configurations are part of reference design of both A23 and A33,
not only restricted to Q8.

The DTS file is tested by me, after cherry-picks this patch from Chen-Yu Tsai:
https://github.com/wens/linux/commit/2823b887a289fbee5f97f3c6b45ed6c74a6368c6

And add these commands to my U-Boot boot command:

fdt addr 0x43000000
fdt resize
fdt set /panel compatible "urt,umsh-8596md-t"
fdt set /panel status "okay"
fdt set /display-engine status "okay"
fdt set /soc at 01c00000/lcd-controller at 01c0c000 status "okay"

 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
index b0bc236..871a20c 100644
--- a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
@@ -47,4 +47,48 @@
 / {
 	model = "Q8 A33 Tablet";
 	compatible = "allwinner,q8-a33", "allwinner,sun8i-a33";
+
+	panel: panel {
+		/* compatible should be set according to the panel */
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_en_q8>;
+		backlight = <&backlight>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		power-supply = <&reg_dc1sw>;
+		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_lcd>;
+			};
+		};
+	};
+};
+
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+};
+
+&tcon0_out {
+	tcon0_out_lcd: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
+&pio {
+	lcd_en_q8: lcd_en at 0 {
+		allwinner,pins = "PH7";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
-- 
2.10.1
