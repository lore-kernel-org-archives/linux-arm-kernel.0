From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Mon, 22 May 2017 12:45:54 +0100
Subject: [PATCH 2/2] arm64: mm: don't print out page table entries on EL0
 faults
In-Reply-To: <1495453554-9412-1-git-send-email-kristina.martsenko@arm.com>
References: <1495453554-9412-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1495453554-9412-2-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we take a fault from EL0 that can't be handled, we print out the
page table entries associated with the faulting address. This allows
userspace to print out any current page table entries, including kernel
(TTBR1) entries.  Exposing kernel mappings like this could pose a
security risk, so don't print out page table information on EL0 faults.
(But still print it out for EL1 faults.)

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0c32f34fb4af..798841f4b00a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -260,7 +260,6 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
 			tsk->comm, task_pid_nr(tsk), inf->name, sig,
 			addr, esr);
-		show_pte(addr);
 		show_regs(regs);
 	}
 
-- 
2.1.4
