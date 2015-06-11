From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Jun 2015 17:15:31 +0100
Subject: [PATCH] arm: dts: vexpress: describe all PMUs in TC2 dts
Message-ID: <1434039331-14504-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dts for the CoreTile Express A15x2 A7x3 (TC2) only describes the
PMUs of the Cortex-A15 CPUs, and not the Cortex-A7 CPUs.

Now that we have a mechanism for describing disparate PMUs and their
interrupts in device tree, this patch makes use of these to describe the
PMUs for all CPUs in the system. For consistency, the existing A15 PMU
interrupt-affinity property is reflowed across two lines.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

This was previously posted along with the corresponding support code [1], which
is now queued in Will's perf/updates branch [2], for v4.2. I've rebased it atop
of Sudeep's interrupt-affinity addition, but otherwise it's identical.

Liviu, Lorenzo, Sudeep, are you happy to ack this and/or queue it up to follow
the support code?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343144.html
[2] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/log/?h=perf/updates

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 107395c..038e30e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -187,11 +187,22 @@
 			     <1 10 0xf08>;
 	};
 
-	pmu {
+	pmu_a15 {
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
-		interrupt-affinity = <&cpu0>, <&cpu1>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>;
+	};
+
+	pmu_a7 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 128 4>,
+			     <0 129 4>,
+			     <0 130 4>;
+		interrupt-affinity = <&cpu2>,
+				     <&cpu3>,
+				     <&cpu4>;
 	};
 
 	oscclk6a: oscclk6a {
-- 
1.9.1
