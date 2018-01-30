From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Jan 2018 22:18:18 +0100
Subject: [PATCH v2 3/4] ARM: dts: exynos: Fix missing missing reg warning for
 syscon restart nodes
In-Reply-To: <20180130211819.17139-1-krzk@kernel.org>
References: <20180130211819.17139-1-krzk@kernel.org>
Message-ID: <20180130211819.17139-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix DTC warnings like:

    arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-poweroff missing or empty reg/ranges property
    arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
        Node /soc/syscon-reboot missing or empty reg/ranges property

by moving the syscon poweroff and restart nodes into the PMU (Power
Management Unit) node.  The PMU node is the actual block responsible for
power management, including typical Exynos on/off/restart procedures.
Therefore the syscon poweroff and restart nodes logically belong to it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Tested on Exynos5410, Exynos5420 and Exynos4412. Other tests are welcomed.
---
 arch/arm/boot/dts/exynos-syscon-restart.dtsi | 28 ++++++++++++----------------
 arch/arm/boot/dts/exynos3250.dtsi            |  2 +-
 arch/arm/boot/dts/exynos4.dtsi               |  3 ++-
 arch/arm/boot/dts/exynos5.dtsi               |  1 -
 arch/arm/boot/dts/exynos5250.dtsi            |  1 +
 arch/arm/boot/dts/exynos5410.dtsi            |  1 +
 arch/arm/boot/dts/exynos5420.dtsi            |  1 +
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
index 09a2040054ed..279ea09f4fe2 100644
--- a/arch/arm/boot/dts/exynos-syscon-restart.dtsi
+++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
@@ -6,22 +6,18 @@
  * published by the Free Software Foundation.
  */
 
-/ {
-	soc {
-		compatible = "simple-bus";
-
-		poweroff: syscon-poweroff {
-			compatible = "syscon-poweroff";
-			regmap = <&pmu_system_controller>;
-			offset = <0x330C>; /* PS_HOLD_CONTROL */
-			mask = <0x5200>; /* reset value */
-		};
+&pmu_system_controller {
+	poweroff: syscon-poweroff {
+		compatible = "syscon-poweroff";
+		regmap = <&pmu_system_controller>;
+		offset = <0x330C>; /* PS_HOLD_CONTROL */
+		mask = <0x5200>; /* reset value */
+	};
 
-		reboot: syscon-reboot {
-			compatible = "syscon-reboot";
-			regmap = <&pmu_system_controller>;
-			offset = <0x0400>; /* SWRESET */
-			mask = <0x1>;
-		};
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&pmu_system_controller>;
+		offset = <0x0400>; /* SWRESET */
+		mask = <0x1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index b8fb94f5daa8..df76624fd382 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -15,7 +15,6 @@
  */
 
 #include "exynos4-cpu-thermal.dtsi"
-#include "exynos-syscon-restart.dtsi"
 #include <dt-bindings/clock/exynos3250.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -914,3 +913,4 @@
 };
 
 #include "exynos3250-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 6d59cc827649..98af5592cc6d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -20,7 +20,6 @@
 #include <dt-bindings/clock/exynos-audss-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "exynos-syscon-restart.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
@@ -1010,3 +1009,5 @@
 		clock-names = "secss";
 	};
 };
+
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index f8d7de1144f1..359f49bdd4e2 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -12,7 +12,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "exynos-syscon-restart.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 56626d1a4235..037aceee5959 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -1114,3 +1114,4 @@
 };
 
 #include "exynos5250-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 1e6b57d013c4..fb7fa217a05b 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -439,3 +439,4 @@
 };
 
 #include "exynos5410-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2f3cb2a97f71..71e2b154a244 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1531,3 +1531,4 @@
 };
 
 #include "exynos5420-pinctrl.dtsi"
+#include "exynos-syscon-restart.dtsi"
-- 
2.11.0
