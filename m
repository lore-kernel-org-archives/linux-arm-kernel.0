From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 20:50:52 +0800
Subject: [PATCH 2/3] arm64: allwinner: a64: add USB0 OHCI/EHCI related
 devicetree parts
In-Reply-To: <20170405125053.6170-1-icenowy@aosc.io>
References: <20170405125053.6170-1-icenowy@aosc.io>
Message-ID: <20170405125053.6170-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we added USB0 route auto switching support for A64, add related
device tree parts to the A64 DTSI file (EHCI0/OHCI0 controllers and the
pmu0 memory area for PHY).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1c64ea2d23f9..a8916df99048 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -179,8 +179,10 @@
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun50i-a64-usb-phy";
 			reg = <0x01c19400 0x14>,
+			      <0x01c1a800 0x4>,
 			      <0x01c1b800 0x4>;
 			reg-names = "phy_ctrl",
+				    "pmu0",
 				    "pmu1";
 			clocks = <&ccu CLK_USB_PHY0>,
 				 <&ccu CLK_USB_PHY1>;
@@ -194,6 +196,28 @@
 			#phy-cells = <1>;
 		};
 
+		ehci0: usb at 01c1a000 {
+			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c1a400 {
+			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
 		ehci1: usb at 01c1b000 {
 			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
-- 
2.12.2
