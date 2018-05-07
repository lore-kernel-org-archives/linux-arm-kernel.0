From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  7 May 2018 23:18:16 +0800
Subject: [PATCH 4/5] arm64: allwinner: h6: add USB3 device nodes
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Message-ID: <20180507151817.55663-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
a custom PHY.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c72da8cd9ef5..9564c938717c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -174,6 +174,44 @@
 			status = "disabled";
 		};
 
+		usb3: usb at 5200000 {
+			compatible = "allwinner,sun50i-h6-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&ccu CLK_BUS_XHCI>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_XHCI>;
+			reset-names = "bus";
+			status = "disabled";
+
+			dwc3: dwc3 {
+				compatible = "snps,dwc3";
+				reg = <0x5200000 0x10000>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				/*
+				 * According to Wink from Allwinner, the
+				 * USB3 port on H6 is not capable of OTG;
+				 * the datasheet doesn't mention OTG at all
+				 * either, so the dr_mode is default to
+				 * "host" here.
+				 */
+				dr_mode = "host";
+				phys = <&usb3phy>;
+				phy-names = "usb3-phy";
+				status = "disabled";
+			};
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
 		r_ccu: clock at 7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-- 
2.17.0
