From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:08:04 +0100
Subject: [PATCH v2 06/10] KVM: arm64: guest debug, add SW break point support
In-Reply-To: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for SW breakpoints inserted by userspace.

We do this by trapping all BKPT exceptions in the
hypervisor (MDCR_EL2_TDE). The kvm_debug_exit_arch carries the address
of the exception. If user-space doesn't know of the breakpoint then we
have a guest inserted breakpoint and the hypervisor needs to start again
and deliver the exception to guest.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - update to use new exit struct
  - tweak for C setup
  - do our setup in debug_setup/clear code
  - fixed up comments

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 06c5064..17d4f9c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2626,7 +2626,7 @@ when running. Common control bits are:
 The top 16 bits of the control field are architecture specific control
 flags which can include the following:
 
-  - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86]
+  - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86, arm64]
   - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390]
   - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
   - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 7ea8b0e..d3bc8dc 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -304,7 +304,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arm_set_running_vcpu(NULL);
 }
 
-#define KVM_GUESTDBG_VALID (KVM_GUESTDBG_ENABLE)
+#define KVM_GUESTDBG_VALID (KVM_GUESTDBG_ENABLE|KVM_GUESTDBG_USE_SW_BP)
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8a29d0b..cff0475 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -45,11 +45,18 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM | MDCR_EL2_TPMCR);
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TDRA | MDCR_EL2_TDOSA);
 
+	/* Trap debug register access? */
 	if (!vcpu->arch.debug_flags & KVM_ARM64_DEBUG_DIRTY)
 		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
 	else
 		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDA;
 
+	/* Trap breakpoints? */
+	if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_TDE;
+	else
+		vcpu->arch.mdcr_el2 &= ~MDCR_EL2_TDE;
+
 }
 
 void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 524fa25..ed1bbb4 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -82,6 +82,37 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+/**
+ * kvm_handle_debug_exception - handle a debug exception instruction
+ *
+ * @vcpu:	the vcpu pointer
+ * @run:	access to the kvm_run structure for results
+ *
+ * We route all debug exceptions through the same handler as we
+ * just need to report the PC and the HSR values to userspace.
+ * Userspace may decide to re-inject the exception and deliver it to
+ * the guest if it wasn't for the host to deal with.
+ */
+static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+
+	run->exit_reason = KVM_EXIT_DEBUG;
+	run->debug.arch.hsr = hsr;
+
+	switch (hsr >> ESR_ELx_EC_SHIFT) {
+	case ESR_ELx_EC_BKPT32:
+	case ESR_ELx_EC_BRK64:
+		run->debug.arch.pc = *vcpu_pc(vcpu);
+		break;
+	default:
+		kvm_err("%s: un-handled case hsr: %#08x\n",
+			__func__, (unsigned int) hsr);
+		break;
+	}
+	return 0;
+}
+
 static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
 	[ESR_ELx_EC_CP15_32]	= kvm_handle_cp15_32,
@@ -96,6 +127,8 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
+	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
+	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
 };
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
-- 
2.3.4
