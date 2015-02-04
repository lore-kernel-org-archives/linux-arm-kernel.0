From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 04 Feb 2015 15:02:56 +0100
Subject: [PATCH v5 RESEND 3/9] ARM: dts: exynos4: add hdmi related nodes
In-Reply-To: <1422883228-10690-4-git-send-email-m.szyprowski@samsung.com>
References: <1422883228-10690-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1423058576-914-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds entries for HDMI, Mixer and i2c with hdmi-phy modules
found in Exynos 4210 and 4x12 SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Resend reason: rebased onto latest kgene/v3.20-next/dt-samsung-4 branch
---
 arch/arm/boot/dts/exynos4.dtsi    | 40 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  8 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi | 11 +++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index d1759bf5202f..c6e72041cc55 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -38,6 +38,7 @@
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
+		i2c8 = &i2c_8;
 		csis0 = &csis_0;
 		csis1 = &csis_1;
 		fimc0 = &fimc_0;
@@ -545,6 +546,22 @@
 		status = "disabled";
 	};
 
+	i2c_8: i2c at 138E0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-hdmiphy-i2c";
+		reg = <0x138E0000 0x100>;
+		interrupts = <0 93 0>;
+		clocks = <&clock CLK_I2C_HDMI>;
+		clock-names = "i2c";
+		status = "disabled";
+
+		hdmi_i2c_phy: hdmiphy at 38 {
+			compatible = "exynos4210-hdmiphy";
+			reg = <0x38>;
+		};
+	};
+
 	spi_0: spi at 13920000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13920000 0x100>;
@@ -654,6 +671,29 @@
 		status = "disabled";
 	};
 
+	hdmi: hdmi at 12D00000 {
+		compatible = "samsung,exynos4210-hdmi";
+		reg = <0x12D00000 0x70000>;
+		interrupts = <0 92 0>;
+		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel", "sclk_hdmiphy",
+			"mout_hdmi";
+		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
+			<&clock CLK_SCLK_PIXEL>, <&clock CLK_SCLK_HDMIPHY>,
+			<&clock CLK_MOUT_HDMI>;
+		phy = <&hdmi_i2c_phy>;
+		power-domains = <&pd_tv>;
+		samsung,syscon-phandle = <&pmu_system_controller>;
+		status = "disabled";
+	};
+
+	mixer: mixer at 12C10000 {
+		compatible = "samsung,exynos4210-mixer";
+		interrupts = <0 91 0>;
+		reg = <0x12C10000 0x2100>, <0x12c00000 0x300>;
+		power-domains = <&pd_tv>;
+		status = "disabled";
+	};
+
 	ppmu_dmc0: ppmu_dmc0 at 106a0000 {
 		compatible = "samsung,exynos-ppmu";
 		reg = <0x106a0000 0x2000>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7c15880bc8ba..1ef40f6f6e08 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -194,6 +194,14 @@
 		};
 	};
 
+	mixer: mixer at 12C10000 {
+		clock-names = "mixer", "hdmi", "sclk_hdmi", "vp", "mout_mixer",
+			"sclk_mixer";
+		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
+			<&clock CLK_SCLK_HDMI>, <&clock CLK_VP>,
+			<&clock CLK_MOUT_MIXER>, <&clock CLK_SCLK_MIXER>;
+	};
+
 	ppmu_lcd1: ppmu_lcd1 at 12240000 {
 		compatible = "samsung,exynos-ppmu";
 		reg = <0x12240000 0x2000>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index af59cab53bd9..2824a5c0e28d 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -283,4 +283,15 @@
 		clock-names = "tmu_apbif";
 		status = "disabled";
 	};
+
+	hdmi: hdmi at 12D00000 {
+		compatible = "samsung,exynos4212-hdmi";
+	};
+
+	mixer: mixer at 12C10000 {
+		compatible = "samsung,exynos4212-mixer";
+		clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
+		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
+			 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	};
 };
-- 
1.9.2
