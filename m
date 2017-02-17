From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 16 Feb 2017 17:19:59 -0800
Subject: [PATCH v2] arm64: print a fault message when attempting to write RO
 memory
Message-ID: <20170217011959.26754-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a page is marked read only we should print out that fact,
instead of printing out that there was a page fault. Right now we
get a cryptic error message that something went wrong with an
unhandled fault, but we don't evaluate the esr to figure out that
it was a read/write permission fault.

Instead of seeing:

  Unable to handle kernel paging request at virtual address ffff000008e460d8
  pgd = ffff800003504000
  [ffff000008e460d8] *pgd=0000000083473003, *pud=0000000083503003, *pmd=0000000000000000
  Internal error: Oops: 9600004f [#1] PREEMPT SMP

we'll see:

  Unable to handle kernel write to read-only memory at virtual address ffff000008e760d8
  pgd = ffff80003d3de000
  [ffff000008e760d8] *pgd=0000000083472003, *pud=0000000083435003, *pmd=0000000000000000
  Internal error: Oops: 9600004f [#1] PREEMPT SMP

Cc: James Morse <james.morse@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

Changes from v1:
 * Move into __do_kernel_fault() (Mark Rutland)

 arch/arm64/mm/fault.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 156169c6981b..8bd4e7f11c70 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -160,12 +160,28 @@ static bool is_el1_instruction_abort(unsigned int esr)
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
 }
 
+static inline bool is_permission_fault(unsigned int esr, struct pt_regs *regs)
+{
+	unsigned int ec       = ESR_ELx_EC(esr);
+	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
+
+	if (ec != ESR_ELx_EC_DABT_CUR && ec != ESR_ELx_EC_IABT_CUR)
+		return false;
+
+	if (system_uses_ttbr0_pan())
+		return fsc_type == ESR_ELx_FSC_FAULT &&
+			(regs->pstate & PSR_PAN_BIT);
+	else
+		return fsc_type == ESR_ELx_FSC_PERM;
+}
+
 /*
  * The kernel tried to access some page that wasn't present.
  */
 static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
 			      unsigned int esr, struct pt_regs *regs)
 {
+	const char *msg;
 	/*
 	 * Are we prepared to handle this kernel fault?
 	 * We are almost certainly not prepared to handle instruction faults.
@@ -177,9 +193,19 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
 	bust_spinlocks(1);
-	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
-		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
-		 "paging request", addr);
+
+	if (is_permission_fault(esr, regs)) {
+		if (esr & ESR_ELx_WNR)
+			msg = "write to read-only memory";
+		else
+			msg = "read from unreadable memory";
+	} else if (addr < PAGE_SIZE)
+		msg = "NULL pointer dereference";
+	else
+		msg = "paging request";
+
+	pr_alert("Unable to handle kernel %s@virtual address %08lx\n", msg,
+		 addr);
 
 	show_pte(mm, addr);
 	die("Oops", regs, esr);
@@ -269,21 +295,6 @@ static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	return fault;
 }
 
-static inline bool is_permission_fault(unsigned int esr, struct pt_regs *regs)
-{
-	unsigned int ec       = ESR_ELx_EC(esr);
-	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
-
-	if (ec != ESR_ELx_EC_DABT_CUR && ec != ESR_ELx_EC_IABT_CUR)
-		return false;
-
-	if (system_uses_ttbr0_pan())
-		return fsc_type == ESR_ELx_FSC_FAULT &&
-			(regs->pstate & PSR_PAN_BIT);
-	else
-		return fsc_type == ESR_ELx_FSC_PERM;
-}
-
 static bool is_el0_instruction_abort(unsigned int esr)
 {
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
-- 
2.10.0.297.gf6727b0
