From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 17 Aug 2017 16:13:55 +0900
Subject: [PATCH -tip 1/4] x86: Add in_entry_text() helper function
In-Reply-To: <150295395797.14424.968407208436624832.stgit@devbox>
References: <150295395797.14424.968407208436624832.stgit@devbox>
Message-ID: <150295402564.14424.15300433101224423177.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add in_entry_text() helper function to cleanup
entry/irqentry section checking code in kprobes and
unwind_frame.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/sections.h |   15 +++++++++++++++
 arch/x86/kernel/kprobes/opt.c   |    5 +----
 arch/x86/kernel/unwind_frame.c  |   15 +--------------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 2f75f30cb2f6..bb72ea0f4367 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -11,4 +11,19 @@ extern struct exception_table_entry __stop___ex_table[];
 extern char __end_rodata_hpage_align[];
 #endif
 
+/**
+ * in_entry_text - check if an address is in entry_text or irqentry_text
+ * @addr: virtual address to be checked
+ *
+ * Returns: true if the address specified by @addr is in the entry_text or
+ * irqentry_text, false otherwise.
+ */
+static inline bool in_entry_text(unsigned long addr)
+{
+	return memory_contains(__entry_text_start, __entry_text_end,
+			       (void *)addr, 0) ||
+		memory_contains(__irqentry_text_start, __irqentry_text_end,
+				(void *)addr, 0);
+}
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 4f98aad38237..74c5ad55ba6a 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -254,10 +254,7 @@ static int can_optimize(unsigned long paddr)
 	 * Do not optimize in the entry code due to the unstable
 	 * stack handling and registers setup.
 	 */
-	if (((paddr >= (unsigned long)__entry_text_start) &&
-	     (paddr <  (unsigned long)__entry_text_end)) ||
-	    ((paddr >= (unsigned long)__irqentry_text_start) &&
-	     (paddr <  (unsigned long)__irqentry_text_end)))
+	if (in_entry_text(paddr))
 		return 0;
 
 	/* Check there is enough space for a relative jump. */
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d145a0b1f529..508cef8904f4 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -77,19 +77,6 @@ static size_t regs_size(struct pt_regs *regs)
 	return sizeof(*regs);
 }
 
-static bool in_entry_code(unsigned long ip)
-{
-	char *addr = (char *)ip;
-
-	if (addr >= __entry_text_start && addr < __entry_text_end)
-		return true;
-
-	if (addr >= __irqentry_text_start && addr < __irqentry_text_end)
-		return true;
-
-	return false;
-}
-
 static inline unsigned long *last_frame(struct unwind_state *state)
 {
 	return (unsigned long *)task_pt_regs(state->task) - 2;
@@ -321,7 +308,7 @@ bool unwind_next_frame(struct unwind_state *state)
 	 * Don't warn if the unwinder got lost due to an interrupt in entry
 	 * code or in the C handler before the first frame pointer got set up:
 	 */
-	if (state->got_irq && in_entry_code(state->ip))
+	if (state->got_irq && in_entry_text(state->ip))
 		goto the_end;
 	if (state->regs &&
 	    state->regs->sp >= (unsigned long)last_aligned_frame(state) &&
