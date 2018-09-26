From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 26 Sep 2018 21:02:48 +0200
Subject: [PATCH v2] ARM: dts: exynos: Add pin configuration for SD write
 protect on Odroid XU
Message-ID: <20180926190248.6369-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SD card write-protect pin configuration to be sure that it will be
properly pulled down to indicate write access.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
   Marek Szyprowski feedback).
2. Pull pin down.
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index a2046f5f998c..434a7591ff63 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -530,7 +530,7 @@
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4 &sd2_wp>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	vmmc-supply = <&ldo21_reg>;
@@ -545,6 +545,14 @@
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
+	sd2_wp: sd2-wp {
+		samsung,pins = "gpm5-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		/* Pin is floating so be sure to disable write-protect */
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
 	pmic_dvs_3: pmic-dvs-3 {
 		samsung,pins = "gpx0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-- 
2.17.1
