From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 31 Mar 2016 05:27:03 +0300
Subject: [RFC] [PATCH] arm64: survive after access to unimplemented register
Message-ID: <1459391223-3826-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all vendors implement all the system registers ARM specifies.
So access them causes undefined instruction abort and then kernel
panic. There are 3 ways to handle it we can figure out:
 - use conditional compilation and erratas;
 - use kernel patching;
 - inline fixups resolving the abort.

Last option is more robust as it does not require additional efforts
to support targers. It is looking reasonable because in many cases
optional registers should be RAZ if not implemented. Special cases may
be handled by underlying __read_cpuid() when needed.

Tested on QEMU emulator version 2.3.0 (Debian 1:2.3+dfsg-5ubuntu9.2)
that does not implement SYS_ID_AA64MMFR2_EL1 register. (Fixed in new
releases),

Discussion: https://lkml.org/lkml/2016/3/29/931

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/cputype.h  | 17 +++++++++++++++--
 arch/arm64/include/asm/exttable.h | 21 +++++++++++++++++++++
 arch/arm64/include/asm/uaccess.h  | 15 ---------------
 arch/arm64/kernel/entry.S         |  3 ++-
 arch/arm64/kernel/traps.c         |  6 ++++++
 arch/arm64/mm/extable.c           |  2 +-
 6 files changed, 45 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/include/asm/exttable.h

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 87e1985..9660130 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -90,13 +90,26 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/sysreg.h>
+#include <asm/exttable.h>
 
-#define read_cpuid(reg) ({						\
+#define __read_cpuid(reg, err) ({					\
 	u64 __val;							\
-	asm("mrs_s	%0, " __stringify(SYS_ ## reg) : "=r" (__val));	\
+	asm (								\
+	"1:mrs_s	%0, " reg "\n"					\
+	"2:\n"								\
+	"	.section .fixup, \"ax\"\n"				\
+	"	.align	2\n"						\
+	"3:	mov	%w0, %1\n"					\
+	"	b	2b\n"						\
+	"	.previous\n"						\
+	_ASM_EXTABLE(1b, 3b)						\
+	: "=r" (__val)							\
+	: "i" (err));							\
 	__val;								\
 })
 
+#define read_cpuid(reg) __read_cpuid(__stringify(SYS_ ## reg), 0)
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
diff --git a/arch/arm64/include/asm/exttable.h b/arch/arm64/include/asm/exttable.h
new file mode 100644
index 0000000..c0a66c8
--- /dev/null
+++ b/arch/arm64/include/asm/exttable.h
@@ -0,0 +1,21 @@
+#ifndef __ASM_EXTTABLE_H
+#define __ASM_EXTTABLE_H
+
+#include <asm/ptrace.h>
+
+#define ARCH_HAS_RELATIVE_EXTABLE
+
+#define _ASM_EXTABLE(from, to)						\
+	"	.pushsection	__ex_table, \"a\"\n"			\
+	"	.align		3\n"					\
+	"	.long		(" #from " - .), (" #to " - .)\n"	\
+	"	.popsection\n"
+
+struct exception_table_entry
+{
+	int insn, fixup;
+};
+
+extern int fixup_exception(struct pt_regs *regs);
+
+#endif /* __ASM_EXTTABLE_H */
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 0685d74..19cfdc5 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -48,15 +48,6 @@
  * on our cache or tlb entries.
  */
 
-struct exception_table_entry
-{
-	int insn, fixup;
-};
-
-#define ARCH_HAS_RELATIVE_EXTABLE
-
-extern int fixup_exception(struct pt_regs *regs);
-
 #define KERNEL_DS	(-1UL)
 #define get_ds()	(KERNEL_DS)
 
@@ -117,12 +108,6 @@ static inline void set_fs(mm_segment_t fs)
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
 
-#define _ASM_EXTABLE(from, to)						\
-	"	.pushsection	__ex_table, \"a\"\n"			\
-	"	.align		3\n"					\
-	"	.long		(" #from " - .), (" #to " - .)\n"	\
-	"	.popsection\n"
-
 /*
  * The "__xxx" versions of the user access functions do not verify the address
  * space - it must have been done previously with a separate "access_ok()"
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1f7a145..6b88096 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -377,7 +377,8 @@ el1_undef:
 	 */
 	enable_dbg
 	mov	x0, sp
-	b	do_undefinstr
+	bl	do_undefinstr
+	kernel_exit 1
 el1_dbg:
 	/*
 	 * Debug exception handling
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cacd30a..515444a 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -386,6 +386,12 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
+	/*
+	 * Are we prepared to handle this kernel fault?
+	 */
+	if (fixup_exception(regs))
+		return;
+
 	if (unhandled_signal(current, SIGILL) && show_unhandled_signals_ratelimited()) {
 		pr_info("%s[%d]: undefined instruction: pc=%p\n",
 			current->comm, task_pid_nr(current), pc);
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 81acd47..c140688 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -3,7 +3,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/uaccess.h>
+#include <asm/exttable.h>
 
 int fixup_exception(struct pt_regs *regs)
 {
-- 
2.5.0
