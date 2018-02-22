From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:51 +0000
Subject: [PATCH 3/9] arm64: Introduce arm64_force_sig_info and hook up in
 arm64_notify_die
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for consolidating our handling of printing unhandled
signals, introduce a wrapper around force_sig_info which can act as
the canonical place for dealing with show_unhandled_signals.

Initially, we just hook this up to arm64_notify_die.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/traps.h |  2 ++
 arch/arm64/kernel/traps.c      | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 1ee63dc38579..c320f3bf6c57 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -37,6 +37,8 @@ void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
+void arm64_force_sig_info(struct siginfo *info, const char *str,
+			  struct task_struct *tsk);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 3f52c07b4bf4..b46b5be5bd6d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -223,13 +223,39 @@ void die(const char *str, struct pt_regs *regs, int err)
 		do_exit(SIGSEGV);
 }
 
+void arm64_force_sig_info(struct siginfo *info, const char *str,
+			  struct task_struct *tsk)
+{
+	unsigned int esr = tsk->thread.fault_code;
+	struct pt_regs *regs = task_pt_regs(tsk);
+
+	if (!unhandled_signal(tsk, info->si_signo))
+		goto send_sig;
+
+	if (!show_unhandled_signals_ratelimited())
+		goto send_sig;
+
+	pr_info("%s[%d]: unhandled exception: ", tsk->comm, task_pid_nr(tsk));
+	if (esr)
+		pr_cont("%s, ESR 0x%03x, ", esr_get_class_string(esr), esr);
+
+	pr_cont("%s", str);
+	print_vma_addr(KERN_CONT " in ", regs->pc);
+	pr_cont("\n");
+	__show_regs(regs);
+
+send_sig:
+	force_sig_info(info->si_signo, info, tsk);
+}
+
 void arm64_notify_die(const char *str, struct pt_regs *regs,
 		      struct siginfo *info, int err)
 {
 	if (user_mode(regs)) {
+		WARN_ON(regs != current_pt_regs());
 		current->thread.fault_address = 0;
 		current->thread.fault_code = err;
-		force_sig_info(info->si_signo, info, current);
+		arm64_force_sig_info(info, str, current);
 	} else {
 		die(str, regs, err);
 	}
-- 
2.1.4
