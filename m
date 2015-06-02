From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Jun 2015 20:29:11 +0800
Subject: [PATCH 2/3] ARM: dts: sun8i: Add support for USB controllers on
 A23/A33
In-Reply-To: <1433248152-13753-1-git-send-email-wens@csie.org>
References: <1433248152-13753-1-git-send-email-wens@csie.org>
Message-ID: <1433248152-13753-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A23/A33 has one pair of EHCI/OHCI USB controllers. There are 2 USB PHYs,
one for the USB OTG controller, one for the EHCI/OHCI pair. The latter
may also support HSIC, though none of the available boards utilize this,
so this is not supported yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7abd0ae3143d..4f1ca44a81f1 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -332,6 +332,40 @@
 			#size-cells = <0>;
 		};
 
+		usbphy: phy at 01c19400 {
+			compatible = "allwinner,sun8i-a23-usb-phy";
+			reg = <0x01c19400 0x10>, <0x01c1a800 0x4>;
+			reg-names = "phy_ctrl", "pmu1";
+			clocks = <&usb_clk 8>, <&usb_clk 9>;
+			clock-names = "usb0_phy", "usb1_phy";
+			resets = <&usb_clk 0>, <&usb_clk 1>;
+			reset-names = "usb0_reset", "usb1_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb at 01c1a000 {
+			compatible = "allwinner,sun8i-a23-ehci", "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 26>;
+			resets = <&ahb1_rst 26>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c1a400 {
+			compatible = "allwinner,sun8i-a23-ohci", "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 29>, <&usb_clk 16>;
+			resets = <&ahb1_rst 29>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		pio: pinctrl at 01c20800 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
-- 
2.1.4
