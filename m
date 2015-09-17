From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:12 +0100
Subject: [PATCH 03/10] arm64: flush: use local TLB and I-cache invalidation
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of places where a single CPU is running with a
private page-table and we need to perform maintenance on the TLB and
I-cache in order to ensure correctness, but do not require the operation
to be broadcast to other CPUs.

This patch adds local variants of tlb_flush_all and __flush_icache_all
to support these use-cases and updates the callers respectively.
__local_flush_icache_all also implies an isb, since it is intended to be
used synchronously.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cacheflush.h | 7 +++++++
 arch/arm64/include/asm/tlbflush.h   | 8 ++++++++
 arch/arm64/kernel/efi.c             | 4 ++--
 arch/arm64/kernel/smp.c             | 2 +-
 arch/arm64/kernel/suspend.c         | 2 +-
 arch/arm64/mm/context.c             | 4 ++--
 arch/arm64/mm/mmu.c                 | 2 +-
 7 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index c75b8d027eb1..54efedaf331f 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -115,6 +115,13 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
 
+static inline void __local_flush_icache_all(void)
+{
+	asm("ic iallu");
+	dsb(nsh);
+	isb();
+}
+
 static inline void __flush_icache_all(void)
 {
 	asm("ic	ialluis");
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 7bd2da021658..96f944e75dc4 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -63,6 +63,14 @@
  *		only require the D-TLB to be invalidated.
  *		- kaddr - Kernel virtual memory address
  */
+static inline void local_flush_tlb_all(void)
+{
+	dsb(nshst);
+	asm("tlbi	vmalle1");
+	dsb(nsh);
+	isb();
+}
+
 static inline void flush_tlb_all(void)
 {
 	dsb(ishst);
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e8ca6eaedd02..b0f6dbdc5260 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -343,9 +343,9 @@ static void efi_set_pgd(struct mm_struct *mm)
 	else
 		cpu_switch_mm(mm->pgd, mm);
 
-	flush_tlb_all();
+	local_flush_tlb_all();
 	if (icache_is_aivivt())
-		__flush_icache_all();
+		__local_flush_icache_all();
 }
 
 void efi_virtmap_load(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacddd9a5..fdd4d4dbd64f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -152,7 +152,7 @@ asmlinkage void secondary_start_kernel(void)
 	 * point to zero page to avoid speculatively fetching new entries.
 	 */
 	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
+	local_flush_tlb_all();
 	cpu_set_default_tcr_t0sz();
 
 	preempt_disable();
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 8297d502217e..3c5e4e6dcf68 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -90,7 +90,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		else
 			cpu_switch_mm(mm->pgd, mm);
 
-		flush_tlb_all();
+		local_flush_tlb_all();
 
 		/*
 		 * Restore per-cpu offset before any kernel
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index d70ff14dbdbd..48b53fb381af 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -48,9 +48,9 @@ static void flush_context(void)
 {
 	/* set the reserved TTBR0 before flushing the TLB */
 	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
+	local_flush_tlb_all();
 	if (icache_is_aivivt())
-		__flush_icache_all();
+		__local_flush_icache_all();
 }
 
 static void set_mm_context(struct mm_struct *mm, unsigned int asid)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9211b8527f25..71a310478c9e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -456,7 +456,7 @@ void __init paging_init(void)
 	 * point to zero page to avoid speculatively fetching new entries.
 	 */
 	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
+	local_flush_tlb_all();
 	cpu_set_default_tcr_t0sz();
 }
 
-- 
2.1.4
