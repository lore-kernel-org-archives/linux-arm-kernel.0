From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 23 Nov 2016 00:59:01 +0800
Subject: [RFC PATCH 1/2] arm64: dts: add MUSB node to Allwinner A64 dtsi
Message-ID: <20161122165902.62543-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC has a MUSB controller like the one in A33, so add
a node for it, just use the compatible of A33 MUSB.

Host mode is tested to work properly on Pine64 and will be added into
the device tree of Pine64 in next patch.

Peripheral mode is also tested on Pine64, by changing dr_mode property
of usb_otg node and use a non-standard USB Type-A to Type-A cable.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
This patchset depends on my patch which adds usbphy to A64 dtsi.
( http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/469561.html )

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 2572dd6..261324a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -122,6 +122,19 @@
 		#size-cells = <1>;
 		ranges;
 
+		usb_otg: usb at 01c19000 {
+			compatible = "allwinner,sun8i-a33-musb";
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
 			compatible = "allwinner,sun50i-a64-usb-phy";
 			reg = <0x01c19400 0x14>,
-- 
2.10.2
