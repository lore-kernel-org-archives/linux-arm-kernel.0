From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 29 Aug 2016 16:48:17 -0500
Subject: [PATCH v8 6/9] arm: arm64: Add routine to determine cpuid of other
 cpus
In-Reply-To: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1472507300-9844-7-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is helpful if we can read the cpuid/midr of other CPUs
in the system independent of arm/arm64.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm/include/asm/cputype.h   | 2 ++
 arch/arm64/include/asm/cputype.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c7..d5900a2 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -208,6 +208,8 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
 	return read_cpuid(CPUID_MPIDR);
 }
 
+#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->cpuid
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 9d9fd4b..beb95dc 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -128,6 +128,9 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
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
