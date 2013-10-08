From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 15:47:40 +0800
Subject: [PATCH] ARM: tegra: add clock properties for devices of Tegra124
Message-ID: <1381218460-23123-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock properties for devices in the DT for basic support
of Tegra124 SoC.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
This patch was based on the series of Tegra124 clock driver and the basic
support of Tegra124. It coulud be used to replace the "HACK" patch in the
basic support of Tegra124 series.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 13 +++++++++++++
 arch/arm/boot/dts/tegra124.dtsi        | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 2bfc7ab..5859ec2 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -17,4 +17,17 @@
 	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 905f148..7862024 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/clock/tegra124-car.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -27,6 +28,13 @@
 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_TIMER>;
+	};
+
+	tegra_car: clock at 60006000 {
+		compatible = "nvidia,tegra124-car";
+		reg = <0x60006000 0x1000>;
+		#clock-cells = <1>;
 	};
 
 	/*
@@ -43,6 +51,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA124_CLK_UARTA>;
 	};
 
 	serial at 70006040 {
@@ -51,6 +60,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA124_CLK_UARTB>;
 	};
 
 	serial at 70006200 {
@@ -59,6 +69,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA124_CLK_UARTC>;
 	};
 
 	serial at 70006300 {
@@ -67,6 +78,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA124_CLK_UARTD>;
 	};
 
 	serial at 70006400 {
@@ -75,6 +87,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA124_CLK_UARTE>;
 	};
 
 	rtc at 7000e000 {
@@ -82,11 +95,14 @@
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA124_CLK_RTC>;
 	};
 
 	pmc at 7000e400 {
 		compatible = "nvidia,tegra124-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
 	};
 
 	cpus {
-- 
1.8.4
