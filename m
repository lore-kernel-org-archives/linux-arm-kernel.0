From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Feb 2017 01:37:21 +0800
Subject: [RFC PATCH 8/9] ARM: dts: sun8i: add USB nodes for R40
In-Reply-To: <20170217173722.6477-1-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
Message-ID: <20170217173722.6477-9-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 SoC features a USB OTG port and two USB HOST ports.

Add support for the ports in the DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index df48c87237f3..052badc2dd3c 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -179,6 +179,95 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c13000 {
+			compatible = "allwinner,sun8i-a33-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			status = "disabled";
+		};
+
+		usbphy: phy at 01c13400 {
+			compatible = "allwinner,sun8i-r40-usb-phy";
+			reg = <0x01c13400 0x14>,
+			      <0x01c19800 0x4>,
+			      <0x01c1c800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu1",
+				    "pmu2";
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>,
+				 <&ccu CLK_USB_PHY2>;
+			clock-names = "usb0_phy",
+				      "usb1_phy",
+				      "usb2_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>,
+				 <&ccu RST_USB_PHY2>;
+			reset-names = "usb0_reset",
+				      "usb1_reset",
+				      "usb2_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci1: usb at 01c19000 {
+			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
+			reg = <0x01c19000 0x100>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_BUS_EHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>,
+				 <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb at 01c19400 {
+			compatible = "allwinner,sun8i-r40-ohci", "generic-ohci";
+			reg = <0x01c19400 0x100>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci2: usb at 01c1c000 {
+			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
+			reg = <0x01c1c000 0x100>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI2>,
+				 <&ccu CLK_BUS_EHCI2>,
+				 <&ccu CLK_USB_OHCI2>;
+			resets = <&ccu RST_BUS_OHCI2>,
+				 <&ccu RST_BUS_EHCI2>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci2: usb at 01c1c400 {
+			compatible = "allwinner,sun8i-r40-ohci", "generic-ohci";
+			reg = <0x01c1c400 0x100>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI2>,
+				 <&ccu CLK_USB_OHCI2>;
+			resets = <&ccu RST_BUS_OHCI2>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		ccu: clock at 01c20000 {
 			compatible = "allwinner,sun8i-r40-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.11.1
