From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 1 Sep 2015 17:41:12 +0300
Subject: [PATCH 2/2] arm64: don't load 32-bit binaries if platform has no
 aarch32_el0
In-Reply-To: <1441118472-3513-1-git-send-email-ynorov@caviumnetworks.com>
References: <1441118472-3513-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1441118472-3513-3-git-send-email-ynorov@caviumnetworks.com>
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
 arch/arm64/include/asm/cpufeature.h | 1 +
 arch/arm64/include/asm/elf.h        | 6 ++++--
 arch/arm64/kernel/cpuinfo.c         | 9 +++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 20cdc26..d24ea15 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -81,6 +81,7 @@ void check_local_cpu_errata(void);
 void check_local_cpu_features(void);
 bool cpu_supports_mixed_endian_el0(void);
 bool system_supports_mixed_endian_el0(void);
+bool system_supports_aarch32_el0(void);
 
 #endif /* __ASSEMBLY__ */
 
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
index 75d5a86..95d953f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -79,6 +79,15 @@ bool system_supports_mixed_endian_el0(void)
 	return mixed_endian_el0;
 }
 
+#define AARCH64		1
+#define AARCH32_64	2
+bool system_supports_aarch32_el0(void)
+{
+	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
+	u64 arm64_el0 = info->reg_id_aa64pfr0 & 0xf;
+	return arm64_el0 == AARCH32_64;
+}
+
 static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
 {
 	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
-- 
2.1.4
