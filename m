From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 9 May 2017 09:53:36 +0800
Subject: [PATCH v2 1/2] arm64: Call __show_regs directly
In-Reply-To: <20170508145535.GF5480@leverpostej>
References: <20170508145535.GF5480@leverpostej>
Message-ID: <1494294817-29187-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic code expects show_regs() to also dump the stack, but arm64's
show_reg() does not do this. Some arm64 callers of show_regs() *only*
want the registers dumped, without the stack.

To enable generic code to work as expected, we need to make
show_regs() dump the stack. Where we only want the registers dumped,
we must use __show_regs().

This patch updates code to use __show_regs() where only registers are
desired. A subsequent patch will modify show_regs().

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

v1->v2:
- Update the changelog according to Mark's kindly review, thanks Mark again.

Please see the background from link [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/494840.html

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
