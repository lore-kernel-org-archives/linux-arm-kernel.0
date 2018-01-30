From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Jan 2018 22:18:19 +0100
Subject: [PATCH v2 4/4] arm64: dts: exynos: Fix missing missing reg warning
 for syscon restart nodes
In-Reply-To: <20180130211819.17139-1-krzk@kernel.org>
References: <20180130211819.17139-1-krzk@kernel.org>
Message-ID: <20180130211819.17139-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix DTC warnings like:

    arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-reboot missing or empty reg/ranges property

by moving the syscon restart node into the PMU (Power Management Unit)
node.  The PMU node is the actual block responsible for power
management, including typical Exynos on/off/restart procedures.
Therefore the syscon restart node logically belongs to it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested.  All tests are welcomed.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 62f276970174..0f3ec7e4b0f7 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -231,13 +231,6 @@
 		cpu_on = <0xC4000003>;
 	};
 
-	reboot: syscon-reboot {
-		compatible = "syscon-reboot";
-		regmap = <&pmu_system_controller>;
-		offset = <0x400>; /* SWRESET */
-		mask = <0x1>;
-	};
-
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -799,6 +792,13 @@
 			#clock-cells = <1>;
 			clock-names = "clkout16";
 			clocks = <&xxti>;
+
+			reboot: syscon-reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmu_system_controller>;
+				offset = <0x400>; /* SWRESET */
+				mask = <0x1>;
+			};
 		};
 
 		gic: interrupt-controller at 11001000 {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ad9dce6894ce..0b98d2334cad 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -494,13 +494,13 @@
 		pmu_system_controller: system-controller at 105c0000 {
 			compatible = "samsung,exynos7-pmu", "syscon";
 			reg = <0x105c0000 0x5000>;
-		};
 
-		reboot: syscon-reboot {
-			compatible = "syscon-reboot";
-			regmap = <&pmu_system_controller>;
-			offset = <0x0400>;
-			mask = <0x1>;
+			reboot: syscon-reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmu_system_controller>;
+				offset = <0x0400>;
+				mask = <0x1>;
+			};
 		};
 
 		rtc: rtc at 10590000 {
-- 
2.11.0
