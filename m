From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Aug 2015 17:28:48 +0100
Subject: [PATCH 10/25] KVM: arm64: enable KVM_CAP_SET_GUEST_DEBUG
In-Reply-To: <1440088143-4722-1-git-send-email-marc.zyngier@arm.com>
References: <1440088143-4722-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1440088143-4722-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Benn?e <alex.bennee@linaro.org>

Finally advertise the KVM capability for SET_GUEST_DEBUG. Once arm
support is added this check can be moved to the common
kvm_vm_ioctl_check_extension() code.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt      |  7 +++++-
 arch/arm64/include/asm/hw_breakpoint.h | 14 ++++++++++++
 arch/arm64/include/asm/kvm_host.h      |  6 ++++-
 arch/arm64/kernel/hw_breakpoint.c      | 12 ----------
 arch/arm64/kvm/debug.c                 | 40 +++++++++++++++++++++++++++++-----
 arch/arm64/kvm/guest.c                 |  7 ++++++
 arch/arm64/kvm/handle_exit.c           |  6 +++++
 arch/arm64/kvm/reset.c                 | 16 ++++++++++++++
 8 files changed, 89 insertions(+), 19 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0f498da..35affb5 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2694,7 +2694,7 @@ The top 16 bits of the control field are architecture specific control
 flags which can include the following:
 
   - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86, arm64]
-  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390]
+  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390, arm64]
   - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
   - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
   - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
@@ -2709,6 +2709,11 @@ updated to the correct (supplied) values.
 The second part of the structure is architecture specific and
 typically contains a set of debug registers.
 
+For arm64 the number of debug registers is implementation defined and
+can be determined by querying the KVM_CAP_GUEST_DEBUG_HW_BPS and
+KVM_CAP_GUEST_DEBUG_HW_WPS capabilities which return a positive number
+indicating the number of supported registers.
+
 When debug events exit the main run loop with the reason
 KVM_EXIT_DEBUG with the kvm_debug_exit_arch part of the kvm_run
 structure containing architecture specific debug information.
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 52b484b..4c47cb2 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_HW_BREAKPOINT_H
 #define __ASM_HW_BREAKPOINT_H
 
+#include <asm/cputype.h>
+
 #ifdef __KERNEL__
 
 struct arch_hw_breakpoint_ctrl {
@@ -132,5 +134,17 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
 
 extern struct pmu perf_ops_bp;
 
+/* Determine number of BRP registers available. */
+static inline int get_num_brps(void)
+{
+	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
+}
+
+/* Determine number of WRP registers available. */
+static inline int get_num_wrps(void)
+{
+	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_BREAKPOINT_H */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9b99402..409217f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -116,13 +116,17 @@ struct kvm_vcpu_arch {
 	 * debugging the guest from the host and to maintain separate host and
 	 * guest state during world switches. vcpu_debug_state are the debug
 	 * registers of the vcpu as the guest sees them.  host_debug_state are
-	 * the host registers which are saved and restored during world switches.
+	 * the host registers which are saved and restored during
+	 * world switches. external_debug_state contains the debug
+	 * values we want to debug the guest. This is set via the
+	 * KVM_SET_GUEST_DEBUG ioctl.
 	 *
 	 * debug_ptr points to the set of debug registers that should be loaded
 	 * onto the hardware when running the guest.
 	 */
 	struct kvm_guest_debug_arch *debug_ptr;
 	struct kvm_guest_debug_arch vcpu_debug_state;
+	struct kvm_guest_debug_arch external_debug_state;
 
 	/* Pointer to host CPU context */
 	kvm_cpu_context_t *host_cpu_context;
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 7a1a5da..77bee00 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -48,18 +48,6 @@ static DEFINE_PER_CPU(int, stepping_kernel_bp);
 static int core_num_brps;
 static int core_num_wrps;
 
-/* Determine number of BRP registers available. */
-static int get_num_brps(void)
-{
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
-}
-
-/* Determine number of WRP registers available. */
-static int get_num_wrps(void)
-{
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
-}
-
 int hw_breakpoint_slots(int type)
 {
 	/*
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index e0947b7..4a99e54 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -105,10 +105,6 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 				MDCR_EL2_TDRA |
 				MDCR_EL2_TDOSA);
 
-	/* Trap on access to debug registers? */
-	if (trap_debug)
-		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
-
 	/* Is Guest debugging in effect? */
 	if (vcpu->guest_debug) {
 		/* Route all software debug exceptions to EL2 */
@@ -143,11 +139,45 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 		} else {
 			vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~DBG_MDSCR_SS;
 		}
+
+		/*
+		 * HW Breakpoints and watchpoints
+		 *
+		 * We simply switch the debug_ptr to point to our new
+		 * external_debug_state which has been populated by the
+		 * debug ioctl. The existing KVM_ARM64_DEBUG_DIRTY
+		 * mechanism ensures the registers are updated on the
+		 * world switch.
+		 */
+		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW) {
+			/* Enable breakpoints/watchpoints */
+			vcpu_sys_reg(vcpu, MDSCR_EL1) |= DBG_MDSCR_MDE;
+
+			vcpu->arch.debug_ptr = &vcpu->arch.external_debug_state;
+			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
+			trap_debug = true;
+		}
 	}
+
+	BUG_ON(!vcpu->guest_debug &&
+		vcpu->arch.debug_ptr != &vcpu->arch.vcpu_debug_state);
+
+	/* Trap debug register access */
+	if (trap_debug)
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
 }
 
 void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->guest_debug)
+	if (vcpu->guest_debug) {
 		restore_guest_debug_regs(vcpu);
+
+		/*
+		 * If we were using HW debug we need to restore the
+		 * debug_ptr to the guest debug state.
+		 */
+		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW)
+			kvm_arm_reset_debug_ptr(vcpu);
+
+	}
 }
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 48de4f4..6f1b249 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -334,6 +334,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE |    \
 			    KVM_GUESTDBG_USE_SW_BP | \
+			    KVM_GUESTDBG_USE_HW | \
 			    KVM_GUESTDBG_SINGLESTEP)
 
 /**
@@ -354,6 +355,12 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
+
+		/* Hardware assisted Break and Watch points */
+		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW) {
+			vcpu->arch.external_debug_state = dbg->arch;
+		}
+
 	} else {
 		/* If not enabled clear all flags */
 		vcpu->guest_debug = 0;
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e9de13e..68a0759 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -103,7 +103,11 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	run->debug.arch.hsr = hsr;
 
 	switch (hsr >> ESR_ELx_EC_SHIFT) {
+	case ESR_ELx_EC_WATCHPT_LOW:
+		run->debug.arch.far = vcpu->arch.fault.far_el2;
+		/* fall through */
 	case ESR_ELx_EC_SOFTSTP_LOW:
+	case ESR_ELx_EC_BREAKPT_LOW:
 	case ESR_ELx_EC_BKPT32:
 	case ESR_ELx_EC_BRK64:
 		break;
@@ -132,6 +136,8 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
+	[ESR_ELx_EC_WATCHPT_LOW]= kvm_handle_guest_debug,
+	[ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
 };
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 0b43265..b4af618 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
+#include <linux/hw_breakpoint.h>
 
 #include <kvm/arm_arch_timer.h>
 
@@ -56,6 +57,12 @@ static bool cpu_has_32bit_el1(void)
 	return !!(pfr0 & 0x20);
 }
 
+/**
+ * kvm_arch_dev_ioctl_check_extension
+ *
+ * We currently assume that the number of HW registers is uniform
+ * across all CPUs (see cpuinfo_sanity_check).
+ */
 int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	int r;
@@ -64,6 +71,15 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_ARM_EL1_32BIT:
 		r = cpu_has_32bit_el1();
 		break;
+	case KVM_CAP_GUEST_DEBUG_HW_BPS:
+		r = get_num_brps();
+		break;
+	case KVM_CAP_GUEST_DEBUG_HW_WPS:
+		r = get_num_wrps();
+		break;
+	case KVM_CAP_SET_GUEST_DEBUG:
+		r = 1;
+		break;
 	default:
 		r = 0;
 	}
-- 
2.1.4
