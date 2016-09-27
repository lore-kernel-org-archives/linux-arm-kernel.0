From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:35 +0200
Subject: [PULL 27/50] arm: KVM: Add Virtual Abort injection helper
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-28-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Now that we're able to context switch the HCR.VA bit, let's
introduce a helper that injects an Abort into a vcpu.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_emulate.h |  1 +
 arch/arm/kvm/emulate.c             | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 448d63c..9a8a45a 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -43,6 +43,7 @@ static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+void kvm_inject_vabt(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index ff9acd1..0064b86 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -303,3 +303,15 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr)
 {
 	inject_abt(vcpu, true, addr);
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
+	vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) | HCR_VA);
+}
-- 
2.9.0
