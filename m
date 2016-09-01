From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Sep 2016 10:37:01 +0200
Subject: [PATCH 1/2] ARM: dts: exynos: Fix mismatched value for SD4 pull
 up/down configuration on exynos4210
Message-ID: <1472719022-27226-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl pull up/down register on exynos4210 is 2-bit wide for each
pin and it accepts only values of 0, 1 and 3.  The pins sd4-bus-width8
were configured with value of 4.  The driver does not validate the value
so this overflow effectively set a bit 1 in adjacent pins thus
configuring them to pull down.

The author's intention was probably to set drive strength of 4x.  All
other bus-widths pins are configured with pull up and drive strength of
4x.  Fix this one with same pattern.

Fixes: 87711d8c7c70 ("ARM: dts: Add pinctrl node entries for SAMSUNG EXYNOS4210 SoC")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 8046340e50ac..d9b6d25e4abe 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -649,7 +649,7 @@
 		sd4_bus8: sd4-bus-width8 {
 			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
 			samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-			samsung,pin-pud = <4>;
+			samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 			samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 		};
 
-- 
1.9.1
