From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Jul 2015 14:37:45 +0900
Subject: [PATCH] ARM: dts: Add CPU cooling binding for Exynos3250-based
 Rinato/Monk board
Message-ID: <1435815465-501-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the cooling device to control the overheating issue on
Exynos3250-based Rinato/Monk board.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Depends on:
This patch needs the cpufreq support of Exynos3250 SoC. So, this patch has the
dependency on patch[1] which support the generic cpufreq for Exynos3250 SoC.
[1] https://lkml.org/lkml/2015/7/1/696
    : [PATCH v6 0/3] cpufreq: Use cpufreq-dt driver for Exynos3250

 arch/arm/boot/dts/exynos3250-monk.dts   | 15 +++++++++++++++
 arch/arm/boot/dts/exynos3250-rinato.dts | 15 +++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi       |  1 +
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 7863265d4868..540a0adf2be6 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -116,6 +116,21 @@
 		min-microvolt = <1100000>;
 		max-microvolt = <2700000>;
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+					/* Correspond to 500MHz at freq_table */
+					cooling-device = <&cpu0 5 5>;
+				};
+				map1 {
+					/* Correspond to 200MHz at freq_table */
+					cooling-device = <&cpu0 8 8>;
+				};
+			};
+		};
+	};
 };
 
 &adc {
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index ddd7ac283045..0e62a6435e07 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -107,6 +107,21 @@
 		min-microvolt = <1100000>;
 		max-microvolt = <2700000>;
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+					/* Corresponds to 500MHz */
+					cooling-device = <&cpu0 5 5>;
+				};
+				map1 {
+					/* Corresponds to 200MHz */
+					cooling-device = <&cpu0 8 8>;
+				};
+			};
+		};
+	};
 };
 
 &adc {
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index e0f3b2ed41a3..a4931b660ddb 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -55,6 +55,7 @@
 			clock-frequency = <1000000000>;
 			clocks = <&cmu CLK_ARM_CLK>;
 			clock-names = "cpu";
+			#cooling-cells = <2>;
 
 			operating-points = <
 				1000000 1150000
-- 
1.8.5.5
