From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 17 Jun 2014 23:16:20 -0700
Subject: [PATCH v1 9/9] ARM: tegra: venice2: Add XHCI support
In-Reply-To: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
Message-ID: <1403072180-4944-10-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign ports previously owned by the EHCI controllers to the XHCI
controller.  There are two external USB ports (UTMI ports 0/2 and
USB3 ports 0/1) and an internal USB port (UTMI port 1).  PCIe lanes
0 and 1 are used by the USB3 ports.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 72 +++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index f1a5bac..bf88c81 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -878,6 +878,51 @@
 		status = "okay";
 	};
 
+	usb at 0,70090000 {
+		status = "okay";
+		phys = <&padctl TEGRA_XUSB_PADCTL_UTMI_P0>,
+		       <&padctl TEGRA_XUSB_PADCTL_UTMI_P1>,
+		       <&padctl TEGRA_XUSB_PADCTL_UTMI_P2>,
+		       <&padctl TEGRA_XUSB_PADCTL_USB3_P0>,
+		       <&padctl TEGRA_XUSB_PADCTL_USB3_P1>;
+		phy-names = "utmi-0", "utmi-1", "utmi-2", "usb3-0", "usb3-1";
+		s1p05v-supply = <&vdd_1v05_run>;
+		s3p3v-supply = <&vdd_3v3_lp0>;
+		s1p8v-supply = <&vddio_1v8>;
+	};
+
+	padctl at 0,7009f000 {
+		pinctrl-0 = <&padctl_default>;
+		pinctrl-names = "default";
+
+		vbus-otg-0-supply = <&vdd_usb1_vbus>;
+		vbus-otg-1-supply = <&vdd_run_cam>;
+		vbus-otg-2-supply = <&vdd_usb3_vbus>;
+
+		padctl_default: pinmux {
+			otg {
+				nvidia,lanes = "otg-0", "otg-1", "otg-2";
+				nvidia,function = "xusb";
+			};
+
+			usb3p0 {
+				nvidia,lanes = "pcie-0";
+				nvidia,function = "usb3";
+				nvidia,iddq = <0>;
+				nvidia,usb3-port-num = <0>;
+				nvidia,usb2-port-num = <0>;
+			};
+
+			usb3p1 {
+				nvidia,lanes = "pcie-1";
+				nvidia,function = "usb3";
+				nvidia,iddq = <0>;
+				nvidia,usb3-port-num = <1>;
+				nvidia,usb2-port-num = <2>;
+			};
+		};
+	};
+
 	sdhci at 0,700b0400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -898,33 +943,6 @@
 		};
 	};
 
-	usb at 0,7d000000 {
-		status = "okay";
-	};
-
-	usb-phy at 0,7d000000 {
-		status = "okay";
-		vbus-supply = <&vdd_usb1_vbus>;
-	};
-
-	usb at 0,7d004000 {
-		status = "okay";
-	};
-
-	usb-phy at 0,7d004000 {
-		status = "okay";
-		vbus-supply = <&vdd_run_cam>;
-	};
-
-	usb at 0,7d008000 {
-		status = "okay";
-	};
-
-	usb-phy at 0,7d008000 {
-		status = "okay";
-		vbus-supply = <&vdd_usb3_vbus>;
-	};
-
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
-- 
2.0.0.526.g5318336
