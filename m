From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 17 Jan 2017 14:50:05 -0600
Subject: [PATCH v13 2/7] arm: arm64: Add routine to determine cpuid of other
 cpus
In-Reply-To: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1484686210-7211-3-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is helpful if we can read the cpuid/midr of other CPUs
in the system independent of arm/arm64.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm/include/asm/cputype.h   | 4 ++++
 arch/arm/kernel/setup.c          | 2 +-
 arch/arm64/include/asm/cputype.h | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 522b5fe..1e87d06 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -235,6 +235,10 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
 #define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
 #define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
 
+#define read_specific_cpuid(cpu_num) (is_smp() ? \
+				      per_cpu_ptr(&cpu_data, cpu_num)->cpuid \
+				      : read_cpuid_id())
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 34e3f3c..d443c97 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1217,7 +1217,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
+		cpuid = read_specific_cpuid(i);
 		seq_printf(m, "model name\t: %s rev %d (%s)\n",
 			   cpu_name, cpuid & 15, elf_platform);
 
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 26a68dd..a6d26e1 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -124,6 +124,9 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
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
