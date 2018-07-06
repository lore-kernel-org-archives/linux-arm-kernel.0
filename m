From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  6 Jul 2018 23:38:04 +0800
Subject: [PATCH v2 8/9] arm64: allwinner: dts: h6: add USB3 device nodes
In-Reply-To: <20180706153805.25842-1-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io>
Message-ID: <20180706153805.25842-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
a custom PHY.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Rebased on top of the USB2 support patch.
- Dropped the dwc3-of-simple device.

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 62fc0f5e10ba..6738e97ee37f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -229,6 +229,30 @@
 			status = "disabled";
 		};
 
+		dwc3: dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x5200000 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			/* The only clock is shared. */
+			clocks = <&ccu CLK_BUS_XHCI>,
+				 <&ccu CLK_BUS_XHCI>,
+				 <&ccu CLK_BUS_XHCI>;
+			clock-names = "ref", "bus_early", "suspend";
+			resets = <&ccu RST_BUS_XHCI>;
+			/*
+			 * The datasheet of the chip doesn't declare the
+			 * peripheral function, and there's no boards known
+			 * to have a USB Type-B port routed to the port.
+			 * In addition, no one has tested the peripheral
+			 * function yet.
+			 * So set the dr_mode to "host" in the DTSI file.
+			 */
+			dr_mode = "host";
+			phys = <&usb3phy>;
+			phy-names = "usb3-phy";
+			status = "disabled";
+		};
+
 		usb3phy: phy at 5210000 {
 			compatible = "allwinner,sun50i-h6-usb3-phy";
 			reg = <0x5210000 0x10000>;
-- 
2.17.1
