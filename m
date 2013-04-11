From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:42 +0100
Subject: [RFC PATCH 11/11] arm: dts: add all PMUs for A15x2 A7x3 coretile
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-12-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we only describe the A15 PMUs, as previously it was not
possible to describe the A7 PMUs.

This patch adds a cpu-map node and interrupts-affinity information
for the PMUs to the dts, enabling the use of both PMUs. It also
corrects the unit addresses of the cpu nodes, which should match
their reg properties. As the A15 PMU has different events than the
A9 PMU, this patch also removes the "arm,cortex-a9-pmu" compatible
string from the dts.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 44 ++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index dfe371e..4117b1b 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -45,25 +45,47 @@
 			reg = <1>;
 		};
 
-		cpu2: cpu at 2 {
+		cpu2: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 		};
 
-		cpu3: cpu at 3 {
+		cpu3: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 		};
 
-		cpu4: cpu at 4 {
+		cpu4: cpu at 102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 		};
 	};
 
+	cpu-map {
+		cluster0 {
+			core0_0: core0 {
+				cpu = <&cpu0>;
+			};
+			core0_1: core1 {
+				cpu = <&cpu1>;
+			};
+		};
+		cluster1 {
+			core1_0: core0 {
+				cpu = <&cpu2>;
+			};
+			core1_1: core1 {
+				cpu = <&cpu3>;
+			};
+			core1_2: core2 {
+				cpu = <&cpu4>;
+			};
+		};
+	};
+
 	memory at 80000000 {
 		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
@@ -133,10 +155,22 @@
 			     <1 10 0xf08>;
 	};
 
-	pmu {
-		compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
+	pmu_a15s {
+		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
+		interrupts-affinity = <&core0_0>,
+				      <&core0_1>;
+	};
+
+	pmu_a7s {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 128 4>,
+			     <0 129 4>,
+			     <0 130 4>;
+		interrupts-affinity = <&core1_0>,
+				      <&core1_1>,
+				      <&core1_2>;
 	};
 
 	oscclk6a: oscclk6a {
-- 
1.8.1.1
