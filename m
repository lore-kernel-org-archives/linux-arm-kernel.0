From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Apr 2015 13:03:08 +0200
Subject: [PATCH 2/2] ARM: dts: Enable S3C RTC on Trats2,
 Odroid-U3 and Arndale Octa
In-Reply-To: <1427972588-6573-1-git-send-email-k.kozlowski@samsung.com>
References: <1427972588-6573-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1427972588-6573-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the S3C RTC node with rtc_src clock so it could be operational.
The rtc_src clock is provided by MAX77686 (Trats2 and Odroid-U3) or
S2MPS11 (Arndale Octa).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Patch depends on new file "dt-bindings/clock/samsung,s2mps11.h"
from:
1. ARM: dts: Add bindings for 32kHz clocks from s2mps11
   http://www.spinics.net/lists/linux-samsung-soc/msg43345.html
---
 arch/arm/boot/dts/exynos4.dtsi                |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  7 +++++++
 arch/arm/boot/dts/exynos4412-trats2.dts       |  9 ++++++++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 11 +++++++----
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 8ea2e374acaf..95efdf805f20 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -266,7 +266,7 @@
 		status = "disabled";
 	};
 
-	rtc at 10070000 {
+	rtc: rtc at 10070000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupt-parent = <&pmu_system_controller>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 44684e57ead1..2bf7447d02ef 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 #include "exynos4412-odroid-common.dtsi"
+#include <dt-bindings/clock/maxim,max77686.h>
 
 / {
 	model = "Hardkernel ODROID-U3 board based on Exynos4412";
@@ -61,3 +62,9 @@
 		"Speakers", "SPKL",
 		"Speakers", "SPKR";
 };
+
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 173ffa479ad3..c032cde11d5c 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -16,6 +16,7 @@
 #include "exynos4412.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/maxim,max77686.h>
 
 / {
 	model = "Samsung Trats 2 based on Exynos4412";
@@ -214,7 +215,7 @@
 		pinctrl-names = "default";
 		status = "okay";
 
-		max77686_pmic at 09 {
+		max77686: max77686_pmic at 09 {
 			compatible = "maxim,max77686";
 			interrupt-parent = <&gpx0>;
 			interrupts = <7 0>;
@@ -1304,3 +1305,9 @@
 		PIN_SLP(gpv4-0, INPUT, DOWN);
 	};
 };
+
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index b82b6fa15f48..d78fcd997ce6 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -13,6 +13,7 @@
 #include "exynos5420.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/samsung,s2mps11.h>
 
 / {
 	model = "Insignal Arndale Octa evaluation board based on EXYNOS5420";
@@ -38,10 +39,6 @@
 		};
 	};
 
-	rtc at 101E0000 {
-		status = "okay";
-	};
-
 	codec at 11000000 {
 		samsung,mfc-r = <0x43000000 0x800000>;
 		samsung,mfc-l = <0x51000000 0x800000>;
@@ -376,3 +373,9 @@
 &cci {
 	status = "disabled";
 };
+
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
-- 
1.9.1
