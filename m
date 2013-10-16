From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 16 Oct 2013 22:32:31 +0530
Subject: [RFC PATCH 2/5] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI SYSTEM_OFF and SYSTEM_RESET functions are VM or Guest level
functions hence cannot be emulated by the in-kernel PSCI emulation code.

To tackle this, we forward PSCI SYSTEM_OFF and SYSTEM_RESET function
calls from Guest to user space (i.e. QEMU or KVMTOOL) via KVM run
structure with KVM_EXIT_PSCI exit reason.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/include/asm/kvm_psci.h   |   25 +++++++++++++++-
 arch/arm/include/uapi/asm/kvm.h   |    2 ++
 arch/arm/kvm/arm.c                |   12 ++++++--
 arch/arm/kvm/handle_exit.c        |   12 ++++++--
 arch/arm/kvm/psci.c               |   57 ++++++++++++++++++++++++++++++++++---
 arch/arm64/include/asm/kvm_psci.h |   25 +++++++++++++++-
 arch/arm64/include/uapi/asm/kvm.h |    2 ++
 arch/arm64/kvm/handle_exit.c      |   24 ++++++++++++----
 8 files changed, 141 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
index 9a83d98..783566f 100644
--- a/arch/arm/include/asm/kvm_psci.h
+++ b/arch/arm/include/asm/kvm_psci.h
@@ -18,6 +18,29 @@
 #ifndef __ARM_KVM_PSCI_H__
 #define __ARM_KVM_PSCI_H__
 
-bool kvm_psci_call(struct kvm_vcpu *vcpu);
+#include <linux/kvm_host.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+
+/*
+ * The in-kernel PSCI emulation code wants to use a copy of run->psci,
+ * which is an anonymous type. Use our own type instead.
+ */
+struct kvm_exit_psci {
+	u32		fn;
+	u64		args[7];
+};
+
+static inline void kvm_prepare_psci(struct kvm_run *run,
+				    struct kvm_exit_psci *psci)
+{
+	run->psci.fn = psci->fn;
+	memcpy(&run->psci.args, &psci->args, sizeof(run->psci.args));
+	memset(&run->psci.ret, 0, sizeof(run->psci.ret));
+	run->exit_reason = KVM_EXIT_PSCI;
+}
+
+int kvm_handle_psci_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_psci_call(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
 #endif /* __ARM_KVM_PSCI_H__ */
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index c1ee007..205cf0e 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -171,6 +171,8 @@ struct kvm_arch_memory_slot {
 #define KVM_PSCI_FN_CPU_OFF		KVM_PSCI_FN(1)
 #define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
 #define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
+#define KVM_PSCI_FN_SYSTEM_OFF		KVM_PSCI_FN(4)
+#define KVM_PSCI_FN_SYSTEM_RESET	KVM_PSCI_FN(5)
 
 #define KVM_PSCI_RET_SUCCESS		0
 #define KVM_PSCI_RET_NI			((unsigned long)-1)
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index cc5adb9..5ffd9a3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -459,7 +459,7 @@ static void update_vttbr(struct kvm *kvm)
 	spin_unlock(&kvm_vmid_lock);
 }
 
-static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
+static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	if (likely(vcpu->arch.has_run_once))
 		return 0;
@@ -483,7 +483,7 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	 */
 	if (test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features)) {
 		*vcpu_reg(vcpu, 0) = KVM_PSCI_FN_CPU_OFF;
-		kvm_psci_call(vcpu);
+		kvm_psci_call(vcpu, run);
 	}
 
 	return 0;
@@ -520,7 +520,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	ret = kvm_vcpu_first_run_init(vcpu);
+	ret = kvm_vcpu_first_run_init(vcpu, vcpu->run);
 	if (ret)
 		return ret;
 
@@ -530,6 +530,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			return ret;
 	}
 
+	if (run->exit_reason == KVM_EXIT_PSCI) {
+		ret = kvm_handle_psci_return(vcpu, vcpu->run);
+		if (ret)
+			return ret;
+	}
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index df4c82d..1a12e6c 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -40,14 +40,20 @@ static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
+	int ret;
+
 	trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
 		      kvm_vcpu_hvc_get_imm(vcpu));
 
-	if (kvm_psci_call(vcpu))
+	ret = kvm_psci_call(vcpu, run);
+	if (!ret)
+		return 1;
+	else if (ret == -EINVAL) {
+		kvm_inject_undefined(vcpu);
 		return 1;
+	}
 
-	kvm_inject_undefined(vcpu);
-	return 1;
+	return 0;
 }
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 86a693a..72c23a7 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -71,6 +71,45 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	return KVM_PSCI_RET_SUCCESS;
 }
 
+static void kvm_psci_system_off(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct kvm_exit_psci psci;
+
+	psci.fn = KVM_PSCI_FN_SYSTEM_OFF;
+	memset(&psci.args, 0, sizeof(psci.args));
+	kvm_prepare_psci(run, &psci);
+}
+
+static void kvm_psci_system_reset(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct kvm_exit_psci psci;
+
+	psci.fn = KVM_PSCI_FN_SYSTEM_RESET;
+	memset(&psci.args, 0, sizeof(psci.args));
+	kvm_prepare_psci(run, &psci);
+}
+
+/**
+ * kvm_handle_psci_return -- Handle PSCI after user space emulation
+ * @vcpu: The VCPU pointer
+ * @run:  The VCPU run struct containing the psci data
+ *
+ * This should only be called after returning from userspace for
+ * PSCI emulation.
+ */
+int kvm_handle_psci_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/*
+	 * Currently, the PSCI functions passed to user space for emulation
+	 * are SYSTEM_OFF and SYSTEM_RESET. These PSCI functions are not
+	 * expected to return back after emulating in user space hence by
+	 * default we return -EINVAL to avoid user space from doing RUN ioctl
+	 * after handling KVM_EXIT_PSCI.
+	 */
+
+	return -EINVAL;
+}
+
 /**
  * kvm_psci_call - handle PSCI call if r0 value is in range
  * @vcpu: Pointer to the VCPU struct
@@ -81,8 +120,9 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
  * function number specified in r0 is withing the PSCI range, and false
  * otherwise.
  */
-bool kvm_psci_call(struct kvm_vcpu *vcpu)
+int kvm_psci_call(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
+	int ret = 0;
 	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
 	unsigned long val;
 
@@ -98,11 +138,20 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
 	case KVM_PSCI_FN_MIGRATE:
 		val = KVM_PSCI_RET_NI;
 		break;
-
+	case KVM_PSCI_FN_SYSTEM_OFF:
+		kvm_psci_system_off(vcpu, run);
+		val = KVM_PSCI_RET_SUCCESS;
+		ret = -EINTR;
+		break;
+	case KVM_PSCI_FN_SYSTEM_RESET:
+		kvm_psci_system_reset(vcpu, run);
+		val = KVM_PSCI_RET_SUCCESS;
+		ret = -EINTR;
+		break;
 	default:
-		return false;
+		return -EINVAL;
 	}
 
 	*vcpu_reg(vcpu, 0) = val;
-	return true;
+	return ret;
 }
diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
index e301a48..db90649 100644
--- a/arch/arm64/include/asm/kvm_psci.h
+++ b/arch/arm64/include/asm/kvm_psci.h
@@ -18,6 +18,29 @@
 #ifndef __ARM64_KVM_PSCI_H__
 #define __ARM64_KVM_PSCI_H__
 
-bool kvm_psci_call(struct kvm_vcpu *vcpu);
+#include <linux/kvm_host.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_arm.h>
+
+/*
+ * The in-kernel PSCI emulation code wants to use a copy of run->psci,
+ * which is an anonymous type. Use our own type instead.
+ */
+struct kvm_exit_psci {
+	u32		fn;
+	u64		args[7];
+};
+
+static inline void kvm_prepare_psci(struct kvm_run *run,
+				    struct kvm_exit_psci *psci)
+{
+	run->psci.fn = psci->fn;
+	memcpy(&run->psci.args, &psci->args, sizeof(run->psci.args));
+	memset(&run->psci.ret, 0, sizeof(run->psci.ret));
+	run->exit_reason = KVM_EXIT_PSCI;
+}
+
+int kvm_handle_psci_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_psci_call(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
 #endif /* __ARM64_KVM_PSCI_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d9f026b..f678902 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -158,6 +158,8 @@ struct kvm_arch_memory_slot {
 #define KVM_PSCI_FN_CPU_OFF		KVM_PSCI_FN(1)
 #define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
 #define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
+#define KVM_PSCI_FN_SYSTEM_OFF		KVM_PSCI_FN(4)
+#define KVM_PSCI_FN_SYSTEM_RESET	KVM_PSCI_FN(5)
 
 #define KVM_PSCI_RET_SUCCESS		0
 #define KVM_PSCI_RET_NI			((unsigned long)-1)
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 9beaca0..28e20bb 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -30,20 +30,32 @@ typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
 
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_psci_call(vcpu))
+	int ret;
+
+	ret = kvm_psci_call(vcpu, run);
+	if (!ret)
+		return 1;
+	else if (ret == -EINVAL) {
+		kvm_inject_undefined(vcpu);
 		return 1;
+	}
 
-	kvm_inject_undefined(vcpu);
-	return 1;
+	return 0;
 }
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_psci_call(vcpu))
+	int ret;
+
+	ret = kvm_psci_call(vcpu, run);
+	if (!ret)
+		return 1;
+	else if (ret == -EINVAL) {
+		kvm_inject_undefined(vcpu);
 		return 1;
+	}
 
-	kvm_inject_undefined(vcpu);
-	return 1;
+	return 0;
 }
 
 /**
-- 
1.7.9.5
