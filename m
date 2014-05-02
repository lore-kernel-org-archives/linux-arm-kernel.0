From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:15 +0100
Subject: [PATCH 8/8] arm64: mm: use inner-shareable barriers for
 inner-shareable maintenance
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to ensure ordering and completion of inner-shareable maintenance
instructions (cache and TLB) on AArch64, we can use the -ish suffix to
the dmb and dsb instructions respectively.

This patch updates our low-level cache and tlb maintenance routines to
use the inner-shareable barrier variants where appropriate.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/cache.S | 6 +++---
 arch/arm64/mm/proc.S  | 2 +-
 arch/arm64/mm/tlb.S   | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index fda756875fa6..23663837acff 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -31,7 +31,7 @@
  *	Corrupted registers: x0-x7, x9-x11
  */
 __flush_dcache_all:
-	dsb	sy				// ensure ordering with previous memory accesses
+	dmb	sy				// ensure ordering with previous memory accesses
 	mrs	x0, clidr_el1			// read clidr
 	and	x3, x0, #0x7000000		// extract loc from clidr
 	lsr	x3, x3, #23			// left align loc bit field
@@ -128,7 +128,7 @@ USER(9f, dc	cvau, x4	)		// clean D line to PoU
 	add	x4, x4, x2
 	cmp	x4, x1
 	b.lo	1b
-	dsb	sy
+	dsb	ish
 
 	icache_line_size x2, x3
 	sub	x3, x2, #1
@@ -139,7 +139,7 @@ USER(9f, ic	ivau, x4	)		// invalidate I line PoU
 	cmp	x4, x1
 	b.lo	1b
 9:						// ignore any faulting cache operation
-	dsb	sy
+	dsb	ish
 	isb
 	ret
 ENDPROC(flush_icache_range)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 9042aff5e9e3..7736779c9809 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -182,7 +182,7 @@ ENDPROC(cpu_do_switch_mm)
 ENTRY(__cpu_setup)
 	ic	iallu				// I+BTB cache invalidate
 	tlbi	vmalle1is			// invalidate I + D TLBs
-	dsb	sy
+	dsb	ish
 
 	mov	x0, #3 << 20
 	msr	cpacr_el1, x0			// Enable FP/ASIMD
diff --git a/arch/arm64/mm/tlb.S b/arch/arm64/mm/tlb.S
index 19da91e0cd27..114033617dcc 100644
--- a/arch/arm64/mm/tlb.S
+++ b/arch/arm64/mm/tlb.S
@@ -36,7 +36,7 @@
 ENTRY(__cpu_flush_user_tlb_range)
 	vma_vm_mm x3, x2			// get vma->vm_mm
 	mmid	w3, x3				// get vm_mm->context.id
-	dsb	sy
+	dsb	ishst
 	lsr	x0, x0, #12			// align address
 	lsr	x1, x1, #12
 	bfi	x0, x3, #48, #16		// start VA and ASID
@@ -45,7 +45,7 @@ ENTRY(__cpu_flush_user_tlb_range)
 	add	x0, x0, #1
 	cmp	x0, x1
 	b.lo	1b
-	dsb	sy
+	dsb	ish
 	ret
 ENDPROC(__cpu_flush_user_tlb_range)
 
@@ -58,14 +58,14 @@ ENDPROC(__cpu_flush_user_tlb_range)
  *	- end   - end address (exclusive, may not be aligned)
  */
 ENTRY(__cpu_flush_kern_tlb_range)
-	dsb	sy
+	dsb	ishst
 	lsr	x0, x0, #12			// align address
 	lsr	x1, x1, #12
 1:	tlbi	vaae1is, x0			// TLB invalidate by address
 	add	x0, x0, #1
 	cmp	x0, x1
 	b.lo	1b
-	dsb	sy
+	dsb	ish
 	isb
 	ret
 ENDPROC(__cpu_flush_kern_tlb_range)
-- 
1.9.2
