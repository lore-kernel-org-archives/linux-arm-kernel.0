From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 17:54:38 +0100
Subject: [PATCH 2/2] ARM: tlb: don't perform inner-shareable invalidation for
 local BP ops
In-Reply-To: <1368809678-25818-1-git-send-email-will.deacon@arm.com>
References: <1368809678-25818-1-git-send-email-will.deacon@arm.com>
Message-ID: <1368809678-25818-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ASID allocator doesn't require inner-shareable maintenance,
we can convert the local_bp_flush_all function to perform only
non-shareable flushing, in a similar manner to the TLB invalidation
routines.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 16 +++++++++++++---
 arch/arm/kernel/smp_tlb.c       |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 55b5e18..8630db6 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -168,7 +168,7 @@
 
 #define v7wbi_tlb_flags_smp	(TLB_WB | TLB_BARRIER | \
 				 TLB_V6_U_FULL | TLB_V6_U_PAGE | \
-				 TLB_V6_U_ASID | \
+				 TLB_V6_U_ASID | TLB_V6_BP | \
 				 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | \
 				 TLB_V7_UIS_ASID | TLB_V7_UIS_BP)
 #define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
@@ -488,14 +488,24 @@ static inline void __flush_tlb_kernel_page(unsigned long kaddr)
 	}
 }
 
-static inline void local_flush_bp_all(void)
+static inline void __flush_bp_all(void)
 {
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_V7_UIS_BP))
 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
-	else if (tlb_flag(TLB_V6_BP))
+
+	if (tlb_flag(TLB_BARRIER))
+		isb();
+}
+
+static inline void local_flush_bp_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_V6_BP))
 		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
 
 	if (tlb_flag(TLB_BARRIER))
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index cc299b5..5cb5500 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -204,5 +204,5 @@ void flush_bp_all(void)
 	if (tlb_ops_need_broadcast())
 		on_each_cpu(ipi_flush_bp_all, NULL, 1);
 	else
-		local_flush_bp_all();
+		__flush_bp_all();
 }
-- 
1.8.2.2
