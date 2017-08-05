From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat,  5 Aug 2017 21:52:10 +0100
Subject: [PATCH 03/15] ARM: head-common.S: use PC-relative insn sequence for
 __turn_mmu_on
In-Reply-To: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
References: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
Message-ID: <20170805205222.19868-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the open coded PC relative offset calculations with a pair
of adr_l invocations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/head.S | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 04286fd9e09c..0a98aec0e39d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -227,11 +227,8 @@ __create_page_tables:
 	 * Create identity mapping to cater for __enable_mmu.
 	 * This identity mapping will be removed by paging_init().
 	 */
-	adr	r0, __turn_mmu_on_loc
-	ldmia	r0, {r3, r5, r6}
-	sub	r0, r0, r3			@ virt->phys offset
-	add	r5, r5, r0			@ phys __turn_mmu_on
-	add	r6, r6, r0			@ phys __turn_mmu_on_end
+	adr_l	r5, __turn_mmu_on		@ _pa(__turn_mmu_on)
+	adr_l	r6, __turn_mmu_on_end		@ _pa(__turn_mmu_on_end)
 	mov	r5, r5, lsr #SECTION_SHIFT
 	mov	r6, r6, lsr #SECTION_SHIFT
 
@@ -354,11 +351,6 @@ __create_page_tables:
 	ret	lr
 ENDPROC(__create_page_tables)
 	.ltorg
-	.align
-__turn_mmu_on_loc:
-	.long	.
-	.long	__turn_mmu_on
-	.long	__turn_mmu_on_end
 
 #if defined(CONFIG_SMP)
 	.text
-- 
2.11.0
