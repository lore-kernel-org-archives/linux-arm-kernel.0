From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:08:08 +0100
Subject: [PATCH v2 10/10] KVM: arm64: add trace points for guest_debug debug
In-Reply-To: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427814488-28467-11-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This includes trace points for:
  kvm_arch_setup_guest_debug
  kvm_arch_clear_guest_debug
  kvm_handle_guest_debug

I've also added some generic register setting trace events so I can
watch the register values being built up over time. The local
dump_dbg_regs() function dumps all the HW BKPT and WPT registers.

I've also added a #define trace_dreg to shorten some lines.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 638c111..7c96288 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -25,12 +25,37 @@
 #include <asm/kvm_host.h>
 #include <asm/kvm_emulate.h>
 
+#include "trace.h"
+
+#define trace_dreg(name, value) trace_kvm_arch_setup_debug_reg32(name, value)
+
 /* These are the bits of MDSCR_EL1 we may mess with */
 #define MDSCR_EL1_DEBUG_BITS	(DBG_MDSCR_SS | \
 				DBG_MDSCR_KDE | \
 				DBG_MDSCR_MDE)
 
 /**
+ * dump_dbg_regs - simple debug helper
+ *
+ * This provides a simple helper to dump the HW debug registers
+ */
+static void dump_dbg_regs(struct kvm_vcpu *vcpu, int nb, int nw)
+{
+	int i;
+
+	for (i = 0; i < nb; i++) {
+		trace_printk("bkpt%d: 0x%08x:0x%llx\n", i,
+			(u32) vcpu_sys_reg(vcpu, DBGBCR0_EL1 + i),
+			vcpu_sys_reg(vcpu, DBGBVR0_EL1 + i));
+	}
+	for (i = 0; i < nb; i++) {
+		trace_printk("wtpt%d: 0x%08x:0x%llx\n", i,
+			(u32) vcpu_sys_reg(vcpu, DBGWCR0_EL1 + i),
+			vcpu_sys_reg(vcpu, DBGWVR0_EL1 + i));
+	}
+}
+
+/**
  * kvm_arch_setup_debug - set-up debug related stuff
  *
  * @vcpu:	the vcpu pointer
@@ -52,9 +77,13 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 {
 	bool trap_debug = false;
 
+	trace_kvm_arch_setup_debug(vcpu->guest_debug);
+
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM | MDCR_EL2_TPMCR);
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TDRA | MDCR_EL2_TDOSA);
 
+	trace_kvm_arch_setup_debug_reg32("MDCR_EL2", vcpu->arch.mdcr_el2);
+
 	/*
 	 * If we are not treating debug registers are dirty we need
 	 * to trap if the guest starts accessing them.
@@ -66,6 +95,8 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 	if (vcpu->guest_debug) {
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDE;
 
+		trace_dreg("MDCR_EL2", vcpu->arch.mdcr_el2);
+
 		/* Save pstate/mdscr */
 		vcpu_debug_saved_reg(vcpu, pstate_ss_bit) =
 			*vcpu_cpsr(vcpu) & DBG_SPSR_SS;
@@ -73,6 +104,11 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 		vcpu_debug_saved_reg(vcpu, mdscr_el1) =
 			vcpu_sys_reg(vcpu, MDSCR_EL1);
 
+		trace_dreg("Save: PSTATE.SS",
+			vcpu_debug_saved_reg(vcpu, pstate_ss_bit));
+		trace_dreg("Save: MDSCR",
+			vcpu_debug_saved_reg(vcpu, mdscr_el1));
+
 		/*
 		 * Single Step (ARM ARM D2.12.3 The software step state
 		 * machine)
@@ -88,6 +124,8 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 			*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
 			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
 		}
+		trace_dreg("SPSR_EL2", *vcpu_cpsr(vcpu));
+		trace_dreg("MDSCR_EL1", vcpu_sys_reg(vcpu, MDSCR_EL1));
 
 		/*
 		 * HW Break/Watch points
@@ -136,6 +174,9 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 			       &host->dbg_wvr,
 			       sizeof(__u64)*nw);
 
+			if (trace_kvm_arch_setup_debug_reg32_enabled())
+				dump_dbg_regs(vcpu, nb, nw);
+
 			/* Make sure hyp.S copies them in/out */
 			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
 			/* Also track guest changes */
@@ -147,15 +188,24 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDE;
 	}
 
+	trace_kvm_arch_setup_debug_reg32("MDCR_EL2", vcpu->arch.mdcr_el2);
+	trace_kvm_arch_setup_debug_reg32("MDSCR_EL1",
+					vcpu_sys_reg(vcpu, MDSCR_EL1));
+
+
 	/* Trap debug register access? */
 	if (trap_debug)
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
 	else
 		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDA;
+
+	trace_kvm_arch_setup_debug_reg32("MDCR_EL2", vcpu->arch.mdcr_el2);
 }
 
 void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
 {
+	trace_kvm_arch_clear_debug(vcpu->guest_debug);
+
 	if (vcpu->guest_debug) {
 		/* Restore pstate/mdscr bits we may have messed with */
 		*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
@@ -164,6 +214,8 @@ void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
 		vcpu_sys_reg(vcpu, MDSCR_EL1) =
 			vcpu_debug_saved_reg(vcpu, mdscr_el1);
 
+		trace_dreg("SPSR_EL2", *vcpu_cpsr(vcpu));
+		trace_dreg("MDSCR_EL1", vcpu_sys_reg(vcpu, MDSCR_EL1));
 		/*
 		 * If we were using HW debug we need to restore the
 		 * values the guest had set them up with
@@ -188,6 +240,10 @@ void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
 			memcpy(&vcpu_sys_reg(vcpu, DBGWVR0_EL1),
 			       &regs->dbg_wvr,
 			       sizeof(__u64)*nw);
+
+			if (trace_kvm_arch_setup_debug_reg32_enabled())
+				dump_dbg_regs(vcpu, nb, nw);
+
 		}
 	}
 }
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 460a1aa..c6cc69a 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -97,6 +97,8 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	u32 hsr = kvm_vcpu_get_hsr(vcpu);
 
+	trace_kvm_handle_guest_debug(*vcpu_pc(vcpu), hsr);
+
 	run->exit_reason = KVM_EXIT_DEBUG;
 	run->debug.arch.hsr = hsr;
 
diff --git a/arch/arm64/kvm/trace.h b/arch/arm64/kvm/trace.h
index 157416e9..dffdb49 100644
--- a/arch/arm64/kvm/trace.h
+++ b/arch/arm64/kvm/trace.h
@@ -44,6 +44,72 @@ TRACE_EVENT(kvm_hvc_arm64,
 		  __entry->vcpu_pc, __entry->r0, __entry->imm)
 );
 
+TRACE_EVENT(kvm_handle_guest_debug,
+	TP_PROTO(unsigned long vcpu_pc, u32 hsr),
+	TP_ARGS(vcpu_pc, hsr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	vcpu_pc)
+		__field(u32,		hsr)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->hsr = hsr;
+	),
+
+	TP_printk("debug exception at 0x%08lx (HSR: 0x%08x)",
+		__entry->vcpu_pc, __entry->hsr)
+);
+
+
+TRACE_EVENT(kvm_arch_setup_debug,
+	TP_PROTO(__u32 guest_debug),
+	TP_ARGS(guest_debug),
+
+	TP_STRUCT__entry(
+		__field(__u32, guest_debug)
+	),
+
+	TP_fast_assign(
+		__entry->guest_debug = guest_debug;
+	),
+
+	TP_printk("flags: 0x%08x", __entry->guest_debug)
+);
+
+TRACE_EVENT(kvm_arch_clear_debug,
+	TP_PROTO(__u32 guest_debug),
+	TP_ARGS(guest_debug),
+
+	TP_STRUCT__entry(
+		__field(__u32, guest_debug)
+	),
+
+	TP_fast_assign(
+		__entry->guest_debug = guest_debug;
+	),
+
+	TP_printk("flags: 0x%08x", __entry->guest_debug)
+);
+
+TRACE_EVENT(kvm_arch_setup_debug_reg32,
+	TP_PROTO(const char *name, __u32 value),
+	TP_ARGS(name, value),
+
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(__u32, value)
+	),
+
+	TP_fast_assign(
+		__entry->name = name;
+		__entry->value = value;
+	),
+
+	TP_printk("%s now 0x%08x", __entry->name, __entry->value)
+);
+
 #endif /* _TRACE_ARM64_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.3.4
