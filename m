From: dave.long@linaro.org (David Long)
Date: Wed, 27 Apr 2016 14:53:01 -0400
Subject: [PATCH v12 06/10] arm64: Treat all entry code as non-kprobe-able
In-Reply-To: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
Message-ID: <1461783185-9056-7-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <panand@redhat.com>

Entry symbols are not kprobe safe. So blacklist them for kprobing.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/entry.S       |  3 +++
 arch/arm64/kernel/kprobes.c     | 10 ++++++++++
 arch/arm64/kernel/vmlinux.lds.S |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 12e8d2b..7d99bed 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -243,6 +243,7 @@ tsk	.req	x28		// current thread_info
  * Exception vectors.
  */
 
+	.pushsection ".entry.text", "ax"
 	.align	11
 ENTRY(vectors)
 	ventry	el1_sync_invalid		// Synchronous EL1t
@@ -781,3 +782,5 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
+
+	.popsection
diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
index dfa1b1f..6a1292b 100644
--- a/arch/arm64/kernel/kprobes.c
+++ b/arch/arm64/kernel/kprobes.c
@@ -29,6 +29,7 @@
 #include <asm/system_misc.h>
 #include <asm/insn.h>
 #include <asm/uaccess.h>
+#include <asm-generic/sections.h>
 
 #include "kprobes-arm64.h"
 
@@ -514,6 +515,15 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	return 1;
 }
 
+bool arch_within_kprobe_blacklist(unsigned long addr)
+{
+	return  (addr >= (unsigned long)__kprobes_text_start &&
+		 addr < (unsigned long)__kprobes_text_end) ||
+		(addr >= (unsigned long)__entry_text_start &&
+		 addr < (unsigned long)__entry_text_end) ||
+		 !!search_exception_tables(addr);
+}
+
 int __init arch_init_kprobes(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e205789..fb68ff8 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -104,6 +104,7 @@ SECTIONS
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			SOFTIRQENTRY_TEXT
+			ENTRY_TEXT
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
-- 
2.5.0
