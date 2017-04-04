From: kamensky@cisco.com (Victor Kamensky)
Date: Mon,  3 Apr 2017 22:51:01 -0700
Subject: [PATCH v2] arm64: mm: unaligned access by user-land should be
 received as SIGBUS
In-Reply-To: <1491285061-15718-1-git-send-email-kamensky@cisco.com>
References: <1491285061-15718-1-git-send-email-kamensky@cisco.com>
Message-ID: <1491285061-15718-2-git-send-email-kamensky@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After 52d7523 (arm64: mm: allow the kernel to handle alignment faults on
user accesses) commit user-land accesses that produce unaligned exceptions
like in case of aarch32 ldm/stm/ldrd/strd instructions operating on
unaligned memory received by user-land as SIGSEGV. It is wrong, it should
be reported as SIGBUS as it was before 52d7523 commit.

Changed do_bad_area function to take signal and code parameters out of esr
value using fault_info table, so in case of do_alignment_fault fault
user-land will receive SIGBUS. Wrapped access to fault_info table into
esr_to_fault_info function.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Cc: xe-linux-external at cisco.com
Fixes: 52d7523 (arm64: mm: allow the kernel to handle alignment faults on user accesses)
---
 arch/arm64/mm/fault.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4bf899f..1b35b8bd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -42,7 +42,20 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
-static const char *fault_name(unsigned int esr);
+struct fault_info {
+	int	(*fn)(unsigned long addr, unsigned int esr,
+		      struct pt_regs *regs);
+	int	sig;
+	int	code;
+	const char *name;
+};
+
+static const struct fault_info fault_info[];
+
+static inline const struct fault_info *esr_to_fault_info(unsigned int esr)
+{
+	return fault_info + (esr & 63);
+}
 
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
@@ -197,10 +210,12 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 			    struct pt_regs *regs)
 {
 	struct siginfo si;
+	const struct fault_info *inf;
 
 	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
+		inf = esr_to_fault_info(esr);
 		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
-			tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
+			tsk->comm, task_pid_nr(tsk), inf->name, sig,
 			addr, esr);
 		show_pte(tsk->mm, addr);
 		show_regs(regs);
@@ -219,14 +234,16 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 {
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->active_mm;
+	const struct fault_info *inf;
 
 	/*
 	 * If we are in kernel mode at this point, we have no context to
 	 * handle this fault with.
 	 */
-	if (user_mode(regs))
-		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs);
-	else
+	if (user_mode(regs)) {
+		inf = esr_to_fault_info(esr);
+		__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs);
+	} else
 		__do_kernel_fault(mm, addr, esr, regs);
 }
 
@@ -488,12 +505,7 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 1;
 }
 
-static const struct fault_info {
-	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
-	int	sig;
-	int	code;
-	const char *name;
-} fault_info[] = {
+static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGBUS,  0,		"ttbr address size fault"	},
 	{ do_bad,		SIGBUS,  0,		"level 1 address size fault"	},
 	{ do_bad,		SIGBUS,  0,		"level 2 address size fault"	},
@@ -560,19 +572,13 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
-static const char *fault_name(unsigned int esr)
-{
-	const struct fault_info *inf = fault_info + (esr & 63);
-	return inf->name;
-}
-
 /*
  * Dispatch a data abort to the relevant handler.
  */
 asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 					 struct pt_regs *regs)
 {
-	const struct fault_info *inf = fault_info + (esr & 63);
+	const struct fault_info *inf = esr_to_fault_info(esr);
 	struct siginfo info;
 
 	if (!inf->fn(addr, esr, regs))
-- 
1.9.3
