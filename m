From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:08 +0800
Subject: [PATCH 5/8] ARM: sun8i: a83t: Add USB PHY and host device nodes
In-Reply-To: <20170803081411.22389-1-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
Message-ID: <20170803081411.22389-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has 3 USB PHYs, 1 for USB OTG, 1 for standard USB 2.0, 1 for
USB HSIC. EHCI0/OHCI0 are the standard USB host pair, while EHCI1 is
the host controller for HSIC. OTG is not added yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 61304761e8f6..6039f1ea6810 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -242,6 +242,68 @@
 			#size-cells = <0>;
 		};
 
+		usbphy: phy at 1c19400 {
+			compatible = "allwinner,sun8i-a83t-usb-phy";
+			reg = <0x01c19400 0x10>,
+			      <0x01c1a800 0x14>,
+			      <0x01c1b800 0x14>;
+			reg-names = "phy_ctrl",
+				    "pmu1",
+				    "pmu2";
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>,
+				 <&ccu CLK_USB_HSIC>,
+				 <&ccu CLK_USB_HSIC_12M>;
+			clock-names = "usb0_phy",
+				      "usb1_phy",
+				      "usb2_phy",
+				      "usb2_hsic_12M";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>,
+				 <&ccu RST_USB_HSIC>;
+			reset-names = "usb0_reset",
+				      "usb1_reset",
+				      "usb2_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb at 1c1a000 {
+			compatible = "allwinner,sun8i-a83t-ehci",
+				     "generic-ehci";
+			reg = <0x01c1a000 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EHCI0>;
+			resets = <&ccu RST_BUS_EHCI0>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 1c1a400 {
+			compatible = "allwinner,sun8i-a83t-ohci",
+				     "generic-ohci";
+			reg = <0x01c1a400 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>, <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb at 1c1b000 {
+			compatible = "allwinner,sun8i-a83t-ehci",
+				     "generic-ehci";
+			reg = <0x01c1b000 0x100>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EHCI1>;
+			resets = <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun8i-a83t-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.13.3
