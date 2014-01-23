From: dave.long@linaro.org (David Long)
Date: Thu, 23 Jan 2014 15:05:44 -0500
Subject: [PATCH v5 01/16] uprobes: allow ignoring of probe hits
In-Reply-To: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
Message-ID: <1390507559-4697-2-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Allow arches to decided to ignore a probe hit.  ARM will use this to
only call handlers if the conditions to execute a conditionally executed
instruction are satisfied.

Signed-off-by: David A. Long <dave.long@linaro.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/uprobes.h | 1 +
 kernel/events/uprobes.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 319eae7..197a36e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -134,6 +134,7 @@ extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
 extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
 extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
+extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 24b7d6c..4eec7ce 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1778,6 +1778,11 @@ static bool handle_trampoline(struct pt_regs *regs)
 	return true;
 }
 
+bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs)
+{
+	return false;
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -1828,7 +1833,11 @@ static void handle_swbp(struct pt_regs *regs)
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
 
+	if (arch_uprobe_ignore(&uprobe->arch, regs))
+		goto out;
+
 	handler_chain(uprobe, regs);
+
 	if (can_skip_sstep(uprobe, regs))
 		goto out;
 
-- 
1.8.1.2
