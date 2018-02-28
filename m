From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:29 +0800
Subject: [PATCH 07/29] arm64: entry.S: move SError handling into a C function
 for future expansion
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-8-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xie XiuQi <xiexiuqi@huawei.com>

commit a92d4d1454ab upstream.

Today SError is taken using the inv_entry macro that ends up in
bad_mode.

SError can be used by the RAS Extensions to notify either the OS or
firmware of CPU problems, some of which may have been corrected.

To allow this handling to be added, add a do_serror() C function
that just panic()s. Add the entry.S boiler plate to save/restore the
CPU registers and unmask debug exceptions. Future patches may change
do_serror() to return if the SError Interrupt was notification of a
corrected error.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Wang Xiongfeng <wangxiongfengi2@huawei.com>
[Split out of a bigger patch, added compat path, renamed, enabled debug
 exceptions]
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no vmap_stack in arch/arm64/kernel/traps.c
	using old enable_dbg_and_irq instead of enable_daif in
		arch/arm64/kernel/entry.S
---
 arch/arm64/kernel/entry.S | 36 +++++++++++++++++++++++++++++-------
 arch/arm64/kernel/traps.c | 14 ++++++++++++++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f5aa8f0..60b202a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -270,18 +270,18 @@ ENTRY(vectors)
 	kernel_ventry	el1_sync			// Synchronous EL1h
 	kernel_ventry	el1_irq				// IRQ EL1h
 	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
-	kernel_ventry	el1_error_invalid		// Error EL1h
+	kernel_ventry	el1_error			// Error EL1h
 
 	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
 	kernel_ventry	el0_irq				// IRQ 64-bit EL0
 	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 64-bit EL0
+	kernel_ventry	el0_error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
 	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
 	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
 	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	kernel_ventry	el0_error_compat		// Error 32-bit EL0
 #else
 	kernel_ventry	el0_sync_invalid		// Synchronous 32-bit EL0
 	kernel_ventry	el0_irq_invalid			// IRQ 32-bit EL0
@@ -321,10 +321,6 @@ ENDPROC(el0_error_invalid)
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
-
-el0_error_invalid_compat:
-	inv_entry 0, BAD_ERROR, 32
-ENDPROC(el0_error_invalid_compat)
 #endif
 
 el1_sync_invalid:
@@ -532,6 +528,10 @@ el0_svc_compat:
 el0_irq_compat:
 	kernel_entry 0, 32
 	b	el0_irq_naked
+
+el0_error_compat:
+	kernel_entry 0, 32
+	b	el0_error_naked
 #endif
 
 el0_da:
@@ -653,6 +653,28 @@ el0_irq_naked:
 	b	ret_to_user
 ENDPROC(el0_irq)
 
+el1_error:
+	kernel_entry 1
+	mrs	x1, esr_el1
+	enable_dbg
+	mov	x0, sp
+	bl	do_serror
+	kernel_exit 1
+ENDPROC(el1_error)
+
+el0_error:
+	kernel_entry 0
+el0_error_naked:
+	mrs	x1, esr_el1
+	enable_dbg
+	mov	x0, sp
+	bl	do_serror
+	enable_dbg_and_irq
+	ct_user_exit
+	b	ret_to_user
+ENDPROC(el0_error)
+
+
 /*
  * Register switch for AArch64. The callee-saved registers need to be saved
  * and restored. On entry:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c743d1f..2ef7e33 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -637,6 +637,20 @@ asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 	force_sig_info(info.si_signo, &info, current);
 }
 
+
+asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
+{
+	nmi_enter();
+
+	console_verbose();
+
+	pr_crit("SError Interrupt on CPU%d, code 0x%08x -- %s\n",
+		smp_processor_id(), esr, esr_get_class_string(esr));
+	__show_regs(regs);
+
+	panic("Asynchronous SError Interrupt");
+}
+
 void __pte_error(const char *file, int line, unsigned long val)
 {
 	pr_err("%s:%d: bad pte %016lx.\n", file, line, val);
-- 
2.7.4
