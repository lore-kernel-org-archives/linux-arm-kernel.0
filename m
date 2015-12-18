From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 18 Dec 2015 19:00:29 +0300
Subject: [PATCH v4] arm64: run-time detection for aarch32 support
Message-ID: <1450454429-22976-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel option COMPAT defines the ability of executing aarch32 binaries.
Some platforms does not support aarch32 mode, and so cannot execute that
binaries. But we cannot just disable COMPAT for them because the same
kernel binary may be used by multiple platforms.

In this patch, system_supports_aarch32_el0() is introduced to detect
aarch32 support at run-time.

v4: use new CPU Feature API.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/cpufeature.h | 7 +++++++
 arch/arm64/include/asm/elf.h        | 6 ++++--
 arch/arm64/include/asm/sysreg.h     | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8f271b8..781a2f7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -184,6 +184,13 @@ static inline bool system_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
 }
 
+static inline bool system_supports_aarch32_el0(void)
+{
+	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+	return ((pfr0 >> ID_AA64PFR0_EL0_SHIFT) & ID_AA64PFR0_ELx_MASK)
+						!= ID_AA64PFR0_EL0_64BIT_ONLY;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index faad6df..1053cd7 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -23,6 +23,7 @@
  */
 #include <asm/ptrace.h>
 #include <asm/user.h>
+#include <asm/cpufeature.h>
 
 typedef unsigned long elf_greg_t;
 
@@ -173,8 +174,9 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
-					 ((x)->e_flags & EF_ARM_EABI_MASK))
+#define compat_elf_check_arch(x)	(system_supports_aarch32_el0()	\
+					 && ((x)->e_machine == EM_ARM)	\
+					 && ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
 #define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d48ab5b..a67b203 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -102,6 +102,7 @@
 #define ID_AA64PFR0_EL2_SHIFT		8
 #define ID_AA64PFR0_EL1_SHIFT		4
 #define ID_AA64PFR0_EL0_SHIFT		0
+#define ID_AA64PFR0_ELx_MASK		0xf
 
 #define ID_AA64PFR0_FP_NI		0xf
 #define ID_AA64PFR0_FP_SUPPORTED	0x0
-- 
2.5.0
