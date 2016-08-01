From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  1 Aug 2016 10:54:16 +0100
Subject: [PATCH v2 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <1470045256-9032-1-git-send-email-marc.zyngier@arm.com>
References: <1470045256-9032-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1470045256-9032-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architected timer specification mandates that the interrupt
associated with each timer is level triggered (which corresponds to
the "counter >= comparator" condition).

A number of DTs are being remarkably creative, declaring the interrupt
to be edge triggered. A quick look at the TRM for the corresponding ARM
CPUs clearly shows that this is wrong, and I've corrected those.
For non-ARM designs (and in the absence of a publicly available TRM),
I've made them active low as well, which can't be completely wrong
as the GIC cannot disinguish between level low and level high.

The respective maintainers are of course welcome to prove me wrong.

While I was at it, I took the liberty to fix a couple of related issue,
such as some spurious affinity bits on ThunderX, and their complete
absence on ls1043a (both of which seem to be related to copy-pasting
from other DTs).

Acked-by: Duc Dang <dhdang@apm.com>
Acked-by: Carlo Caione <carlo@endlessm.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 8 ++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 8 ++++----
 arch/arm64/boot/dts/apm/apm-storm.dtsi               | 8 ++++----
 arch/arm64/boot/dts/broadcom/ns2.dtsi                | 8 ++++----
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 8 ++++----
 arch/arm64/boot/dts/exynos/exynos7.dtsi              | 8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 8 ++++----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 8 ++++----
 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi               | 8 ++++----
 11 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 445aa67..c2b9bcb 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -255,10 +255,10 @@
 		/* Local timer */
 		timer {
 			compatible = "arm,armv8-timer";
-			interrupts = <1 13 0xf01>,
-				     <1 14 0xf01>,
-				     <1 11 0xf01>,
-				     <1 10 0xf01>;
+			interrupts = <1 13 0xf08>,
+				     <1 14 0xf08>,
+				     <1 11 0xf08>,
+				     <1 10 0xf08>;
 		};
 
 		timer0: timer0 at ffc03000 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..4d9d144 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -100,13 +100,13 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>;
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	xtal: xtal-clk {
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 6bf7cbe..010e961 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -110,10 +110,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 0 0xff01>,	/* Secure Phys IRQ */
-			     <1 13 0xff01>,	/* Non-secure Phys IRQ */
-			     <1 14 0xff01>,	/* Virt IRQ */
-			     <1 15 0xff01>;	/* Hyp IRQ */
+		interrupts = <1 0 0xff08>,	/* Secure Phys IRQ */
+			     <1 13 0xff08>,	/* Non-secure Phys IRQ */
+			     <1 14 0xff08>,	/* Virt IRQ */
+			     <1 15 0xff08>;	/* Hyp IRQ */
 		clock-frequency = <50000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 46b78fa..01b4ee9 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -88,13 +88,13 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) |
-			      IRQ_TYPE_EDGE_RISING)>,
+			      IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) |
-			      IRQ_TYPE_EDGE_RISING)>,
+			      IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) |
-			      IRQ_TYPE_EDGE_RISING)>,
+			      IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) |
-			      IRQ_TYPE_EDGE_RISING)>;
+			      IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
index 2eb9b22..04dc8a8 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
@@ -354,10 +354,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xff01>,
-		             <1 14 0xff01>,
-		             <1 11 0xff01>,
-		             <1 10 0xff01>;
+		interrupts = <1 13 4>,
+		             <1 14 4>,
+		             <1 11 4>,
+		             <1 10 4>;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ca663df..1628315 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -473,10 +473,10 @@
 
 		timer {
 			compatible = "arm,armv8-timer";
-			interrupts = <1 13 0xff01>,
-				     <1 14 0xff01>,
-				     <1 11 0xff01>,
-				     <1 10 0xff01>;
+			interrupts = <1 13 0xff08>,
+				     <1 14 0xff08>,
+				     <1 11 0xff08>,
+				     <1 10 0xff08>;
 		};
 
 		pmu_system_controller: system-controller at 105c0000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 6bd46c1..59b7b76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -111,10 +111,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0x1>, /* Physical Secure PPI */
-			     <1 14 0x1>, /* Physical Non-Secure PPI */
-			     <1 11 0x1>, /* Virtual PPI */
-			     <1 10 0x1>; /* Hypervisor PPI */
+		interrupts = <1 13 0xf08>, /* Physical Secure PPI */
+			     <1 14 0xf08>, /* Physical Non-Secure PPI */
+			     <1 11 0xf08>, /* Virtual PPI */
+			     <1 10 0xf08>; /* Hypervisor PPI */
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 3187c82..675c1ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -167,10 +167,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0x8>, /* Physical Secure PPI, active-low */
-			     <1 14 0x8>, /* Physical Non-Secure PPI, active-low */
-			     <1 11 0x8>, /* Virtual PPI, active-low */
-			     <1 10 0x8>; /* Hypervisor PPI, active-low */
+		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
+			     <1 14 4>, /* Physical Non-Secure PPI, active-low */
+			     <1 11 4>, /* Virtual PPI, active-low */
+			     <1 10 4>; /* Hypervisor PPI, active-low */
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 20d256b..b1d6bb8 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -122,10 +122,10 @@
 
 			timer {
 				compatible = "arm,armv8-timer";
-				interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>,
-					     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>,
-					     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>,
-					     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+				interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+					     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 			};
 
 			odmi: odmi at 300000 {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index 9532880..c6059aa 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -127,10 +127,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xf01>,
-			     <1 14 0xf01>,
-			     <1 11 0xf01>,
-			     <1 10 0xf01>;
+		interrupts = <1 13 4>,
+			     <1 14 4>,
+			     <1 11 4>,
+			     <1 10 4>;
 	};
 
 	soc {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index e595f22..3e2e51f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -65,10 +65,10 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-		interrupts = <1 13 0xf01>,
-			     <1 14 0xf01>,
-			     <1 11 0xf01>,
-			     <1 10 0xf01>;
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
 	};
 
 	amba_apu {
-- 
2.1.4
