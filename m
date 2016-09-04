From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  4 Sep 2016 23:31:50 +0200
Subject: [PATCH 5/7] ARM64: meson-gxbb: add USB Nodes
In-Reply-To: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160904213152.25837-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the nodes for the dwc2 USB controller and the related USB PHYs.
Currently we force usb0 to host mode because OTG is currently not
working in our PHY driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 2e8a3d9..02dfc54 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -151,6 +151,34 @@
 		#size-cells = <2>;
 		ranges;
 
+		usb-phys at c0000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xc0000000 0x0 0x40>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x40>;
+
+			usb0_phy: usb_phy at 0 {
+				compatible = "amlogic,meson-gxbb-usb2-phy";
+				#phy-cells = <0>;
+				reg = <0x0 0x0 0x0 0x20>;
+				resets = <&reset 34>;
+				clocks = <&clkc CLKID_USB &clkc CLKID_USB0>;
+				clock-names = "usb_general", "usb";
+				status = "disabled";
+			};
+
+			usb1_phy: usb_phy at 20 {
+				compatible = "amlogic,meson-gxbb-usb2-phy";
+				#phy-cells = <0>;
+				reg = <0x0 0x20 0x0 0x20>;
+				resets = <&reset 34>;
+				clocks = <&clkc CLKID_USB &clkc CLKID_USB1>;
+				clock-names = "usb_general", "usb";
+				status = "disabled";
+			};
+		};
+
 		cbus: cbus at c1100000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc1100000 0x0 0x100000>;
@@ -496,6 +524,30 @@
 			};
 		};
 
+		usb0: usb-controller at c9000000 {
+			compatible = "amlogic,meson-gxbb-usb", "snps,dwc2";
+			reg = <0x0 0xc9000000 0x0 0x40000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLKID_USB0_DDR_BRIDGE>;
+			clock-names = "otg";
+			phys = <&usb0_phy>;
+			phy-names = "usb2-phy";
+			dr_mode = "host";
+			status = "disabled";
+		};
+
+		usb1: usb-controller at c9100000 {
+			compatible = "amlogic,meson-gxbb-usb", "snps,dwc2";
+			reg = <0x0 0xc9100000 0x0 0x40000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
+			clock-names = "otg";
+			phys = <&usb1_phy>;
+			phy-names = "usb2-phy";
+			dr_mode = "host";
+			status = "disabled";
+		};
+
 		ethmac: ethernet at c9410000 {
 			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
 			reg = <0x0 0xc9410000 0x0 0x10000
-- 
2.9.3
