From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  6 Jun 2016 18:36:37 +0200
Subject: [PATCH 8/8] arm64: tegra: Enable XUSB controller on Jetson TX1
In-Reply-To: <20160606163637.14234-1-thierry.reding@gmail.com>
References: <20160606163637.14234-1-thierry.reding@gmail.com>
Message-ID: <20160606163637.14234-8-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 162 +++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 78a16a57fec7..8bba178d8d0f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1278,6 +1278,146 @@
 		};
 	};
 
+	usb at 70090000 {
+		phys = <&{/padctl@7009f000/pads/usb2/lanes/usb2-0}>,
+		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-1}>,
+		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-2}>,
+		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-3}>,
+		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-6}>,
+		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-5}>;
+		phy-names = "usb2-0", "usb2-1", "usb2-2", "usb2-3", "usb3-0",
+			    "usb3-1";
+
+		dvddio-pex-supply = <&vdd_pex_1v05>;
+		hvddio-pex-supply = <&vdd_1v8>;
+		avdd-usb-supply = <&vdd_3v3_sys>;
+		/* XXX what are these? */
+		avdd-pll-utmip-supply = <&vdd_1v8>;
+		avdd-pll-uerefe-supply = <&vdd_pex_1v05>;
+		dvdd-usb-ss-pll-supply = <&vdd_pex_1v05>;
+		hvdd-usb-ss-pll-e-supply = <&vdd_1v8>;
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
+
+					usb2-1 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb2-2 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb2-3 {
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
+					pcie-0 {
+						nvidia,function = "pcie-x1";
+						status = "okay";
+					};
+
+					pcie-1 {
+						nvidia,function = "pcie-x4";
+						status = "okay";
+					};
+
+					pcie-2 {
+						nvidia,function = "pcie-x4";
+						status = "okay";
+					};
+
+					pcie-3 {
+						nvidia,function = "pcie-x4";
+						status = "okay";
+					};
+
+					pcie-4 {
+						nvidia,function = "pcie-x4";
+						status = "okay";
+					};
+
+					pcie-5 {
+						nvidia,function = "usb3-ss";
+						status = "okay";
+					};
+
+					pcie-6 {
+						nvidia,function = "usb3-ss";
+						status = "okay";
+					};
+				};
+			};
+
+			sata {
+				status = "okay";
+
+				lanes {
+					sata-0 {
+						nvidia,function = "sata";
+						status = "okay";
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "okay";
+				mode = "otg";
+			};
+
+			usb2-1 {
+				status = "okay";
+				vbus-supply = <&vdd_5v0_rtl>;
+				mode = "host";
+			};
+
+			usb2-2 {
+				status = "okay";
+				vbus-supply = <&vdd_usb_vbus>;
+				mode = "host";
+			};
+
+			usb2-3 {
+				status = "okay";
+				mode = "host";
+			};
+
+			usb3-0 {
+				nvidia,usb2-companion = <1>;
+				status = "okay";
+			};
+
+			usb3-1 {
+				nvidia,usb2-companion = <2>;
+				status = "okay";
+			};
+		};
+	};
+
 	/* MMC/SD */
 	sdhci at 700b0000 {
 		status = "okay";
@@ -1390,6 +1530,28 @@
 			enable-active-high;
 			vin-supply = <&vdd_1v8>;
 		};
+
+		vdd_5v0_rtl: regulator at 8 {
+			compatible = "regulator-fixed";
+			reg = <8>;
+			regulator-name = "RTL_5V";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_5v0_sys>;
+		};
+
+		vdd_usb_vbus: regulator at 9 {
+			compatible = "regulator-fixed";
+			reg = <9>;
+			regulator-name = "USB_VBUS_EN1";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(CC, 5) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_5v0_sys>;
+		};
 	};
 
 	gpio-keys {
-- 
2.8.3
