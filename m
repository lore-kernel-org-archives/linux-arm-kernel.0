From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  8 Sep 2016 11:25:35 +0800
Subject: [PATCH] ARM: dts: sun8i: Move A23/A33 usbphy and usb_otg nodes to
 common dtsi
Message-ID: <20160908032535.12987-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usbphy and usb_otg nodes in the A23 and A33 dts files only differ
by compatible, and for the usbphy, the size of one of its register
regions.

Move all the common bits to the A23/A33 common dtsi file.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

This patch applies on top of your A23/A33 CCU patches.

---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 30 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a23.dtsi     | 43 +++++++++---------------------------
 arch/arm/boot/dts/sun8i-a33.dtsi     | 41 +++++++++-------------------------
 3 files changed, 50 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 9cb474bf7911..2d1ad55daf2d 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -201,6 +201,36 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c19000 {
+			/* compatible gets set in SoC specific dtsi file */
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
+		usbphy: phy at 01c19400 {
+			/*
+			 * compatible and address regions get set in
+			 * SoC specific dtsi file
+			 */
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
 		ehci0: usb at 01c1a000 {
 			compatible = "allwinner,sun8i-a23-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index a915feb3a494..54d045dab825 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -48,39 +48,6 @@
 	memory {
 		reg = <0x40000000 0x40000000>;
 	};
-
-	soc at 01c00000 {
-		usb_otg: usb at 01c19000 {
-			compatible = "allwinner,sun6i-a31-musb";
-			reg = <0x01c19000 0x0400>;
-			clocks = <&ccu CLK_BUS_OTG>;
-			resets = <&ccu RST_BUS_OTG>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mc";
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			extcon = <&usbphy 0>;
-			status = "disabled";
-		};
-
-		usbphy: phy at 01c19400 {
-			compatible = "allwinner,sun8i-a23-usb-phy";
-			reg = <0x01c19400 0x10>,
-			      <0x01c1a800 0x4>;
-			reg-names = "phy_ctrl",
-				    "pmu1";
-			clocks = <&ccu CLK_USB_PHY0>,
-				 <&ccu CLK_USB_PHY1>;
-			clock-names = "usb0_phy",
-				      "usb1_phy";
-			resets = <&ccu RST_USB_PHY0>,
-				 <&ccu RST_USB_PHY1>;
-			reset-names = "usb0_reset",
-				      "usb1_reset";
-			status = "disabled";
-			#phy-cells = <1>;
-		};
-	};
 };
 
 &ccu {
@@ -93,3 +60,13 @@
 		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&usb_otg {
+	compatible = "allwinner,sun6i-a31-musb";
+};
+
+&usbphy {
+	compatible = "allwinner,sun8i-a23-usb-phy";
+	reg = <0x01c19400 0x10>, <0x01c1a800 0x4>;
+	reg-names = "phy_ctrl", "pmu1";
+};
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index f3d91d2c96ef..bc939c0e317d 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -73,37 +73,6 @@
 			resets = <&ccu RST_BUS_SS>;
 			reset-names = "ahb";
 		};
-
-		usb_otg: usb at 01c19000 {
-			compatible = "allwinner,sun8i-a33-musb";
-			reg = <0x01c19000 0x0400>;
-			clocks = <&ccu CLK_BUS_OTG>;
-			resets = <&ccu RST_BUS_OTG>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mc";
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			extcon = <&usbphy 0>;
-			status = "disabled";
-		};
-
-		usbphy: phy at 01c19400 {
-			compatible = "allwinner,sun8i-a33-usb-phy";
-			reg = <0x01c19400 0x14>,
-			      <0x01c1a800 0x4>;
-			reg-names = "phy_ctrl",
-				    "pmu1";
-			clocks = <&ccu CLK_USB_PHY0>,
-				 <&ccu CLK_USB_PHY1>;
-			clock-names = "usb0_phy",
-				      "usb1_phy";
-			resets = <&ccu RST_USB_PHY0>,
-				 <&ccu RST_USB_PHY1>;
-			reset-names = "usb0_reset",
-				      "usb1_reset";
-			status = "disabled";
-			#phy-cells = <1>;
-		};
 	};
 };
 
@@ -124,3 +93,13 @@
 	};
 
 };
+
+&usb_otg {
+	compatible = "allwinner,sun8i-a33-musb";
+};
+
+&usbphy {
+	compatible = "allwinner,sun8i-a33-usb-phy";
+	reg = <0x01c19400 0x14>, <0x01c1a800 0x4>;
+	reg-names = "phy_ctrl", "pmu1";
+};
-- 
2.9.3
