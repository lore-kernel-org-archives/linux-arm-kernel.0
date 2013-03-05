From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:03 +0000
Subject: [PATCH 09/29] ARM: KVM: abstract SAS decoding away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 15 +++++++++++++++
 arch/arm/kvm/mmio.c                | 17 +++--------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index c27d9c9..2cbb694 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -120,4 +120,19 @@ static inline bool kvm_vcpu_dabt_iss1tw(struct kvm_vcpu *vcpu)
 	return (kvm_vcpu_get_hsr(vcpu) >> 7) & 1;
 }
 
+static inline int kvm_vcpu_dabt_get_as(struct kvm_vcpu *vcpu)
+{
+	switch ((kvm_vcpu_get_hsr(vcpu) >> 22) & 0x3) {
+	case 0:
+		return 1;
+	case 1:
+		return 2;
+	case 2:
+		return 4;
+	default:
+		kvm_err("Hardware is weird: SAS 0b11 is reserved\n");
+		return -EFAULT;
+	}
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 6495c1c..cd33a7e 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -77,20 +77,9 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return 1;
 	}
 
-	switch ((kvm_vcpu_get_hsr(vcpu) >> 22) & 0x3) {
-	case 0:
-		len = 1;
-		break;
-	case 1:
-		len = 2;
-		break;
-	case 2:
-		len = 4;
-		break;
-	default:
-		kvm_err("Hardware is weird: SAS 0b11 is reserved\n");
-		return -EFAULT;
-	}
+	len = kvm_vcpu_dabt_get_as(vcpu);
+	if (len < 0)
+		return len;	/* Unlikely... */
 
 	is_write = kvm_vcpu_dabt_iswrite(vcpu);
 	sign_extend = kvm_vcpu_dabt_issext(vcpu);
-- 
1.7.12.4
