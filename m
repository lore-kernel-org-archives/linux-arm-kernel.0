From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:18 +0100
Subject: [PATCH v2 04/12] ARM: tlb: don't perform inner-shareable invalidation
 for local BP ops
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ASID allocator doesn't require inner-shareable maintenance,
we can convert the local_bp_flush_all function to perform only
non-shareable flushing, in a similar manner to the TLB invalidation
routines.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 22 ++++++++++++++++++++--
 arch/arm/kernel/smp_tlb.c       |  2 +-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 45e3aea..b9c0811 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -531,17 +531,35 @@ static inline void __flush_tlb_kernel_page(unsigned long kaddr)
  * Branch predictor maintenance is paired with full TLB invalidation, so
  * there is no need for any barriers here.
  */
+static inline void __local_flush_bp_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_V6_BP))
+		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
+}
+
 static inline void local_flush_bp_all(void)
 {
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
+	__local_flush_bp_all();
 	if (tlb_flag(TLB_V7_UIS_BP))
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
-	else if (tlb_flag(TLB_V6_BP))
 		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
 }
 
+static inline void __flush_bp_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	__local_flush_bp_all();
+	if (tlb_flag(TLB_V7_UIS_BP))
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
+}
+
 #ifdef CONFIG_ARM_ERRATA_798181
 static inline void dummy_flush_tlb_a15_erratum(void)
 {
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
