From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 20 Jan 2015 11:35:27 +0100
Subject: [PATCH 2/2] ARM: dts: Add DISP1 power domain for exynos5420
In-Reply-To: <1421750127-22536-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1421750127-22536-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1421750127-22536-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DISP1 power domain on Exynos5420 SoC includes the FIMD1, MIXER
and HDMI modules. Add a device node for this power domain and mark
these modules as consumer of the DISP1 power domain.

When a power domain is powered on and off, the input clocks of the
devices attached to it are reparented. So a reference to the input
and parent clocks of the devices are needed to manage that.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e5cb74d2b9f5..9dc2e9773b30 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -274,6 +274,20 @@
 		#power-domain-cells = <0>;
 	};
 
+	disp_pd: power-domain at 100440C0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440C0 0x20>;
+		#power-domain-cells = <0>;
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK200>,
+			 <&clock CLK_MOUT_USER_ACLK200_DISP1>,
+			 <&clock CLK_MOUT_SW_ACLK300>,
+			 <&clock CLK_MOUT_USER_ACLK300_DISP1>,
+			 <&clock CLK_MOUT_SW_ACLK400>,
+			 <&clock CLK_MOUT_USER_ACLK400_DISP1>;
+		clock-names = "oscclk", "pclk0", "clk0",
+			      "pclk1", "clk1", "pclk2", "clk2";
+	};
+
 	pinctrl_0: pinctrl at 13400000 {
 		compatible = "samsung,exynos5420-pinctrl";
 		reg = <0x13400000 0x1000>;
@@ -541,6 +555,7 @@
 	fimd: fimd at 14400000 {
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
+		power-domains = <&disp_pd>;
 	};
 
 	adc: adc at 12D10000 {
@@ -714,6 +729,7 @@
 		phy = <&hdmiphy>;
 		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
+		power-domains = <&disp_pd>;
 	};
 
 	hdmiphy: hdmiphy at 145D0000 {
@@ -726,6 +742,7 @@
 		interrupts = <0 94 0>;
 		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "sclk_hdmi";
+		power-domains = <&disp_pd>;
 	};
 
 	gsc_0: video-scaler at 13e00000 {
-- 
2.1.3
