From: maninder1.s@samsung.com (Maninder Singh)
Date: Wed, 30 Nov 2016 13:33:56 +0530
Subject: [PATCH 1/2] arm64: Correcting format specifier for printin 64 bit
 addresses
Message-ID: <1480493036-47334-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects format specifier for printing 64 bit addresses.

Before Patch
============
[   68.251603] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   68.251673] pgd = ffffffc013950000
[   68.251782] [00000000] *pgd=0000000093e19003, *pud=0000000093e19003, *pmd=0000000000000000

After patch
===========
[    8.565030] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    8.565389] pgd = ffffffc013872000
[    8.565553] [0000000000000000] *pgd=0000000093874003, *pud=0000000093874003, *pmd=0000000000000000

and same for user space fault.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm64/mm/fault.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a78a5c4..8cb5c93 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -77,7 +77,7 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 
 	pr_alert("pgd = %p\n", mm->pgd);
 	pgd = pgd_offset(mm, addr);
-	pr_alert("[%08lx] *pgd=%016llx", addr, pgd_val(*pgd));
+	pr_alert("[%016lx] *pgd=%016llx", addr, pgd_val(*pgd));
 
 	do {
 		pud_t *pud;
@@ -177,7 +177,7 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
 	bust_spinlocks(1);
-	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
+	pr_alert("Unable to handle kernel %s at virtual address %016lx\n",
 		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
 		 "paging request", addr);
 
@@ -198,9 +198,15 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	struct siginfo si;
 
 	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: unhandled %s (%d)@0x%08lx, esr 0x%03x\n",
-			tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
-			addr, esr);
+		if (compat_user_mode(regs))
+			pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
+				tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
+				addr, esr);
+		else
+			pr_info("%s[%d]: unhandled %s (%d) at 0x%016lx, esr 0x%03x\n",
+				tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
+				addr, esr);
+
 		show_pte(tsk->mm, addr);
 		show_regs(regs);
 	}
-- 
1.9.1
