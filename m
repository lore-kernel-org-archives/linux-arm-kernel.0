From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:29 +0200
Subject: [PATCH v4 19/24] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <c6c978070e2076e33f3d575075b46c875fe4c995.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Add a separate syscall-table for ILP32, which dispatches either to native
LP64 system call implementation or to compat-syscalls, as appropriate.

This revision of the patch now addresses Catalin's comment regarding the
duplicate reading of the task-flags in the el0_svc-handler and simply
relies on the flags having been read by the kernel_entry macro.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/asm/unistd.h |   4 +
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/entry.S       |  12 ++-
 arch/arm64/kernel/sys_ilp32.c   | 173 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/sys_ilp32.c

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index bed97c3..10397e8 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,6 +13,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#ifdef CONFIG_ARM64_ILP32
+#define __ARCH_WANT_COMPAT_SYS_PREADV64
+#define __ARCH_WANT_COMPAT_SYS_PWRITEV64
+#endif
 #ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3cf8120..131996d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -23,6 +23,7 @@ arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= sys_ilp32.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0dce3d0..39fdf67 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -642,9 +642,13 @@ ENDPROC(ret_from_fork)
  */
 	.align	6
 el0_svc:
-	adrp	stbl, sys_call_table		// load syscall table pointer
 	uxtw	scno, w8			// syscall number in w8
 	mov	sc_nr, #__NR_syscalls
+#ifdef CONFIG_ARM64_ILP32
+	ldr	x16, [tsk, #TI_FLAGS]
+	tbnz	x16, #TIF_32BIT_AARCH64, el0_ilp32_svc // We are using ILP32
+#endif
+	adrp	stbl, sys_call_table		// load syscall table pointer
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
@@ -664,6 +668,12 @@ ni_sys:
 	b	ret_fast_syscall
 ENDPROC(el0_svc)
 
+#ifdef CONFIG_ARM64_ILP32
+el0_ilp32_svc:
+	adrp	stbl, sys_call_ilp32_table // load syscall table pointer
+	b el0_svc_naked
+#endif
+
 	/*
 	 * This is the really slow path.  We're going to be doing context
 	 * switches, and waiting for our parent to respond.
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
new file mode 100644
index 0000000..06c05ce
--- /dev/null
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -0,0 +1,173 @@
+/*
+ * AArch64- ILP32 specific system calls implementation
+ *
+ * Copyright (C) 2013 Cavium Inc.
+ * Author: Andrew Pinski <apinski@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+
+/*
+ * Wrappers to pass the pt_regs argument.
+ */
+#define sys_rt_sigreturn        sys_rt_sigreturn_wrapper
+
+/* Using Compat syscalls where necessary */
+#define sys_ioctl		compat_sys_ioctl
+/* iovec */
+#define sys_readv		compat_sys_readv
+#define sys_writev		compat_sys_writev
+#define sys_preadv		compat_sys_preadv64
+#define sys_pwritev		compat_sys_pwritev64
+#define sys_vmsplice		compat_sys_vmsplice
+/* robust_list_head */
+#define sys_set_robust_list	compat_sys_set_robust_list
+#define sys_get_robust_list	compat_sys_get_robust_list
+
+/* kexec_segment */
+#define sys_kexec_load		compat_sys_kexec_load
+
+/* Ptrace has some structures which are different between ILP32 and LP64 */
+#define sys_ptrace		compat_sys_ptrace
+
+/* struct msghdr */
+#define sys_recvfrom		compat_sys_recvfrom
+#define sys_recvmmsg		compat_sys_recvmmsg
+#define sys_sendmmsg		compat_sys_sendmmsg
+#define sys_sendmsg		compat_sys_sendmsg
+#define sys_recvmsg		compat_sys_recvmsg
+
+#define sys_setsockopt		compat_sys_setsockopt
+#define sys_getsockopt		compat_sys_getsockopt
+
+/* Array of pointers */
+#define sys_execve		compat_sys_execve
+#define sys_move_pages		compat_sys_move_pages
+
+/* iovec */
+#define sys_process_vm_readv	compat_sys_process_vm_readv
+#define sys_process_vm_writev	compat_sys_process_vm_writev
+
+/* Pointer in struct */
+#define sys_mount               compat_sys_mount
+
+/* NUMA */
+/* unsigned long bitmaps */
+#define sys_get_mempolicy       compat_sys_get_mempolicy
+#define sys_set_mempolicy       compat_sys_set_mempolicy
+#define sys_mbind               compat_sys_mbind
+/* array of pointers */
+/* unsigned long bitmaps */
+#define sys_migrate_pages       compat_sys_migrate_pages
+
+/* Scheduler */
+/* unsigned long bitmaps */
+#define sys_sched_setaffinity   compat_sys_sched_setaffinity
+#define sys_sched_getaffinity   compat_sys_sched_getaffinity
+
+/* iov usage */
+#define sys_keyctl              compat_sys_keyctl
+
+/* aio */
+/* Pointer to Pointer  */
+#define sys_io_setup		compat_sys_io_setup
+/* Array of pointers */
+#define sys_io_submit           compat_sys_io_submit
+
+/* We need to make sure the pointer gets copied correctly. */
+asmlinkage long ilp32_sys_mq_notify(mqd_t mqdes, const struct sigevent __user *u_notification)
+{
+	struct sigevent __user *p = NULL;
+	if (u_notification) {
+		struct sigevent n;
+		p = compat_alloc_user_space(sizeof(*p));
+		if (copy_from_user(&n, u_notification, sizeof(*p)))
+			return -EFAULT;
+		if (n.sigev_notify == SIGEV_THREAD)
+			n.sigev_value.sival_ptr = compat_ptr((uintptr_t)n.sigev_value.sival_ptr);
+		if (copy_to_user(p, &n, sizeof(*p)))
+			return -EFAULT;
+	}
+	return sys_mq_notify(mqdes, p);
+}
+
+/* sigevent contains sigval_t which is now 64bit always
+   but need special handling due to padding for SIGEV_THREAD.  */
+#define sys_mq_notify		ilp32_sys_mq_notify
+
+
+/* sigaltstack needs some special handling as the
+   padding for stack_t might not be non-zero. */
+long ilp32_sys_sigaltstack(const stack_t __user *uss_ptr,
+			   stack_t __user *uoss_ptr)
+{
+	stack_t uss, uoss;
+	int ret;
+	mm_segment_t seg;
+
+	if (uss_ptr) {
+		if (!access_ok(VERIFY_READ, uss_ptr, sizeof(*uss_ptr)))
+			return -EFAULT;
+		if (__get_user(uss.ss_sp, &uss_ptr->ss_sp) |
+			__get_user(uss.ss_flags, &uss_ptr->ss_flags) |
+			__get_user(uss.ss_size, &uss_ptr->ss_size))
+			return -EFAULT;
+		/* Zero extend the sp address and the size. */
+		uss.ss_sp = (void *)(uintptr_t)(unsigned int)(uintptr_t)uss.ss_sp;
+		uss.ss_size = (size_t)(unsigned int)uss.ss_size;
+	}
+	seg = get_fs();
+	set_fs(KERNEL_DS);
+	/* Note we need to use uoss as we have changed the segment to the
+	   kernel one so passing an user one around is wrong. */
+	ret = sys_sigaltstack((stack_t __force __user *) (uss_ptr ? &uss : NULL),
+			      (stack_t __force __user *) &uoss);
+	set_fs(seg);
+	if (ret >= 0 && uoss_ptr)  {
+		if (!access_ok(VERIFY_WRITE, uoss_ptr, sizeof(stack_t)) ||
+		    __put_user(uoss.ss_sp, &uoss_ptr->ss_sp) ||
+		    __put_user(uoss.ss_flags, &uoss_ptr->ss_flags) ||
+		    __put_user(uoss.ss_size, &uoss_ptr->ss_size))
+			ret = -EFAULT;
+	}
+	return ret;
+}
+
+/* sigaltstack needs some special handling as the padding
+   for stack_t might not be non-zero. */
+#define sys_sigaltstack		ilp32_sys_sigaltstack
+
+
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)	[nr] = sym,
+
+/*
+ * The sys_call_ilp32_table array must be 4K aligned to be accessible from
+ * kernel/entry.S.
+ */
+void *sys_call_ilp32_table[__NR_syscalls] __aligned(4096) = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
1.9.1
