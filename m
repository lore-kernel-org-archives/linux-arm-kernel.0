From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:21 +0100
Subject: [PATCH v2 07/12] ARM: mm: use inner-shareable barriers for TLB and
 user cache operations
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System-wide barriers aren't required for situations where we only need
to make visibility and ordering guarantees in the inner-shareable domain
(i.e. we are not dealing with devices or potentially incoherent CPUs).

This patch changes the v7 TLB operations, coherent_user_range and
dcache_clean_area functions to user inner-shareable barriers. For cache
maintenance, only the store access type is required to ensure completion.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-v7.S | 4 ++--
 arch/arm/mm/proc-v7.S  | 2 +-
 arch/arm/mm/tlb-v7.S   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 15451ee..44f5a6a 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -274,7 +274,7 @@ ENTRY(v7_coherent_user_range)
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	1b
-	dsb
+	dsb	ishst
 	icache_line_size r2, r3
 	sub	r3, r2, #1
 	bic	r12, r0, r3
@@ -286,7 +286,7 @@ ENTRY(v7_coherent_user_range)
 	mov	r0, #0
 	ALT_SMP(mcr	p15, 0, r0, c7, c1, 6)	@ invalidate BTB Inner Shareable
 	ALT_UP(mcr	p15, 0, r0, c7, c5, 6)	@ invalidate BTB
-	dsb
+	dsb	ishst
 	isb
 	mov	pc, lr
 
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c73a73..d19ddc0 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -82,7 +82,7 @@ ENTRY(cpu_v7_dcache_clean_area)
 	add	r0, r0, r2
 	subs	r1, r1, r2
 	bhi	1b
-	dsb
+	dsb	ishst
 	mov	pc, lr
 ENDPROC(cpu_v7_dcache_clean_area)
 
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index ea94765..3553087 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -35,7 +35,7 @@
 ENTRY(v7wbi_flush_user_tlb_range)
 	vma_vm_mm r3, r2			@ get vma->vm_mm
 	mmid	r3, r3				@ get vm_mm->context.id
-	dsb
+	dsb	ish
 	mov	r0, r0, lsr #PAGE_SHIFT		@ align address
 	mov	r1, r1, lsr #PAGE_SHIFT
 	asid	r3, r3				@ mask ASID
@@ -56,7 +56,7 @@ ENTRY(v7wbi_flush_user_tlb_range)
 	add	r0, r0, #PAGE_SZ
 	cmp	r0, r1
 	blo	1b
-	dsb
+	dsb	ish
 	mov	pc, lr
 ENDPROC(v7wbi_flush_user_tlb_range)
 
@@ -69,7 +69,7 @@ ENDPROC(v7wbi_flush_user_tlb_range)
  *	- end   - end address (exclusive, may not be aligned)
  */
 ENTRY(v7wbi_flush_kern_tlb_range)
-	dsb
+	dsb	ish
 	mov	r0, r0, lsr #PAGE_SHIFT		@ align address
 	mov	r1, r1, lsr #PAGE_SHIFT
 	mov	r0, r0, lsl #PAGE_SHIFT
@@ -84,7 +84,7 @@ ENTRY(v7wbi_flush_kern_tlb_range)
 	add	r0, r0, #PAGE_SZ
 	cmp	r0, r1
 	blo	1b
-	dsb
+	dsb	ish
 	isb
 	mov	pc, lr
 ENDPROC(v7wbi_flush_kern_tlb_range)
-- 
1.8.2.2
