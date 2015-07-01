From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  1 Jul 2015 19:28:58 +0100
Subject: [PATCH v7 06/11] KVM: arm64: guest debug, add support for single-step
In-Reply-To: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
References: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1435775343-20034-7-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for single-stepping the guest. To do this we need to
manipulate the guests PSTATE.SS and MDSCR_EL1.SS bits to trigger
stepping. We take care to preserve MDSCR_EL1 and trap access to it to
ensure we don't affect the apparent state of the guest.

As we have to enable trapping of all software debug exceptions we
suppress the ability of the guest to single-step itself. If we didn't we
would have to deal with the exception arriving while the guest was in
kernelspace when the guest is expecting to single-step userspace. This
is something we don't want to unwind in the kernel. Once the host is no
longer debugging the guest its ability to single-step userspace is
restored.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

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
v4
  - added more comments based on suggestions
  - guest_debug_state->guest_debug_preserved
  - no point masking restore, we will trap out
v5
  - more comments
  - don't bother preserving pstate.ss (guest never sees change)
v6
  - reword comments on guest SS suppression
  - simplify comment for save regs, SS explained in detail later on
  - add r-b-t (code)
  - expanded commit description
v7
  - merge fix for ioctl move to guest.c
---
 arch/arm64/include/asm/kvm_host.h | 11 +++++++
 arch/arm64/kvm/debug.c            | 68 ++++++++++++++++++++++++++++++++++++---
 arch/arm64/kvm/guest.c            |  4 ++-
 arch/arm64/kvm/handle_exit.c      |  2 ++
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cb99b5..e2db6a6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -123,6 +123,17 @@ struct kvm_vcpu_arch {
 	 * here.
 	 */
 
+	/*
+	 * Guest registers we preserve during guest debugging.
+	 *
+	 * These shadow registers are updated by the kvm_handle_sys_reg
+	 * trap handler if the guest accesses or updates them while we
+	 * are using guest debug.
+	 */
+	struct {
+		u32	mdscr_el1;
+	} guest_debug_preserved;
+
 	/* Don't run the guest */
 	bool pause;
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8d1bfa4..d439eb8 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -19,11 +19,39 @@
 
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
 
 static DEFINE_PER_CPU(u32, mdcr_el2);
 
 /**
+ * save/restore_guest_debug_regs
+ *
+ * For some debug operations we need to tweak some guest registers. As
+ * a result we need to save the state of those registers before we
+ * make those modifications.
+ *
+ * Guest access to MDSCR_EL1 is trapped by the hypervisor and handled
+ * after we have restored the preserved value to the main context.
+ */
+static void save_guest_debug_regs(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.guest_debug_preserved.mdscr_el1 = vcpu_sys_reg(vcpu, MDSCR_EL1);
+}
+
+static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
+{
+	vcpu_sys_reg(vcpu, MDSCR_EL1) = vcpu->arch.guest_debug_preserved.mdscr_el1;
+}
+
+/**
  * kvm_arm_init_debug - grab what we need for debug
  *
  * Currently the sole task of this function is to retrieve the initial
@@ -38,7 +66,6 @@ void kvm_arm_init_debug(void)
 	__this_cpu_write(mdcr_el2, kvm_call_hyp(__kvm_get_mdcr_el2));
 }
 
-
 /**
  * kvm_arm_setup_debug - set up debug related stuff
  *
@@ -73,12 +100,45 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 	if (trap_debug)
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
 
-	/* Trap breakpoints? */
-	if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
+	/* Is Guest debugging in effect? */
+	if (vcpu->guest_debug) {
+		/* Route all software debug exceptions to EL2 */
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDE;
+
+		/* Save guest debug state */
+		save_guest_debug_regs(vcpu);
+
+		/*
+		 * Single Step (ARM ARM D2.12.3 The software step state
+		 * machine)
+		 *
+		 * If we are doing Single Step we need to manipulate
+		 * the guest's MDSCR_EL1.SS and PSTATE.SS. Once the
+		 * step has occurred the hypervisor will trap the
+		 * debug exception and we return to userspace.
+		 *
+		 * If the guest attempts to single step its userspace
+		 * we would have to deal with a trapped exception
+		 * while in the guest kernel. Because this would be
+		 * hard to unwind we suppress the guest's ability to
+		 * do so by masking MDSCR_EL.SS.
+		 *
+		 * This confuses guest debuggers which use
+		 * single-step behind the scenes but everything
+		 * returns to normal once the host is no longer
+		 * debugging the system.
+		 */
+		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+			*vcpu_cpsr(vcpu) |=  DBG_SPSR_SS;
+			vcpu_sys_reg(vcpu, MDSCR_EL1) |= DBG_MDSCR_SS;
+		} else {
+			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
+		}
+	}
 }
 
 void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 {
-	/* Nothing to do yet */
+	if (vcpu->guest_debug)
+		restore_guest_debug_regs(vcpu);
 }
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 22d22c5..48de4f4 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -332,7 +332,9 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
-#define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)
+#define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE |    \
+			    KVM_GUESTDBG_USE_SW_BP | \
+			    KVM_GUESTDBG_SINGLESTEP)
 
 /**
  * kvm_arch_vcpu_ioctl_set_guest_debug - set up guest debugging
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
2.4.5
