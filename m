From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 17 Dec 2012 23:06:38 -0500
Subject: [PATCH 2/2] ARM: Use implementor and part defines from cputype.h
In-Reply-To: <1355803598-58471-1-git-send-email-c.dall@virtualopensystems.com>
References: <1355803598-58471-1-git-send-email-c.dall@virtualopensystems.com>
Message-ID: <1355803598-58471-2-git-send-email-c.dall@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of decoding implementor numbers, part numbers and Xscale
architecture masks inline in the pmu probing function, use defines
and accessor functions from cputype.h, which can also be shared by
other subsystems, such as KVM.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kernel/perf_event_cpu.c |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 9a4f630..5c59e19 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -201,48 +201,46 @@ static struct platform_device_id __devinitdata cpu_pmu_plat_device_ids[] = {
 static int __devinit probe_current_pmu(struct arm_pmu *pmu)
 {
 	int cpu = get_cpu();
-	unsigned long cpuid = read_cpuid_id();
-	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
-	unsigned long part_number = (cpuid & 0xFFF0);
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
 	int ret = -ENODEV;
 
 	pr_info("probing PMU on CPU %d\n", cpu);
 
 	/* ARM Ltd CPUs. */
-	if (0x41 == implementor) {
+	if (implementor == ARM_CPU_IMP_ARM) {
 		switch (part_number) {
-		case 0xB360:	/* ARM1136 */
-		case 0xB560:	/* ARM1156 */
-		case 0xB760:	/* ARM1176 */
+		case ARM_CPU_PART_ARM1136:
+		case ARM_CPU_PART_ARM1156:
+		case ARM_CPU_PART_ARM1176:
 			ret = armv6pmu_init(pmu);
 			break;
-		case 0xB020:	/* ARM11mpcore */
+		case ARM_CPU_PART_ARM11MPCORE:
 			ret = armv6mpcore_pmu_init(pmu);
 			break;
-		case 0xC080:	/* Cortex-A8 */
+		case ARM_CPU_PART_CORTEX_A8:
 			ret = armv7_a8_pmu_init(pmu);
 			break;
-		case 0xC090:	/* Cortex-A9 */
+		case ARM_CPU_PART_CORTEX_A9:
 			ret = armv7_a9_pmu_init(pmu);
 			break;
-		case 0xC050:	/* Cortex-A5 */
+		case ARM_CPU_PART_CORTEX_A5:
 			ret = armv7_a5_pmu_init(pmu);
 			break;
-		case 0xC0F0:	/* Cortex-A15 */
+		case ARM_CPU_PART_CORTEX_A15:
 			ret = armv7_a15_pmu_init(pmu);
 			break;
-		case 0xC070:	/* Cortex-A7 */
+		case ARM_CPU_PART_CORTEX_A7:
 			ret = armv7_a7_pmu_init(pmu);
 			break;
 		}
 	/* Intel CPUs [xscale]. */
-	} else if (0x69 == implementor) {
-		part_number = (cpuid >> 13) & 0x7;
-		switch (part_number) {
-		case 1:
+	} else if (implementor == ARM_CPU_IMP_INTEL) {
+		switch (xscale_cpu_arch_version()) {
+		case ARM_CPU_XSCALE_ARCH_V1:
 			ret = xscale1pmu_init(pmu);
 			break;
-		case 2:
+		case ARM_CPU_XSCALE_ARCH_V2:
 			ret = xscale2pmu_init(pmu);
 			break;
 		}
-- 
1.7.9.5
