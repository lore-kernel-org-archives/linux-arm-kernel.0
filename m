From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue,  2 Sep 2014 14:35:01 -0700
Subject: [PATCH v3 9/9] ARM: tegra: venice2: Add xHCI support
In-Reply-To: <1409693701-16520-1-git-send-email-abrestic@chromium.org>
References: <1409693701-16520-1-git-send-email-abrestic@chromium.org>
Message-ID: <1409693701-16520-10-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign ports previously owned by the EHCI controllers to the xHCI
controller.  There are two external USB ports (UTMI ports 0/2 and
USB3 ports 0/1) and an internal USB port (UTMI port 1).  PCIe lanes
0 and 1 are used by the USB3 ports.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v2:
 - Updated VBUS power supply names.
Changes from v1:
 - Updated USB power supplies.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 79 ++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 70ad91d..1cc3be2 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -736,7 +736,7 @@
 					regulator-always-on;
 				};
 
-				ldo0 {
+				avdd_1v05_run: ldo0 {
 					regulator-name = "+1.05V_RUN_AVDD";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
@@ -878,6 +878,56 @@
 		status = "okay";
 	};
 
+	usb at 0,70090000 {
+		status = "okay";
+		phys = <&padctl TEGRA_XUSB_PADCTL_UTMI_P0>, /* 1st USB A */
+		       <&padctl TEGRA_XUSB_PADCTL_UTMI_P1>, /* Internal USB */
+		       <&padctl TEGRA_XUSB_PADCTL_UTMI_P2>, /* 2nd USB A */
+		       <&padctl TEGRA_XUSB_PADCTL_USB3_P0>, /* 1st USB A */
+		       <&padctl TEGRA_XUSB_PADCTL_USB3_P1>; /* 2nd USB A */
+		phy-names = "utmi-0", "utmi-1", "utmi-2", "usb3-0", "usb3-1";
+		avddio-pex-supply = <&vdd_1v05_run>;
+		dvddio-pex-supply = <&vdd_1v05_run>;
+		avdd-usb-supply = <&vdd_3v3_lp0>;
+		avdd-pll-utmip-supply = <&vddio_1v8>;
+		avdd-pll-erefe-supply = <&avdd_1v05_run>;
+		avdd-pex-pll-supply = <&vdd_1v05_run>;
+		hvdd-pex-supply = <&vdd_3v3_lp0>;
+		hvdd-pex-plle-supply = <&vdd_3v3_lp0>;
+	};
+
+	padctl at 0,7009f000 {
+		pinctrl-0 = <&padctl_default>;
+		pinctrl-names = "default";
+
+		vbus-0-supply = <&vdd_usb1_vbus>;
+		vbus-1-supply = <&vdd_run_cam>;
+		vbus-2-supply = <&vdd_usb3_vbus>;
+		nvidia,usb3-port-0-lane = <TEGRA_XUSB_PADCTL_PIN_PCIE_0>;
+		nvidia,usb3-port-1-lane = <TEGRA_XUSB_PADCTL_PIN_PCIE_1>;
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
+				nvidia,usb2-port-num = <0>;
+			};
+
+			usb3p1 {
+				nvidia,lanes = "pcie-1";
+				nvidia,function = "usb3";
+				nvidia,iddq = <0>;
+				nvidia,usb2-port-num = <2>;
+			};
+		};
+	};
+
 	sdhci at 0,700b0400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -898,33 +948,6 @@
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
2.1.0.rc2.206.gedb03e5
