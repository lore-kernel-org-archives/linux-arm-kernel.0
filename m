From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:58:06 +0100
Subject: [PATCH 9/9] arm64: entry.S: move SError handling into a C function
 for future expansion
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-10-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xie XiuQi <xiexiuqi@huawei.com>

Today SError is taken using the inv_entry macro that ends up in
bad_mode.

SError can be used by the RAS Extensions to notify either the OS or
firmware of CPU problems, some of which may have been corrected.

To allow this handling to be added, add a do_serror() C function
that panic()s. Without the RAS features added by v8.2 we can't do any
better. In particular the ARM-ARM's D1.14.4 "Prioritization and
recognition of interrupts" allows an IRQ to be taken before SError
if both are pending.

Add the entry.S boiler plate to save/restore the CPU registers and
unmask debug exceptions. Future patches may change do_serror() to
return if the SError Interrupt was notification of a corrected error.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Wang Xiongfeng <wangxiongfengi2@huawei.com>
[Split out of a bigger patch, added compat path, renamed, enabled debug
 exceptions]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig        |  1 +
 arch/arm64/kernel/entry.S | 36 +++++++++++++++++++++++++++++-------
 arch/arm64/kernel/traps.c | 13 +++++++++++++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec69bca..5813ecc8a3b9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -92,6 +92,7 @@ config ARM64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
+	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index bd1100105212..1f7cf906445d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -329,18 +329,18 @@ ENTRY(vectors)
 	ventry	el1_sync			// Synchronous EL1h
 	ventry	el1_irq				// IRQ EL1h
 	ventry	el1_fiq_invalid			// FIQ EL1h
-	ventry	el1_error_invalid		// Error EL1h
+	ventry	el1_serror			// Error EL1h
 
 	ventry	el0_sync			// Synchronous 64-bit EL0
 	ventry	el0_irq				// IRQ 64-bit EL0
 	ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	ventry	el0_error_invalid		// Error 64-bit EL0
+	ventry	el0_serror			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
 	ventry	el0_sync_compat			// Synchronous 32-bit EL0
 	ventry	el0_irq_compat			// IRQ 32-bit EL0
 	ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	ventry	el0_serror_compat		// Error 32-bit EL0
 #else
 	ventry	el0_sync_invalid		// Synchronous 32-bit EL0
 	ventry	el0_irq_invalid			// IRQ 32-bit EL0
@@ -380,10 +380,6 @@ ENDPROC(el0_error_invalid)
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
-
-el0_error_invalid_compat:
-	inv_entry 0, BAD_ERROR, 32
-ENDPROC(el0_error_invalid_compat)
 #endif
 
 el1_sync_invalid:
@@ -592,6 +588,10 @@ el0_svc_compat:
 el0_irq_compat:
 	kernel_entry 0, 32
 	b	el0_irq_naked
+
+el0_serror_compat:
+	kernel_entry 0, 32
+	b	el0_serror_naked
 #endif
 
 el0_da:
@@ -690,6 +690,28 @@ el0_irq_naked:
 	b	ret_to_user
 ENDPROC(el0_irq)
 
+el1_serror:
+	kernel_entry 1
+	mrs	x1, esr_el1
+	enable_dbg
+	mov	x0, sp
+	bl	do_serror
+	kernel_exit 1
+ENDPROC(el1_serror)
+
+el0_serror:
+	kernel_entry 0
+el0_serror_naked:
+	mrs	x1, esr_el1
+	enable_dbg
+	mov	x0, sp
+	bl	do_serror
+	enable_daif
+	ct_user_exit
+	b	ret_to_user
+ENDPROC(el0_serror)
+
+
 /*
  * Register switch for AArch64. The callee-saved registers need to be saved
  * and restored. On entry:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 52d75e3dcd80..ef008103dcca 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -683,6 +683,19 @@ asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 	force_sig_info(info.si_signo, &info, current);
 }
 
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
2.11.0
