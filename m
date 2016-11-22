From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 22 Nov 2016 23:58:29 +0800
Subject: [PATCH v2 1/3] arm64: dts: add USB1-related nodes of Allwinner A64
Message-ID: <20161122155831.8724-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 have two HCI USB controllers, a OTG controller and a USB
PHY device which have two ports. One of the port is wired to both a HCI
USB controller and the OTG controller, which is currently not supported.
The another one is only wired to a HCI controller, and the device node of
OHCI/EHCI controller of the port can be added now.

Also the A64 USB PHY device node is also added for the HCI controllers to
work.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Remove manual CLK_USB_OHCI0 gate, as it's dealed by ccu driver now.
- Sort the nodes and fixed {e,o}hci1 regs.
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 3d70be3..2572dd6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -122,6 +122,50 @@
 		#size-cells = <1>;
 		ranges;
 
+		usbphy: phy at 01c19400 {
+			compatible = "allwinner,sun50i-a64-usb-phy";
+			reg = <0x01c19400 0x14>,
+			      <0x01c1b800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu1";
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ohci1: usb at 01c1b400 {
+			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
+			reg = <0x01c1b400 0x100>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb at 01c1b000 {
+			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
+			reg = <0x01c1b000 0x100>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
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
 		ccu: clock at 01c20000 {
 			compatible = "allwinner,sun50i-a64-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.10.2
