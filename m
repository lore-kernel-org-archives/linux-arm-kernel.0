From: andreyknvl@google.com (Andrey Konovalov)
Date: Mon, 19 Nov 2018 18:26:29 +0100
Subject: [PATCH v11 13/24] kasan, arm64: fix up fault handling logic
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
Message-ID: <99c747edfba8ea4b93d9c70aac47ea86ef258b86.1542648335.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now arm64 fault handling code removes pointer tags from addresses
covered by TTBR0 in faults taken from both EL0 and EL1, but doesn't do
that for pointers covered by TTBR1.

This patch adds two helper functions is_ttbr0_addr() and is_ttbr1_addr(),
where the latter one accounts for the fact that TTBR1 pointers might be
tagged when tag-based KASAN is in use, and uses these helper functions to
perform pointer checks in arch/arm64/mm/fault.c.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7d9571f4ae3d..6023d4752701 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -40,6 +40,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
+#include <asm/kasan.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/pgtable.h>
@@ -132,6 +133,18 @@ static void mem_abort_decode(unsigned int esr)
 		data_abort_decode(esr);
 }
 
+static inline bool is_ttbr0_addr(unsigned long addr)
+{
+        /* entry assembly clears tags for TTBR0 addrs */
+        return addr < TASK_SIZE;
+}
+
+static inline bool is_ttbr1_addr(unsigned long addr)
+{
+        /* TTBR1 addresses may have a tag if KASAN_SW_TAGS is in use */
+        return arch_kasan_reset_tag(addr) >= VA_START;
+}
+
 /*
  * Dump out the page tables associated with 'addr' in the currently active mm.
  */
@@ -141,7 +154,7 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
-	if (addr < TASK_SIZE) {
+	if (is_ttbr0_addr(addr)) {
 		/* TTBR0 */
 		mm = current->active_mm;
 		if (mm == &init_mm) {
@@ -149,7 +162,7 @@ void show_pte(unsigned long addr)
 				 addr);
 			return;
 		}
-	} else if (addr >= VA_START) {
+	} else if (is_ttbr1_addr(addr)) {
 		/* TTBR1 */
 		mm = &init_mm;
 	} else {
@@ -254,7 +267,7 @@ static inline bool is_el1_permission_fault(unsigned long addr, unsigned int esr,
 	if (fsc_type == ESR_ELx_FSC_PERM)
 		return true;
 
-	if (addr < TASK_SIZE && system_uses_ttbr0_pan())
+	if (is_ttbr0_addr(addr) && system_uses_ttbr0_pan())
 		return fsc_type == ESR_ELx_FSC_FAULT &&
 			(regs->pstate & PSR_PAN_BIT);
 
@@ -319,7 +332,7 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
 	 * type", so we ignore this wrinkle and just return the translation
 	 * fault.)
 	 */
-	if (current->thread.fault_address >= TASK_SIZE) {
+	if (!is_ttbr0_addr(current->thread.fault_address)) {
 		switch (ESR_ELx_EC(esr)) {
 		case ESR_ELx_EC_DABT_LOW:
 			/*
@@ -455,7 +468,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	if (addr < TASK_SIZE && is_el1_permission_fault(addr, esr, regs)) {
+	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
 		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 		if (regs->orig_addr_limit == KERNEL_DS)
 			die_kernel_fault("access to user memory with fs=KERNEL_DS",
@@ -603,7 +616,7 @@ static int __kprobes do_translation_fault(unsigned long addr,
 					  unsigned int esr,
 					  struct pt_regs *regs)
 {
-	if (addr < TASK_SIZE)
+	if (is_ttbr0_addr(addr))
 		return do_page_fault(addr, esr, regs);
 
 	do_bad_area(addr, esr, regs);
@@ -758,7 +771,7 @@ asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 	 * re-enabled IRQs. If the address is a kernel address, apply
 	 * BP hardening prior to enabling IRQs and pre-emption.
 	 */
-	if (addr > TASK_SIZE)
+	if (!is_ttbr0_addr(addr))
 		arm64_apply_bp_hardening();
 
 	local_daif_restore(DAIF_PROCCTX);
@@ -771,7 +784,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 					   struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
-		if (instruction_pointer(regs) > TASK_SIZE)
+		if (!is_ttbr0_addr(instruction_pointer(regs)))
 			arm64_apply_bp_hardening();
 		local_daif_restore(DAIF_PROCCTX);
 	}
@@ -825,7 +838,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+	if (user_mode(regs) && !is_ttbr0_addr(instruction_pointer(regs)))
 		arm64_apply_bp_hardening();
 
 	if (!inf->fn(addr, esr, regs)) {
-- 
2.19.1.1215.g8438c0b245-goog
