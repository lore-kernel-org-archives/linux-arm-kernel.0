From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:14 +0100
Subject: [PATCH 08/14] arm64: big-endian: don't treat code as data when
 copying sigret code
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-9-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the sigreturn compat code is copied to an offset in the
vectors table. When using a BE kernel this data will be stored in the
wrong endianess so when returning from a signal on a 32-bit BE system,
arbitrary code will be executed.

Instead of declaring the code inside a struct and copying that, use
the assembler's .byte directives to store the code in the correct
endianess regardless of platform endianess.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm64/kernel/Makefile   |    2 +-
 arch/arm64/kernel/kuser32.S  |   42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c |   28 ----------------------------
 arch/arm64/kernel/vdso.c     |    5 ++++-
 4 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..7d45ad7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -11,7 +11,7 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
 			   hyp-stub.o psci.o
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o  	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 8b69ecb..1e4905d 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -27,6 +27,9 @@
  *
  * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
  */
+
+#include <asm/unistd32.h>
+
 	.align	5
 	.globl	__kuser_helper_start
 __kuser_helper_start:
@@ -75,3 +78,42 @@ __kuser_helper_version:			// 0xffff0ffc
 	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
 	.globl	__kuser_helper_end
 __kuser_helper_end:
+
+/*
+ * AArch32 sigreturn code
+ *
+ * For ARM syscalls, the syscall number has to be loaded into r7.
+ * We do not support an OABI userspace.
+ *
+ * For Thumb syscalls, we also pass the syscall number via r7. We therefore
+ * need two 16-bit instructions.
+ */
+	.globl __aarch32_sigret_code_start
+__aarch32_sigret_code_start:
+
+	/*
+	 * ARM Code
+	 */
+	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
+
+	/*
+	 * ARM code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
+
+        .globl __aarch32_sigret_code_end
+__aarch32_sigret_code_end:
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index e393174..e8772c0 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -100,34 +100,6 @@ struct compat_rt_sigframe {
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-/*
- * For ARM syscalls, the syscall number has to be loaded into r7.
- * We do not support an OABI userspace.
- */
-#define MOV_R7_NR_SIGRETURN	(0xe3a07000 | __NR_compat_sigreturn)
-#define SVC_SYS_SIGRETURN	(0xef000000 | __NR_compat_sigreturn)
-#define MOV_R7_NR_RT_SIGRETURN	(0xe3a07000 | __NR_compat_rt_sigreturn)
-#define SVC_SYS_RT_SIGRETURN	(0xef000000 | __NR_compat_rt_sigreturn)
-
-/*
- * For Thumb syscalls, we also pass the syscall number via r7. We therefore
- * need two 16-bit instructions.
- */
-#define SVC_THUMB_SIGRETURN	(((0xdf00 | __NR_compat_sigreturn) << 16) | \
-				   0x2700 | __NR_compat_sigreturn)
-#define SVC_THUMB_RT_SIGRETURN	(((0xdf00 | __NR_compat_rt_sigreturn) << 16) | \
-				   0x2700 | __NR_compat_rt_sigreturn)
-
-const compat_ulong_t aarch32_sigret_code[6] = {
-	/*
-	 * AArch32 sigreturn code.
-	 * We don't construct an OABI SWI - instead we just set the imm24 field
-	 * to the EABI syscall number so that we create a sane disassembly.
-	 */
-	MOV_R7_NR_SIGRETURN,    SVC_SYS_SIGRETURN,    SVC_THUMB_SIGRETURN,
-	MOV_R7_NR_RT_SIGRETURN, SVC_SYS_RT_SIGRETURN, SVC_THUMB_RT_SIGRETURN,
-};
-
 static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
 {
 	compat_sigset_t	cset;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 6a389dc..65d40cf 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -58,7 +58,10 @@ static struct page *vectors_page[1];
 static int alloc_vectors_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
+	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
+
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
+	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
 	unsigned long vpage;
 
 	vpage = get_zeroed_page(GFP_ATOMIC);
@@ -72,7 +75,7 @@ static int alloc_vectors_page(void)
 
 	/* sigreturn code */
 	memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
-		aarch32_sigret_code, sizeof(aarch32_sigret_code));
+               __aarch32_sigret_code_start, sigret_sz);
 
 	flush_icache_range(vpage, vpage + PAGE_SIZE);
 	vectors_page[0] = virt_to_page(vpage);
-- 
1.7.9.5
