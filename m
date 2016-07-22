From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:28:26 +0100
Subject: [PATCH 09/55] arm/arm64: KVM: Remove hyp_kern_va helper
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hyp_kern_va is now completely unused, so let's remove it entirely.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_hyp.h   |  1 -
 arch/arm64/include/asm/kvm_hyp.h | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index f0e8607..e38fce2 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -26,7 +26,6 @@
 #define __hyp_text __section(.hyp.text) notrace
 
 #define kern_hyp_va(v) (v)
-#define hyp_kern_va(v) (v)
 
 #define __ACCESS_CP15(CRn, Op1, CRm, Op2)	\
 	"mrc", "mcr", __stringify(p15, Op1, %0, CRn, CRm, Op2), u32
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 44eaff7..1d81f9a 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -36,18 +36,6 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
 
 #define kern_hyp_va(v) (typeof(v))(__kern_hyp_va((unsigned long)(v)))
 
-static inline unsigned long __hyp_kern_va(unsigned long v)
-{
-	u64 offset = PAGE_OFFSET - HYP_PAGE_OFFSET;
-	asm volatile(ALTERNATIVE("add %0, %0, %1",
-				 "nop",
-				 ARM64_HAS_VIRT_HOST_EXTN)
-		     : "+r" (v) : "r" (offset));
-	return v;
-}
-
-#define hyp_kern_va(v) (typeof(v))(__hyp_kern_va((unsigned long)(v)))
-
 #define read_sysreg_elx(r,nvh,vh)					\
 	({								\
 		u64 reg;						\
-- 
2.8.1
