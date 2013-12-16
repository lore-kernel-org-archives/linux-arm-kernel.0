From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Dec 2013 22:04:35 +0100
Subject: [PATCH 1/4] arm64: drop redundant macros from read_cpuid()
In-Reply-To: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1387227878-30438-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/cputype.h contains a bunch of #defines for CPU id registers
that essentially map to themselves. Remove the #defines and pass
the tokens directly to the inline asm() that reads the registers.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cputype.h | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5fe138e..e1af1b4 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -16,23 +16,13 @@
 #ifndef __ASM_CPUTYPE_H
 #define __ASM_CPUTYPE_H
 
-#define ID_MIDR_EL1		"midr_el1"
-#define ID_MPIDR_EL1		"mpidr_el1"
-#define ID_CTR_EL0		"ctr_el0"
-
-#define ID_AA64PFR0_EL1		"id_aa64pfr0_el1"
-#define ID_AA64DFR0_EL1		"id_aa64dfr0_el1"
-#define ID_AA64AFR0_EL1		"id_aa64afr0_el1"
-#define ID_AA64ISAR0_EL1	"id_aa64isar0_el1"
-#define ID_AA64MMFR0_EL1	"id_aa64mmfr0_el1"
-
 #define INVALID_HWID		ULONG_MAX
 
 #define MPIDR_HWID_BITMASK	0xff00ffffff
 
 #define read_cpuid(reg) ({						\
 	u64 __val;							\
-	asm("mrs	%0, " reg : "=r" (__val));			\
+	asm("mrs	%0, " #reg : "=r" (__val));			\
 	__val;								\
 })
 
@@ -54,12 +44,12 @@
  */
 static inline u32 __attribute_const__ read_cpuid_id(void)
 {
-	return read_cpuid(ID_MIDR_EL1);
+	return read_cpuid(MIDR_EL1);
 }
 
 static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 {
-	return read_cpuid(ID_MPIDR_EL1);
+	return read_cpuid(MPIDR_EL1);
 }
 
 static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
@@ -74,7 +64,7 @@ static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
 
 static inline u32 __attribute_const__ read_cpuid_cachetype(void)
 {
-	return read_cpuid(ID_CTR_EL0);
+	return read_cpuid(CTR_EL0);
 }
 
 #endif /* __ASSEMBLY__ */
-- 
1.8.3.2
