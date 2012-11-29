From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 29 Nov 2012 14:56:29 -0500
Subject: [PATCH v2] ARM: Factor out cpuid implementor and part number
Message-ID: <1354218989-43729-1-git-send-email-c.dall@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Decoding the implementor and part number of the CPU id in the CPU ID
register is needed by KVM, so we factor it out to share the code.

Changes since v1:
 - Accidentally pointed to an old file, this one has more consistent
   naming of the cpu implementor and part number defines.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
Applies to Will Deacon's perf/updates branch

 arch/arm/include/asm/cputype.h   |   26 ++++++++++++++++++++++++++
 arch/arm/kernel/perf_event_cpu.c |   30 +++++++++++++++---------------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb47d28..a848630 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -51,6 +51,22 @@ extern unsigned int processor_id;
 #define read_cpuid_ext(reg) 0
 #endif
 
+#define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_INTEL		0x69
+
+#define ARM_CPU_PART_ARM1136		0xB360
+#define ARM_CPU_PART_ARM1156		0xB560
+#define ARM_CPU_PART_ARM1176		0xB760
+#define ARM_CPU_PART_ARM11MPCORE	0xB020
+#define ARM_CPU_PART_CORTEX_A8		0xC080
+#define ARM_CPU_PART_CORTEX_A9 		0xC090
+#define ARM_CPU_PART_CORTEX_A5 		0xC050
+#define ARM_CPU_PART_CORTEX_A15		0xC0F0
+#define ARM_CPU_PART_CORTEX_A7		0xC070
+
+#define ARM_CPU_PART_XSCALE1		0x1
+#define ARM_CPU_PART_XSCALE2		0x2
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
@@ -61,6 +77,16 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 	return read_cpuid(CPUID_ID);
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
+{
+	return (read_cpuid_id() & 0xFF000000) >> 24;
+}
+
+static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
+{
+	return (read_cpuid_id() & 0xFFF0);
+}
+
 static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CPUID_CACHETYPE);
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 9a4f630..c680de8 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -202,47 +202,47 @@ static int __devinit probe_current_pmu(struct arm_pmu *pmu)
 {
 	int cpu = get_cpu();
 	unsigned long cpuid = read_cpuid_id();
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
+	} else if (implementor == ARM_CPU_IMP_INTEL) {
 		part_number = (cpuid >> 13) & 0x7;
 		switch (part_number) {
-		case 1:
+		case ARM_CPU_PART_XSCALE1:
 			ret = xscale1pmu_init(pmu);
 			break;
-		case 2:
+		case ARM_CPU_PART_XSCALE2:
 			ret = xscale2pmu_init(pmu);
 			break;
 		}
-- 
1.7.9.5
