From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 14:25:56 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG traps
In-Reply-To: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the minimal default BUG() implementation from asm-
generic is used for arm64.

This patch uses the BRK software breakpoint instruction to generate
a trap instead, similarly to most other arches, with the generic
BUG code generating the dmesg boilerplate.

This allows bug metadata to be moved to a separate table and
reduces the amount of inline code at BUG and WARN sites.  This also
avoids clobbering any registers before they can be dumped.

To mitigate the size of the bug table further, this patch makes
use of the existing infrastructure for encoding addresses within
the bug table as 32-bit offsets instead of absolute pointers.
(Note that this limits the kernel size to 2GB.)

Traps are registered at arch_initcall time for aarch64, but BUG
has minimal real dependencies and it is desirable to be able to
generate bug splats as early as possible.  This patch redirects
all debug exceptions caused by BRK directly to bug_handler() until
the full debug exception support has been initialised.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig                      |    8 ++++
 arch/arm64/include/asm/bug.h            |   64 +++++++++++++++++++++++++++++++
 arch/arm64/include/asm/debug-monitors.h |    2 +
 arch/arm64/kernel/traps.c               |   59 +++++++++++++++++++++++++++-
 arch/arm64/mm/fault.c                   |   12 +++++-
 5 files changed, 142 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/bug.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f..b918286 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -113,6 +113,14 @@ config TRACE_IRQFLAGS_SUPPORT
 config RWSEM_XCHGADD_ALGORITHM
 	def_bool y
 
+config GENERIC_BUG
+	def_bool y
+	depends on BUG
+
+config GENERIC_BUG_RELATIVE_POINTERS
+	def_bool y
+	depends on GENERIC_BUG
+
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
new file mode 100644
index 0000000..4a748ce
--- /dev/null
+++ b/arch/arm64/include/asm/bug.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2015  ARM Limited
+ * Author: Dave Martin <Dave.Martin@arm.com>
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
+#ifndef _ARCH_ARM64_ASM_BUG_H
+#define _ARCH_ARM64_ASM_BUG_H
+
+#include <asm/debug-monitors.h>
+
+#ifdef CONFIG_GENERIC_BUG
+#define HAVE_ARCH_BUG
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define __BUGVERBOSE_LOCATION(file, line)				\
+		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
+	"2:	.string \"" file "\"\n\t"				\
+		".popsection\n\t"					\
+									\
+		".long 2b - 0b\n\t"					\
+		".short " #line "\n\t"
+#else
+#define _BUGVERBOSE_LOCATION(file, line)
+#endif
+
+#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
+
+#define __BUG_FLAGS(flags) asm volatile (		\
+		".pushsection __bug_table,\"a\"\n\t"	\
+		".align 2\n\t"				\
+	"0:	.long 1f - 0b\n\t"			\
+_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
+		".short " #flags "\n\t"			\
+		".popsection\n"				\
+							\
+	"1:	brk %[imm]"				\
+		:: [imm] "i" (BUG_BRK_IMM)		\
+)
+
+#define BUG() do {				\
+	_BUG_FLAGS(0);				\
+	unreachable();				\
+} while (0)
+
+#define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
+
+#endif /* ! CONFIG_GENERIC_BUG */
+
+#include <asm-generic/bug.h>
+
+#endif /* ! _ARCH_ARM64_ASM_BUG_H */
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index b5715cb..c37c70e 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -50,10 +50,12 @@
  * 0x100: for triggering a fault on purpose (reserved)
  * 0x400: for dynamic BRK instruction
  * 0x401: for compile time BRK instruction
+ * 0x800: kernel-mode BUG() and WARN() traps
  */
 #define FAULT_BRK_IMM			0x100
 #define KGDB_DYN_DBG_BRK_IMM		0x400
 #define KGDB_COMPILED_DBG_BRK_IMM	0x401
+#define BUG_BRK_IMM			0x800
 
 /*
  * BRK instruction encoding
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 566bc4c..b10f4bf 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/bug.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/kallsyms.h>
@@ -32,8 +33,10 @@
 #include <linux/syscalls.h>
 
 #include <asm/atomic.h>
+#include <asm/bug.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
+#include <asm/insn.h>
 #include <asm/traps.h>
 #include <asm/stacktrace.h>
 #include <asm/exception.h>
@@ -459,7 +462,61 @@ void __pgd_error(const char *file, int line, unsigned long val)
 	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
 }
 
+/* GENERIC_BUG traps */
+
+int is_valid_bugaddr(unsigned long addr)
+{
+	/*
+	 * bug_handler() only called for BRK #BUG_BRK_IMM.
+	 * So the answer is trivial -- any spurious instances with no
+	 * bug table entry will be rejected by report_bug() and passed
+	 * back to the debug-monitors code and handled as a fatal
+	 * unexpected debug exception.
+	 */
+	return 1;
+}
+
+static int bug_handler(struct pt_regs *regs, unsigned int esr)
+{
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
+	switch (report_bug(regs->pc, regs)) {
+	case BUG_TRAP_TYPE_BUG:
+		die("Oops - BUG", regs, 0);
+		break;
+
+	case BUG_TRAP_TYPE_WARN:
+		break;
+
+	default:
+		/* unknown/unrecognised bug trap type */
+		return DBG_HOOK_ERROR;
+	}
+
+	/* If thread survives, skip over the BUG instruction and continue: */
+	regs->pc += AARCH64_INSN_SIZE;	/* skip BRK and resume */
+	return DBG_HOOK_HANDLED;
+}
+
+static struct break_hook bug_break_hook = {
+	.esr_val = 0xf2000000 | BUG_BRK_IMM,
+	.esr_mask = 0xffffffff,
+	.fn = bug_handler,
+};
+
+/*
+ * Initial handler for AArch64 BRK exceptions
+ * This handler only used until debug_traps_init().
+ */
+int __init early_brk64(unsigned long addr, unsigned int esr,
+		struct pt_regs *regs)
+{
+	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
+}
+
+/* This registration must happen early, before debug_traps_init(). */
 void __init trap_init(void)
 {
-	return;
+	register_break_hook(&bug_break_hook);
 }
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 94d98cd..49da50d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -492,14 +492,22 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	arm64_notify_die("Oops - SP/PC alignment exception", regs, &info, esr);
 }
 
-static struct fault_info debug_fault_info[] = {
+int __init early_brk64(unsigned long addr, unsigned int esr,
+		       struct pt_regs *regs);
+
+/*
+ * __refdata because early_brk64 is __init, but the reference to it is
+ * clobbered at arch_initcall time.
+ * See traps.c and debug-monitors.c:debug_traps_init().
+ */
+static struct fault_info __refdata debug_fault_info[] = {
 	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware breakpoint"	},
 	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware single-step"	},
 	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware watchpoint"	},
 	{ do_bad,	SIGBUS,		0,		"unknown 3"		},
 	{ do_bad,	SIGTRAP,	TRAP_BRKPT,	"aarch32 BKPT"		},
 	{ do_bad,	SIGTRAP,	0,		"aarch32 vector catch"	},
-	{ do_bad,	SIGTRAP,	TRAP_BRKPT,	"aarch64 BRK"		},
+	{ early_brk64,	SIGTRAP,	TRAP_BRKPT,	"aarch64 BRK"		},
 	{ do_bad,	SIGBUS,		0,		"unknown 7"		},
 };
 
-- 
1.7.10.4
