From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 17 Aug 2017 16:15:00 +0900
Subject: [PATCH -tip 2/4] arm: Cleanup in_exception_text() and move it in
 asm/sections.h
In-Reply-To: <150295395797.14424.968407208436624832.stgit@devbox>
References: <150295395797.14424.968407208436624832.stgit@devbox>
Message-ID: <150295409062.14424.11976553130089631456.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup in_exception_text() using memory_contains() and
move it in asm/sections.h from asm/trap.h because
section symbols and memory_contains() are defined in
asm/sections.h.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/include/asm/sections.h |   17 +++++++++++++++++
 arch/arm/include/asm/traps.h    |   22 +---------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
index 803bbf2b20b8..76791cfc7619 100644
--- a/arch/arm/include/asm/sections.h
+++ b/arch/arm/include/asm/sections.h
@@ -4,5 +4,22 @@
 #include <asm-generic/sections.h>
 
 extern char _exiprom[];
+extern char __exception_text_start[], __exception_text_end[];
+
+/**
+ * in_exception_text - check if an address is in exception_text or
+ *			irqentry_text
+ * @addr: virtual address to be checked
+ *
+ * Returns: true if the address specified by @addr is in the exception_text or
+ * irqentry_text, false otherwise.
+ */
+static inline bool in_exception_text(unsigned long addr)
+{
+	return memory_contains(__exception_text_start, __exception_text_end,
+			       (void *)addr, 0) ||
+		memory_contains(__irqentry_text_start, __irqentry_text_end,
+				(void *)addr, 0);
+}
 
 #endif	/* _ASM_ARM_SECTIONS_H */
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 683d9230984a..0ee9a87b9dd4 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -2,6 +2,7 @@
 #define _ASMARM_TRAP_H
 
 #include <linux/list.h>
+#include <asm/sections.h>
 
 struct pt_regs;
 struct task_struct;
@@ -18,27 +19,6 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
-static inline int __in_irqentry_text(unsigned long ptr)
-{
-	extern char __irqentry_text_start[];
-	extern char __irqentry_text_end[];
-
-	return ptr >= (unsigned long)&__irqentry_text_start &&
-	       ptr < (unsigned long)&__irqentry_text_end;
-}
-
-static inline int in_exception_text(unsigned long ptr)
-{
-	extern char __exception_text_start[];
-	extern char __exception_text_end[];
-	int in;
-
-	in = ptr >= (unsigned long)&__exception_text_start &&
-	     ptr < (unsigned long)&__exception_text_end;
-
-	return in ? : __in_irqentry_text(ptr);
-}
-
 extern void __init early_trap_init(void *);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
 extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
