From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:02 +0000
Subject: [PATCH 08/29] ARM: KVM: abstract S1TW abort detection away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/mmio.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 90e92b4..c27d9c9 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -115,4 +115,9 @@ static inline bool kvm_vcpu_dabt_isextabt(struct kvm_vcpu *vcpu)
 	return (kvm_vcpu_get_hsr(vcpu) >> 8) & 1;
 }
 
+static inline bool kvm_vcpu_dabt_iss1tw(struct kvm_vcpu *vcpu)
+{
+	return (kvm_vcpu_get_hsr(vcpu) >> 7) & 1;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index e4682a3..6495c1c 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -71,7 +71,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return 1;
 	}
 
-	if ((kvm_vcpu_get_hsr(vcpu) >> 7) & 1) {
+	if (kvm_vcpu_dabt_iss1tw(vcpu)) {
 		/* page table accesses IO mem: tell guest to fix its TTBR */
 		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 		return 1;
-- 
1.7.12.4
