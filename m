From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Dec 2014 15:56:53 +0100
Subject: [PATCH v2 3/3] ARM: dts: Add devfreq to Exynos3250 and Rinato board
In-Reply-To: <1418655413-25410-1-git-send-email-k.kozlowski@samsung.com>
References: <1418655413-25410-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1418655413-25410-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devfreq to Exynos3250 common file and enable it for Rinato board.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 12 ++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi       | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 7970b8e91ab2..6def01c61742 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -567,6 +567,18 @@
 	clock-frequency = <24000000>;
 };
 
+&busfreq_mif {
+	vdd-mif-supply = <&buck1_reg>;
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	status = "okay";
+};
+
+&busfreq_int {
+	vdd-int-supply = <&buck3_reg>;
+	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	status = "okay";
+};
+
 &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 51e3e7111e59..cc0e30768ec2 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -175,6 +175,32 @@
 			#clock-cells = <1>;
 		};
 
+		busfreq_mif: busfreq at 106A0000 {
+			compatible = "samsung,exynos3250-busfreq-mif";
+			clocks = <&cmu_dmc CLK_DIV_DMC>;
+			clock-names = "dmc";
+			status = "disabled";
+		};
+
+		busfreq_int: busfreq at 116A0000 {
+			compatible = "samsung,exynos3250-busfreq-int";
+			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>,
+				<&cmu CLK_DIV_ACLK_266>,
+				<&cmu CLK_DIV_ACLK_200>,
+				<&cmu CLK_DIV_ACLK_160>,
+				<&cmu CLK_DIV_GDL>,
+				<&cmu CLK_DIV_GDR>,
+				<&cmu CLK_DIV_MFC>;
+			clock-names = "aclk_400",
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
