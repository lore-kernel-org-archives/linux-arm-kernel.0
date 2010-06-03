From: eric.miao@canonical.com (Eric Miao)
Date: Thu,  3 Jun 2010 17:43:34 +0800
Subject: [PATCH 1/2] [ARM] Make __create_page_table to accept phys_offset in a
	register
In-Reply-To: <1275558215-12743-1-git-send-email-eric.miao@canonical.com>
References: <1275558215-12743-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1275558215-12743-2-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.y.miao@gmail.com>

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/kernel/head.S |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..db789fb 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -44,8 +44,12 @@
 	.globl	swapper_pg_dir
 	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - 0x4000
 
-	.macro	pgtbl, rd
-	ldr	\rd, =(KERNEL_RAM_PADDR - 0x4000)
+	.macro	pgtbl, rd, phys_offset
+	add	\rd, \phys_offset, #(TEXT_OFFSET - 0x4000)
+	.endm
+
+	.macro	get_phys_offset, rd
+	ldr	\rd, =(PHYS_OFFSET & 0xfff00000)
 	.endm
 
 #ifdef CONFIG_XIP_KERNEL
@@ -86,6 +90,7 @@ ENTRY(stext)
 	movs	r8, r5				@ invalid machine (r5=0)?
 	beq	__error_a			@ yes, error 'a'
 	bl	__vet_atags
+	get_phys_offset r5
 	bl	__create_page_tables
 
 	/*
@@ -215,9 +220,10 @@ ENDPROC(__turn_mmu_on)
  * Returns:
  *  r0, r3, r6, r7 corrupted
  *  r4 = physical page table address
+ *  r5 = physical address of memory start
  */
 __create_page_tables:
-	pgtbl	r4				@ page table address
+	pgtbl	r4, r5				@ page table address
 
 	/*
 	 * Clear the 16K level 1 swapper page table
@@ -282,10 +288,7 @@ __create_page_tables:
 	 * Then map first 1MB of ram in case it contains our boot params.
 	 */
 	add	r0, r4, #PAGE_OFFSET >> 18
-	orr	r6, r7, #(PHYS_OFFSET & 0xff000000)
-	.if	(PHYS_OFFSET & 0x00f00000)
-	orr	r6, r6, #(PHYS_OFFSET & 0x00f00000)
-	.endif
+	orr	r6, r5, r7
 	str	r6, [r0]
 
 #ifdef CONFIG_DEBUG_LL
-- 
1.7.0.4
