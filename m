From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu,  9 Jun 2016 17:23:29 -0500
Subject: [PATCH 4/8] arm: arm64: Add routine to determine cpuid of other cpus
In-Reply-To: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1465511013-10742-5-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is helpful if we can read the cpuid/midr of other CPUs
in the system independent of arm/arm64.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm/include/asm/cputype.h   | 6 +++++-
 arch/arm64/include/asm/cputype.h | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c7..e391b67 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -81,6 +81,8 @@
 #define ARM_CPU_XSCALE_ARCH_V2		0x4000
 #define ARM_CPU_XSCALE_ARCH_V3		0x6000
 
+#define ARM_PARTNUM(cpuid_id) (cpuid_id & ARM_CPU_PART_MASK)
+
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
@@ -180,7 +182,7 @@ static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
  */
 static inline unsigned int __attribute_const__ read_cpuid_part(void)
 {
-	return read_cpuid_id() & ARM_CPU_PART_MASK;
+	return ARM_PARTNUM(read_cpuid_id());
 }
 
 static inline unsigned int __attribute_const__ __deprecated read_cpuid_part_number(void)
@@ -208,6 +210,8 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
 	return read_cpuid(CPUID_MPIDR);
 }
 
+#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->cpuid
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 87e1985..56fd8c1 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -38,6 +38,7 @@
 #define MIDR_PARTNUM_MASK	(0xfff << MIDR_PARTNUM_SHIFT)
 #define MIDR_PARTNUM(midr)	\
 	(((midr) & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT)
+#define ARM_PARTNUM MIDR_PARTNUM
 #define MIDR_ARCHITECTURE_SHIFT	16
 #define MIDR_ARCHITECTURE_MASK	(0xf << MIDR_ARCHITECTURE_SHIFT)
 #define MIDR_ARCHITECTURE(midr)	\
@@ -126,6 +127,9 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CTR_EL0);
 }
+
+#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->reg_midr
+
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.5.5
