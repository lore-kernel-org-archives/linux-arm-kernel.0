From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 8 May 2017 21:56:54 +0800
Subject: [PATCH 1/2] arm64: Call __show_regs directly
Message-ID: <1494251815-55961-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call __show_regs directly in longjmp_break_handler() and
__do_user_fault(), it is to prepare for dump stack when
softlockup detected.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/probes/kprobes.c | 4 ++--
 arch/arm64/mm/fault.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c5c4594..d849d98 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -522,9 +522,9 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 		pr_err("current sp %lx does not match saved sp %lx\n",
 		       orig_sp, stack_addr);
 		pr_err("Saved registers for jprobe %p\n", jp);
-		show_regs(saved_regs);
+		__show_regs(saved_regs);
 		pr_err("Current registers\n");
-		show_regs(regs);
+		__show_regs(regs);
 		BUG();
 	}
 	unpause_graph_tracing();
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 37b95df..c3f2b10 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -250,7 +250,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 			tsk->comm, task_pid_nr(tsk), inf->name, sig,
 			addr, esr);
 		show_pte(tsk->mm, addr);
-		show_regs(regs);
+		__show_regs(regs);
 	}
 
 	tsk->thread.fault_address = addr;
-- 
1.7.12.4
