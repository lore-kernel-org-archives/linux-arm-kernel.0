From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 May 2016 14:43:59 +0200
Subject: [PATCH v3 2/3] ARM: dts: exynos: Define vqmmc for eMMC card on Odroid
 X/X2/U3
In-Reply-To: <1462365840-27406-1-git-send-email-k.kozlowski@samsung.com>
References: <1462365840-27406-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462365840-27406-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC card vmmc-supply contained incorrectly two regulators: LDO20
and buck8. The second one is ignored. Additionally the buck8 is a vqmmc
supply only on X and X2. On U3 the buck8 is providing power to the LAN
(SMSC95xx) so instead the LDO22 should be used.

Fix this by defining proper vmmc and vqmmc supplies for respective
boards.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v2:
1. Add Javier's tag.
2. Apply Javier's feedback: remove the regulator constraints (min/max
   volts) from common DTS.

Changes since v1:
1. buck8 is used on X/X2 so differentiate the configuration (hint by
   Tobias Jakobi).
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 17 ++++++++++++++---
 arch/arm/boot/dts/exynos4412-odroidu3.dts       | 18 ++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroidx.dts        | 11 +++++++++++
 arch/arm/boot/dts/exynos4412-odroidx2.dts       | 11 +++++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 3d0d44581fbd..7485ce8a6fb3 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -347,6 +347,15 @@
 				regulator-boot-on;
 			};
 
+			ldo22_reg: LDO22 {
+				/*
+				 * Only U3 uses it, so let it define the
+				 * constraints
+				 */
+				regulator-name = "LDO22";
+				regulator-boot-on;
+			};
+
 			ldo25_reg: LDO25 {
 				regulator-name = "VDDQ_LCD_1.8V";
 				regulator-min-microvolt = <1800000>;
@@ -410,9 +419,11 @@
 			};
 
 			buck8_reg: BUCK8 {
+				/*
+				 * Constraints set by specific board: X,
+				 * X2 and U3.
+				 */
 				regulator-name = "BUCK8_2.8V";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
 			};
 		};
 	};
@@ -456,7 +467,7 @@
 &mshc_0 {
 	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 	pinctrl-names = "default";
-	vmmc-supply = <&ldo20_reg &buck8_reg>;
+	vmmc-supply = <&ldo20_reg>;
 	mmc-pwrseq = <&emmc_pwrseq>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index dd89f7b37c9f..d73aa6c58fe3 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -69,6 +69,24 @@
 	};
 };
 
+/* Supply for LAN9730/SMSC95xx */
+&buck8_reg {
+	regulator-name = "BUCK8_P3V3";
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
+
+/* VDDQ for MSHC (eMMC card) */
+&ldo22_reg {
+	regulator-name = "LDO22_VDDQ_MMC4_2.8V";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
+&mshc_0 {
+	vqmmc-supply = <&ldo22_reg>;
+};
+
 &pwm {
 	pinctrl-0 = <&pwm0_out>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index bf7b21b817e4..2af235151301 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -63,12 +63,23 @@
 	};
 };
 
+/* VDDQ for MSHC (eMMC card) */
+&buck8_reg {
+	regulator-name = "BUCK8_VDDQ_MMC4_2.8V";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
 &ehci {
 	port at 1 {
 		status = "okay";
 	};
 };
 
+&mshc_0 {
+	vqmmc-supply = <&buck8_reg>;
+};
+
 &pinctrl_1 {
 	gpio_home_key: home_key {
 		samsung,pins = "gpx2-2";
diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/exynos4412-odroidx2.dts
index 6e33678562ae..3e3584270e00 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx2.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx2.dts
@@ -22,6 +22,17 @@
 	};
 };
 
+/* VDDQ for MSHC (eMMC card) */
+&buck8_reg {
+	regulator-name = "BUCK8_VDDQ_MMC4_2.8V";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
+&mshc_0 {
+	vqmmc-supply = <&buck8_reg>;
+};
+
 &sound {
 	simple-audio-card,name = "Odroid-X2";
 	simple-audio-card,widgets =
-- 
1.9.1
