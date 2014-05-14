From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 06:41:14 +0530
Subject: [PATCH v4 6/8] ARM: dts: Exynos: add cpu nodes,
 opp and cpu clock configuration data
In-Reply-To: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1400029876-5830-7-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For all Exynos based platforms, add CPU nodes, operating points and cpu
clock data for migrating from Exynos specific cpufreq driver to using
generic cpufreq-cpu0 driver.

Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts         |    6 +++
 arch/arm/boot/dts/exynos4210-trats.dts          |    6 +++
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +++
 arch/arm/boot/dts/exynos4210.dtsi               |   35 +++++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi               |   18 ++++++++++
 arch/arm/boot/dts/exynos4412-odroidx.dts        |    6 +++
 arch/arm/boot/dts/exynos4412-origen.dts         |    6 +++
 arch/arm/boot/dts/exynos4412-trats2.dts         |    6 +++
 arch/arm/boot/dts/exynos4412.dtsi               |   31 +++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi               |   36 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +++
 arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +++
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +++
 arch/arm/boot/dts/exynos5250.dtsi               |   41 +++++++++++++++++++++++
 14 files changed, 215 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 72fb11f..4324b25 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -32,6 +32,12 @@
 		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck1_reg>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 63aa2bb..7cc0a57 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -30,6 +30,12 @@
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
 	};
 
+	cpus {
+		cpu: cpu at 0 {
+			cpu0-supply = <&varm_breg>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 63e34b2..844f3fb 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -28,6 +28,12 @@
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
 	};
 
+	cpus {
+		cpu: cpu at 0 {
+			cpu0-supply = <&vdd_arm_reg>;
+		};
+	};
+
 	mct at 10050000 {
 		compatible = "none";
 	};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cacf614..22b967d 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -36,6 +36,33 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1200000 1250000
+				1000000 1150000
+				800000	1075000
+				500000	975000
+				400000	975000
+				200000	950000
+			>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
@@ -73,6 +100,14 @@
 		compatible = "samsung,exynos4210-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
+
+		samsung,armclk-cells = <9>;
+		samsung,armclk-divider-table = <1200000 3 7 3 4 1 7 5 0>,
+					       <1000000 3 7 3 4 1 7 4 0>,
+					       < 800000 3 7 3 3 1 7 3 0>,
+					       < 500000 3 7 3 3 1 7 3 0>,
+					       < 400000 3 7 3 3 1 7 3 0>,
+					       < 200000 1 3 1 1 1 0 3 0>;
 	};
 
 	pmu {
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 3c00e6e..87847d5 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,6 +22,24 @@
 / {
 	compatible = "samsung,exynos4212", "samsung,exynos4";
 
+	clock: clock-controller at 10030000 {
+		samsung,armclk-cells = <9>;
+		samsung,armclk-divider-table = <1500000 3 7 0 6 1 2 6 0>,
+					       <1400000 3 7 0 6 1 2 6 0>,
+					       <1300000 3 7 0 5 1 2 5 0>,
+					       <1200000 3 7 0 5 1 2 5 0>,
+					       <1100000 3 6 0 4 1 2 4 0>,
+					       <1000000 2 5 0 4 1 1 4 0>,
+					       < 900000 2 5 0 3 1 1 3 0>,
+					       < 800000 2 5 0 3 1 1 3 0>,
+					       < 700000 2 4 0 3 1 1 3 0>,
+					       < 600000 2 4 0 3 1 1 3 0>,
+					       < 500000 2 4 0 3 1 1 3 0>,
+					       < 400000 2 4 0 3 1 1 3 0>,
+					       < 300000 2 4 0 2 1 1 3 0>,
+					       < 200000 1 3 0 1 1 1 3 0>;
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <18>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 31db28a..4671714 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -22,6 +22,12 @@
 		reg = <0x40000000 0x40000000>;
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck2_reg>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led1 {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e2c0dca..442bf90 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -27,6 +27,12 @@
 		bootargs ="console=ttySAC2,115200";
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck2_reg>;
+		};
+	};
+
 	firmware at 0203F000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0203F000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 9583563..6567c9d 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -31,6 +31,12 @@
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck2_reg>;
+		};
+	};
+
 	firmware at 0204F000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0204F000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 15d3c0a..85005d1 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,6 +22,37 @@
 / {
 	compatible = "samsung,exynos4412", "samsung,exynos4";
 
+	cpus {
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+		};
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <3>;
+		};
+	};
+
+	clock: clock-controller at 10030000 {
+		samsung,armclk-cells = <10>;
+		samsung,armclk-divider-table = <1500000 3 7 0 6 1 2 6 0 7>,
+					       <1400000 3 7 0 6 1 2 6 0 6>,
+					       <1300000 3 7 0 5 1 2 5 0 6>,
+					       <1200000 3 7 0 5 1 2 5 0 5>,
+					       <1100000 3 6 0 4 1 2 4 0 5>,
+					       <1000000 2 5 0 4 1 1 4 0 4>,
+					       < 900000 2 5 0 3 1 1 3 0 4>,
+					       < 800000 2 5 0 3 1 1 3 0 3>,
+					       < 700000 2 4 0 3 1 1 3 0 3>,
+					       < 600000 2 4 0 3 1 1 3 0 2>,
+					       < 500000 2 4 0 3 1 1 3 0 2>,
+					       < 400000 2 4 0 3 1 1 3 0 1>,
+					       < 300000 2 4 0 2 1 1 3 0 1>,
+					       < 200000 1 3 0 1 1 1 3 0 0>;
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <20>;
 	};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c4a9306..09a86e7 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -31,6 +31,42 @@
 		mshc0 = &mshc_0;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1500000 1350000
+				1400000 1287500
+				1300000 1250000
+				1200000 1187500
+				1100000 1137500
+				1000000 1087500
+				 900000 1037500
+				 800000 1000000
+				 700000  987500
+				 600000  975000
+				 500000  950000
+				 400000  925000
+				 300000  900000
+				 200000  900000
+			>;
+			clock-latency = <200000>;
+			boost-frequency = <1500000>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 090f983..443c0d3 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -25,6 +25,12 @@
 		bootargs = "console=ttySAC2,115200";
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck2_reg>;
+		};
+	};
+
 	rtc at 101E0000 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..4bde756 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -19,6 +19,12 @@
 	chosen {
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck2_reg>;
+		};
+	};
+
 	pinctrl at 11400000 {
 		/*
 		 * Disabled pullups since external part has its own pullups and
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a794a70..3632f7a 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -27,6 +27,12 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
 	};
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&buck2_reg>;
+		};
+	};
+
 	rtc at 101E0000 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..f59f8a9 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -63,6 +63,29 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1700000 1300000
+				1600000 1250000
+				1500000 1225000
+				1400000 1200000
+				1300000 1150000
+				1200000 1125000
+				1100000 1100000
+				1000000 1075000
+				 900000 1050000
+				 800000 1025000
+				 700000 1012500
+				 600000 1000000
+				 500000  975000
+				 400000  950000
+				 300000  937500
+				 200000  925000
+			>;
+			clock-latency = <200000>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
@@ -86,6 +109,24 @@
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
+
+		samsung,armclk-cells = <9>;
+		samsung,armclk-divider-table = <1700000 3 7 7 7 3 5 0 2>,
+					       <1600000 3 7 7 7 1 4 0 2>,
+					       <1500000 2 7 7 7 1 4 0 2>,
+					       <1400000 2 7 7 6 1 4 0 2>,
+					       <1300000 2 7 7 6 1 3 0 2>,
+					       <1200000 2 7 7 5 1 3 0 2>,
+					       <1100000 3 7 7 5 1 3 0 2>,
+					       <1000000 1 7 7 4 1 2 0 2>,
+					       < 900000 1 7 7 4 1 2 0 2>,
+					       < 800000 1 7 7 4 1 2 0 2>,
+					       < 700000 1 7 7 3 1 1 0 2>,
+					       < 600000 1 7 7 3 1 1 0 2>,
+					       < 500000 1 7 7 2 1 1 0 2>,
+					       < 400000 1 7 7 2 1 1 0 2>,
+					       < 300000 1 7 7 1 1 1 0 2>,
+					       < 200000 1 7 7 1 1 1 0 2>;
 	};
 
 	clock_audss: audss-clock-controller at 3810000 {
-- 
1.7.4.4
