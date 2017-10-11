From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 11 Oct 2017 13:19:54 +0100
Subject: [PATCH v2 2/3] arm64: KVM: Support Common Not Private translations
In-Reply-To: <1507724395-13735-1-git-send-email-vladimir.murzin@arm.com>
References: <1507724395-13735-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1507724395-13735-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We rely on cpufeature framework to detect and enable CNP so for KVM we
need to patch hyp to set CNP bit just before TTBR0_EL2 gets written.
For the guest it is enough to update VTTBR_EL2 with CNP bit just
before it gets scheduled.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/kvm/hyp-init.S   | 4 ++++
 arch/arm64/kvm/hyp/switch.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 3f96155..4fd31b3 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -63,6 +63,10 @@ __do_hyp_init:
 	cmp	x0, #HVC_STUB_HCALL_NR
 	b.lo	__kvm_handle_stub_hvc
 
+alternative_if ARM64_HAS_CNP
+	orr	x0, x0, #TTBR_CNP_BIT
+alternative_else_nop_endif
+
 	msr	ttbr0_el2, x0
 
 	mrs	x4, tcr_el1
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 945e79c..a1f3bf2 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -150,7 +150,11 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 static void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	u64 val = kvm->arch.vttbr;
+
+	if (system_supports_cnp())
+		val |= TTBR_CNP_BIT;
+	write_sysreg(val, vttbr_el2);
 }
 
 static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
-- 
2.0.0
