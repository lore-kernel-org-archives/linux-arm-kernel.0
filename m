From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 1 Aug 2017 15:03:33 +0800
Subject: [PATCH 5/5] arm: dts: mt2701: Add usb3 device nodes
In-Reply-To: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
References: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1501571013-22327-6-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

Add xhci nodes and usb3 phy nodes for MT2701

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index efb5118..16242f5 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -13,6 +13,7 @@
  */
 
 #include <dt-bindings/clock/mt2701-clk.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -677,6 +678,84 @@
 		#clock-cells = <1>;
 	};
 
+	usb0: usb at 1a1c0000 {
+		compatible = "mediatek,mt8173-xhci";
+		reg = <0 0x1a1c0000 0 0x1000>,
+		      <0 0x1a1c4700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&hifsys CLK_HIFSYS_USB0PHY>,
+			 <&topckgen CLK_TOP_ETHIF_SEL>;
+		clock-names = "sys_ck", "ref_ck";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+		status = "disabled";
+	};
+
+	u3phy0: usb-phy at 1a1c4000 {
+		compatible = "mediatek,mt2701-u3phy";
+		reg = <0 0x1a1c4000 0 0x0700>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port0: usb-phy at 1a1c4800 {
+			reg = <0 0x1a1c4800 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port0: usb-phy at 1a1c4900 {
+			reg = <0 0x1a1c4900 0 0x0700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
+	usb1: usb at 1a240000 {
+		compatible = "mediatek,mt8173-xhci";
+		reg = <0 0x1a240000 0 0x1000>,
+		      <0 0x1a244700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&hifsys CLK_HIFSYS_USB1PHY>,
+			 <&topckgen CLK_TOP_ETHIF_SEL>;
+		clock-names = "sys_ck", "ref_ck";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
+		status = "disabled";
+	};
+
+	u3phy1: usb-phy at 1a244000 {
+		compatible = "mediatek,mt2701-u3phy";
+		reg = <0 0x1a244000 0 0x0700>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port1: usb-phy at 1a244800 {
+			reg = <0 0x1a244800 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port1: usb-phy at 1a244900 {
+			reg = <0 0x1a244900 0 0x0700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
 	ethsys: syscon at 1b000000 {
 		compatible = "mediatek,mt2701-ethsys", "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
-- 
1.9.1
