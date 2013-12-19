From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 17:06:22 +0100
Subject: [PATCH 10/10] ARM: tegra: Enable USB on Venice2
In-Reply-To: <1387469182-14398-1-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
Message-ID: <1387469182-14398-11-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB1 and USB3 are routed to two external connectors, while USB2 is used
for the integrated webcam.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note: connecting a USB mouse to USB3 works properly and lsusb also detects
the integrated webcam, though I haven't tested whether the camera actually
works.

USB1 doesn't seem to work, but I suspect that might just be because it's
used for recovery mode and we can't switch it around at runtime yet.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 47 +++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index b770e903fabb..efdf93e6f5cc 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -534,7 +534,7 @@
 					ams,enable-tracking;
 				};
 
-				ldo4 {
+				cam_2v8_reg: ldo4 {
 					regulator-name = "avdd_cam";
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
@@ -715,6 +715,33 @@
 		};
 	};
 
+	usb at 7d000000 {
+		status = "okay";
+	};
+
+	usb-phy at 7d000000 {
+		status = "okay";
+		vbus-supply = <&usb1_vbus_reg>;
+	};
+
+	usb at 7d004000 {
+		status = "okay";
+	};
+
+	usb-phy at 7d004000 {
+		status = "okay";
+		vbus-supply = <&cam_2v8_reg>;
+	};
+
+	usb at 7d008000 {
+		status = "okay";
+	};
+
+	usb-phy at 7d008000 {
+		status = "okay";
+		vbus-supply = <&usb3_vbus_reg>;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
@@ -788,6 +815,24 @@
 			gpio = <&gpio TEGRA_GPIO(P, 2) 0 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
+
+		usb1_vbus_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+		};
+
+		usb3_vbus_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "usb3_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+		};
 	};
 
 	sound {
-- 
1.8.4.2
