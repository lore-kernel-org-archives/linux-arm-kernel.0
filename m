From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 May 2018 14:14:51 +0100
Subject: [PATCH 2/2] arm64: Unify kernel fault reporting
In-Reply-To: <20180521131451.41040-1-mark.rutland@arm.com>
References: <20180521131451.41040-1-mark.rutland@arm.com>
Message-ID: <20180521131451.41040-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In do_page_fault(), we handle some kernel faults early, and simply
die() with a message. For faults handled later, we dump the faulting
address, decode the ESR, walk the page tables, and perform a number of
steps to ensure that this data is reported.

Let's unify the handling of fatal kernel faults with a new
die_kernel_fault() helper, handling all of these details. This is
largely the same as the existing logic in __do_kernel_fault(), except
that addresses are consistently padded to 16 hex characters, as would be
expected for a 64-bit address.

The messages currently logged in do_page_fault are adjusted to fit into
the die_kernel_fault() message template.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 59990491e72a..27cbe0b38960 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -255,6 +255,22 @@ static inline bool is_el1_permission_fault(unsigned int esr,
 	return false;
 }
 
+static void die_kernel_fault(const char *msg, unsigned long addr,
+			     unsigned int esr, struct pt_regs *regs)
+{
+	bust_spinlocks(1);
+
+	pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
+		 addr);
+
+	mem_abort_decode(esr);
+
+	show_pte(addr);
+	die("Oops", regs, esr);
+	bust_spinlocks(0);
+	do_exit(SIGKILL);
+}
+
 static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
@@ -267,8 +283,6 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
 		return;
 
-	bust_spinlocks(1);
-
 	if (is_el1_permission_fault(esr, regs, addr)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
@@ -280,15 +294,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 		msg = "paging request";
 	}
 
-	pr_alert("Unable to handle kernel %s at virtual address %08lx\n", msg,
-		 addr);
-
-	mem_abort_decode(esr);
-
-	show_pte(addr);
-	die("Oops", regs, esr);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
+	die_kernel_fault(msg, addr, esr, regs);
 }
 
 static void __do_user_fault(struct siginfo *info, unsigned int esr)
@@ -399,13 +405,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	if (addr < TASK_SIZE && is_el1_permission_fault(esr, regs, addr)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
-			die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
+			die_kernel_fault("access to user memory with fs=KERNEL_DS",
+					 addr, esr, regs);
 
 		if (is_el1_instruction_abort(esr))
-			die("Attempting to execute userspace memory", regs, esr);
+			die_kernel_fault("execution of user memory",
+					 addr, esr, regs);
 
 		if (!search_exception_tables(regs->pc))
-			die("Accessing user space memory outside uaccess.h routines", regs, esr);
+			die_kernel_fault("access to user memory outside uaccess routines",
+					 addr, esr, regs);
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
-- 
2.11.0
