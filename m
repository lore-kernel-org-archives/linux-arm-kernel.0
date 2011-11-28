From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:28:56 +0000
Subject: [PATCH v2 5/6] ARM: head.S: only include __turn_mmu_on in the initial
 identity mapping
In-Reply-To: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322504937-24718-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__create_page_tables identity maps the region of memory from
__enable_mmu to the end of __turn_mmu_on.

In preparation for including __turn_mmu_on in the .idmap.text section,
this patch modifies the identity mapping so that it only includes the
__turn_mmu_on code.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/head.S |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 566c54c..43e3aa3 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -170,11 +170,11 @@ __create_page_tables:
 	 * Create identity mapping to cater for __enable_mmu.
 	 * This identity mapping will be removed by paging_init().
 	 */
-	adr	r0, __enable_mmu_loc
+	adr	r0, __turn_mmu_on_loc
 	ldmia	r0, {r3, r5, r6}
 	sub	r0, r0, r3			@ virt->phys offset
-	add	r5, r5, r0			@ phys __enable_mmu
-	add	r6, r6, r0			@ phys __enable_mmu_end
+	add	r5, r5, r0			@ phys __turn_mmu_on
+	add	r6, r6, r0			@ phys __turn_mmu_on_end
 	mov	r5, r5, lsr #SECTION_SHIFT
 	mov	r6, r6, lsr #SECTION_SHIFT
 
@@ -287,10 +287,10 @@ __create_page_tables:
 ENDPROC(__create_page_tables)
 	.ltorg
 	.align
-__enable_mmu_loc:
+__turn_mmu_on_loc:
 	.long	.
-	.long	__enable_mmu
-	.long	__enable_mmu_end
+	.long	__turn_mmu_on
+	.long	__turn_mmu_on_end
 
 #if defined(CONFIG_SMP)
 	__CPUINIT
@@ -405,7 +405,7 @@ __turn_mmu_on:
 	mov	r3, r3
 	mov	r3, r13
 	mov	pc, r3
-__enable_mmu_end:
+__turn_mmu_on_end:
 ENDPROC(__turn_mmu_on)
 
 
-- 
1.7.4.1
