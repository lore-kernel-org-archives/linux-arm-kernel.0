From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Mar 2017 23:11:55 +0800
Subject: [PATCH v2 2/3] ARM: dts: sun8i: add usb_otg and OHCI/EHCI for usbc0
 on H3
In-Reply-To: <20170302151156.49295-1-icenowy@aosc.xyz>
References: <20170302151156.49295-1-icenowy@aosc.xyz>
Message-ID: <20170302151156.49295-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3 have a dual-routed USB PHY0 -- routed to either OHCI/EHCI
or MUSB controller.

Add device nodes for these controllers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Unbind PHY from *HCI controllers, as they do not know how to properly
  handle the Vbus status.

 arch/arm/boot/dts/sun8i-h3.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 27780b97c863..e8265ba68952 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -206,6 +206,19 @@
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
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun8i-h3-usb-phy";
 			reg = <0x01c19400 0x2c>,
@@ -238,6 +251,25 @@
 			#phy-cells = <1>;
 		};
 
+		ehci0: usb at 01c1a000 {
+			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>;
+			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c1a400 {
+			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
 		ehci1: usb at 01c1b000 {
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
-- 
2.11.1
