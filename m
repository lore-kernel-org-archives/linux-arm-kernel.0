From: james.morse@arm.com (James Morse)
Date: Wed, 24 Aug 2016 18:27:28 +0100
Subject: [PATCH v6 1/3] arm64: Create sections.h
In-Reply-To: <1472059650-591-1-git-send-email-james.morse@arm.com>
References: <1472059650-591-1-git-send-email-james.morse@arm.com>
Message-ID: <1472059650-591-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each time new section markers are added, kernel/vmlinux.ld.S is updated,
and new extern char __start_foo[] definitions are scattered through the
tree.

Create asm/include/sections.h to collect these definitions (and include
the existing asm-generic version).

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/arm64/include/asm/sections.h  | 29 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/traps.h     |  6 +-----
 arch/arm64/include/asm/virt.h      |  9 +--------
 arch/arm64/kernel/alternative.c    |  7 +++----
 arch/arm64/kernel/hibernate.c      |  6 ------
 arch/arm64/kernel/probes/kprobes.c |  5 +----
 7 files changed, 35 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/include/asm/sections.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index f43d2c44c765..2b3d2d24acba 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -32,7 +32,6 @@ generic-y += poll.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
-generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
 generic-y += serial.h
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
new file mode 100644
index 000000000000..237fcdd13445
--- /dev/null
+++ b/arch/arm64/include/asm/sections.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2016 ARM Limited
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
+#ifndef __ASM_SECTIONS_H
+#define __ASM_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char __alt_instructions[], __alt_instructions_end[];
+extern char __exception_text_start[], __exception_text_end[];
+extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
+extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
+extern char __hyp_text_start[], __hyp_text_end[];
+extern char __idmap_text_start[], __idmap_text_end[];
+extern char __irqentry_text_start[], __irqentry_text_end[];
+
+#endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 9cd03f3e812f..02e9035b0685 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -19,6 +19,7 @@
 #define __ASM_TRAP_H
 
 #include <linux/list.h>
+#include <asm/sections.h>
 
 struct pt_regs;
 
@@ -39,9 +40,6 @@ void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static inline int __in_irqentry_text(unsigned long ptr)
 {
-	extern char __irqentry_text_start[];
-	extern char __irqentry_text_end[];
-
 	return ptr >= (unsigned long)&__irqentry_text_start &&
 	       ptr < (unsigned long)&__irqentry_text_end;
 }
@@ -54,8 +52,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
 
 static inline int in_exception_text(unsigned long ptr)
 {
-	extern char __exception_text_start[];
-	extern char __exception_text_end[];
 	int in;
 
 	in = ptr >= (unsigned long)&__exception_text_start &&
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 1788545f25bc..db5739413677 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -45,6 +45,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/ptrace.h>
+#include <asm/sections.h>
 
 /*
  * __boot_cpu_mode records what mode CPUs were booted in.
@@ -87,14 +88,6 @@ extern void verify_cpu_run_el(void);
 static inline void verify_cpu_run_el(void) {}
 #endif
 
-/* The section containing the hypervisor idmap text */
-extern char __hyp_idmap_text_start[];
-extern char __hyp_idmap_text_end[];
-
-/* The section containing the hypervisor text */
-extern char __hyp_text_start[];
-extern char __hyp_text_end[];
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d2ee1b21a10d..4434dabde898 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -25,14 +25,13 @@
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
+#include <asm/sections.h>
 #include <linux/stop_machine.h>
 
 #define __ALT_PTR(a,f)		(u32 *)((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
-
 struct alt_region {
 	struct alt_instr *begin;
 	struct alt_instr *end;
@@ -124,8 +123,8 @@ static int __apply_alternatives_multi_stop(void *unused)
 {
 	static int patched = 0;
 	struct alt_region region = {
-		.begin	= __alt_instructions,
-		.end	= __alt_instructions_end,
+		.begin	= (struct alt_instr *)__alt_instructions,
+		.end	= (struct alt_instr *)__alt_instructions_end,
 	};
 
 	/* We always have a CPU 0 at this point (__init) */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 65d81f965e74..b4082017c4cb 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -54,12 +54,6 @@ extern int in_suspend;
 /* Do we need to reset el2? */
 #define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
 
-/*
- * Start/end of the hibernate exit code, this must be copied to a 'safe'
- * location in memory, and executed from there.
- */
-extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
-
 /* temporary el2 vectors in the __hibernate_exit_text section. */
 extern char hibernate_el2_vectors[];
 
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c6b0f40620d8..2dc1b42afaaa 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -31,7 +31,7 @@
 #include <asm/insn.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
-#include <asm-generic/sections.h>
+#include <asm/sections.h>
 
 #include "decode-insn.h"
 
@@ -543,9 +543,6 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
-	extern char __idmap_text_start[], __idmap_text_end[];
-	extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
-
 	if ((addr >= (unsigned long)__kprobes_text_start &&
 	    addr < (unsigned long)__kprobes_text_end) ||
 	    (addr >= (unsigned long)__entry_text_start &&
-- 
2.8.0.rc3
