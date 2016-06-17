From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jun 2016 22:28:11 +0200
Subject: [PATCH 6/7] ARM: dts: move the fixed MMC regulator to SURF board
In-Reply-To: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
References: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1466195292-28236-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently a fixed regulator in the .dtsi file for
the MSM8660 chipset, used by the SURF board. We want to define
real regulators for a board using this chipset, so push the fixed
regulator down to the SURF board which is the only user.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660-surf.dts | 11 +++++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi     | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
index b17f379e8c2a..23de764558ab 100644
--- a/arch/arm/boot/dts/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom-msm8660-surf.dts
@@ -23,15 +23,26 @@
 			};
 		};
 
+		/* Temporary fixed regulator */
+		vsdcc_fixed: vsdcc-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "SDCC Power";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-always-on;
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
 				status = "okay";
+				vmmc-supply = <&vsdcc_fixed>;
 			};
 
 			/* External micro SD card */
 			sdcc3: sdcc at 12180000 {
 				status = "okay";
+				vmmc-supply = <&vsdcc_fixed>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index b7d7f0c27ba1..acbe71febe13 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -315,15 +315,6 @@
 			};
 		};
 
-		/* Temporary fixed regulator */
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-			regulator-always-on;
-		};
-
 		amba {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -343,7 +334,6 @@
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				vmmc-supply = <&vsdcc_fixed>;
 			};
 
 			sdcc3: sdcc at 12180000 {
@@ -360,7 +350,6 @@
 				cap-mmc-highspeed;
 				max-frequency	= <48000000>;
 				no-1-8-v;
-				vmmc-supply = <&vsdcc_fixed>;
 			};
 
 			sdcc5: sdcc at 12200000 {
@@ -376,7 +365,6 @@
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
 				max-frequency	= <48000000>;
-				vmmc-supply = <&vsdcc_fixed>;
 			};
 		};
 
-- 
2.4.11
