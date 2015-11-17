From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 18 Nov 2015 00:16:54 +0300
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Add a separate syscall-table for ILP32, which dispatches either to native
LP64 system call implementation or to compat-syscalls, as appropriate.

Reviewed-by: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
---
 arch/arm64/include/asm/unistd.h |   7 ++-
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/entry.S       |  12 +++-
 arch/arm64/kernel/sys_ilp32.c   | 118 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/sys_ilp32.c

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 4c2cbbc..696e638 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,13 +13,16 @@
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
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
@@ -39,6 +42,8 @@
 #define __NR_compat_sigreturn		119
 #define __NR_compat_rt_sigreturn	173
 
+#define __ARCH_WANT_SYS_LLSEEK
+
 /*
  * The following SVCs are ARM private.
  */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 35a59af..837d730 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -24,6 +24,7 @@ arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= sys_ilp32.o
 arm64-obj-$(CONFIG_COMPAT)		+= entry32-common.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 52be5c8..bcd921a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -664,9 +664,13 @@ ENDPROC(ret_from_fork)
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
@@ -686,6 +690,12 @@ ni_sys:
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
index 0000000..c366d92
--- /dev/null
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -0,0 +1,118 @@
+/*
+ * AArch64- ILP32 specific system calls implementation
+ *
+ * Copyright (C) 2015 Cavium Inc.
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
+#include <linux/msg.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+
+/*
+ * Wrappers to pass the pt_regs argument.
+ */
+asmlinkage long sys_rt_sigreturn_wrapper(void);
+#define compat_sys_rt_sigreturn        sys_rt_sigreturn_wrapper
+
+/* Using non-compat syscalls where necessary */
+#define compat_sys_fadvise64_64        sys_fadvise64_64
+#define compat_sys_fallocate           sys_fallocate
+#define compat_sys_ftruncate64         sys_ftruncate
+#define compat_sys_pread64             sys_pread64
+#define compat_sys_pwrite64            sys_pwrite64
+#define compat_sys_readahead           sys_readahead
+#define compat_sys_rt_sigaction        sys_rt_sigaction
+#define compat_sys_shmat               sys_shmat
+#define compat_sys_sync_file_range     sys_sync_file_range
+#define compat_sys_truncate64          sys_truncate
+#define compat_sys_sigaltstack         sys_sigaltstack
+
+#define compat_sys_io_getevents        sys_io_getevents
+#define compat_sys_lookup_dcookie      sys_lookup_dcookie
+#define compat_sys_epoll_pwait         sys_epoll_pwait
+#define compat_sys_fcntl64             compat_sys_fcntl
+#define compat_sys_preadv              compat_sys_preadv64
+#define compat_sys_signalfd4           sys_signalfd4
+
+#define compat_sys_rt_sigsuspend       sys_rt_sigsuspend
+#define compat_sys_rt_sigprocmask      sys_rt_sigprocmask
+#define compat_sys_rt_sigpending       sys_rt_sigpending
+#define compat_sys_rt_sigqueueinfo     sys_rt_sigqueueinfo
+#define compat_sys_semtimedop          sys_semtimedop
+#define compat_sys_rt_tgsigqueueinfo   sys_rt_tgsigqueueinfo
+
+#define compat_sys_timer_create        sys_timer_create
+#define compat_sys_timer_gettime       sys_timer_gettime
+#define compat_sys_timer_settime       sys_timer_settime
+#define compat_sys_rt_sigtimedwait     sys_rt_sigtimedwait
+
+#define compat_sys_mq_open             sys_mq_open
+#define compat_sys_mq_timedsend        sys_mq_timedsend
+#define compat_sys_mq_timedreceive     sys_mq_timedreceive
+#define compat_sys_mq_getsetattr       sys_mq_getsetattr
+#define compat_sys_mq_open             sys_mq_open
+
+#define compat_sys_open_by_handle_at   sys_open_by_handle_at
+#define compat_sys_clock_adjtime       sys_clock_adjtime
+
+#define compat_sys_openat              sys_openat
+#define compat_sys_getdents64          sys_getdents64
+#define compat_sys_waitid              sys_waitid
+#define compat_sys_timer_settime       sys_timer_settime
+#define compat_sys_sched_rr_get_interval sys_sched_rr_get_interval
+#define compat_sys_execveat            sys_execveat
+
+#define compat_sys_mq_notify           sys_mq_notify
+#define compat_sys_clock_nanosleep     sys_clock_nanosleep
+#define compat_sys_clock_getres        sys_clock_getres
+
+#define sys_lseek                      sys_llseek
+
+asmlinkage long compat_sys_mmap2_wrapper(void);
+#define sys_mmap2                      compat_sys_mmap2_wrapper
+
+asmlinkage long compat_sys_fstatfs64_wrapper(void);
+#define compat_sys_fstatfs64    compat_sys_fstatfs64_wrapper
+asmlinkage long compat_sys_statfs64_wrapper(void);
+#define compat_sys_statfs64             compat_sys_statfs64_wrapper
+
+#define compat_sys_pwritev	       compat_sys_pwritev64
+
+#include <asm/syscall.h>
+
+#undef __SYSCALL
+#undef __SC_COMP
+#undef __SC_3264
+#undef __SC_COMP_3264
+
+#define __SYSCALL_COMPAT
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
2.1.4
