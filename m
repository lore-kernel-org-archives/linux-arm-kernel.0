From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 24 Mar 2016 17:12:05 +0900
Subject: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
Message-ID: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The buck9 regulator of S2MPS11 PMIC had incorrect maximum voltage -
lower by 5 mV than specified by datasheet. This buck9 provides power to
other regulators, including LDO13 and LDO19 which supply the MMC2 (SD
card).

When constraints were applied, the depending regulators were not
providing enough power, leading to SD card detection errors:
	mmc1: card never left busy state
	mmc1: error -110 whilst initialising SD card

Fixes: 86a2d2ac5e5d ("ARM: dts: Add dts file for Odroid XU3 board")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The issue can be reproduced on next-20160324 with
bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in bounds for our constraints).
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1bd507bfa750..82b2ba632cf6 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -299,7 +299,7 @@
 			buck9_reg: BUCK9 {
 				regulator-name = "vdd_2.8v_ldo";
 				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3750000>;
+				regulator-max-microvolt = <3755000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
-- 
2.5.0
