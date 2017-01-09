From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:18 -0500
Subject: [RFC 22/55] KVM: arm64: Handle PSCI call from the guest
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-23-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VMs used to execute hvc #0 for the psci call. However, when we come to
provide virtual EL2 to the VM, the host OS inside the VM also calls
kvm_call_hyp which is also hvc #0. So, it's hard to differentiate
between them from the host hypervisor's point of view.

So, let the VM execute smc for the psci call. On ARMv8.3, even if EL3 is
not implemented, a smc instruction executed at non-secure EL1 is trapped
to EL2 if HCR_EL2.TSC==1, rather than being treated as UNDEFINED. So,
the host hypervisor can handle this psci call without any confusion.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/handle_exit.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 208be16..ce6d2ef 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -64,8 +64,27 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	kvm_inject_undefined(vcpu);
-	return 1;
+	int ret;
+
+	/* If imm is non-zero, it's not defined */
+	if (kvm_vcpu_hvc_get_imm(vcpu)) {
+		kvm_inject_undefined(vcpu);
+		return 1;
+	}
+
+	/*
+	 * If imm is zero, it's a psci call.
+	 * Note that on ARMv8.3, even if EL3 is not implemented, SMC executed
+	 * at Non-secure EL1 is trapped to EL2 if HCR_EL2.TSC==1, rather than
+	 * being treated as UNDEFINED.
+	 */
+	ret = kvm_psci_call(vcpu);
+	if (ret < 0) {
+		kvm_inject_undefined(vcpu);
+		return 1;
+	}
+
+	return ret;
 }
 
 /**
-- 
1.9.1
