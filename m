From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:36:05 -0400
Subject: [PATCH 15/15] KVM: ARM: Guest wait-for-interrupts (WFI) support
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <20120915153605.21241.75455.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@cs.columbia.edu>

When the guest executes a WFI instruction the operation is trapped to
KVM, which emulates the instruction in software. There is no correlation
between a guest executing a WFI instruction and actually putting the
hardware into a low-power mode, since a KVM guest is essentially a
process and the WFI instruction can be seen as 'sleep' call from this
process. Therefore, we block the vcpu when the guest excecutes a wfi
instruction and the IRQ or FIQ lines are not raised.

When an interrupt comes in through KVM_IRQ_LINE (see previous patch) we
signal the VCPU thread and unflag the VCPU to no longer wait for
interrupts.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/arm.c     |   10 ++++++++--
 arch/arm/kvm/emulate.c |   13 ++++++++++++-
 arch/arm/kvm/trace.h   |   16 ++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 06a3368..64fbec7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -318,9 +318,16 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+/**
+ * kvm_arch_vcpu_runnable - determine if the vcpu can be scheduled
+ * @v:		The VCPU pointer
+ *
+ * If the guest CPU is not waiting for interrupts or an interrupt line is
+ * asserted, the CPU is by definition runnable.
+ */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return 0;
+	return !!v->arch.irq_lines;
 }
 
 int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
@@ -586,7 +593,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Check conditions before entering the guest
 		 */
 		cond_resched();
-
 		update_vttbr(vcpu->kvm);
 
 		local_irq_disable();
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index 2670679..fc0fcd3 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -154,9 +154,20 @@ static int kvm_instr_index(u32 instr, u32 table[][2], int table_entries)
 	return INSTR_NONE;
 }
 
+/**
+ * kvm_handle_wfi - handle a wait-for-interrupts instruction executed by a guest
+ * @vcpu:	the vcpu pointer
+ * @run:	the kvm_run structure pointer
+ *
+ * Simply sets the wait_for_interrupts flag on the vcpu structure, which will
+ * halt execution of world-switches and schedule other host processes until
+ * there is an incoming IRQ or FIQ to the VM.
+ */
 int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	return 0;
+	trace_kvm_wfi(vcpu->arch.regs.pc);
+	kvm_vcpu_block(vcpu);
+	return 1;
 }
 
 
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index 7199b58..b371138 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -143,6 +143,22 @@ TRACE_EVENT(kvm_emulate_cp15_imp,
 			__entry->CRm, __entry->Op2)
 );
 
+TRACE_EVENT(kvm_wfi,
+	TP_PROTO(unsigned long vcpu_pc),
+	TP_ARGS(vcpu_pc),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+	),
+
+	TP_printk("guest executed wfi at: 0x%08lx", __entry->vcpu_pc)
+);
+
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
