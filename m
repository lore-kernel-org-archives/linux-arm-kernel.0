From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 20 Jan 2015 13:16:55 +0100
Subject: [PATCH v4 5/9] ARM: dts: exynos4412-odroid: enable hdmi support
In-Reply-To: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1421756219-21037-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds nodes specific to Exynos4412 based Odroid X/X2/U2/U3
boards required for enabling HDMI display.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 3fbf588682b9..e10efa88807a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -231,6 +231,20 @@
 					regulator-always-on;
 				};
 
+				ldo8_reg: ldo at 8 {
+					regulator-compatible = "LDO8";
+					regulator-name = "VDD10_HDMI_1.0V";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+				};
+
+				ldo10_reg: ldo at 10 {
+					regulator-compatible = "LDO10";
+					regulator-name = "VDDQ_MIPIHSI_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
 				ldo11_reg: LDO11 {
 					regulator-name = "VDD18_ABB1_1.8V";
 					regulator-min-microvolt = <1800000>;
@@ -389,6 +403,31 @@
 	ehci: ehci at 12580000 {
 		status = "okay";
 	};
+
+	mixer: mixer at 12C10000 {
+		status = "okay";
+	};
+
+	hdmi at 12D00000 {
+		hpd-gpio = <&gpx3 7 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd>;
+		vdd-supply = <&ldo8_reg>;
+		vdd_osc-supply = <&ldo10_reg>;
+		vdd_pll-supply = <&ldo8_reg>;
+		ddc = <&hdmi_ddc>;
+		status = "okay";
+	};
+
+	hdmi_ddc: i2c at 13880000 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_bus>;
+	};
+
+	i2c at 138E0000 {
+		status = "okay";
+	};
 };
 
 &pinctrl_1 {
@@ -403,4 +442,9 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
+
+	hdmi_hpd: hdmi-hpd {
+		samsung,pins = "gpx3-7";
+		samsung,pin-pud = <1>;
+	};
 };
-- 
1.9.2
