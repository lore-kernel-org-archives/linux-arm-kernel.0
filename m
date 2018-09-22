From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Sat, 22 Sep 2018 21:09:53 +0530
Subject: [PATCH 2/5] arm64/mm: Reorganize arguments for
 is_el1_permission_fault()
In-Reply-To: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
References: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537630796-14756-3-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most memory abort exception handling related functions have the arguments
in the order (addr, esr, regs) except is_el1_permission_fault(). This
changes the argument order in this function as (addr, esr, regs) like
others.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 75b8794..30e040c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -235,9 +235,8 @@ static bool is_el1_instruction_abort(unsigned int esr)
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
 }
 
-static inline bool is_el1_permission_fault(unsigned int esr,
-					   struct pt_regs *regs,
-					   unsigned long addr)
+static inline bool is_el1_permission_fault(unsigned long addr, unsigned int esr,
+					   struct pt_regs *regs)
 {
 	unsigned int ec       = ESR_ELx_EC(esr);
 	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
@@ -283,7 +282,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	if (!is_el1_instruction_abort(esr) && fixup_exception(regs))
 		return;
 
-	if (is_el1_permission_fault(esr, regs, addr)) {
+	if (is_el1_permission_fault(addr, esr, regs)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
 		else
@@ -454,7 +453,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (addr < TASK_SIZE && is_el1_permission_fault(esr, regs, addr)) {
+	if (addr < TASK_SIZE && is_el1_permission_fault(addr, esr, regs)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
 			die_kernel_fault("access to user memory with fs=KERNEL_DS",
-- 
2.7.4
