From: dave.long@linaro.org (David Long)
Date: Mon, 20 Apr 2015 16:19:46 -0400
Subject: [PATCH v6 5/6] arm64: Add kernel return probes support (kretprobes)
In-Reply-To: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
Message-ID: <1429561187-3661-6-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>

AArch64 ISA does not have instructions to pop the PC register
value from the stack(like ARM v7 has ldmia {...,pc}) without using
one of the general purpose registers. This means return probes
cannot return to the actual return address directly without
modifying register context, and without trapping into debug exception.

So, like many other architectures, we prepare a global routine
with NOPs which serve as a trampoline to hack away the
function return address by placing an extra kprobe on the
trampoline entry.

The pre-handler of this special 'trampoline' kprobe executes the return
probe handler functions and restores original return address in ELR_EL1.
This way the saved pt_regs still hold the original register context to be
carried back to the probed kernel function.

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/kprobes.h |   1 +
 arch/arm64/kernel/kprobes.c      | 112 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8e06a03..84f3c9e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -69,6 +69,7 @@ config ARM64
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KRETPROBES if HAVE_KPROBES
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index af31c4d..d081f49 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -58,5 +58,6 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 			     unsigned long val, void *data);
 int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
 int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
+void kretprobe_trampoline(void);
 
 #endif /* _ARM_KPROBES_H */
diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
index 6255814..2b3ef17 100644
--- a/arch/arm64/kernel/kprobes.c
+++ b/arch/arm64/kernel/kprobes.c
@@ -560,7 +560,117 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	return 0;
 }
 
+/*
+ * Kretprobes: kernel return probes handling
+ *
+ * AArch64 mode does not support popping the PC value from the
+ * stack like on ARM 32-bit (ldmia {..,pc}), so atleast one
+ * register need to be used to achieve branching/return.
+ * It means return probes cannot return back to the original
+ * return address directly without modifying the register context.
+ *
+ * So like other architectures, we prepare a global routine
+ * with NOPs, which serve as trampoline address that hack away the
+ * function return, with the exact register context.
+ * Placing a kprobe on trampoline routine entry will trap again to
+ * execute return probe handlers and restore original return address
+ * in ELR_EL1, this way saved pt_regs still hold the original
+ * register values to be carried back to the caller.
+ */
+static void __used kretprobe_trampoline_holder(void)
+{
+	asm volatile (".global kretprobe_trampoline\n"
+			"kretprobe_trampoline:\n"
+			"NOP\n\t"
+			"NOP\n\t");
+}
+
+static int __kprobes
+trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head, empty_rp;
+	struct hlist_node *tmp;
+	unsigned long flags, orig_ret_addr = 0;
+	unsigned long trampoline_address =
+		(unsigned long)&kretprobe_trampoline;
+
+	INIT_HLIST_HEAD(&empty_rp);
+	kretprobe_hash_lock(current, &head, &flags);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because multiple functions in the call path have
+	 * a return probe installed on them, and/or more than one return
+	 * probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always inserted at the head of the list
+	 *     - when multiple return probes are registered for the same
+	 *       function, the first instance's ret_addr will point to the
+	 *       real return address, and all the rest will point to
+	 *       kretprobe_trampoline
+	 */
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+
+		if (ri->rp && ri->rp->handler) {
+			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
+			ri->rp->handler(ri, regs);
+			__this_cpu_write(current_kprobe, NULL);
+		}
+
+		orig_ret_addr = (unsigned long)ri->ret_addr;
+		recycle_rp_inst(ri, &empty_rp);
+
+		if (orig_ret_addr != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_assert(ri, orig_ret_addr, trampoline_address);
+	/* restore the original return address */
+	instruction_pointer(regs) = orig_ret_addr;
+	reset_current_kprobe();
+	kretprobe_hash_unlock(current, &flags);
+
+	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
+		hlist_del(&ri->hlist);
+		kfree(ri);
+	}
+
+	/* return 1 so that post handlers not called */
+	return 1;
+}
+
+void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
+				      struct pt_regs *regs)
+{
+	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
+
+	/* replace return addr (x30) with trampoline */
+	regs->regs[30] = (long)&kretprobe_trampoline;
+}
+
+static struct kprobe trampoline = {
+	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
+	.pre_handler = trampoline_probe_handler
+};
+
+int __kprobes arch_trampoline_kprobe(struct kprobe *p)
+{
+	return p->addr == (kprobe_opcode_t *) &kretprobe_trampoline;
+}
+
 int __init arch_init_kprobes(void)
 {
-	return 0;
+	/* register trampoline for kret probe */
+	return register_kprobe(&trampoline);
 }
-- 
1.8.1.2
