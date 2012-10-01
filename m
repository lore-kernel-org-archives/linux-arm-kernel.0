From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:10:20 -0400
Subject: [PATCH v2 03/14] ARM: Factor out cpuid implementor and part number
In-Reply-To: <20121001090945.49198.68950.stgit@ubuntu>
References: <20121001090945.49198.68950.stgit@ubuntu>
Message-ID: <20121001091020.49198.94718.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Decoding the implementor and part number of the CPU id in the CPU ID
register is needed by KVM, so we factor it out to share the code.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/cputype.h |   26 ++++++++++++++++++++++++++
 arch/arm/kernel/perf_event.c   |   30 +++++++++++++++---------------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb47d28..306fb2c 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -51,6 +51,22 @@ extern unsigned int processor_id;
 #define read_cpuid_ext(reg) 0
 #endif
 
+#define IMPLEMENTOR_ARM		0x41
+#define IMPLEMENTOR_INTEL	0x69
+
+#define PART_NUMBER_ARM1136	0xB360
+#define PART_NUMBER_ARM1156	0xB560
+#define PART_NUMBER_ARM1176	0xB760
+#define PART_NUMBER_ARM11MPCORE	0xB020
+#define PART_NUMBER_CORTEX_A8	0xC080
+#define PART_NUMBER_CORTEX_A9 	0xC090
+#define PART_NUMBER_CORTEX_A5 	0xC050
+#define PART_NUMBER_CORTEX_A15	0xC0F0
+#define PART_NUMBER_CORTEX_A7	0xC070
+
+#define PART_NUMBER_XSCALE1	0x1
+#define PART_NUMBER_XSCALE2	0x2
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
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index ab243b8..c8243c6 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -709,44 +709,44 @@ static int __init
 init_hw_perf_events(void)
 {
 	unsigned long cpuid = read_cpuid_id();
-	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
-	unsigned long part_number = (cpuid & 0xFFF0);
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
 
 	/* ARM Ltd CPUs. */
-	if (0x41 == implementor) {
+	if (implementor == IMPLEMENTOR_ARM) {
 		switch (part_number) {
-		case 0xB360:	/* ARM1136 */
-		case 0xB560:	/* ARM1156 */
-		case 0xB760:	/* ARM1176 */
+		case PART_NUMBER_ARM1136:
+		case PART_NUMBER_ARM1156:
+		case PART_NUMBER_ARM1176:
 			cpu_pmu = armv6pmu_init();
 			break;
-		case 0xB020:	/* ARM11mpcore */
+		case PART_NUMBER_ARM11MPCORE:
 			cpu_pmu = armv6mpcore_pmu_init();
 			break;
-		case 0xC080:	/* Cortex-A8 */
+		case PART_NUMBER_CORTEX_A8:
 			cpu_pmu = armv7_a8_pmu_init();
 			break;
-		case 0xC090:	/* Cortex-A9 */
+		case PART_NUMBER_CORTEX_A9:
 			cpu_pmu = armv7_a9_pmu_init();
 			break;
-		case 0xC050:	/* Cortex-A5 */
+		case PART_NUMBER_CORTEX_A5:
 			cpu_pmu = armv7_a5_pmu_init();
 			break;
-		case 0xC0F0:	/* Cortex-A15 */
+		case PART_NUMBER_CORTEX_A15:
 			cpu_pmu = armv7_a15_pmu_init();
 			break;
-		case 0xC070:	/* Cortex-A7 */
+		case PART_NUMBER_CORTEX_A7:
 			cpu_pmu = armv7_a7_pmu_init();
 			break;
 		}
 	/* Intel CPUs [xscale]. */
-	} else if (0x69 == implementor) {
+	} else if (implementor == IMPLEMENTOR_INTEL) {
 		part_number = (cpuid >> 13) & 0x7;
 		switch (part_number) {
-		case 1:
+		case PART_NUMBER_XSCALE1:
 			cpu_pmu = xscale1pmu_init();
 			break;
-		case 2:
+		case PART_NUMBER_XSCALE2:
 			cpu_pmu = xscale2pmu_init();
 			break;
 		}
