From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 05 Dec 2014 17:46:28 +0100
Subject: [RFC 3/3] ARM: dts: Add devfreq to Exynos3250 and Rinato board
In-Reply-To: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
References: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417797988-29225-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devfreq to Exynos3250 common file and enable it for Rinato board.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 10 ++++++++++
 arch/arm/boot/dts/exynos3250.dtsi       | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 80aa8b4c4a3d..713b6a5c3f85 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -527,6 +527,16 @@
 	clock-frequency = <24000000>;
 };
 
+&busfreq_mif {
+	vdd_mif-supply = <&buck1_reg>;
+	status = "okay";
+};
+
+&busfreq_int {
+	vdd_int-supply = <&buck3_reg>;
+	status = "okay";
+};
+
 &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 22465494b796..8f8d674a8748 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -175,6 +175,38 @@
 			#clock-cells = <1>;
 		};
 
+		busfreq_mif: busfreq at 106A0000 {
+			compatible = "samsung,exynos3250-busfreq-mif";
+			reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+			clocks = <&cmu_dmc CLK_DIV_DMC>;
+			clock-names = "dmc";
+			status = "disabled";
+		};
+
+		busfreq_int: busfreq at 116A0000 {
+			compatible = "samsung,exynos3250-busfreq-int";
+			reg = <0x116A0000 0x2000>, <0x112A0000 0x2000>;
+			clocks = <&cmu CLK_PPMULEFT>,
+				<&cmu CLK_PPMURIGHT>,
+				<&cmu CLK_DIV_ACLK_400_MCUISP>,
+				<&cmu CLK_DIV_ACLK_266>,
+				<&cmu CLK_DIV_ACLK_200>,
+				<&cmu CLK_DIV_ACLK_160>,
+				<&cmu CLK_DIV_GDL>,
+				<&cmu CLK_DIV_GDR>,
+				<&cmu CLK_DIV_MFC>;
+			clock-names = "ppmu_left",
+				"ppmu_right",
+				"aclk_400",
+				"aclk_266",
+				"aclk_200",
+				"aclk_160",
+				"aclk_gdl",
+				"aclk_gdr",
+				"mfc";
+			status = "disabled";
+		};
+
 		rtc: rtc at 10070000 {
 			compatible = "samsung,exynos3250-rtc";
 			reg = <0x10070000 0x100>;
-- 
1.9.1
