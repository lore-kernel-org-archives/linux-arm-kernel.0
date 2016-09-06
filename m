From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:02:01 +0100
Subject: [PATCH 03/19] arm64: KVM: Add Virtual Abort injection helper
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1473166937-15271-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're able to context switch the HCR_EL2.VA bit, let's
introduce a helper that injects an Abort into a vcpu.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/kvm/inject_fault.c        | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index b336434d..fd9d5fd 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -38,6 +38,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr);
 
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+void kvm_inject_vabt(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 898c0e6..da6a8cf 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -231,3 +231,15 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 	else
 		inject_undef64(vcpu);
 }
+
+/**
+ * kvm_inject_vabt - inject an async abort / SError into the guest
+ * @vcpu: The VCPU to receive the exception
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_vabt(struct kvm_vcpu *vcpu)
+{
+	vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) | HCR_VSE);
+}
-- 
2.1.4
