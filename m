From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 17 Dec 2012 23:06:37 -0500
Subject: [PATCH 1/2] ARM: Define CPU part numbers and implementors
Message-ID: <1355803598-58471-1-git-send-email-c.dall@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define implementor IDs, part numbers and Xscale architecture versions in
cputype.h.  Also create accessor functions for reading the implementor,
part number, and Xscale architecture versions from the CPUID regiser.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/cputype.h |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb47d28..6283f36 100644
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
+#define ARM_CPU_PART_CORTEX_A9		0xC090
+#define ARM_CPU_PART_CORTEX_A5		0xC050
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
+	return read_cpuid_id() & 0xFFF0;
+}
+
+static inline unsigned int __attribute_const__ xscale_cpu_arch_version(void)
+{
+	return read_cpuid_part_number() & ARM_CPU_XSCALE_ARCH_MASK;
+}
+
 static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CPUID_CACHETYPE);
-- 
1.7.9.5
