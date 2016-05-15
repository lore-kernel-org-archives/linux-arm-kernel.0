From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 May 2016 22:13:49 +0200
Subject: [PATCH v4 08/22] ARM: dts: exynos: Move common nodes to exynos5.dtsi
In-Reply-To: <1463343243-26429-1-git-send-email-krzk@kernel.org>
References: <1463343243-26429-1-git-send-email-krzk@kernel.org>
Message-ID: <1463343243-26429-9-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 and Exynos5250 share some nodes: the PWM, syscon
(sysreg_system_controller) and first four I2C controllers. Move them to
parent DTSI to avoid duplication.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Important changes since v2:
1. Move also i2c[0123] to exynos5.dtsi.
---
 arch/arm/boot/dts/exynos5.dtsi    |  56 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 108 ++++++++++++--------------------------
 arch/arm/boot/dts/exynos5420.dtsi | 108 ++++++++++++--------------------------
 3 files changed, 124 insertions(+), 148 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index d5c0f18a4223..c5d198c70b86 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -20,6 +20,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
+		i2c2 = &i2c_2;
+		i2c3 = &i2c_3;
 		serial0 = &serial_0;
 		serial1 = &serial_1;
 		serial2 = &serial_2;
@@ -63,6 +67,11 @@
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
@@ -87,6 +96,53 @@
 		interrupts = <0 54 0>;
 	};
 
+	i2c_0: i2c at 12C60000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C60000 0x100>;
+		interrupts = <0 56 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
+		status = "disabled";
+	};
+
+	i2c_1: i2c at 12C70000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C70000 0x100>;
+		interrupts = <0 57 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
+		status = "disabled";
+	};
+
+	i2c_2: i2c at 12C80000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C80000 0x100>;
+		interrupts = <0 58 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
+		status = "disabled";
+	};
+
+	i2c_3: i2c at 12C90000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C90000 0x100>;
+		interrupts = <0 59 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
+		status = "disabled";
+	};
+
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
index c7158b2fb213..ae4970d1c74f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -37,10 +37,6 @@
 		mshc1 = &mmc_1;
 		mshc2 = &mmc_2;
 		mshc3 = &mmc_3;
-		i2c0 = &i2c_0;
-		i2c1 = &i2c_1;
-		i2c2 = &i2c_2;
-		i2c3 = &i2c_3;
 		i2c4 = &i2c_4;
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
@@ -235,11 +231,6 @@
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
@@ -328,62 +319,7 @@
 		status = "disabled";
 	};
 
-	i2c_0: i2c at 12C60000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C60000 0x100>;
-		interrupts = <0 56 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C0>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c0_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
-	i2c_1: i2c at 12C70000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C70000 0x100>;
-		interrupts = <0 57 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C1>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
-	i2c_2: i2c at 12C80000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C80000 0x100>;
-		interrupts = <0 58 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C2>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
-	i2c_3: i2c at 12C90000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C90000 0x100>;
-		interrupts = <0 59 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C3>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c3_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
+	/* i2c_0-3 are defined in exynos5.dtsi */
 	i2c_4: i2c at 12CA0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CA0000 0x100>;
@@ -662,15 +598,6 @@
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
@@ -1070,6 +997,39 @@
 	iommus = <&sysmmu_fimd1>;
 };
 
+&i2c_0 {
+	clocks = <&clock CLK_I2C0>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_bus>;
+};
+
+&i2c_1 {
+	clocks = <&clock CLK_I2C1>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_bus>;
+};
+
+&i2c_2 {
+	clocks = <&clock CLK_I2C2>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_bus>;
+};
+
+&i2c_3 {
+	clocks = <&clock CLK_I2C3>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_bus>;
+};
+
+&pwm {
+	clocks = <&clock CLK_PWM>;
+	clock-names = "timers";
+};
+
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 549ebf23fee0..f2e8e6482888 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -30,10 +30,6 @@
 		pinctrl2 = &pinctrl_2;
 		pinctrl3 = &pinctrl_3;
 		pinctrl4 = &pinctrl_4;
-		i2c0 = &i2c_0;
-		i2c1 = &i2c_1;
-		i2c2 = &i2c_2;
-		i2c3 = &i2c_3;
 		i2c4 = &hsi2c_4;
 		i2c5 = &hsi2c_5;
 		i2c6 = &hsi2c_6;
@@ -542,15 +538,6 @@
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
@@ -588,62 +575,7 @@
 		status = "disabled";
 	};
 
-	i2c_0: i2c at 12C60000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C60000 0x100>;
-		interrupts = <0 56 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C0>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c0_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
-	i2c_1: i2c at 12C70000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C70000 0x100>;
-		interrupts = <0 57 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C1>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
-	i2c_2: i2c at 12C80000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C80000 0x100>;
-		interrupts = <0 58 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C2>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
-	i2c_3: i2c at 12C90000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C90000 0x100>;
-		interrupts = <0 59 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clock CLK_I2C3>;
-		clock-names = "i2c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c3_bus>;
-		samsung,sysreg-phandle = <&sysreg_system_controller>;
-		status = "disabled";
-	};
-
+	/* i2c_0-3 are defined in exynos5.dtsi */
 	hsi2c_4: i2c at 12CA0000 {
 		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12CA0000 0x1000>;
@@ -823,11 +755,6 @@
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
@@ -1207,6 +1134,39 @@
 	iommu-names = "m0", "m1";
 };
 
+&i2c_0 {
+	clocks = <&clock CLK_I2C0>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_bus>;
+};
+
+&i2c_1 {
+	clocks = <&clock CLK_I2C1>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_bus>;
+};
+
+&i2c_2 {
+	clocks = <&clock CLK_I2C2>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_bus>;
+};
+
+&i2c_3 {
+	clocks = <&clock CLK_I2C3>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_bus>;
+};
+
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
