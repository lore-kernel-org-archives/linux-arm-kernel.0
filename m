From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:54:34 -0200
Subject: [PATCH v2 01/11] ARM: dts: imx53: Move nodes which have no reg
 property out of bus
Message-ID: <1511981684-13433-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Move pmu, usbphy0 and usbphy1 nodes from soc node to root node.

The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

This fixes the following build warnings with W=1:

arch/arm/boot/dts/imx53-ard.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
arch/arm/boot/dts/imx53-ard.dtb: Warning (simple_bus_reg): Node /soc/aips at 50000000/usbphy-0 missing or empty reg/ranges property
arch/arm/boot/dts/imx53-ard.dtb: Warning (simple_bus_reg): Node /soc/aips at 50000000/usbphy-1 missing or empty reg/ranges property
arch/arm/boot/dts/imx53-ard.dtb: Warning (simple_bus_reg): Node /soc/pmu missing or empty reg/ranges property

Based on a patch from Simon Horman for r8a7795.dtsi.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx53.dtsi | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index fb6cdd6..c088a23 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -116,6 +116,28 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a8-pmu";
+		interrupt-parent = <&tzic>;
+		interrupts = <77>;
+	};
+
+	usbphy0: usbphy-0 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clks IMX5_CLK_USB_PHY1_GATE>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+		status = "okay";
+	};
+
+	usbphy1: usbphy-1 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clks IMX5_CLK_USB_PHY2_GATE>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+		status = "okay";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -299,22 +321,6 @@
 				reg = <0x53f00000 0x60>;
 			};
 
-			usbphy0: usbphy-0 {
-				compatible = "usb-nop-xceiv";
-				clocks = <&clks IMX5_CLK_USB_PHY1_GATE>;
-				clock-names = "main_clk";
-				#phy-cells = <0>;
-				status = "okay";
-			};
-
-			usbphy1: usbphy-1 {
-				compatible = "usb-nop-xceiv";
-				clocks = <&clks IMX5_CLK_USB_PHY2_GATE>;
-				clock-names = "main_clk";
-				#phy-cells = <0>;
-				status = "okay";
-			};
-
 			usbotg: usb at 53f80000 {
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80000 0x0200>;
@@ -815,10 +821,5 @@
 			reg = <0xf8000000 0x20000>;
 			clocks = <&clks IMX5_CLK_OCRAM>;
 		};
-
-		pmu {
-			compatible = "arm,cortex-a8-pmu";
-			interrupts = <77>;
-		};
 	};
 };
-- 
2.7.4
