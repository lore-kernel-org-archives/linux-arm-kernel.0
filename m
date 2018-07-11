From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:42 +0100
Subject: [PATCHv5 07/21] arm64: introduce syscall_fn_t
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-8-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for invoking arbitrary syscalls from C code, let's define
a type for an arbitrary syscall, matching the parameter passing rules of
the AAPCS.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/syscall.h | 6 +++++-
 arch/arm64/kernel/sys.c          | 8 +++++---
 arch/arm64/kernel/sys32.c        | 8 +++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 709a574468f0..50841cb1bfa9 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -20,7 +20,11 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
-extern const void *sys_call_table[];
+typedef long (*syscall_fn_t)(unsigned long, unsigned long,
+			     unsigned long, unsigned long,
+			     unsigned long, unsigned long);
+
+extern const syscall_fn_t sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 31045f3fed92..7f0907261269 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -25,7 +25,9 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
+
 #include <asm/cpufeature.h>
+#include <asm/syscall.h>
 
 asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 			 unsigned long prot, unsigned long flags,
@@ -52,13 +54,13 @@ asmlinkage long sys_rt_sigreturn(void);
 #define sys_personality		sys_arm64_personality
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym)	[nr] = sym,
+#define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)sym,
 
 /*
  * The sys_call_table array must be 4K aligned to be accessible from
  * kernel/entry.S.
  */
-void * const sys_call_table[__NR_syscalls] __aligned(4096) = {
-	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+const syscall_fn_t sys_call_table[__NR_syscalls] __aligned(4096) = {
+	[0 ... __NR_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 1ef103c95410..d993214118aa 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -25,6 +25,8 @@
 #include <linux/compiler.h>
 #include <linux/syscalls.h>
 
+#include <asm/syscall.h>
+
 asmlinkage long compat_sys_sigreturn(void);
 asmlinkage long compat_sys_rt_sigreturn(void);
 asmlinkage long compat_sys_statfs64_wrapper(void);
@@ -40,13 +42,13 @@ asmlinkage long compat_sys_fallocate_wrapper(void);
 asmlinkage long compat_sys_mmap2_wrapper(void);
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym)	[nr] = sym,
+#define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)sym,
 
 /*
  * The sys_call_table array must be 4K aligned to be accessible from
  * kernel/entry.S.
  */
-void * const compat_sys_call_table[__NR_compat_syscalls] __aligned(4096) = {
-	[0 ... __NR_compat_syscalls - 1] = sys_ni_syscall,
+const syscall_fn_t compat_sys_call_table[__NR_compat_syscalls] __aligned(4096) = {
+	[0 ... __NR_compat_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
 #include <asm/unistd32.h>
 };
-- 
2.11.0
