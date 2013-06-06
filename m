From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Jun 2013 15:28:27 +0100
Subject: [PATCH 03/10] ARM: tlb: don't bother with barriers for branch
 predictor maintenance
In-Reply-To: <1370528914-17506-1-git-send-email-will.deacon@arm.com>
References: <1370528914-17506-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370528914-17506-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Branch predictor maintenance is only required when we are either
changing the kernel's view of memory (switching tables completely) or
dealing with ASID rollover.

Both of these use-cases require subsequent TLB invalidation, which has
the relevant barrier instructions to ensure completion and visibility
of the maintenance, so this patch removes the instruction barrier from
[local_]flush_bp_all.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 55b5e18..e111027 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -488,6 +488,10 @@ static inline void __flush_tlb_kernel_page(unsigned long kaddr)
 	}
 }
 
+/*
+ * Branch predictor maintenance is paired with full TLB invalidation, so
+ * there is no need for any barriers here.
+ */
 static inline void local_flush_bp_all(void)
 {
 	const int zero = 0;
@@ -497,9 +501,6 @@ static inline void local_flush_bp_all(void)
 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
 	else if (tlb_flag(TLB_V6_BP))
 		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
-
-	if (tlb_flag(TLB_BARRIER))
-		isb();
 }
 
 #ifdef CONFIG_ARM_ERRATA_798181
-- 
1.8.2.2
