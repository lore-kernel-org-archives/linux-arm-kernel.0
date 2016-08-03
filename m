From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Aug 2016 17:38:49 +0200
Subject: [PATCH 7/8] ARM: head.S: use PC-relative insn sequences for
 __fixup_pv_table
In-Reply-To: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1470238730-30038-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the open coded PC relative offset calculations with adr_l,
ldr_l and str_l invocations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/head.S | 32 ++++++--------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index a9d8f9004dfd..b9746366b633 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -577,37 +577,28 @@ ENDPROC(fixup_smp)
  */
 	__HEAD
 __fixup_pv_table:
-	adr	r0, 1f
-	ldmia	r0, {r3-r7}
+	adr_l	r7, __pv_offset			@ __pa(__pv_offset)
+	ldr	r3, =__pv_offset		@ __va(__pv_offset)
 	mvn	ip, #0
-	subs	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
-	add	r4, r4, r3	@ adjust table start address
-	add	r5, r5, r3	@ adjust table end address
-	add	r6, r6, r3	@ adjust __pv_phys_pfn_offset address
-	add	r7, r7, r3	@ adjust __pv_offset address
-	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
-	str	r0, [r6]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
+	subs	r3, r7, r3			@ PHYS_OFFSET - PAGE_OFFSET
+	mov	r0, r8, lsr #PAGE_SHIFT		@ convert to PFN
+	str_l	r0, __pv_phys_pfn_offset, r6	@ save computed PHYS_OFFSET
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
 	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
+
+	adr_l	r4, __pv_table_begin
+	adr_l	r5, __pv_table_end
 	b	__fixup_a_pv_table
 ENDPROC(__fixup_pv_table)
-
-	.align
-1:	.long	.
-	.long	__pv_table_begin
-	.long	__pv_table_end
-2:	.long	__pv_phys_pfn_offset
-	.long	__pv_offset
+	.ltorg
 
 	.text
 __fixup_a_pv_table:
-	adr	r0, 3f
-	ldr	r6, [r0]
-	add	r6, r6, r3
+	adr_l	r6, __pv_offset
 	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
 	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
 	mov	r6, r6, lsr #24
@@ -675,9 +666,6 @@ ARM_BE8(rev16	ip, ip)
 #endif
 ENDPROC(__fixup_a_pv_table)
 
-	.align
-3:	.long __pv_offset
-
 ENTRY(fixup_pv_table)
 	stmfd	sp!, {r4 - r7, lr}
 	mov	r3, #0			@ no offset
-- 
2.7.4
