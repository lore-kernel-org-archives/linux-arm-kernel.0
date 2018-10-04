From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu,  4 Oct 2018 20:28:54 +0800
Subject: [PATCH v4 09/10] arm64: allwinner: dts: h6: add USB3 device nodes
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
Message-ID: <20181004122855.22981-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
a custom PHY.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
No changes in v4.

Changes in v3:
- Changed the dwc3 clock according to the user manual.
- Added Chen-Yu's Review tag.

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3d60af6cb3ae..0a8b4845c0df 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -313,6 +313,38 @@
 			status = "disabled";
 		};
 
+		dwc3: dwc3 at 5200000 {
+			compatible = "snps,dwc3";
+			reg = <0x05200000 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_XHCI>,
+				 <&ccu CLK_BUS_XHCI>,
+				 <&osc32k>;
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
+		usb3phy: phy at 5210000 {
+			compatible = "allwinner,sun50i-h6-usb3-phy";
+			reg = <0x5210000 0x10000>;
+			clocks = <&ccu CLK_USB_PHY1>;
+			resets = <&ccu RST_USB_PHY1>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		ehci3: usb at 5311000 {
 			compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
 			reg = <0x05311000 0x100>;
-- 
2.18.0
