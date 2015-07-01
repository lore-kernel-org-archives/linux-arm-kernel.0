From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  1 Jul 2015 19:29:03 +0100
Subject: [PATCH v7 11/11] KVM: arm64: add trace points for guest_debug debug
In-Reply-To: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
References: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1435775343-20034-12-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This includes trace points for:
  kvm_arch_setup_guest_debug
  kvm_arch_clear_guest_debug

I've also added some generic register setting trace events and also a
trace point to dump the array of hardware registers.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v3
  - add trace event for debug access.
  - remove short trace #define, rename trace events
  - use __print_array with fixed array instead of own func
  - rationalise trace points (only one per register changed)
  - add vcpu ptr to the debug_setup trace
  - remove :: in prints
v4
  - u32/u64 split on debug registers
  - fix for renames
  - add tracing of traps/set_guest_debug
  - remove handle_guest_debug trace
v5
  - minor print fmt fix
  - rm pstate traces
v6
  - fix merge conflicts
  - update control reg tracking to u64 (abi change)
v7
  - fix merge conflicts from ioctl move
  - fix other minor merge conflicts
  - fixes for the re-factored sys_regs code
---
 arch/arm64/kvm/debug.c    |  35 ++++++++++++-
 arch/arm64/kvm/guest.c    |   4 ++
 arch/arm64/kvm/sys_regs.c |  21 ++++++++
 arch/arm64/kvm/trace.h    | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 46b73d7..119107f 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -24,6 +24,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 
+#include "trace.h"
+
 /* These are the bits of MDSCR_EL1 we may manipulate */
 #define MDSCR_EL1_DEBUG_MASK	(DBG_MDSCR_SS | \
 				DBG_MDSCR_KDE | \
@@ -44,11 +46,17 @@ static DEFINE_PER_CPU(u32, mdcr_el2);
 static void save_guest_debug_regs(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.guest_debug_preserved.mdscr_el1 = vcpu_sys_reg(vcpu, MDSCR_EL1);
+
+	trace_kvm_arm_set_dreg32("Saved MDSCR_EL1",
+				vcpu->arch.guest_debug_preserved.mdscr_el1);
 }
 
 static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
 {
 	vcpu_sys_reg(vcpu, MDSCR_EL1) = vcpu->arch.guest_debug_preserved.mdscr_el1;
+
+	trace_kvm_arm_set_dreg32("Restored MDSCR_EL1",
+				vcpu_sys_reg(vcpu, MDSCR_EL1));
 }
 
 /**
@@ -99,6 +107,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 {
 	bool trap_debug = !(vcpu->arch.debug_flags & KVM_ARM64_DEBUG_DIRTY);
 
+	trace_kvm_arm_setup_debug(vcpu, vcpu->guest_debug);
+
 	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
 				MDCR_EL2_TPMCR |
@@ -140,6 +150,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
 		}
 
+		trace_kvm_arm_set_dreg32("SPSR_EL2", *vcpu_cpsr(vcpu));
+
 		/*
 		 * HW Breakpoints and watchpoints
 		 *
@@ -156,6 +168,14 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 			vcpu->arch.debug_ptr = &vcpu->arch.external_debug_state;
 			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
 			trap_debug = true;
+
+			trace_kvm_arm_set_regset("BKPTS", get_num_brps(),
+						&vcpu->arch.debug_ptr->dbg_bcr[0],
+						&vcpu->arch.debug_ptr->dbg_bvr[0]);
+
+			trace_kvm_arm_set_regset("WAPTS", get_num_wrps(),
+						&vcpu->arch.debug_ptr->dbg_wcr[0],
+						&vcpu->arch.debug_ptr->dbg_wvr[0]);
 		}
 	}
 
@@ -165,10 +185,15 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 	/* Trap debug register access */
 	if (trap_debug)
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
+
+	trace_kvm_arm_set_dreg32("MDCR_EL2", vcpu->arch.mdcr_el2);
+	trace_kvm_arm_set_dreg32("MDSCR_EL1", vcpu_sys_reg(vcpu, MDSCR_EL1));
 }
 
 void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 {
+	trace_kvm_arm_clear_debug(vcpu->guest_debug);
+
 	if (vcpu->guest_debug) {
 		restore_guest_debug_regs(vcpu);
 
@@ -176,8 +201,16 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 		 * If we were using HW debug we need to restore the
 		 * debug_ptr to the guest debug state.
 		 */
-		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW)
+		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW) {
 			kvm_arm_reset_debug_ptr(vcpu);
 
+			trace_kvm_arm_set_regset("BKPTS", get_num_brps(),
+						&vcpu->arch.debug_ptr->dbg_bcr[0],
+						&vcpu->arch.debug_ptr->dbg_bvr[0]);
+
+			trace_kvm_arm_set_regset("WAPTS", get_num_wrps(),
+						&vcpu->arch.debug_ptr->dbg_wcr[0],
+						&vcpu->arch.debug_ptr->dbg_wvr[0]);
+		}
 	}
 }
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 6f1b249..48868d8 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -32,6 +32,8 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 
+#include "trace.h"
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
@@ -350,6 +352,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	trace_kvm_set_guest_debug(vcpu, dbg->control);
+
 	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
 		return -EINVAL;
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f753a67..2c9aa68 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -38,6 +38,8 @@
 
 #include "sys_regs.h"
 
+#include "trace.h"
+
 /*
  * All of this file is extremly similar to the ARM coproc.c, but the
  * types are different. My gut feeling is that it should be pretty
@@ -208,6 +210,8 @@ static bool trap_debug_regs(struct kvm_vcpu *vcpu,
 		*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
 	}
 
+	trace_trap_reg(__func__, r->reg, p->is_write, *vcpu_reg(vcpu, p->Rt));
+
 	return true;
 }
 
@@ -245,6 +249,9 @@ static inline bool trap_bvr(struct kvm_vcpu *vcpu,
 			vcpu->arch.vcpu_debug_state.dbg_bvr[rd->reg]);
 	}
 
+	trace_trap_reg(__func__, rd->reg, p->is_write,
+		vcpu->arch.vcpu_debug_state.dbg_bvr[rd->reg]);
+
 	return true;
 }
 
@@ -284,6 +291,9 @@ static inline bool trap_bcr(struct kvm_vcpu *vcpu,
 			vcpu->arch.vcpu_debug_state.dbg_bcr[rd->reg]);
 	}
 
+	trace_trap_reg(__func__, rd->reg, p->is_write,
+		vcpu->arch.vcpu_debug_state.dbg_bcr[rd->reg]);
+
 	return true;
 }
 
@@ -323,6 +333,9 @@ static inline bool trap_wvr(struct kvm_vcpu *vcpu,
 			vcpu->arch.vcpu_debug_state.dbg_wvr[rd->reg]);
 	}
 
+	trace_trap_reg(__func__, rd->reg, p->is_write,
+		vcpu->arch.vcpu_debug_state.dbg_wvr[rd->reg]);
+
 	return true;
 }
 
@@ -362,6 +375,9 @@ static inline bool trap_wcr(struct kvm_vcpu *vcpu,
 			vcpu->arch.vcpu_debug_state.dbg_wcr[rd->reg]);
 	}
 
+	trace_trap_reg(__func__, rd->reg, p->is_write,
+		vcpu->arch.vcpu_debug_state.dbg_wcr[rd->reg]);
+
 	return true;
 }
 
@@ -719,6 +735,9 @@ static inline bool trap_xvr(struct kvm_vcpu *vcpu,
 			vcpu->arch.vcpu_debug_state.dbg_bvr[rd->reg] >> 32);
 	}
 
+	trace_trap_reg(__func__, rd->reg, p->is_write,
+		vcpu->arch.vcpu_debug_state.dbg_bvr[rd->reg]);
+
 	return true;
 }
 
@@ -1200,6 +1219,8 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	struct sys_reg_params params;
 	unsigned long esr = kvm_vcpu_get_hsr(vcpu);
 
+	trace_kvm_handle_sys_reg(esr);
+
 	params.is_aarch32 = false;
 	params.is_32bit = false;
 	params.Op0 = (esr >> 20) & 3;
diff --git a/arch/arm64/kvm/trace.h b/arch/arm64/kvm/trace.h
index 157416e9..7fb0008 100644
--- a/arch/arm64/kvm/trace.h
+++ b/arch/arm64/kvm/trace.h
@@ -44,6 +44,129 @@ TRACE_EVENT(kvm_hvc_arm64,
 		  __entry->vcpu_pc, __entry->r0, __entry->imm)
 );
 
+TRACE_EVENT(kvm_arm_setup_debug,
+	TP_PROTO(struct kvm_vcpu *vcpu, __u32 guest_debug),
+	TP_ARGS(vcpu, guest_debug),
+
+	TP_STRUCT__entry(
+		__field(struct kvm_vcpu *, vcpu)
+		__field(__u32, guest_debug)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu = vcpu;
+		__entry->guest_debug = guest_debug;
+	),
+
+	TP_printk("vcpu: %p, flags: 0x%08x", __entry->vcpu, __entry->guest_debug)
+);
+
+TRACE_EVENT(kvm_arm_clear_debug,
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
+TRACE_EVENT(kvm_arm_set_dreg32,
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
+	TP_printk("%s: 0x%08x", __entry->name, __entry->value)
+);
+
+TRACE_EVENT(kvm_arm_set_regset,
+	TP_PROTO(const char *type, int len, __u64 *control, __u64 *value),
+	TP_ARGS(type, len, control, value),
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(int, len)
+		__array(u64, ctrls, 16)
+		__array(u64, values, 16)
+	),
+	TP_fast_assign(
+		__entry->name = type;
+		__entry->len = len;
+		memcpy(__entry->ctrls, control, len << 3);
+		memcpy(__entry->values, value, len << 3);
+	),
+	TP_printk("%d %s CTRL:%s VALUE:%s", __entry->len, __entry->name,
+		__print_array(__entry->ctrls, __entry->len, sizeof(__u64)),
+		__print_array(__entry->values, __entry->len, sizeof(__u64)))
+);
+
+TRACE_EVENT(trap_reg,
+	TP_PROTO(const char *fn, int reg, bool is_write, u64 write_value),
+	TP_ARGS(fn, reg, is_write, write_value),
+
+	TP_STRUCT__entry(
+		__field(const char *, fn)
+		__field(int, reg)
+		__field(bool, is_write)
+		__field(u64, write_value)
+	),
+
+	TP_fast_assign(
+		__entry->fn = fn;
+		__entry->reg = reg;
+		__entry->is_write = is_write;
+		__entry->write_value = write_value;
+	),
+
+	TP_printk("%s %s reg %d (0x%08llx)", __entry->fn,  __entry->is_write?"write to":"read from", __entry->reg, __entry->write_value)
+);
+
+TRACE_EVENT(kvm_handle_sys_reg,
+	TP_PROTO(unsigned long hsr),
+	TP_ARGS(hsr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	hsr)
+	),
+
+	TP_fast_assign(
+		__entry->hsr = hsr;
+	),
+
+	TP_printk("HSR 0x%08lx", __entry->hsr)
+);
+
+TRACE_EVENT(kvm_set_guest_debug,
+	TP_PROTO(struct kvm_vcpu *vcpu, __u32 guest_debug),
+	TP_ARGS(vcpu, guest_debug),
+
+	TP_STRUCT__entry(
+		__field(struct kvm_vcpu *, vcpu)
+		__field(__u32, guest_debug)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu = vcpu;
+		__entry->guest_debug = guest_debug;
+	),
+
+	TP_printk("vcpu: %p, flags: 0x%08x", __entry->vcpu, __entry->guest_debug)
+);
+
+
 #endif /* _TRACE_ARM64_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.4.5
