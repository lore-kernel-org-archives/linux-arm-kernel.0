From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:40 -0500
Subject: [RFC 44/55] KVM: arm/arm64: Move kvm_is_write_fault to header file
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-45-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Move this little function to the header files for arm/arm64 so other
code can make use of it directly.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/include/asm/kvm_emulate.h   | 8 ++++++++
 arch/arm/kvm/mmu.c                   | 8 --------
 arch/arm64/include/asm/kvm_emulate.h | 8 ++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index dfc53ce..dde5335 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -235,6 +235,14 @@ static inline u8 kvm_vcpu_trap_get_fault_type(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & HSR_FSC_TYPE;
 }
 
+static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_trap_is_iabt(vcpu))
+		return false;
+
+	return kvm_vcpu_dabt_iswrite(vcpu);
+}
+
 static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 710ae60..abdf345 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1113,14 +1113,6 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, gfn_t gfn,
 	return false;
 }
 
-static bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
-{
-	if (kvm_vcpu_trap_is_iabt(vcpu))
-		return false;
-
-	return kvm_vcpu_dabt_iswrite(vcpu);
-}
-
 /**
  * stage2_wp_ptes - write protect PMD range
  * @pmd:	pointer to pmd entry
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 2994410..17f4855 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -285,6 +285,14 @@ static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
 }
 
+static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_trap_is_iabt(vcpu))
+		return false;
+
+	return kvm_vcpu_dabt_iswrite(vcpu);
+}
+
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
-- 
1.9.1
