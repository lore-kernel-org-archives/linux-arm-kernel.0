From: william.wu@rock-chips.com (William Wu)
Date: Fri,  2 Jun 2017 15:04:24 +0800
Subject: [PATCH v2 1/2] ARM: dts: rockchip: add usb nodes on rk322x
In-Reply-To: <1496387065-21073-1-git-send-email-william.wu@rock-chips.com>
References: <1496387065-21073-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <1496387065-21073-2-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usb otg/host controllers and phys nodes on rk322x.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 138 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index df57413..1e0ee4a 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -210,8 +210,61 @@
 	};
 
 	grf: syscon at 11000000 {
-		compatible = "syscon";
+		compatible = "syscon", "simple-mfd";
 		reg = <0x11000000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy0: usb2-phy at 760 {
+			compatible = "rockchip,rk3228-usb2phy";
+			reg = <0x0760 0x0c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			clock-output-names = "usb480m_phy0";
+			status = "disabled";
+
+			u2phy0_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				status = "disabled";
+			};
+
+			u2phy0_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+		};
+
+		u2phy1: usb2-phy at 800 {
+			compatible = "rockchip,rk3228-usb2phy";
+			reg = <0x0800 0x0c>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			clock-output-names = "usb480m_phy1";
+			status = "disabled";
+
+			u2phy1_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+
+			u2phy1_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+		};
 	};
 
 	uart0: serial at 11010000 {
@@ -467,6 +520,89 @@
 		status = "disabled";
 	};
 
+	usb_otg: usb at 30040000 {
+		compatible = "rockchip,rk3228-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x30040000 0x40000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		g-use-dma;
+		phys = <&u2phy0_otg>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usb_host0_ehci: usb at 30080000 {
+		compatible = "generic-ehci";
+		reg = <0x30080000 0x20000>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy0>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy0_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb at 300a0000 {
+		compatible = "generic-ohci";
+		reg = <0x300a0000 0x20000>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy0>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy0_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host1_ehci: usb at 300c0000 {
+		compatible = "generic-ehci";
+		reg = <0x300c0000 0x20000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST1>, <&u2phy1>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy1_otg>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host1_ohci: usb at 300e0000 {
+		compatible = "generic-ohci";
+		reg = <0x300e0000 0x20000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST1>, <&u2phy1>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy1_otg>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host2_ehci: usb at 30100000 {
+		compatible = "generic-ehci";
+		reg = <0x30100000 0x20000>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST2>, <&u2phy1>;
+		phys = <&u2phy1_host>;
+		phy-names = "usb";
+		clock-names = "usbhost", "utmi";
+		status = "disabled";
+	};
+
+	usb_host2_ohci: usb at 30120000 {
+		compatible = "generic-ohci";
+		reg = <0x30120000 0x20000>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST2>, <&u2phy1>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy1_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	gmac: ethernet at 30200000 {
 		compatible = "rockchip,rk3228-gmac";
 		reg = <0x30200000 0x10000>;
-- 
2.0.0
