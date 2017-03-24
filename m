From: opendmb@gmail.com (Doug Berger)
Date: Fri, 24 Mar 2017 07:46:26 -0700
Subject: [PATCH 3/9] arm64: mm: install SError abort handler
In-Reply-To: <20170324144632.5896-1-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
Message-ID: <20170324144632.5896-4-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for minimal handling of SError aborts and
allows them to be hooked by a driver or other part of the kernel to
install a custom SError abort handler.  The hook function returns
the previously registered handler so that handlers may be chained if
desired.

The handler should return the value 0 if the error has been handled,
otherwise the handler should either call the next handler in the
chain or return a non-zero value.

Since the Instruction Specific Syndrome value for SError aborts is
implementation specific the registerred handlers must implement
their own parsing of the syndrome.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 arch/arm64/include/asm/system_misc.h |  2 ++
 arch/arm64/kernel/entry.S            | 69 ++++++++++++++++++++++++++++++++----
 arch/arm64/mm/fault.c                | 31 ++++++++++++++++
 3 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index e05f5b8c7c1c..60ac784ff4e6 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -41,6 +41,8 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 void hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 				       struct pt_regs *),
 		     int sig, int code, const char *name);
+void *hook_serror_handler(int (*fn)(unsigned long, unsigned int,
+				    struct pt_regs *));
 
 struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 43512d4d7df2..d043d66b390d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -323,18 +323,18 @@ ENTRY(vectors)
 	ventry	el1_sync			// Synchronous EL1h
 	ventry	el1_irq				// IRQ EL1h
 	ventry	el1_fiq_invalid			// FIQ EL1h
-	ventry	el1_error_invalid		// Error EL1h
+	ventry	el1_error			// Error EL1h
 
 	ventry	el0_sync			// Synchronous 64-bit EL0
 	ventry	el0_irq				// IRQ 64-bit EL0
 	ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	ventry	el0_error_invalid		// Error 64-bit EL0
+	ventry	el0_error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
 	ventry	el0_sync_compat			// Synchronous 32-bit EL0
 	ventry	el0_irq_compat			// IRQ 32-bit EL0
 	ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	ventry	el0_error_compat		// Error 32-bit EL0
 #else
 	ventry	el0_sync_invalid		// Synchronous 32-bit EL0
 	ventry	el0_irq_invalid			// IRQ 32-bit EL0
@@ -374,10 +374,6 @@ ENDPROC(el0_error_invalid)
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
-
-el0_error_invalid_compat:
-	inv_entry 0, BAD_ERROR, 32
-ENDPROC(el0_error_invalid_compat)
 #endif
 
 el1_sync_invalid:
@@ -508,6 +504,34 @@ el1_preempt:
 	ret	x24
 #endif
 
+	.align	6
+el1_error:
+	kernel_entry 1
+	mrs	x1, esr_el1			// read the syndrome register
+	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_SERROR		// SError exception in EL1
+	b.ne	el1_error_inv
+el1_serr:
+	mrs	x0, far_el1
+	enable_dbg
+	// re-enable interrupts if they were enabled in the aborted context
+	tbnz	x23, #7, 1f			// PSR_I_BIT
+	enable_irq
+1:
+	mov	x2, sp				// struct pt_regs
+	bl	do_serr_abort
+
+	// disable interrupts before pulling preserved data off the stack
+	disable_irq
+	kernel_exit 1
+el1_error_inv:
+	enable_dbg
+	mov	x0, sp
+	mov	x2, x1
+	mov	x1, #BAD_ERROR
+	b	bad_mode
+ENDPROC(el1_error)
+
 /*
  * EL0 mode handlers.
  */
@@ -584,6 +608,11 @@ el0_svc_compat:
 el0_irq_compat:
 	kernel_entry 0, 32
 	b	el0_irq_naked
+
+	.align	6
+el0_error_compat:
+	kernel_entry 0, 32
+	b	el0_error_naked
 #endif
 
 el0_da:
@@ -705,6 +734,32 @@ el0_irq_naked:
 	b	ret_to_user
 ENDPROC(el0_irq)
 
+	.align	6
+el0_error:
+	kernel_entry 0
+el0_error_naked:
+	mrs	x25, esr_el1			// read the syndrome register
+	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_SERROR		// SError exception in EL0
+	b.ne	el0_error_inv
+el0_serr:
+	mrs	x26, far_el1
+	// enable interrupts before calling the main handler
+	enable_dbg_and_irq
+	ct_user_exit
+	bic	x0, x26, #(0xff << 56)
+	mov	x1, x25
+	mov	x2, sp
+	bl	do_serr_abort
+	b	ret_to_user
+el0_error_inv:
+	enable_dbg
+	mov	x0, sp
+	mov	x1, #BAD_ERROR
+	mov	x2, x25
+	b	bad_mode
+ENDPROC(el0_error)
+
 /*
  * Register switch for AArch64. The callee-saved registers need to be saved
  * and restored. On entry:
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 43319ed58a47..577fecea7c7d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -705,3 +705,34 @@ int cpu_enable_pan(void *__unused)
 	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
+
+static int (*serror_handler)(unsigned long, unsigned int,
+			     struct pt_regs *) __ro_after_init;
+
+void *__init hook_serror_handler(int (*fn)(unsigned long, unsigned int,
+				 struct pt_regs *))
+{
+	void *ret = serror_handler;
+
+	serror_handler = fn;
+	return ret;
+}
+
+asmlinkage void __exception do_serr_abort(unsigned long addr, unsigned int esr,
+					 struct pt_regs *regs)
+{
+	struct siginfo info;
+
+	if (serror_handler)
+		if (!serror_handler(addr, esr, regs))
+			return;
+
+	pr_alert("Unhandled SError: (0x%08x)@0x%016lx\n", esr, addr);
+	__show_regs(regs);
+
+	info.si_signo = SIGILL;
+	info.si_errno = 0;
+	info.si_code  = ILL_ILLOPC;
+	info.si_addr  = (void __user *)addr;
+	arm64_notify_die("", regs, &info, esr);
+}
-- 
2.12.0
