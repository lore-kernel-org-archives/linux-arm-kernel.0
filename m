From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 14 May 2014 17:33:06 -0700
Subject: [RFC PATCH 10/10] ARM: tegra124: Enable XHCI on Venice2
In-Reply-To: <1400113986-339-1-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
Message-ID: <1400113986-339-11-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the XHCI host controller and XUSB PHY on Venice2.  All three
USB2.0 ports are owned by the XHCI controller and the two SuperSpeed
ports are mapped to the external USB2.0 ports.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 46 ++++++++++++++--------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index f0bb842..dcfc0c7 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -940,6 +940,25 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	usb at 0,70090000 {
+		status = "okay";
+		s1p05v-supply = <&vdd_1v05_run>;
+		s3p3v-supply = <&vdd_3v3_lp0>;
+		s1p8v-supply = <&vddio_1v8>;
+	};
+
+	phy at 0,7009f000 {
+		status = "okay";
+		nvidia,ss-pads = <0x3>;
+		nvidia,hsic-pads = <0x0>;
+		nvidia,utmi-pads = <0x7>;
+		nvidia,ss-port0-map = <0>;
+		nvidia,ss-port1-map = <2>;
+		vbus1-supply = <&vdd_usb1_vbus>;
+		vbus2-supply = <&vdd_run_cam>;
+		vbus3-supply = <&vdd_usb3_vbus>;
+	};
+
 	sdhci at 0,700b0400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -960,33 +979,6 @@
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
1.9.1.423.g4596e3a
