From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 12:11:38 +0100
Subject: [PATCH v3 5/7] ARM: KVM: don't special case PC when doing an MMIO
In-Reply-To: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368529900-22572-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Admitedly, reading a MMIO register to load PC is very weird.
Writing PC to a MMIO register is probably even worse. But
the architecture doesn't forbid any of these, and injecting
a Prefetch Abort is the wrong thing to do anyway.

Remove this check altogether, and let the adventurous guest
wander into LaLaLand if they feel compelled to do so.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 -----
 arch/arm/kvm/mmio.c                | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 82b4bab..a464e8d 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -65,11 +65,6 @@ static inline bool vcpu_mode_priv(struct kvm_vcpu *vcpu)
 	return cpsr_mode > USR_MODE;;
 }
 
-static inline bool kvm_vcpu_reg_is_pc(struct kvm_vcpu *vcpu, int reg)
-{
-	return reg == 15;
-}
-
 static inline u32 kvm_vcpu_get_hsr(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.hsr;
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 72a12f2..b8e06b7 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -86,12 +86,6 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	sign_extend = kvm_vcpu_dabt_issext(vcpu);
 	rt = kvm_vcpu_dabt_get_rd(vcpu);
 
-	if (kvm_vcpu_reg_is_pc(vcpu, rt)) {
-		/* IO memory trying to read/write pc */
-		kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
-		return 1;
-	}
-
 	mmio->is_write = is_write;
 	mmio->phys_addr = fault_ipa;
 	mmio->len = len;
-- 
1.8.2.3
