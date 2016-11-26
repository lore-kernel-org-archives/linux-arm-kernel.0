From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 26 Nov 2016 15:56:33 +0100
Subject: [PATCH 3/5] arm64: dts: meson-gxl: add USB support
In-Reply-To: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
References: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161126145635.24488-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds USB support the the Meson GXL SoC. On most devices only the
dwc3 controller is used. It has an internal USB hub which provides two
ports. The PHYs for these ports are defined through the USB3 PHY, which
is ensures that all PHYs are using the same mode (because all of them
are used by the same controller).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3af54dc..99ac900 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -44,9 +44,58 @@
 #include "meson-gx.dtsi"
 #include <dt-bindings/clock/gxbb-clkc.h>
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
+#include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
 
 / {
 	compatible = "amlogic,meson-gxl";
+
+	soc {
+
+		usb0: usb at c9000000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xc9000000 0x0 0x100000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3_phy0>;
+			phy-names = "usb3-phy";
+			dr_mode = "host";
+			maximum-speed = "high-speed";
+			snps,dis_u2_susphy_quirk;
+		};
+
+		usb1: usb at c9100000 {
+			compatible = "snps,dwc2";
+			reg = <0x0 0xc9100000 0x0 0x40000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLKID_USB>;
+			clock-names = "otg";
+			dr_mode = "host";
+			status = "disabled";
+		};
+	};
+};
+
+&apb {
+	usb2_phys: phy at 78000 {
+		compatible = "amlogic,meson-gxl-usb2-phy";
+		#phy-cells = <1>;
+		reg = <0x0 0x78000 0x0 0x80>;
+		clocks = <&clkc CLKID_USB1>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+		clock-names = "usb", "usb_ddr";
+		resets = <&reset RESET_USB_OTG>;
+		status = "disabled";
+	};
+
+	usb3_phy0: phy at 78080 {
+		compatible = "amlogic,meson-gxl-usb3-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x78080 0x0 0x20>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+
+		/* dwc3 on GXL enables 2 USB ports on the internal hub */
+		phys = <&usb2_phys 0>, <&usb2_phys 1>;
+
+		status = "disabled";
+	};
 };
 
 &ethmac {
-- 
2.10.2
