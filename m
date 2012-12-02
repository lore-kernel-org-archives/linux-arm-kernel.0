From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat,  1 Dec 2012 19:21:26 -0500
Subject: [PATCH v6] ARM: Factor out cpuid implementor and part number
Message-ID: <1354407686-38366-1-git-send-email-c.dall@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Decoding the implementor and part number of the CPU id in the CPU ID
register is needed by KVM, so we factor it out to share the code.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
Changes since v5:
 - (OK, this is getting ridiculous, this time I forgot a git add):
   incorrect function declaration
Changes since v4:
 - Properly decode XScale cpu architecture versions
Changes since v3:
 - Only call read_cpuid_part_number once and squash warning
Changes since v2:
 - Take implementor as argument to read_cpuid_part_number
Changes since v1:
 - Accidentally pointed to an old file, this one has more consistent
   naming of the cpu implementor and part number defines.

 arch/arm/include/asm/cputype.h   |   33 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/perf_event_cpu.c |   34 ++++++++++++++++------------------
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb47d28..8c83961 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -51,6 +51,24 @@ extern unsigned int processor_id;
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
+#define ARM_CPU_XSCALE_ARCH_MASK	0xe000
+#define ARM_CPU_XSCALE_ARCH_V1		0x2000
+#define ARM_CPU_XSCALE_ARCH_V2		0x4000
+#define ARM_CPU_XSCALE_ARCH_V3		0x6000
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
@@ -61,6 +79,21 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
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
+static inline unsigned int __attribute_const__ xscale_cpu_arch_version(void)
+{
+	return read_cpuid_part_number() &ARM_CPU_XSCALE_ARCH_MASK;
+}
+
 static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CPUID_CACHETYPE);
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
