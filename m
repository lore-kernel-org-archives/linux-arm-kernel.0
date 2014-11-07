From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  7 Nov 2014 16:25:36 +0000
Subject: [PATCH 11/11] arm: dts: vexpress: describe all PMUs in TC2 dts
In-Reply-To: <1415377536-12841-1-git-send-email-mark.rutland@arm.com>
References: <1415377536-12841-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1415377536-12841-12-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dts for the CoreTile Express A15x2 A7x3 (TC2) only describes the
PMUs of the Cortex-A15 CPUs, and not the Cortex-A7 CPUs.

Now that we have a mechanism for describing disparate PMUs and their
interrupts in device tree, this patch makes use of these to describe the
PMUs for all CPUs in the system.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 36 +++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 322fd15..52416f9 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -90,6 +90,28 @@
 				min-residency-us = <2500>;
 			};
 		};
+
+		cpu-map {
+			cluster0 {
+				core_0_0: core0 {
+					cpu = <&cpu0>;
+				};
+				core_0_1: core1 {
+					cpu = <&cpu1>;
+				};
+			};
+			cluster1 {
+				core_1_0: core0 {
+					cpu = <&cpu2>;
+				};
+				core_1_1: core1 {
+					cpu = <&cpu3>;
+				};
+				core_1_2: core2 {
+					cpu = <&cpu4>;
+				};
+			};
+		};
 	};
 
 	memory at 80000000 {
@@ -187,10 +209,22 @@
 			     <1 10 0xf08>;
 	};
 
-	pmu {
+	pmu_a15 {
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
+		interrupts-affinity = <&core_0_0>,
+				      <&core_0_1>;
+	};
+
+	pmu_a7 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 128 4>,
+			     <0 129 4>,
+			     <0 130 4>;
+		interrupts-affinity = <&core_1_0>,
+				      <&core_1_1>,
+				      <&core_1_2>;
 	};
 
 	oscclk6a: oscclk6a {
-- 
1.9.1
