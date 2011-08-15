From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Aug 2011 17:34:52 +0100
Subject: [PATCH 1/1] fixup! ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead of PGDIR_*
Message-ID: <mailman.86.1313426936.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the hard-coded shift and mask values in head.S and mmu.c to
SECTION_SHIFT and PMD_ORDER for easier integration of the LPAE support.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/head.S |   74 +++++++++++++++++++++++++----------------------
 arch/arm/mm/mmu.c      |    4 ++-
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index d8231b2..45e5e60 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -21,6 +21,7 @@
 #include <asm/memory.h>
 #include <asm/thread_info.h>
 #include <asm/system.h>
+#include <asm/pgtable.h>
 
 #ifdef CONFIG_DEBUG_LL
 #include <mach/debug-macro.S>
@@ -38,11 +39,14 @@
 #error KERNEL_RAM_VADDR must start at 0xXXXX8000
 #endif
 
+#define PG_DIR_SIZE	0x4000
+#define PMD_ORDER	2
+
 	.globl	swapper_pg_dir
-	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - 0x4000
+	.equ	swapper_pg_dir, KERNEL_RAM_VADDR - PG_DIR_SIZE
 
 	.macro	pgtbl, rd, phys
-	add	\rd, \phys, #TEXT_OFFSET - 0x4000
+	add	\rd, \phys, #TEXT_OFFSET - PG_DIR_SIZE
 	.endm
 
 #ifdef CONFIG_XIP_KERNEL
@@ -148,11 +152,11 @@ __create_page_tables:
 	pgtbl	r4, r8				@ page table address
 
 	/*
-	 * Clear the 16K level 1 swapper page table
+	 * Clear the swapper page table
 	 */
 	mov	r0, r4
 	mov	r3, #0
-	add	r6, r0, #0x4000
+	add	r6, r0, #PG_DIR_SIZE
 1:	str	r3, [r0], #4
 	str	r3, [r0], #4
 	str	r3, [r0], #4
@@ -171,30 +175,30 @@ __create_page_tables:
 	sub	r0, r0, r3			@ virt->phys offset
 	add	r5, r5, r0			@ phys __enable_mmu
 	add	r6, r6, r0			@ phys __enable_mmu_end
-	mov	r5, r5, lsr #20
-	mov	r6, r6, lsr #20
+	mov	r5, r5, lsr #SECTION_SHIFT
+	mov	r6, r6, lsr #SECTION_SHIFT
 
-1:	orr	r3, r7, r5, lsl #20		@ flags + kernel base
-	str	r3, [r4, r5, lsl #2]		@ identity mapping
-	teq	r5, r6
-	addne	r5, r5, #1			@ next section
-	bne	1b
+1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
+	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
+	cmp	r5, r6
+	addlo	r5, r5, #1			@ next section
+	blo	1b
 
 	/*
 	 * Now setup the pagetables for our kernel direct
 	 * mapped region.
 	 */
 	mov	r3, pc
-	mov	r3, r3, lsr #20
-	orr	r3, r7, r3, lsl #20
-	add	r0, r4,  #(KERNEL_START & 0xff000000) >> 18
-	str	r3, [r0, #(KERNEL_START & 0x00f00000) >> 18]!
+	mov	r3, r3, lsr #SECTION_SHIFT
+	orr	r3, r7, r3, lsl #SECTION_SHIFT
+	add	r0, r4,  #(KERNEL_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
+	str	r3, [r0, #((KERNEL_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ORDER]!
 	ldr	r6, =(KERNEL_END - 1)
-	add	r0, r0, #4
-	add	r6, r4, r6, lsr #18
+	add	r0, r0, #1 << PMD_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
 1:	cmp	r0, r6
-	add	r3, r3, #1 << 20
-	strls	r3, [r0], #4
+	add	r3, r3, #1 << SECTION_SHIFT
+	strls	r3, [r0], #1 << PMD_ORDER
 	bls	1b
 
 #ifdef CONFIG_XIP_KERNEL
@@ -203,11 +207,11 @@ __create_page_tables:
 	 */
 	add	r3, r8, #TEXT_OFFSET
 	orr	r3, r3, r7
-	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> 18
-	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> 18]!
+	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
+	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> (SECTION_SHIFT - PMD_ORDER)]!
 	ldr	r6, =(_end - 1)
 	add	r0, r0, #4
-	add	r6, r4, r6, lsr #18
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
 1:	cmp	r0, r6
 	add	r3, r3, #1 << 20
 	strls	r3, [r0], #4
@@ -218,12 +222,12 @@ __create_page_tables:
 	 * Then map boot params address in r2 or
 	 * the first 1MB of ram if boot params address is not specified.
 	 */
-	mov	r0, r2, lsr #20
-	movs	r0, r0, lsl #20
+	mov	r0, r2, lsr #SECTION_SHIFT
+	movs	r0, r0, lsl #SECTION_SHIFT
 	moveq	r0, r8
 	sub	r3, r0, r8
 	add	r3, r3, #PAGE_OFFSET
-	add	r3, r4, r3, lsr #18
+	add	r3, r4, r3, lsr #(SECTION_SHIFT - PMD_ORDER)
 	orr	r6, r7, r0
 	str	r6, [r3]
 
@@ -236,21 +240,21 @@ __create_page_tables:
 	 */
 	addruart r7, r3
 
-	mov	r3, r3, lsr #20
-	mov	r3, r3, lsl #2
+	mov	r3, r3, lsr #SECTION_SHIFT
+	mov	r3, r3, lsl #PMD_ORDER
 
 	add	r0, r4, r3
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
 	add	r6, r0, r3
-	mov	r3, r7, lsr #20
+	mov	r3, r7, lsr #SECTION_SHIFT
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
-	orr	r3, r7, r3, lsl #20
+	orr	r3, r7, r3, lsl #SECTION_SHIFT
 1:	str	r3, [r0], #4
-	add	r3, r3, #1 << 20
-	teq	r0, r6
-	bne	1b
+	add	r3, r3, #1 << SECTION_SHIFT
+	cmp	r0, r6
+	blo	1b
 
 #else /* CONFIG_DEBUG_ICEDCC */
 	/* we don't need any serial debugging mappings for ICEDCC */
@@ -262,7 +266,7 @@ __create_page_tables:
 	 * If we're using the NetWinder or CATS, we also need to map
 	 * in the 16550-type serial port for the debug messages
 	 */
-	add	r0, r4, #0xff000000 >> 18
+	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ORDER)
 	orr	r3, r7, #0x7c000000
 	str	r3, [r0]
 #endif
@@ -272,10 +276,10 @@ __create_page_tables:
 	 * Similar reasons here - for debug.  This is
 	 * only for Acorn RiscPC architectures.
 	 */
-	add	r0, r4, #0x02000000 >> 18
+	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ORDER)
 	orr	r3, r7, #0x02000000
 	str	r3, [r0]
-	add	r0, r4, #0xd8000000 >> 18
+	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ORDER)
 	str	r3, [r0]
 #endif
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index dc26858..36e983d 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -889,6 +889,8 @@ static inline void prepare_page_table(void)
 		pmd_clear(pmd_off_k(addr));
 }
 
+#define SWAPPER_PG_DIR_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
+
 /*
  * Reserve the special regions of memory
  */
@@ -898,7 +900,7 @@ void __init arm_mm_memblock_reserve(void)
 	 * Reserve the page tables.  These are already in use,
 	 * and can only be in node 0.
 	 */
-	memblock_reserve(__pa(swapper_pg_dir), PTRS_PER_PGD * sizeof(pgd_t));
+	memblock_reserve(__pa(swapper_pg_dir), SWAPPER_PG_DIR_SIZE);
 
 #ifdef CONFIG_SA1111
 	/*

-- 
Catalin
