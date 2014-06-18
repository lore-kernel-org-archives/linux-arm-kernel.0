From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 17 Jun 2014 23:16:19 -0700
Subject: [PATCH v1 8/9] ARM: tegra: jetson-tk1: Add XHCI support
In-Reply-To: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
Message-ID: <1403072180-4944-9-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign USB ports previously owned by the EHCI controllers to the XHCI
controller.  There is a mini-PCIe USB port (UTMI port 1) and a USB A
connector (UTMI port 2, USB3 port 0).  PCIe lane 0 is used for USB3
port 0.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 43 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 11c1650..cea2d2b 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1619,15 +1619,35 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	usb at 0,70090000 {
+		status = "okay";
+		phys = <&padctl TEGRA_XUSB_PADCTL_UTMI_P1>, /* mini-PCIe USB */
+		       <&padctl TEGRA_XUSB_PADCTL_UTMI_P2>, /* USB A */
+		       <&padctl TEGRA_XUSB_PADCTL_USB3_P0>; /* USB A */
+		phy-names = "utmi-1", "utmi-2", "usb3-0";
+		s1p05v-supply = <&vdd_1v05_run>;
+		s3p3v-supply = <&vdd_3v3_lp0>;
+		s1p8v-supply = <&vddio_1v8>;
+	};
+
 	padctl at 0,7009f000 {
 		pinctrl-0 = <&padctl_default>;
 		pinctrl-names = "default";
 
+		vbus-otg-2-supply = <&vdd_usb3_vbus>;
+
 		padctl_default: pinmux {
-			usb3 {
-				nvidia,lanes = "pcie-0", "pcie-1";
+			otg {
+				nvidia,lanes = "otg-1", "otg-2";
+				nvidia,function = "xusb";
+			};
+
+			usb3p0 {
+				nvidia,lanes = "pcie-0";
 				nvidia,function = "usb3";
 				nvidia,iddq = <0>;
+				nvidia,usb3-port-num = <0>;
+				nvidia,usb2-port-num = <2>;
 			};
 
 			pcie {
@@ -1668,25 +1688,6 @@
 		};
 	};
 
-	/* mini-PCIe USB */
-	usb at 0,7d004000 {
-		status = "okay";
-	};
-
-	usb-phy at 0,7d004000 {
-		status = "okay";
-	};
-
-	/* USB A connector */
-	usb at 0,7d008000 {
-		status = "okay";
-	};
-
-	usb-phy at 0,7d008000 {
-		status = "okay";
-		vbus-supply = <&vdd_usb3_vbus>;
-	};
-
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.0.0.526.g5318336
