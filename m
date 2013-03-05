From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:42:59 +0000
Subject: [PATCH 05/29] ARM: KVM: abstract HSR_SSE away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/mmio.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 236fadd..2a077bc 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -100,4 +100,9 @@ static inline bool kvm_vcpu_dabt_iswrite(struct kvm_vcpu *vcpu)
 	return !!(kvm_vcpu_get_hsr(vcpu) & HSR_WNR);
 }
 
+static inline bool kvm_vcpu_dabt_issext(struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_hsr(vcpu) & HSR_SSE);
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 7d58cb5..058029c 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -93,7 +93,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	is_write = kvm_vcpu_dabt_iswrite(vcpu);
-	sign_extend = kvm_vcpu_get_hsr(vcpu) & HSR_SSE;
+	sign_extend = kvm_vcpu_dabt_issext(vcpu);
 	rt = (kvm_vcpu_get_hsr(vcpu) & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
 
 	if (kvm_vcpu_reg_is_pc(vcpu, rt)) {
-- 
1.7.12.4
