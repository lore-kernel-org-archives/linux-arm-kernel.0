From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 17 Jun 2014 20:55:31 +0530
Subject: [PATCH v6 4/6] ARM: dts: Exynos: add cpu nodes,
 opp and cpu clock configuration data
In-Reply-To: <1403018733-4187-1-git-send-email-thomas.ab@samsung.com>
References: <1403018733-4187-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1403018733-4187-6-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos 4210/5250/5420 based platforms, add CPU nodes, operating points and
cpu clock data for migrating from Exynos specific cpufreq driver to using
generic cpufreq drivers.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts         |    6 +++++
 arch/arm/boot/dts/exynos4210-trats.dts          |    6 +++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +++++
 arch/arm/boot/dts/exynos4210.dtsi               |   27 +++++++++++++++++++
 arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +++++
 arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +++++
 arch/arm/boot/dts/exynos5250.dtsi               |   23 ++++++++++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    6 +++++
 arch/arm/boot/dts/exynos5420.dtsi               |   32 +++++++++++++++++++++++
 10 files changed, 124 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index f767c42..49a97fc 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -33,6 +33,12 @@
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
index f516da9..fe32b6a 100644
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
index d50eb3a..8ab12d6 100644
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
 	sysram at 02020000 {
 		smp-sysram at 0 {
 			status = "disabled";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ee3001f..c3a73bf 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -31,6 +31,33 @@
 		pinctrl2 = &pinctrl_2;
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
 	sysram at 02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x20000>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index d0de1f5..d9b803b 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -26,6 +26,12 @@
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
index 89ac90f..34bb31c 100644
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
index 834fb5a..66b0f98 100644
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
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6052aa9..084e587 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -24,6 +24,12 @@
 		bootargs = "console=ttySAC2,115200 init=/linuxrc";
 	};
 
+	cpus {
+		cpu at 4 {
+			cpu0-supply = <&buck6_reg>;
+		};
+	};
+
 	fixed-rate-clocks {
 		oscclk {
 			compatible = "samsung,exynos5420-oscclk";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e385322..3baee7f 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -59,8 +59,26 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu-cluster.0";
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			clock-latency = <200000>;
+
+			operating-points = <
+				1800000 1250000
+				1700000 1212500
+				1600000 1175000
+				1500000 1137500
+				1400000 1112500
+				1300000 1062500
+				1200000 1037500
+				1100000 1012500
+				1000000 987500
+				 900000 962500
+				 800000 937500
+				 700000 912500
+			>;
 		};
 
 		cpu1: cpu at 1 {
@@ -91,8 +109,22 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
+			clocks = <&clock CLK_KFC_CLK>;
+			clock-names = "cpu-cluster.1";
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			clock-latency = <200000>;
+
+			operating-points = <
+				1300000 1275000
+				1200000 1212500
+				1100000 1162500
+				1000000 1112500
+				 900000 1062500
+				 800000 1025000
+				 700000 975000
+				 600000 937500
+			>;
 		};
 
 		cpu5: cpu at 101 {
-- 
1.7.9.5
