From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 1 Jul 2016 17:04:03 +0100
Subject: [PATCH] arm64: tegra: Enable XUSB controller on Tegra210 Smaug
Message-ID: <1467389043-959-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the XUSB controller on Tegra210 Smaug. The Smaug has a USB Type-C
connector with one of the USB2.0 lanes and one of the USB3.0 lanes
populated.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 431266a48e9c..db9763fd945f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1568,6 +1568,63 @@
 		status = "okay";
 	};
 
+	usb at 70090000 {
+		phys = <&{/padctl@7009f000/pads/usb2/lanes/usb2-0}>,
+		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-6}>;
+		phy-names = "usb2-0", "usb3-0";
+
+		dvddio-pex-supply = <&avddio_1v05>;
+		hvddio-pex-supply = <&pp1800>;
+		avdd-usb-supply = <&pp3300>;
+		avdd-pll-utmip-supply = <&pp1800>;
+		avdd-pll-uerefe-supply = <&pp1050_avdd>;
+		dvdd-pex-pll-supply = <&avddio_1v05>;
+		hvdd-pex-pll-e-supply = <&pp1800>;
+
+		status = "okay";
+	};
+
+	padctl at 7009f000 {
+		status = "okay";
+
+		pads {
+			usb2 {
+				status = "okay";
+
+				lanes {
+					usb2-0 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+				};
+			};
+
+			pcie {
+				status = "okay";
+
+				lanes {
+					pcie-6 {
+						nvidia,function = "usb3-ss";
+						status = "okay";
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "okay";
+				vbus-supply = <&usbc_vbus>;
+				mode = "otg";
+			};
+
+			usb3-0 {
+				nvidia,usb2-companion = <0>;
+				status = "okay";
+			};
+		};
+	};
+
 	sdhci at 700b0600 {
 		bus-width = <8>;
 		non-removable;
-- 
2.1.4
