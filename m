From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 12:33:03 +0100
Subject: [PATCH 3/3] arm64: kill ESR_LNX_EXEC
In-Reply-To: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
References: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1464694383-31700-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we treat ESR_EL1 bit 24 as software-defined for distinguishing
instruction aborts from data aborts, but this bit is architecturally
RES0 for instruction aborts, and could be allocated for an arbitrary
purpose in future. Additionally, we hard-code the value in entry.S
without the mnemonic, making the code difficult to understand.

Instead, remove ESR_LNX_EXEC, and distinguish aborts based on the esr,
which we already pass to the sole use of ESR_LNX_EXEC. A new helper,
is_el0_instruction_abort() is added to make the logic clear. Any
instruction aborts taken from EL1 will already have been handled by
bad_mode, so we need not handle that case in the helper.

For consistency, the existing permission_fault helper is renamed to
is_permission_fault, and the return type is changed to bool. There
should be no functional changes as the return value was a boolean
expression, and the result is only used in another boolean expression.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave P Martin <dave.martin@arm.com>
Cc: Huang Shijie <shijie.huang@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S |  2 +-
 arch/arm64/mm/fault.c     | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 12e8d2b..eefffa8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -532,7 +532,7 @@ el0_ia:
 	enable_dbg_and_irq
 	ct_user_exit
 	mov	x0, x26
-	orr	x1, x25, #1 << 24		// use reserved ISS bit for instruction aborts
+	mov	x1, x25
 	mov	x2, sp
 	bl	do_mem_abort
 	b	ret_to_user
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6b6f5ec..5af5f7f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -202,8 +202,6 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
-#define ESR_LNX_EXEC		(1 << 24)
-
 static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags,
 			   struct task_struct *tsk)
@@ -242,7 +240,7 @@ out:
 	return fault;
 }
 
-static inline int permission_fault(unsigned int esr)
+static inline bool is_permission_fault(unsigned int esr)
 {
 	unsigned int ec       = ESR_ELx_EC(esr);
 	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
@@ -250,6 +248,11 @@ static inline int permission_fault(unsigned int esr)
 	return (ec == ESR_ELx_EC_DABT_CUR && fsc_type == ESR_ELx_FSC_PERM);
 }
 
+static bool is_el0_instruction_abort(unsigned int esr)
+{
+	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
+}
+
 static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				   struct pt_regs *regs)
 {
@@ -272,14 +275,14 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	if (user_mode(regs))
 		mm_flags |= FAULT_FLAG_USER;
 
-	if (esr & ESR_LNX_EXEC) {
+	if (is_el0_instruction_abort(esr)) {
 		vm_flags = VM_EXEC;
 	} else if ((esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM)) {
 		vm_flags = VM_WRITE;
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (permission_fault(esr) && (addr < USER_DS)) {
+	if (is_permission_fault(esr) && (addr < USER_DS)) {
 		if (get_fs() == KERNEL_DS)
 			die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
 
-- 
1.9.1
