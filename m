From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:42:57 +0000
Subject: [PATCH 03/29] ARM: KVM: abstract HSR_ISV away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/mmio.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 3c01988..9531535 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -90,4 +90,9 @@ static inline unsigned long kvm_vcpu_get_hyp_pc(struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault.hyp_pc;
 }
 
+static inline bool kvm_vcpu_dabt_isvalid(struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_hsr(vcpu) & HSR_ISV);
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index ce63f39..41f96e9 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -130,7 +130,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	 * space do its magic.
 	 */
 
-	if (kvm_vcpu_get_hsr(vcpu) & HSR_ISV) {
+	if (kvm_vcpu_dabt_isvalid(vcpu)) {
 		ret = decode_hsr(vcpu, fault_ipa, &mmio);
 		if (ret)
 			return ret;
-- 
1.7.12.4
