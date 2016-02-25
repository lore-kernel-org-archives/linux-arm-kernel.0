From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 25 Feb 2016 09:52:47 +0000
Subject: [PATCH v2 7/8] arm64: compat: Check for AArch32 state
In-Reply-To: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456393968-17386-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yury Norov <ynorov@caviumnetworks.com>

Make sure we have AArch32 state available for running COMPAT
binaries and also for switching the personality to PER_LINUX32.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
[ Added checks for ELF HWCAP, Use cap bit in cap_hwcaps ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/elf.h   |    3 ++-
 arch/arm64/kernel/cpufeature.c |    7 +++++--
 arch/arm64/kernel/sys.c        |    4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index faad6df..a1946f2 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -173,7 +173,8 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
+#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
+					 ((x)->e_machine == EM_ARM) && \
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8f6b674..1ae545e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -929,7 +929,8 @@ void verify_local_cpu_capabilities(void)
 
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
-	verify_local_elf_hwcaps(compat_elf_hwcaps);
+	if (system_supports_32bit_el0())
+		verify_local_elf_hwcaps(compat_elf_hwcaps);
 }
 
 static void __init setup_feature_capabilities(void)
@@ -946,7 +947,9 @@ void __init setup_cpu_features(void)
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
-	setup_elf_hwcaps(compat_elf_hwcaps);
+
+	if (system_supports_32bit_el0())
+		setup_elf_hwcaps(compat_elf_hwcaps);
 
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 817d860..26fe8ea 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
+#include <asm/cpufeature.h>
 
 asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 			 unsigned long prot, unsigned long flags,
@@ -38,6 +39,9 @@ asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 
 SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 {
+	if (personality(personality) == PER_LINUX32 &&
+		!system_supports_32bit_el0())
+		return -EINVAL;
 	return sys_personality(personality);
 }
 
-- 
1.7.9.5
