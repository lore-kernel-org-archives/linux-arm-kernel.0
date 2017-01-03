From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  3 Jan 2017 23:25:33 +0800
Subject: [PATCH 3/4] ARM: dts: sunxi: add usb_otg and usbphy node for V3s SoC
In-Reply-To: <20170103152534.20118-1-icenowy@aosc.xyz>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
Message-ID: <20170103152534.20118-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V3s SoC features a USB PHY controller and a MUSB OTG controller.

Add device nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 084da7474afb..ebefc0fefef2 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -153,6 +153,33 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c19000 {
+			compatible = "allwinner,sun8i-h3-musb";
+			reg = <0x01c19000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			status = "disabled";
+		};
+
+		usbphy: phy at 01c19400 {
+			compatible = "allwinner,sun8i-v3s-usb-phy";
+			reg = <0x01c19400 0x2c>,
+			      <0x01c1a800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu0";
+			clocks = <&ccu CLK_USB_PHY0>;
+			clock-names = "usb0_phy";
+			resets = <&ccu RST_USB_PHY0>;
+			reset-names = "usb0_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
 		ccu: clock at 01c20000 {
 			compatible = "allwinner,sun8i-v3s-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.11.0
