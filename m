From: william.wu@rock-chips.com (William Wu)
Date: Fri, 16 Jun 2017 17:46:05 +0800
Subject: [PATCH 1/2] arm64: dts: rockchip: add usb2 nodes for RK3328 SoCs
In-Reply-To: <1497606366-1012-1-git-send-email-william.wu@rock-chips.com>
References: <1497606366-1012-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <1497606366-1012-2-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usb2 otg/host controllers and phys nodes
for Rockchip RK3328 SoCs.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 0be96ce..c55edb4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -372,6 +372,43 @@
 			<32768>;
 	};
 
+	usb2phy_grf: syscon at ff450000 {
+		compatible = "rockchip,rk3328-usb2phy-grf", "syscon",
+			     "simple-mfd";
+		reg = <0x0 0xff450000 0x0 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy: usb2-phy at 100 {
+			compatible = "rockchip,rk3328-usb2phy";
+			reg = <0x100 0x10>;
+			clocks = <&xin24m>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&cru USB480M>;
+			assigned-clock-parents = <&u2phy>;
+			clock-output-names = "usb480m_phy";
+			status = "disabled";
+
+			u2phy_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				status = "disabled";
+			};
+
+			u2phy_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+		};
+	};
+
 	sdmmc: dwmmc at ff500000 {
 		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff500000 0x0 0x4000>;
@@ -424,6 +461,45 @@
 		status = "disabled";
 	};
 
+	usb20_otg: usb at ff580000 {
+		compatible = "rockchip,rk3328-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x0 0xff580000 0x0 0x40000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "host";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		g-use-dma;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usb_host0_ehci: usb at ff5c0000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xff5c0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb at ff5d0000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xff5d0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.0.0
