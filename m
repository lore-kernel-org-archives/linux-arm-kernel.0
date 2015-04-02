From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Apr 2015 10:06:19 +0200
Subject: [PATCH 2/2] ARM: dts: Use last parent for clocks during power domain
 on/off
In-Reply-To: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
References: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1427961979-29477-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace fixed parent with last parent (obtained with clk_get_parent())
of clocks for devices in mfc and disp power domains. This should improve
behavior if such clocks were reparented by the drivers and new parents
are different than those specified in DTS.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c7a44ee0ce06..b9b99305991b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -264,9 +264,8 @@
 	mfc_pd: power-domain at 10044060 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044060 0x20>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK333>,
-			<&clock CLK_MOUT_USER_ACLK333>;
-		clock-names = "oscclk", "pclk0", "clk0";
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_USER_ACLK333>;
+		clock-names = "oscclk", "clk0";
 		#power-domain-cells = <0>;
 	};
 
@@ -280,16 +279,12 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x100440C0 0x20>;
 		#power-domain-cells = <0>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK200>,
+		clocks = <&clock CLK_FIN_PLL>,
 			 <&clock CLK_MOUT_USER_ACLK200_DISP1>,
-			 <&clock CLK_MOUT_SW_ACLK300>,
 			 <&clock CLK_MOUT_USER_ACLK300_DISP1>,
-			 <&clock CLK_MOUT_SW_ACLK400>,
 			 <&clock CLK_MOUT_USER_ACLK400_DISP1>,
 			 <&clock CLK_FIMD1>, <&clock CLK_MIXER>;
-		clock-names = "oscclk", "pclk0", "clk0",
-			      "pclk1", "clk1", "pclk2", "clk2",
-			      "asb0", "asb1";
+		clock-names = "oscclk", "clk0", "clk1", "clk2", "asb0", "asb1";
 	};
 
 	pinctrl_0: pinctrl at 13400000 {
-- 
1.9.1
