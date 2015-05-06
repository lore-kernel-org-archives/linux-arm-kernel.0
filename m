From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  6 May 2015 17:23:22 +0100
Subject: [PATCH v3 07/12] KVM: arm64: guest debug, add support for single-step
In-Reply-To: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1430929407-3487-8-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for single-stepping the guest. To do this we need to
manipulate the guests PSTATE.SS and MDSCR_EL1.SS bits which we do in the
kvm_arm_setup/clear_debug() so we don't affect the apparent state of the
guest. Additionally while the host is debugging the guest we suppress
the ability of the guest to single-step itself.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - Move pstate/mdscr manipulation into C
  - don't export guest_debug to assembly
  - add accessor for saved_debug regs
  - tweak save/restore of mdscr_el1
v3
  - don't save PC in debug information struct
  - rename debug_saved_regs->guest_debug_state
  - save whole value, only use bits in restore
  - add save/restore_guest-debug_regs helper functions
  - simplify commit message for clarity
  - rm vcpu_debug_saved_reg access fn

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 064c105..9b3ed6d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -302,7 +302,9 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arm_set_running_vcpu(NULL);
 }
 
-#define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)
+#define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE |    \
+			    KVM_GUESTDBG_USE_SW_BP | \
+			    KVM_GUESTDBG_SINGLESTEP)
 
 /**
  * kvm_arch_vcpu_ioctl_set_guest_debug - set up guest debugging
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cb99b5..b60fa7a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -123,6 +123,12 @@ struct kvm_vcpu_arch {
 	 * here.
 	 */
 
+	/* Guest registers we preserve during guest debugging */
+	struct {
+		u32	pstate;
+		u32	mdscr_el1;
+	} guest_debug_state;
+
 	/* Don't run the guest */
 	bool pause;
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 5bee676..19346e8 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -19,11 +19,42 @@
 
 #include <linux/kvm_host.h>
 
+#include <asm/debug-monitors.h>
+#include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
+#include <asm/kvm_emulate.h>
+
+/* These are the bits of MDSCR_EL1 we may manipulate */
+#define MDSCR_EL1_DEBUG_MASK	(DBG_MDSCR_SS | \
+				DBG_MDSCR_KDE | \
+				DBG_MDSCR_MDE)
+
+#define SPSR_DEBUG_MASK DBG_SPSR_SS
 
 static DEFINE_PER_CPU(u32, mdcr_el2);
 
 /**
+ * save/restore_guest_debug_regs
+ *
+ * For some debug operations we need to tweak some guest registers. As
+ * a result we need to save the state of those registers before we
+ * make those modifications.
+ */
+static void save_guest_debug_regs(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.guest_debug_state.pstate = *vcpu_cpsr(vcpu);
+	vcpu->arch.guest_debug_state.mdscr_el1 = vcpu_sys_reg(vcpu, MDSCR_EL1);
+}
+
+static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
+{
+	*vcpu_cpsr(vcpu) |=
+		(vcpu->arch.guest_debug_state.pstate & SPSR_DEBUG_MASK);
+	vcpu_sys_reg(vcpu, MDSCR_EL1) |=
+		(vcpu->arch.guest_debug_state.mdscr_el1 & MDSCR_EL1_DEBUG_MASK);
+}
+
+/**
  * kvm_arm_init_debug - grab what we need for debug
  *
  * Currently the sole task of this function is to retrieve the initial
@@ -38,7 +69,6 @@ void kvm_arm_init_debug(void)
 	__this_cpu_write(mdcr_el2, kvm_call_hyp(__kvm_get_mdcr_el2));
 }
 
-
 /**
  * kvm_arm_setup_debug - set up debug related stuff
  *
@@ -75,15 +105,37 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 	else
 		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDA;
 
-	/* Trap breakpoints? */
-	if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
+	/* Is Guest debugging in effect? */
+	if (vcpu->guest_debug) {
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDE;
-	else
-		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDE;
 
+		/* Save guest debug state */
+		save_guest_debug_regs(vcpu);
+
+		/*
+		 * Single Step (ARM ARM D2.12.3 The software step state
+		 * machine)
+		 *
+		 * If we are doing Single Step we need to manipulate
+		 * MDSCR_EL1.SS and PSTATE.SS. If not we need to
+		 * suppress the guests ability to trigger single step itself.
+		 */
+		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+			*vcpu_cpsr(vcpu) |=  DBG_SPSR_SS;
+			vcpu_sys_reg(vcpu, MDSCR_EL1) |= DBG_MDSCR_SS;
+		} else {
+			*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
+			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
+		}
+
+	} else {
+		/* Debug operations can go straight to the guest */
+		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDE;
+	}
 }
 
 void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 {
-	/* Nothing to do yet */
+	if (vcpu->guest_debug)
+		restore_guest_debug_regs(vcpu);
 }
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 27f38a9..e9de13e 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -103,6 +103,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	run->debug.arch.hsr = hsr;
 
 	switch (hsr >> ESR_ELx_EC_SHIFT) {
+	case ESR_ELx_EC_SOFTSTP_LOW:
 	case ESR_ELx_EC_BKPT32:
 	case ESR_ELx_EC_BRK64:
 		break;
@@ -130,6 +131,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
+	[ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
 };
-- 
2.3.5
