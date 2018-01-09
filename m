From: keescook@chromium.org (Kees Cook)
Date: Tue,  9 Jan 2018 12:56:00 -0800
Subject: [PATCH 31/36] arm: Implement thread_struct whitelist for hardened
 usercopy
In-Reply-To: <1515531365-37423-1-git-send-email-keescook@chromium.org>
References: <1515531365-37423-1-git-send-email-keescook@chromium.org>
Message-ID: <1515531365-37423-32-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM does not carry FPU state in the thread structure, so it can declare
no usercopy whitelist at all.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Kconfig                 | 1 +
 arch/arm/include/asm/processor.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df561077..3ea00d65f35d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
+	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 338cbe0a18ef..01a41be58d43 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -45,6 +45,13 @@ struct thread_struct {
 	struct debug_info	debug;
 };
 
+/* Nothing needs to be usercopy-whitelisted from thread_struct. */
+static inline void arch_thread_struct_whitelist(unsigned long *offset,
+						unsigned long *size)
+{
+	*offset = *size = 0;
+}
+
 #define INIT_THREAD  {	}
 
 #define start_thread(regs,pc,sp)					\
-- 
2.7.4
