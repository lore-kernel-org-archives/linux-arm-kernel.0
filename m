From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:05:58 +0200
Subject: [PATCH v2 13/22] ARM: dts: exynos: Move common nodes to exynos5.dtsi
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-14-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 and Exynos5250 share some nodes: the PWM and syscon
(sysreg_system_controller). Move them to parent DTSI to avoid
duplication.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5.dtsi    | 12 ++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 19 +++++--------------
 arch/arm/boot/dts/exynos5420.dtsi | 19 +++++--------------
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index d5c0f18a4223..fe901152f3ea 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -63,6 +63,11 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	sysreg_system_controller: syscon at 10050000 {
+		compatible = "samsung,exynos5-sysreg", "syscon";
+		reg = <0x10050000 0x5000>;
+	};
+
 	serial_0: serial at 12C00000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C00000 0x100>;
@@ -87,6 +92,13 @@
 		interrupts = <0 54 0>;
 	};
 
+	pwm: pwm at 12DD0000 {
+		compatible = "samsung,exynos4210-pwm";
+		reg = <0x12DD0000 0x100>;
+		samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+		#pwm-cells = <3>;
+	};
+
 	rtc: rtc at 101E0000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x101E0000 0x100>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index c7158b2fb213..6762faaf12a8 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -235,11 +235,6 @@
 		interrupt-parent = <&gic>;
 	};
 
-	sysreg_system_controller: syscon at 10050000 {
-		compatible = "samsung,exynos5-sysreg", "syscon";
-		reg = <0x10050000 0x5000>;
-	};
-
 	watchdog at 101D0000 {
 		compatible = "samsung,exynos5250-wdt";
 		reg = <0x101D0000 0x100>;
@@ -662,15 +657,6 @@
 		samsung,pmureg-phandle = <&pmu_system_controller>;
 	};
 
-	pwm: pwm at 12dd0000 {
-		compatible = "samsung,exynos4210-pwm";
-		reg = <0x12dd0000 0x100>;
-		samsung,pwm-outputs = <0>, <1>, <2>, <3>;
-		#pwm-cells = <3>;
-		clocks = <&clock CLK_PWM>;
-		clock-names = "timers";
-	};
-
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -1070,6 +1056,11 @@
 	iommus = <&sysmmu_fimd1>;
 };
 
+&pwm {
+	clocks = <&clock CLK_PWM>;
+	clock-names = "timers";
+};
+
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 4c8523471c65..f7322d87095f 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -542,15 +542,6 @@
 		status = "disabled";
 	};
 
-	pwm: pwm at 12dd0000 {
-		compatible = "samsung,exynos4210-pwm";
-		reg = <0x12dd0000 0x100>;
-		samsung,pwm-outputs = <0>, <1>, <2>, <3>;
-		#pwm-cells = <3>;
-		clocks = <&clock CLK_PWM>;
-		clock-names = "timers";
-	};
-
 	dp_phy: dp-video-phy {
 		compatible = "samsung,exynos5420-dp-video-phy";
 		samsung,pmu-syscon = <&pmu_system_controller>;
@@ -823,11 +814,6 @@
 		interrupt-parent = <&gic>;
 	};
 
-	sysreg_system_controller: syscon at 10050000 {
-		compatible = "samsung,exynos5-sysreg", "syscon";
-		reg = <0x10050000 0x5000>;
-	};
-
 	tmu_cpu0: tmu at 10060000 {
 		compatible = "samsung,exynos5420-tmu";
 		reg = <0x10060000 0x100>;
@@ -1207,6 +1193,11 @@
 	iommu-names = "m0", "m1";
 };
 
+&pwm {
+	clocks = <&clock CLK_PWM>;
+	clock-names = "timers";
+};
+
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
-- 
2.5.0
