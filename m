From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  8 Sep 2014 22:29:27 +0200
Subject: [PATCH] ARM/arm64: KVM: fix use of WnR bit in kvm_is_write_fault()
Message-ID: <1410208167-32532-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ISS encoding for an exception from a Data Abort has a WnR
bit[6] that indicates whether the Data Abort was caused by a
read or a write instruction. While there are several fields
in the encoding that are only valid if the ISV bit[24] is set,
WnR is not one of them, so we can read it unconditionally.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This fixes an issue I observed with UEFI running under QEMU/KVM using
NOR flash emulation and the upcoming KVM_CAP_READONLY_MEM support, where
NOR flash reads were mistaken for NOR flash writes, resulting in all read
accesses to go through the MMIO emulation layer.

 arch/arm/include/asm/kvm_mmu.h   | 5 +----
 arch/arm64/include/asm/kvm_mmu.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 5cc0b0f5f72f..fad5648980ad 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -83,10 +83,7 @@ static inline bool kvm_is_write_fault(unsigned long hsr)
 	unsigned long hsr_ec = hsr >> HSR_EC_SHIFT;
 	if (hsr_ec == HSR_EC_IABT)
 		return false;
-	else if ((hsr & HSR_ISV) && !(hsr & HSR_WNR))
-		return false;
-	else
-		return true;
+	return hsr & HSR_WNR;
 }
 
 static inline void kvm_clean_pgd(pgd_t *pgd)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 8e138c7c53ac..09fd9e4c13d8 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -100,10 +100,7 @@ static inline bool kvm_is_write_fault(unsigned long esr)
 	if (esr_ec == ESR_EL2_EC_IABT)
 		return false;
 
-	if ((esr & ESR_EL2_ISV) && !(esr & ESR_EL2_WNR))
-		return false;
-
-	return true;
+	return esr & ESR_EL2_WNR;
 }
 
 static inline void kvm_clean_pgd(pgd_t *pgd) {}
-- 
1.8.3.2
