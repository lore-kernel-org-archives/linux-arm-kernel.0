From: frank.wang@rock-chips.com (Frank Wang)
Date: Mon, 21 Aug 2017 16:39:27 +0800
Subject: [PATCH 2/3] ARM: dts: rockchip: add usb nodes for rv1108 SoCs
In-Reply-To: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
References: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1503304768-14520-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usb otg/host controllers and phys nodes for RV1108 SoCs.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 73 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 25fab0b..2322328 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -262,8 +262,35 @@
 	};
 
 	grf: syscon at 10300000 {
-		compatible = "rockchip,rv1108-grf", "syscon";
+		compatible = "rockchip,rv1108-grf", "syscon", "simple-mfd";
 		reg = <0x10300000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy: usb2-phy at 100 {
+			compatible = "rockchip,rv1108-usb2phy";
+			reg = <0x100 0x0c>;
+			rockchip,usbgrf = <&usbgrf>;
+			clocks = <&cru SCLK_USBPHY>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			clock-output-names = "usbphy";
+			status = "disabled";
+
+			u2phy_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-mux";
+				status = "disabled";
+			};
+
+			u2phy_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+		};
 	};
 
 	watchdog: wdt at 10360000 {
@@ -353,6 +380,11 @@
 		reg = <0x20060000 0x1000>;
 	};
 
+	usbgrf: syscon at 202a0000 {
+		compatible = "rockchip,rv1108-usbgrf", "syscon";
+		reg = <0x202a0000 0x1000>;
+	};
+
 	cru: clock-controller at 20200000 {
 		compatible = "rockchip,rv1108-cru";
 		reg = <0x20200000 0x1000>;
@@ -399,6 +431,45 @@
 		status = "disabled";
 	};
 
+	usb_host_ehci: usb at 30140000 {
+		compatible = "generic-ehci";
+		reg = <0x30140000 0x20000>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host_ohci: usb at 30160000 {
+		compatible = "generic-ohci";
+		reg = <0x30160000 0x20000>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&u2phy>;
+		clock-names = "usbhost", "utmi";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_otg: usb at 30180000 {
+		compatible = "rockchip,rv1108-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x30180000 0x40000>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		g-use-dma;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at 32010000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.0.0
