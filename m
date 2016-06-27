From: dave.long@linaro.org (David Long)
Date: Sun, 26 Jun 2016 23:06:52 -0400
Subject: [PATCH v14 09/10] arm64: Add kernel return probes support (kretprobes)
In-Reply-To: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
References: <1466996813-23295-1-git-send-email-dave.long@linaro.org>
Message-ID: <1466996813-23295-10-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>

The pre-handler of this special 'trampoline' kprobe executes the return
probe handler functions and restores original return address in ELR_EL1.
This way the saved pt_regs still hold the original register context to be
carried back to the probed kernel function.

Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/kernel/kprobes/kprobes.c | 90 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f7d644..6af0e2e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KRETPROBES if HAVE_KPROBES
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/kernel/kprobes/kprobes.c b/arch/arm64/kernel/kprobes/kprobes.c
index 89936d2..b5d9b9c 100644
--- a/arch/arm64/kernel/kprobes/kprobes.c
+++ b/arch/arm64/kernel/kprobes/kprobes.c
@@ -578,7 +578,95 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return NULL;
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head, empty_rp;
+	struct hlist_node *tmp;
+	unsigned long flags, orig_ret_address = 0;
+	unsigned long trampoline_address =
+		(unsigned long)&kretprobe_trampoline;
+	kprobe_opcode_t *correct_ret_addr = NULL;
+
+	INIT_HLIST_HEAD(&empty_rp);
+	kretprobe_hash_lock(current, &head, &flags);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because multiple functions in the call path have
+	 * return probes installed on them, and/or more than one
+	 * return probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always pushed into the head of the list
+	 *     - when multiple return probes are registered for the same
+	 *	 function, the (chronologically) first instance's ret_addr
+	 *	 will be the real return address, and all the rest will
+	 *	 point to kretprobe_trampoline.
+	 */
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+
+	correct_ret_addr = ri->ret_addr;
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (ri->rp && ri->rp->handler) {
+			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
+			ri->ret_addr = correct_ret_addr;
+			ri->rp->handler(ri, regs);
+			__this_cpu_write(current_kprobe, NULL);
+		}
+
+		recycle_rp_inst(ri, &empty_rp);
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_hash_unlock(current, &flags);
+
+	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
+		hlist_del(&ri->hlist);
+		kfree(ri);
+	}
+	return (void *)orig_ret_address;
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
+int __kprobes arch_trampoline_kprobe(struct kprobe *p)
+{
+	return 0;
 }
 
 int __init arch_init_kprobes(void)
-- 
2.5.0
