From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Sep 2015 18:50:00 +0300
Subject: [PATCH v3 2/2] arm64: don't load 32-bit binaries if platform has no
 aarch32_el0
In-Reply-To: <1441209000-26746-1-git-send-email-ynorov@caviumnetworks.com>
References: <1441209000-26746-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1441209000-26746-3-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel option COMPAT defines the ability of executing aarch32 binaries.
Some platforms does not support aarch32 mode, and so cannot execute that
binaries. But we cannot just disable COMPAT for them because the same
kernel binary may be used by multiple platforms.

In this patch, system_supports_aarch32_el0() is introduced to detect
aarch32 support at run-time.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/include/asm/cputype.h    |  9 +++++++++
 arch/arm64/include/asm/elf.h        |  6 ++++--
 arch/arm64/kernel/cpuinfo.c         | 12 ++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f0e4017..35f2654 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -83,6 +83,7 @@ void check_local_cpu_errata(void);
 void check_local_cpu_features(void);
 bool cpu_supports_mixed_endian_el0(void);
 bool system_supports_mixed_endian_el0(void);
+bool system_supports_aarch32_el0(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index a84ec60..5fb5585 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -81,6 +81,10 @@
 #define ID_AA64MMFR0_BIGEND(mmfr0)	\
 	(((mmfr0) & ID_AA64MMFR0_BIGEND_MASK) >> ID_AA64MMFR0_BIGEND_SHIFT)
 
+#define ID_AA64PFR0_EL0_64	1
+#define ID_AA64PFR0_EL0_6432	2
+#define ID_AA64PFR0_EL0_MASK	0xf
+
 #define SCTLR_EL1_CP15BEN	(0x1 << 5)
 #define SCTLR_EL1_SED		(0x1 << 8)
 
@@ -116,6 +120,11 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
 	return read_cpuid(CTR_EL0);
 }
 
+static inline bool id_aa64pfr0_aarch32_el0(u64 pfr0)
+{
+	return (pfr0 & ID_AA64PFR0_EL0_MASK) == ID_AA64PFR0_EL0_6432;
+}
+
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
 {
 	return (ID_AA64MMFR0_BIGEND(mmfr0) == 0x1) ||
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index faad6df..461897b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -21,6 +21,7 @@
 /*
  * ELF register definitions..
  */
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
 #include <asm/user.h>
 
@@ -173,8 +174,9 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
-					 ((x)->e_flags & EF_ARM_EABI_MASK))
+#define compat_elf_check_arch(x)	(system_supports_aarch32_el0()	\
+					&& ((x)->e_machine == EM_ARM)	\
+					&& ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
 #define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 75d5a86..4a6ae31 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -36,6 +36,7 @@
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
 static bool mixed_endian_el0 = true;
+static bool aarch32_el0 = true;
 
 static char *icache_policy_str[] = {
 	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
@@ -79,13 +80,24 @@ bool system_supports_mixed_endian_el0(void)
 	return mixed_endian_el0;
 }
 
+bool system_supports_aarch32_el0(void)
+{
+	return aarch32_el0;
+}
+
 static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
 {
 	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
 }
 
+static void update_aarch32_el0_support(struct cpuinfo_arm64 *info)
+{
+	aarch32_el0 &= id_aa64pfr0_aarch32_el0(info->reg_id_aa64pfr0);
+}
+
 static void update_cpu_features(struct cpuinfo_arm64 *info)
 {
+	update_aarch32_el0_support(info);
 	update_mixed_endian_el0_support(info);
 }
 
-- 
2.1.4
