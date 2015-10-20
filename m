From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Oct 2015 17:00:19 +0900
Subject: [PATCH v2 2/2] arm64: fix dump_backtrace() to show correct pt_regs at
 interrupt
In-Reply-To: <1445328019-23330-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445328019-23330-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1445328019-23330-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an extra dummy stack frame for interrupt has one side-effect that
dump_backtrace() shows inccorect data of struct pt_regs at
"Exception stack ..." because we are still on an interrupt stack when
dump_backtrace() encounters an interrupt handler's frame.

This patch reuses __in_irqentry_text() macro, which was added by
  commit 9a5ad7d0e3e1 ("arm64: Add __exception_irq_entry definition for
                        function graph"),
and allows dump_backtrace() to recognize an interrupt handler's
frame and fetch a correct pointer (sp) to struct pt_regs on an process
stack.

One of drawbacks in this approach is that we will sometimes see
__irqentry_text_start and gic_handle_irq interchangeably, especially,
when "perf report --call-graph" shows stack traces because both symbols
has the same address.
(Please note that this can happen even without this patch if
CONFIG_FUNCTION_GRAPH_TRACER is enabled.)

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/exception.h |    7 +++----
 arch/arm64/include/asm/traps.h     |    7 -------
 arch/arm64/kernel/traps.c          |    9 +++++++--
 arch/arm64/kernel/vmlinux.lds.S    |    7 +++++++
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 6cb7e1a..8415005 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -21,10 +21,9 @@
 #include <linux/ftrace.h>
 
 #define __exception	__attribute__((section(".exception.text")))
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* We always need this definition for dump_backtrace */
+#undef __irq_entry
+#define __irq_entry	__attribute__((__section__(".irqentry.text")))
 #define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry	__exception
-#endif
 
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 0cc2f29..8f05d3b 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -34,7 +34,6 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static inline int __in_irqentry_text(unsigned long ptr)
 {
 	extern char __irqentry_text_start[];
@@ -43,12 +42,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
 	return ptr >= (unsigned long)&__irqentry_text_start &&
 	       ptr < (unsigned long)&__irqentry_text_end;
 }
-#else
-static inline int __in_irqentry_text(unsigned long ptr)
-{
-	return 0;
-}
-#endif
 
 static inline int in_exception_text(unsigned long ptr)
 {
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e9b9b53..8fc3d4b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -179,10 +179,15 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		ret = unwind_frame(&frame);
 		if (ret < 0)
 			break;
-		stack = frame.sp;
-		if (in_exception_text(where))
+		if (__in_irqentry_text(where)) {
+			stack = *(unsigned long *)(frame.fp + 0x18);
+			dump_mem("", "Interrupt stack", stack,
+				 stack + sizeof(struct pt_regs), false);
+		} else if (in_exception_text(where)) {
+			stack = frame.sp;
 			dump_mem("", "Exception stack", stack,
 				 stack + sizeof(struct pt_regs), false);
+		}
 	}
 }
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 9807333..0d16d02 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -44,6 +44,13 @@ jiffies = jiffies_64;
 	*(.idmap.text)					\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;
 
+#undef IRQENTRY_TEXT
+#define IRQENTRY_TEXT						\
+		ALIGN_FUNCTION();				\
+		VMLINUX_SYMBOL(__irqentry_text_start) = .;	\
+		*(.irqentry.text)				\
+		VMLINUX_SYMBOL(__irqentry_text_end) = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
-- 
1.7.9.5
