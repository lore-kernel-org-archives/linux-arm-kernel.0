From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:01 +0000
Subject: [PATCH 07/29] ARM: KVM: abstract external abort detection away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/mmio.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 603f5ea..90e92b4 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -110,4 +110,9 @@ static inline int kvm_vcpu_dabt_get_rd(struct kvm_vcpu *vcpu)
 	return (kvm_vcpu_get_hsr(vcpu) & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
 }
 
+static inline bool kvm_vcpu_dabt_isextabt(struct kvm_vcpu *vcpu)
+{
+	return (kvm_vcpu_get_hsr(vcpu) >> 8) & 1;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 586063d..e4682a3 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -65,7 +65,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	unsigned long rt, len;
 	bool is_write, sign_extend;
 
-	if ((kvm_vcpu_get_hsr(vcpu) >> 8) & 1) {
+	if (kvm_vcpu_dabt_isextabt(vcpu)) {
 		/* cache operation on I/O addr, tell guest unsupported */
 		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 		return 1;
-- 
1.7.12.4
