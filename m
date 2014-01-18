From: ta.omasab@gmail.com (Thomas Abraham)
Date: Sat, 18 Jan 2014 17:40:54 +0530
Subject: [PATCH v2 4/7] ARM: dts: Exynos: add cpu nodes,
 opp and cpu clock frequency table
In-Reply-To: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1390047057-2239-5-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For all Exynos based platforms, add CPU nodes, operating points and cpu
clock frequency table for migrating from Exynos specific cpufreq driver
to using generic cpufreq-cpu0 driver.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts         |    6 +++
 arch/arm/boot/dts/exynos4210-trats.dts          |    6 +++
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +++
 arch/arm/boot/dts/exynos4210.dtsi               |   35 ++++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi               |   17 +++++++++
 arch/arm/boot/dts/exynos4412-odroidx.dts        |    6 +++
 arch/arm/boot/dts/exynos4412-origen.dts         |    6 +++
 arch/arm/boot/dts/exynos4412-trats2.dts         |    6 +++
 arch/arm/boot/dts/exynos4412.dtsi               |   30 ++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi               |   35 ++++++++++++++++++
 arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +++
 arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +++
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +++
 arch/arm/boot/dts/exynos5250.dtsi               |   43 ++++++++++++++++++++++-
 14 files changed, 213 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 2aa13cb..dd17e93 100644
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
index 63cc571..25487d7 100644
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
index d2e3f5f..74d5a70 100644
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
index 48ecd7a..40cd663 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -36,6 +36,34 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clocks = <&clock 12>;
+			clock-names = "cpu";
+
+			operating-points = <
+				200000	950000
+				400000	975000
+				500000	975000
+				800000	1075000
+				1000000	1150000
+				1200000	1250000
+			>;
+			safe-opp = <800000 1075000>;
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
@@ -73,6 +101,13 @@
 		compatible = "samsung,exynos4210-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
+
+		arm-frequency-table = <1200000 1200000 0 3 7 3 4 1 7 0 5 0 0>,
+				      <1000000 1000000 0 3 7 3 4 1 7 0 4 0 0>,
+				      < 800000  800000 0 3 7 3 3 1 7 0 3 0 0>,
+				      < 500000  500000 0 3 7 3 3 1 7 0 3 0 0>,
+				      < 400000  400000 0 3 7 3 3 1 7 0 3 0 0>,
+				      < 200000  200000 0 1 3 1 1 1 0 0 3 0 0>;
 	};
 
 	pmu {
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 94a43f9..2ea0f83 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,6 +22,23 @@
 / {
 	compatible = "samsung,exynos4212";
 
+	clock: clock-controller at 10030000 {
+		arm-frequency-table = <1500000 1500000 0 3 7 0 6 1 2 0 6 2 0>,
+				      <1400000 1400000 0 3 7 0 6 1 2 0 6 2 0>,
+				      <1300000 1300000 0 3 7 0 5 1 2 0 5 2 0>,
+				      <1200000 1200000 0 3 7 0 5 1 2 0 5 2 0>,
+				      <1100000 1100000 0 3 6 0 4 1 2 0 4 2 0>,
+				      <1000000 1000000 0 2 5 0 4 1 1 0 4 2 0>,
+				      < 900000  900000 0 2 5 0 3 1 1 0 3 2 0>,
+				      < 800000  800000 0 2 5 0 3 1 1 0 3 2 0>,
+				      < 700000  700000 0 2 4 0 3 1 1 0 3 2 0>,
+				      < 600000  600000 0 2 4 0 3 1 1 0 3 2 0>,
+				      < 500000  500000 0 2 4 0 3 1 1 0 3 2 0>,
+				      < 400000  400000 0 2 4 0 3 1 1 0 3 2 0>,
+				      < 300000  300000 0 2 4 0 2 1 1 0 3 2 0>,
+				      < 200000  200000 0 1 3 0 1 1 1 0 3 2 0>;
+	};
+
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 12459b0..1c751f9 100644
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
index 388f035..36080e5 100644
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
index 4f851cc..4a4d446 100644
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
index 87b339c..7e9eca7 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,6 +22,36 @@
 / {
 	compatible = "samsung,exynos4412";
 
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
+		arm-frequency-table = <1500000 1500000 0 3 7 0 6 1 2 0 6 0 7>,
+				      <1400000 1400000 0 3 7 0 6 1 2 0 6 0 6>,
+				      <1300000 1300000 0 3 7 0 5 1 2 0 5 0 6>,
+				      <1200000 1200000 0 3 7 0 5 1 2 0 5 0 5>,
+				      <1100000 1100000 0 3 6 0 4 1 2 0 4 0 5>,
+				      <1000000 1000000 0 2 5 0 4 1 1 0 4 0 4>,
+				      < 900000  900000 0 2 5 0 3 1 1 0 3 0 4>,
+				      < 800000  800000 0 2 5 0 3 1 1 0 3 0 3>,
+				      < 700000  700000 0 2 4 0 3 1 1 0 3 0 3>,
+				      < 600000  600000 0 2 4 0 3 1 1 0 3 0 2>,
+				      < 500000  500000 0 2 4 0 3 1 1 0 3 0 2>,
+				      < 400000  400000 0 2 4 0 3 1 1 0 3 0 1>,
+				      < 300000  300000 0 2 4 0 2 1 1 0 3 0 1>,
+				      < 200000  200000 0 1 3 0 1 1 1 0 3 0 0>;
+	};
+
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x4000>;
 	};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 5c412aa..47e2195 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -31,6 +31,41 @@
 		mshc0 = &mshc_0;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clocks = <&clock 12>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1400000 1350000
+				1300000 1287500
+				1200000 1250000
+				1100000 1187500
+				1000000 1137500
+				 900000 1087500
+				 800000 1037500
+				 700000 1000000
+				 600000  987500
+				 500000  950000
+				 400000  925000
+				 300000  900000
+				 200000  900000
+			>;
+			clock-latency = <200000>;
+			safe-opp = <800000 1037500>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
 	pd_isp: isp-power-domain at 10023CA0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CA0 0x20>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index b42e658..4716eef 100644
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
 	codec at 11000000 {
 		samsung,mfc-r = <0x43000000 0x800000>;
 		samsung,mfc-l = <0x51000000 0x800000>;
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
index 5c1b7d9..7c228e2 100644
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
 	i2c at 12C60000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b7dec41..d2f98dc 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -61,6 +61,30 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+
+			clocks = <&clock 12>;
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
+			safe-opp = <800000 1025000>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
@@ -84,7 +108,24 @@
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
-	};
+
+		arm-frequency-table = <1700000 1700000 0 3 7 7 7 3 5 0 0 2 0>,
+				      <1600000 1600000 0 3 7 7 7 1 4 0 0 2 0>,
+				      <1500000 1500000 0 2 7 7 7 1 4 0 0 2 0>,
+				      <1400000 1400000 0 2 7 7 6 1 4 0 0 2 0>,
+				      <1300000 1300000 0 2 7 7 6 1 3 0 0 2 0>,
+				      <1200000 1200000 0 2 7 7 5 1 3 0 0 2 0>,
+				      <1100000 1100000 0 3 7 7 5 1 3 0 0 2 0>,
+				      <1000000 1000000 0 1 7 7 4 1 2 0 0 2 0>,
+				      < 900000  900000 0 1 7 7 4 1 2 0 0 2 0>,
+				      < 800000  800000 0 1 7 7 4 1 2 0 0 2 0>,
+				      < 700000  700000 0 1 7 7 3 1 1 0 0 2 0>,
+				      < 600000  600000 0 1 7 7 3 1 1 0 0 2 0>,
+				      < 500000  500000 0 1 7 7 2 1 1 0 0 2 0>,
+				      < 400000  400000 0 1 7 7 2 1 1 0 0 2 0>,
+				      < 300000  300000 0 1 7 7 1 1 1 0 0 2 0>,
+				      < 200000  200000 0 1 7 7 1 1 1 0 0 2 0>;
+	};
 
 	clock_audss: audss-clock-controller at 3810000 {
 		compatible = "samsung,exynos5250-audss-clock";
-- 
1.6.6.rc2
