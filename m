From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Feb 2014 13:09:12 +0100
Subject: [PATCH v3 4/4] ARM: sun7i: dt: Add USB host bindings
In-Reply-To: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
References: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393157352-21104-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index ed9b8cc..bdfa594 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -453,6 +453,38 @@
 			status = "disabled";
 		};
 
+		usbphy: phy at 01c13400 {
+			#phy-cells = <1>;
+			compatible = "allwinner,sun7i-a20-usb-phy";
+			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
+			reg-names = "phy_ctrl", "pmu1", "pmu2";
+			clocks = <&usb_clk 8>;
+			clock-names = "usb_phy";
+			resets = <&usb_clk 1>, <&usb_clk 2>;
+			reset-names = "usb1_reset", "usb2_reset";
+			status = "disabled";
+		};
+
+		ehci0: usb at 01c14000 {
+			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
+			reg = <0x01c14000 0x100>;
+			interrupts = <0 39 4>;
+			clocks = <&ahb_gates 1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c14400 {
+			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
+			reg = <0x01c14400 0x100>;
+			interrupts = <0 64 4>;
+			clocks = <&usb_clk 6>, <&ahb_gates 2>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		ahci: sata at 01c18000 {
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
@@ -461,6 +493,26 @@
 			status = "disabled";
 		};
 
+		ehci1: usb at 01c1c000 {
+			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
+			reg = <0x01c1c000 0x100>;
+			interrupts = <0 40 4>;
+			clocks = <&ahb_gates 3>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb at 01c1c400 {
+			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
+			reg = <0x01c1c400 0x100>;
+			interrupts = <0 65 4>;
+			clocks = <&usb_clk 7>, <&ahb_gates 4>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
1.9.0
