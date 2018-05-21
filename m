From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 May 2018 14:14:50 +0100
Subject: [PATCH 1/2] arm64: make is_permission_fault() name clearer
In-Reply-To: <20180521131451.41040-1-mark.rutland@arm.com>
References: <20180521131451.41040-1-mark.rutland@arm.com>
Message-ID: <20180521131451.41040-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The naming of is_permission_fault() makes it sound like it should return
true for permission faults from EL0, but by design, it only does so for
faults from EL1.

Let's make this clear by dropping el1 in the name, as we do for
is_el1_instruction_abort().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485e8b6e..59990491e72a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -235,8 +235,9 @@ static bool is_el1_instruction_abort(unsigned int esr)
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
 }
 
-static inline bool is_permission_fault(unsigned int esr, struct pt_regs *regs,
-				       unsigned long addr)
+static inline bool is_el1_permission_fault(unsigned int esr,
+					   struct pt_regs *regs,
+					   unsigned long addr)
 {
 	unsigned int ec       = ESR_ELx_EC(esr);
 	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
@@ -268,7 +269,7 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 
 	bust_spinlocks(1);
 
-	if (is_permission_fault(esr, regs, addr)) {
+	if (is_el1_permission_fault(esr, regs, addr)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
 		else
@@ -395,7 +396,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (addr < TASK_SIZE && is_permission_fault(esr, regs, addr)) {
+	if (addr < TASK_SIZE && is_el1_permission_fault(esr, regs, addr)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
 			die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
-- 
2.11.0
