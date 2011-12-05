From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Dec 2011 15:31:43 -0500 (EST)
Subject: [PATCH] ARM: make head.S register assignments more convenient
Message-ID: <alpine.LFD.2.02.1112051528200.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The r1 (machine ID) and r2 (boot data pointer) values are getting
in the way of standard procedure calls as those registers are normally
clobbered by function calls.  This is especially obnoxious when using
the printascii et cie debugging routines..  This non-standard register
allocation is even leaking into code far away from head.S i.e. the *_setup
routines in mm/proc-*.S.

Move the machine ID / boot data pointer  to r6 and r7 respectively, and
adjust the surrounding/affected code accordingly.

Minor fixes to some comments are also included.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/head-common.S |  101 +++++++++---------
 arch/arm/kernel/head-nommu.S  |    4 +-
 arch/arm/kernel/head.S        |  207 ++++++++++++++++++-----------------
 arch/arm/mm/proc-arm1020.S    |    8 +-
 arch/arm/mm/proc-arm1020e.S   |    8 +-
 arch/arm/mm/proc-arm1022.S    |    8 +-
 arch/arm/mm/proc-arm1026.S    |    8 +-
 arch/arm/mm/proc-arm720.S     |   16 ++--
 arch/arm/mm/proc-arm920.S     |    8 +-
 arch/arm/mm/proc-arm922.S     |    8 +-
 arch/arm/mm/proc-arm925.S     |    8 +-
 arch/arm/mm/proc-arm926.S     |    6 +-
 arch/arm/mm/proc-feroceon.S   |    8 +-
 arch/arm/mm/proc-mohawk.S     |    8 +-
 arch/arm/mm/proc-sa110.S      |   16 ++--
 arch/arm/mm/proc-sa1100.S     |    8 +-
 arch/arm/mm/proc-v6.S         |   22 ++--
 arch/arm/mm/proc-v7.S         |  130 +++++++++++-----------
 arch/arm/mm/proc-xsc3.S       |   10 +-
 arch/arm/mm/proc-xscale.S     |    8 +-
 20 files changed, 302 insertions(+), 298 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 854bd22380..0d9dfcdb1b 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -32,38 +32,38 @@
  */
 	__HEAD
 
-/* Determine validity of the r2 atags pointer.  The heuristic requires
- * that the pointer be aligned, in the first 16k of physical RAM and
+/* Determine validity of the r2 (now in r7) atags pointer.  The heuristic
+ * requires that the pointer be aligned, in the first 16k of physical RAM and
  * that the ATAG_CORE marker is first and present.  If CONFIG_OF_FLATTREE
  * is selected, then it will also accept a dtb pointer.  Future revisions
  * of this function may be more lenient with the physical address and
  * may also be able to move the ATAGS block if necessary.
  *
  * Returns:
- *  r2 either valid atags pointer, valid dtb pointer, or zero
- *  r5, r6 corrupted
+ *  r7 either valid atags pointer, valid dtb pointer, or zero
+ *  r1, r5 corrupted
  */
 __vet_atags:
-	tst	r2, #0x3			@ aligned?
+	tst	r7, #0x3			@ aligned?
 	bne	1f
 
-	ldr	r5, [r2, #0]
+	ldr	r5, [r7, #0]
 #ifdef CONFIG_OF_FLATTREE
-	ldr	r6, =OF_DT_MAGIC		@ is it a DTB?
-	cmp	r5, r6
+	ldr	r1, =OF_DT_MAGIC		@ is it a DTB?
+	cmp	r5, r1
 	beq	2f
 #endif
 	cmp	r5, #ATAG_CORE_SIZE		@ is first tag ATAG_CORE?
 	cmpne	r5, #ATAG_CORE_SIZE_EMPTY
 	bne	1f
-	ldr	r5, [r2, #4]
-	ldr	r6, =ATAG_CORE
-	cmp	r5, r6
+	ldr	r5, [r7, #4]
+	ldr	r1, =ATAG_CORE
+	cmp	r5, r1
 	bne	1f
 
 2:	mov	pc, lr				@ atag/dtb pointer is ok
 
-1:	mov	r2, #0
+1:	mov	r7, #0
 	mov	pc, lr
 ENDPROC(__vet_atags)
 
@@ -72,48 +72,48 @@ ENDPROC(__vet_atags)
  * and uses absolute addresses; this is not position independent.
  *
  *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags/dtb pointer
+ *  r6  = machine ID
+ *  r7  = atags/dtb pointer
  *  r9  = processor ID
  */
 	__INIT
 __mmap_switched:
 	adr	r3, __mmap_switched_data
 
-	ldmia	r3!, {r4, r5, r6, r7}
-	cmp	r4, r5				@ Copy data segment if needed
-1:	cmpne	r5, r6
-	ldrne	fp, [r4], #4
-	strne	fp, [r5], #4
+	ldmia	r3!, {r1, r2, r4, r5}
+	cmp	r1, r2				@ Copy data segment if needed
+1:	cmpne	r2, r4
+	ldrne	fp, [r1], #4
+	strne	fp, [r2], #4
 	bne	1b
 
 	mov	fp, #0				@ Clear BSS (and zero fp)
-1:	cmp	r6, r7
-	strcc	fp, [r6],#4
+1:	cmp	r4, r5
+	strcc	fp, [r4], #4
 	bcc	1b
 
- ARM(	ldmia	r3, {r4, r5, r6, r7, sp})
- THUMB(	ldmia	r3, {r4, r5, r6, r7}	)
+ ARM(	ldmia	r3, {r1, r2, r4, r5, sp})
+ THUMB(	ldmia	r3, {r1, r2, r4, r5}	)
  THUMB(	ldr	sp, [r3, #16]		)
-	str	r9, [r4]			@ Save processor ID
-	str	r1, [r5]			@ Save machine type
-	str	r2, [r6]			@ Save atags pointer
-	bic	r4, r0, #CR_A			@ Clear 'A' bit
-	stmia	r7, {r0, r4}			@ Save control register values
+	str	r9, [r1]			@ Save processor ID
+	str	r6, [r2]			@ Save machine type
+	str	r7, [r4]			@ Save atags pointer
+	bic	r1, r0, #CR_A			@ Clear 'A' bit
+	stmia	r5, {r0, r1}			@ Save control register values
 	b	start_kernel
 ENDPROC(__mmap_switched)
 
 	.align	2
 	.type	__mmap_switched_data, %object
 __mmap_switched_data:
-	.long	__data_loc			@ r4
-	.long	_sdata				@ r5
-	.long	__bss_start			@ r6
-	.long	_end				@ r7
-	.long	processor_id			@ r4
-	.long	__machine_arch_type		@ r5
-	.long	__atags_pointer			@ r6
-	.long	cr_alignment			@ r7
+	.long	__data_loc			@ r1
+	.long	_sdata				@ r2
+	.long	__bss_start			@ r4
+	.long	_end				@ r5
+	.long	processor_id			@ r1
+	.long	__machine_arch_type		@ r2
+	.long	__atags_pointer			@ r4
+	.long	cr_alignment			@ r5
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
@@ -121,11 +121,10 @@ __mmap_switched_data:
  * This provides a C-API version of __lookup_processor_type
  */
 ENTRY(lookup_processor_type)
-	stmfd	sp!, {r4 - r6, r9, lr}
+	stmfd	sp!, {r9, lr}
 	mov	r9, r0
 	bl	__lookup_processor_type
-	mov	r0, r5
-	ldmfd	sp!, {r4 - r6, r9, pc}
+	ldmfd	sp!, {r9, pc}
 ENDPROC(lookup_processor_type)
 
 /*
@@ -137,25 +136,25 @@ ENDPROC(lookup_processor_type)
  *
  *	r9 = cpuid
  * Returns:
- *	r3, r4, r6 corrupted
- *	r5 = proc_info pointer in physical address space
+ *	r1, r2, r3 corrupted
+ *	r0 = proc_info pointer in physical address space
  *	r9 = cpuid (preserved)
  */
 	__CPUINIT
 __lookup_processor_type:
 	adr	r3, __lookup_processor_type_data
-	ldmia	r3, {r4 - r6}
-	sub	r3, r3, r4			@ get offset between virt&phys
-	add	r5, r5, r3			@ convert virt addresses to
-	add	r6, r6, r3			@ physical address space
-1:	ldmia	r5, {r3, r4}			@ value, mask
-	and	r4, r4, r9			@ mask wanted bits
-	teq	r3, r4
+	ldmia	r3, {r0 - r2}
+	sub	r3, r3, r0			@ get offset between virt&phys
+	add	r0, r1, r3			@ convert virt addresses to
+	add	r1, r2, r3			@ physical address space
+1:	ldmia	r0, {r2, r3}			@ value, mask
+	and	r3, r3, r9			@ mask wanted bits
+	teq	r2, r3
 	beq	2f
-	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
-	cmp	r5, r6
+	add	r0, r0, #PROC_INFO_SZ		@ sizeof(proc_info_list)
+	cmp	r0, r1
 	blo	1b
-	mov	r5, #0				@ unknown processor
+	mov	r0, #0				@ unknown processor
 2:	mov	pc, lr
 ENDPROC(__lookup_processor_type)
 
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index d46f25968b..5d0a42c3b6 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -44,13 +44,15 @@ ENTRY(stext)
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
+	mov	r6, r1				@ preserve machine ID
+	mov	r7, r2				@ preserve boot data pointer
 #ifndef CONFIG_CPU_CP15
 	ldr	r9, =CONFIG_PROCESSOR_ID
 #else
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 #endif
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
-	movs	r10, r5				@ invalid processor (r5=0)?
+	movs	r10, r0				@ invalid processor (r5=0)?
 	beq	__error_p				@ yes, error 'p'
 
 	adr	lr, BSYM(__after_proc_init)	@ return (PIC) address
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 08c82fd844..cb3034c3fb 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -87,9 +87,11 @@ ENTRY(stext)
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
+	mov	r6, r1				@ preserve machine ID
+	mov	r7, r2				@ preserve boot data pointer
 	mrc	p15, 0, r9, c0, c0		@ get processor id
-	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
-	movs	r10, r5				@ invalid processor (r5=0)?
+	bl	__lookup_processor_type		@ r9=cpuid
+	movs	r10, r0				@ invalid processor (r0=0)?
  THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p			@ yes, error 'p'
 
@@ -103,7 +105,7 @@ ENTRY(stext)
 #endif
 
 	/*
-	 * r1 = machine no, r2 = atags or dtb,
+	 * r6 = machine no, r7 = atags or dtb,
 	 * r8 = phys_offset, r9 = cpuid, r10 = procinfo
 	 */
 	bl	__vet_atags
@@ -145,7 +147,7 @@ ENDPROC(stext)
  * r8 = phys_offset, r9 = cpuid, r10 = procinfo
  *
  * Returns:
- *  r0, r3, r5-r7 corrupted
+ *  r0, r1, r2, r3, r5 corrupted
  *  r4 = physical page table address
  */
 __create_page_tables:
@@ -156,49 +158,49 @@ __create_page_tables:
 	 */
 	mov	r0, r4
 	mov	r3, #0
-	add	r6, r0, #PG_DIR_SIZE
+	add	r1, r0, #PG_DIR_SIZE
 1:	str	r3, [r0], #4
 	str	r3, [r0], #4
 	str	r3, [r0], #4
 	str	r3, [r0], #4
-	teq	r0, r6
+	teq	r0, r1
 	bne	1b
 
-	ldr	r7, [r10, #PROCINFO_MM_MMUFLAGS] @ mm_mmuflags
+	ldr	r2, [r10, #PROCINFO_MM_MMUFLAGS] @ mm_mmuflags
 
 	/*
 	 * Create identity mapping to cater for __enable_mmu.
 	 * This identity mapping will be removed by paging_init().
 	 */
 	adr	r0, __enable_mmu_loc
-	ldmia	r0, {r3, r5, r6}
-	sub	r0, r0, r3			@ virt->phys offset
-	add	r5, r5, r0			@ phys __enable_mmu
-	add	r6, r6, r0			@ phys __enable_mmu_end
+	ldmia	r0, {r1, r3, r5}
+	sub	r0, r0, r1			@ virt->phys offset
+	add	r3, r3, r0			@ phys __enable_mmu
+	add	r5, r5, r0			@ phys __enable_mmu_end
+	mov	r3, r3, lsr #SECTION_SHIFT
 	mov	r5, r5, lsr #SECTION_SHIFT
-	mov	r6, r6, lsr #SECTION_SHIFT
 
-1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
-	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
-	cmp	r5, r6
-	addlo	r5, r5, #1			@ next section
+1:	orr	r1, r2, r3, lsl #SECTION_SHIFT	@ flags + kernel base
+	str	r1, [r4, r3, lsl #PMD_ORDER]	@ identity mapping
+	cmp	r3, r5
+	addlo	r3, r3, #1			@ next section
 	blo	1b
 
 	/*
 	 * Now setup the pagetables for our kernel direct
 	 * mapped region.
 	 */
-	mov	r3, pc
-	mov	r3, r3, lsr #SECTION_SHIFT
-	orr	r3, r7, r3, lsl #SECTION_SHIFT
+	mov	r5, pc
+	mov	r5, r5, lsr #SECTION_SHIFT
+	orr	r5, r2, r5, lsl #SECTION_SHIFT
 	add	r0, r4,  #(KERNEL_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
-	str	r3, [r0, #((KERNEL_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ORDER]!
-	ldr	r6, =(KERNEL_END - 1)
-	add	r0, r0, #1 << PMD_ORDER
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-1:	cmp	r0, r6
-	add	r3, r3, #1 << SECTION_SHIFT
-	strls	r3, [r0], #1 << PMD_ORDER
+	str	r5, [r0, #(KERNEL_START & 0x00f00000) >> (SECTION_SHIFT - PMD_ORDER)]!
+	ldr	r3, =(KERNEL_END - 1)
+	add	r0, r0, #(1 << PMD_ORDER)
+	add	r3, r4, r3, lsr #(SECTION_SHIFT - PMD_ORDER)
+1:	cmp	r0, r3
+	add	r5, r5, #(1 << SECTION_SHIFT)
+	strls	r5, [r0], #(1 << PMD_ORDER)
 	bls	1b
 
 #ifdef CONFIG_XIP_KERNEL
@@ -206,30 +208,30 @@ __create_page_tables:
 	 * Map some ram to cover our .data and .bss areas.
 	 */
 	add	r3, r8, #TEXT_OFFSET
-	orr	r3, r3, r7
+	orr	r3, r3, r2
 	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
 	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> (SECTION_SHIFT - PMD_ORDER)]!
-	ldr	r6, =(_end - 1)
+	ldr	r1, =(_end - 1)
 	add	r0, r0, #4
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-1:	cmp	r0, r6
+	add	r1, r4, r1, lsr #(SECTION_SHIFT - PMD_ORDER)
+1:	cmp	r0, r1
 	add	r3, r3, #1 << 20
 	strls	r3, [r0], #4
 	bls	1b
 #endif
 
 	/*
-	 * Then map boot params address in r2 or
+	 * Then map boot params address in r7 or
 	 * the first 1MB of ram if boot params address is not specified.
 	 */
-	mov	r0, r2, lsr #SECTION_SHIFT
+	mov	r0, r7, lsr #SECTION_SHIFT
 	movs	r0, r0, lsl #SECTION_SHIFT
 	moveq	r0, r8
 	sub	r3, r0, r8
 	add	r3, r3, #PAGE_OFFSET
 	add	r3, r4, r3, lsr #(SECTION_SHIFT - PMD_ORDER)
-	orr	r6, r7, r0
-	str	r6, [r3]
+	orr	r1, r2, r0
+	str	r1, [r3]
 
 #ifdef CONFIG_DEBUG_LL
 #ifndef CONFIG_DEBUG_ICEDCC
@@ -238,7 +240,7 @@ __create_page_tables:
 	 * This allows debug messages to be output
 	 * via a serial console before paging_init.
 	 */
-	addruart r7, r3, r0
+	addruart r2, r3, r0
 
 	mov	r3, r3, lsr #SECTION_SHIFT
 	mov	r3, r3, lsl #PMD_ORDER
@@ -247,18 +249,18 @@ __create_page_tables:
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
-	add	r6, r0, r3
-	mov	r3, r7, lsr #SECTION_SHIFT
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
-	orr	r3, r7, r3, lsl #SECTION_SHIFT
+	add	r1, r0, r3
+	mov	r3, r2, lsr #SECTION_SHIFT
+	ldr	r2, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+	orr	r3, r2, r3, lsl #SECTION_SHIFT
 1:	str	r3, [r0], #4
-	add	r3, r3, #1 << SECTION_SHIFT
-	cmp	r0, r6
+	add	r3, r3, #(1 << SECTION_SHIFT)
+	cmp	r0, r1
 	blo	1b
 
 #else /* CONFIG_DEBUG_ICEDCC */
 	/* we don't need any serial debugging mappings for ICEDCC */
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+	ldr	r2, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 #endif /* !CONFIG_DEBUG_ICEDCC */
 
 #if defined(CONFIG_ARCH_NETWINDER) || defined(CONFIG_ARCH_CATS)
@@ -267,7 +269,7 @@ __create_page_tables:
 	 * in the 16550-type serial port for the debug messages
 	 */
 	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ORDER)
-	orr	r3, r7, #0x7c000000
+	orr	r3, r2, #0x7c000000
 	str	r3, [r0]
 #endif
 #ifdef CONFIG_ARCH_RPC
@@ -277,7 +279,7 @@ __create_page_tables:
 	 * only for Acorn RiscPC architectures.
 	 */
 	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ORDER)
-	orr	r3, r7, #0x02000000
+	orr	r3, r2, #0x02000000
 	str	r3, [r0]
 	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ORDER)
 	str	r3, [r0]
@@ -305,7 +307,7 @@ ENTRY(secondary_startup)
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type
-	movs	r10, r5				@ invalid processor?
+	movs	r10, r0				@ invalid processor?
 	moveq	r0, #'p'			@ yes, error 'p'
  THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p
@@ -314,11 +316,11 @@ ENTRY(secondary_startup)
 	 * Use the page tables supplied from  __cpu_up.
 	 */
 	adr	r4, __secondary_data
-	ldmia	r4, {r5, r7, r12}		@ address to jump to after
-	sub	lr, r4, r5			@ mmu has been enabled
-	ldr	r4, [r7, lr]			@ get secondary_data.pgdir
-	add	r7, r7, #4
-	ldr	r8, [r7, lr]			@ get secondary_data.swapper_pg_dir
+	ldmia	r4, {r3, r5, r12}		@ address to jump to after
+	sub	r3, r4, r3			@ mmu has been enabled
+	ldr	r4, [r5, r3]			@ get secondary_data.pgdir
+	add	r3, r3, #4
+	ldr	r8, [r5, r3]			@ get secondary_data.swapper_pg_dir
 	adr	lr, BSYM(__enable_mmu)		@ return address
 	mov	r13, r12			@ __secondary_switched address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
@@ -328,10 +330,10 @@ ENTRY(secondary_startup)
 ENDPROC(secondary_startup)
 
 	/*
-	 * r6  = &secondary_data
+	 * r5 = &secondary_data
 	 */
 ENTRY(__secondary_switched)
-	ldr	sp, [r7, #4]			@ get secondary_data.stack
+	ldr	sp, [r5, #8]			@ get secondary_data.stack
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
@@ -353,9 +355,10 @@ __secondary_data:
  * registers.
  *
  *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags or dtb pointer
  *  r4  = page table pointer
+ *  r5  = &secondary_data if SMP
+ *  r6  = machine ID
+ *  r7  = atags or dtb pointer
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  */
@@ -374,11 +377,11 @@ __enable_mmu:
 #ifdef CONFIG_CPU_ICACHE_DISABLE
 	bic	r0, r0, #CR_I
 #endif
-	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
+	mov	r1, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
-	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
+	mcr	p15, 0, r1, c3, c0, 0		@ load domain access register
 	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
 	b	__turn_mmu_on
 ENDPROC(__enable_mmu)
@@ -390,8 +393,8 @@ ENDPROC(__enable_mmu)
  * mailing list archives BEFORE sending another post to the list.
  *
  *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags or dtb pointer
+ *  r6  = machine ID
+ *  r7  = atags or dtb pointer
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  *
@@ -455,25 +458,25 @@ smp_on_up:
 __do_fixup_smp_on_up:
 	cmp	r4, r5
 	movhs	pc, lr
-	ldmia	r4!, {r0, r6}
- ARM(	str	r6, [r0, r3]	)
+	ldmia	r4!, {r0, r1}
+ ARM(	str	r1, [r0, r3]	)
  THUMB(	add	r0, r0, r3	)
 #ifdef __ARMEB__
- THUMB(	mov	r6, r6, ror #16	)	@ Convert word order for big-endian.
+ THUMB(	mov	r1, r1, ror #16	)	@ Convert word order for big-endian.
 #endif
- THUMB(	strh	r6, [r0], #2	)	@ For Thumb-2, store as two halfwords
- THUMB(	mov	r6, r6, lsr #16	)	@ to be robust against misaligned r3.
- THUMB(	strh	r6, [r0]	)
+ THUMB(	strh	r1, [r0], #2	)	@ For Thumb-2, store as two halfwords
+ THUMB(	mov	r1, r1, lsr #16	)	@ to be robust against misaligned r3.
+ THUMB(	strh	r1, [r0]	)
 	b	__do_fixup_smp_on_up
 ENDPROC(__do_fixup_smp_on_up)
 
 ENTRY(fixup_smp)
-	stmfd	sp!, {r4 - r6, lr}
+	stmfd	sp!, {r4, r5, lr}
 	mov	r4, r0
 	add	r5, r0, r1
 	mov	r3, #0
 	bl	__do_fixup_smp_on_up
-	ldmfd	sp!, {r4 - r6, pc}
+	ldmfd	sp!, {r4, r5, pc}
 ENDPROC(fixup_smp)
 
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
@@ -486,17 +489,17 @@ ENDPROC(fixup_smp)
 	__HEAD
 __fixup_pv_table:
 	adr	r0, 1f
-	ldmia	r0, {r3-r5, r7}
-	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
-	add	r4, r4, r3	@ adjust table start address
-	add	r5, r5, r3	@ adjust table end address
-	add	r7, r7, r3	@ adjust __pv_phys_offset address
-	str	r8, [r7]	@ save computed PHYS_OFFSET to __pv_phys_offset
-	mov	r6, r3, lsr #24	@ constant for add/sub instructions
-	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+	ldmia	r0, {r2 - r5}
+	sub	r2, r0, r2	@ PHYS_OFFSET - PAGE_OFFSET
+	add	r3, r3, r2	@ adjust table start address
+	add	r4, r4, r2	@ adjust table end address
+	add	r5, r5, r2	@ adjust __pv_phys_offset address
+	str	r8, [r5]	@ save computed PHYS_OFFSET to __pv_phys_offset
+	mov	r1, r2, lsr #24	@ constant for add/sub instructions
+	teq	r2, r1, lsl #24 @ must be 16MiB aligned
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
-	str	r6, [r7, #4]	@ save to __pv_offset
+	str	r1, [r5, #4]	@ save to __pv_offset
 	b	__fixup_a_pv_table
 ENDPROC(__fixup_pv_table)
 
@@ -509,48 +512,48 @@ ENDPROC(__fixup_pv_table)
 	.text
 __fixup_a_pv_table:
 #ifdef CONFIG_THUMB2_KERNEL
-	lsls	r6, #24
+	lsls	r1, #24
 	beq	2f
-	clz	r7, r6
-	lsr	r6, #24
-	lsl	r6, r7
-	bic	r6, #0x0080
-	lsrs	r7, #1
-	orrcs	r6, #0x0080
-	orr	r6, r6, r7, lsl #12
-	orr	r6, #0x4000
+	clz	r5, r1
+	lsr	r1, #24
+	lsl	r1, r5
+	bic	r1, #0x0080
+	lsrs	r5, #1
+	orrcs	r1, #0x0080
+	orr	r1, r1, r5, lsl #12
+	orr	r1, #0x4000
 	b	2f
-1:	add     r7, r3
-	ldrh	ip, [r7, #2]
+1:	add     r5, r2
+	ldrh	ip, [r5, #2]
 	and	ip, 0x8f00
-	orr	ip, r6	@ mask in offset bits 31-24
-	strh	ip, [r7, #2]
-2:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
+	orr	ip, r1	@ mask in offset bits 31-24
+	strh	ip, [r5, #2]
+2:	cmp	r3, r4
+	ldrcc	r5, [r3], #4	@ use branch for delay slot
 	bcc	1b
 	bx	lr
 #else
 	b	2f
-1:	ldr	ip, [r7, r3]
+1:	ldr	ip, [r5, r2]
 	bic	ip, ip, #0x000000ff
-	orr	ip, ip, r6	@ mask in offset bits 31-24
-	str	ip, [r7, r3]
-2:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
+	orr	ip, ip, r1	@ mask in offset bits 31-24
+	str	ip, [r5, r2]
+2:	cmp	r3, r4
+	ldrcc	r5, [r3], #4	@ use branch for delay slot
 	bcc	1b
 	mov	pc, lr
 #endif
 ENDPROC(__fixup_a_pv_table)
 
 ENTRY(fixup_pv_table)
-	stmfd	sp!, {r4 - r7, lr}
-	ldr	r2, 2f			@ get address of __pv_phys_offset
-	mov	r3, #0			@ no offset
-	mov	r4, r0			@ r0 = table start
-	add	r5, r0, r1		@ r1 = table size
-	ldr	r6, [r2, #4]		@ get __pv_offset
+	stmfd	sp!, {r4, r5, lr}
+	ldr	r5, 2f			@ get address of __pv_phys_offset
+	mov	r2, #0			@ no offset
+	mov	r3, r0			@ r0 = table start
+	add	r4, r0, r1		@ r1 = table size
+	ldr	r1, [r5, #4]		@ get __pv_offset
 	bl	__fixup_a_pv_table
-	ldmfd	sp!, {r4 - r7, pc}
+	ldmfd	sp!, {r4, r5, pc}
 ENDPROC(fixup_pv_table)
 
 	.align
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 67469665d4..b1a5b409b4 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -447,11 +447,11 @@ __arm1020_setup:
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
 
-	adr	r5, arm1020_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm1020_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 #ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
 	orr	r0, r0, #0x4000 		@ .R.. .... .... ....
 #endif
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 4251421c0e..373d5436f5 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -428,11 +428,11 @@ __arm1020e_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
-	adr	r5, arm1020e_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm1020e_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 #ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
 	orr	r0, r0, #0x4000 		@ .R.. .... .... ....
 #endif
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index d283cf3d06..c07e9eb335 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -410,11 +410,11 @@ __arm1022_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
-	adr	r5, arm1022_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm1022_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 #ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
 	orr	r0, r0, #0x4000 		@ .R..............
 #endif
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 678a1ceafe..d8c9990333 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -405,11 +405,11 @@ __arm1026_setup:
 	mov	r0, #4				@ explicitly disable writeback
 	mcr	p15, 7, r0, c15, c0, 0
 #endif
-	adr	r5, arm1026_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm1026_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 #ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
 	orr	r0, r0, #0x4000 		@ .R.. .... .... ....
 #endif
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 55f4e29066..127bcf71bc 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -123,10 +123,10 @@ __arm710_setup:
 	mcr	p15, 0, r0, c8, c7, 0		@ flush TLB (v4)
 #endif
 	mrc	p15, 0, r0, c1, c0		@ get control register
-	ldr	r5, arm710_cr1_clear
-	bic	r0, r0, r5
-	ldr	r5, arm710_cr1_set
-	orr	r0, r0, r5
+	ldr	r2, arm710_cr1_clear
+	bic	r0, r0, r2
+	ldr	r2, arm710_cr1_set
+	orr	r0, r0, r2
 	mov	pc, lr				@ __ret (head.S)
 	.size	__arm710_setup, . - __arm710_setup
 
@@ -150,11 +150,11 @@ __arm720_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7, 0		@ flush TLB (v4)
 #endif
-	adr	r5, arm720_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm720_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr				@ __ret (head.S)
 	.size	__arm720_setup, . - __arm720_setup
 
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 88fb3d9e06..de135f097f 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -413,11 +413,11 @@ __arm920_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
-	adr	r5, arm920_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm920_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 	.size	__arm920_setup, . - __arm920_setup
 
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 490e188338..3657d949ef 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -391,11 +391,11 @@ __arm922_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
-	adr	r5, arm922_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm922_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 	.size	__arm922_setup, . - __arm922_setup
 
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 51d494be05..ea40d3cbf6 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -456,11 +456,11 @@ __arm925_setup:
 	mcr	p15, 7, r0, c15, c0, 0
 #endif
 
-	adr	r5, arm925_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, arm925_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 #ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
 	orr	r0, r0, #0x4000			@ .1.. .... .... ....
 #endif
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 9f8fd91f91..062fe111ca 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -436,10 +436,10 @@ __arm926_setup:
 #endif 
 
 	adr	r5, arm926_crval
-	ldmia	r5, {r5, r6}
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 #ifdef CONFIG_CPU_CACHE_ROUND_ROBIN
 	orr	r0, r0, #0x4000			@ .1.. .... .... ....
 #endif
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 8a6c2f78c1..b3977d0d6d 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -517,11 +517,11 @@ __feroceon_setup:
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
 
-	adr	r5, feroceon_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, feroceon_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 	.size	__feroceon_setup, . - __feroceon_setup
 
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index db52b0fb14..21d6feb021 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -355,11 +355,11 @@ __mohawk_setup:
 	mov	r0, #0				@ don't allow CP access
 	mcr	p15, 0, r0, c15, c1, 0		@ write CP access register
 
-	adr	r5, mohawk_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, mohawk_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 
 	.size	__mohawk_setup, . - __mohawk_setup
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index d50ada26ed..cd7d6c2348 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -160,18 +160,18 @@ ENTRY(cpu_sa110_set_pte_ext)
 
 	.type	__sa110_setup, #function
 __sa110_setup:
-	mov	r10, #0
-	mcr	p15, 0, r10, c7, c7		@ invalidate I,D caches on v4
-	mcr	p15, 0, r10, c7, c10, 4		@ drain write buffer on v4
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c7		@ invalidate I,D caches on v4
+	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer on v4
 #ifdef CONFIG_MMU
-	mcr	p15, 0, r10, c8, c7		@ invalidate I,D TLBs on v4
+	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
 
-	adr	r5, sa110_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, sa110_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 	.size	__sa110_setup, . - __sa110_setup
 
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 7d91545d08..b0d4dc3d26 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -205,11 +205,11 @@ __sa1100_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7		@ invalidate I,D TLBs on v4
 #endif
-	adr	r5, sa1100_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, sa1100_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 	.size	__sa1100_setup, . - __sa1100_setup
 
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index d061d2fa55..0e4f1749c1 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -209,14 +209,14 @@ __v6_setup:
 	ALT_UP(orr	r8, r8, #TTB_FLAGS_UP)
 	mcr	p15, 0, r8, c2, c0, 1		@ load TTB1
 #endif /* CONFIG_MMU */
-	adr	r5, v6_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, v6_crval
+	ldmia	r2, {r2, r3}
 #ifdef CONFIG_CPU_ENDIAN_BE8
-	orr	r6, r6, #1 << 25		@ big-endian page tables
+	orr	r3, r3, #1 << 25		@ big-endian page tables
 #endif
 	mrc	p15, 0, r0, c1, c0, 0		@ read control register
-	bic	r0, r0, r5			@ clear bits them
-	orr	r0, r0, r6			@ set them
+	bic	r0, r0, r2			@ clear bits them
+	orr	r0, r0, r3			@ set them
 #ifdef CONFIG_ARM_ERRATA_364296
 	/*
 	 * Workaround for the 364296 ARM1136 r0p2 erratum (possible cache data
@@ -225,12 +225,12 @@ __v6_setup:
 	 * and the FI bit in the control register) disables hit-under-miss
 	 * without putting the processor into full low interrupt latency mode.
 	 */
-	ldr	r6, =0x4107b362			@ id for ARM1136 r0p2
-	mrc	p15, 0, r5, c0, c0, 0		@ get processor id
-	teq	r5, r6				@ check for the faulty core
-	mrceq	p15, 0, r5, c1, c0, 1		@ load aux control reg
-	orreq	r5, r5, #(1 << 31)		@ set the undocumented bit 31
-	mcreq	p15, 0, r5, c1, c0, 1		@ write aux control reg
+	ldr	r3, =0x4107b362			@ id for ARM1136 r0p2
+	mrc	p15, 0, r2, c0, c0, 0		@ get processor id
+	teq	r2, r3				@ check for the faulty core
+	mrceq	p15, 0, r2, c1, c0, 1		@ load aux control reg
+	orreq	r2, r2, #(1 << 31)		@ set the undocumented bit 31
+	mcreq	p15, 0, r2, c1, c0, 1		@ write aux control reg
 	orreq	r0, r0, #(1 << 21)		@ low interrupt latency configuration
 #endif
 	mov	pc, lr				@ return to head.S:__ret
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c559ac381..8b27eb7a1e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -282,124 +282,124 @@ ENDPROC(cpu_v7_do_resume)
  */
 __v7_ca5mp_setup:
 __v7_ca9mp_setup:
-	mov	r10, #(1 << 0)			@ TLB ops broadcasting
+	mov	r1, #(1 << 0)			@ TLB ops broadcasting
 	b	1f
 __v7_ca15mp_setup:
-	mov	r10, #0
+	mov	r1, #0
 1:
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
 	ALT_UP(mov	r0, #(1 << 6))		@ fake it for UP
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
 	orreq	r0, r0, #(1 << 6)		@ Enable SMP/nAMP mode
-	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
+	orreq	r0, r0, r1			@ Enable CPU-specific SMP bits
 	mcreq	p15, 0, r0, c1, c0, 1
 #endif
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
-	stmia	r12, {r0-r5, r7, r9, r11, lr}
+	stmia	r12, {r4-r7, r9-r11, lr}
 	bl	v7_flush_dcache_all
-	ldmia	r12, {r0-r5, r7, r9, r11, lr}
+	ldmia	r12, {r4-r7, r9-r11, lr}
 
 	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
-	and	r10, r0, #0xff000000		@ ARM?
-	teq	r10, #0x41000000
+	and	r1, r0, #0xff000000		@ ARM?
+	teq	r1, #0x41000000
 	bne	3f
-	and	r5, r0, #0x00f00000		@ variant
-	and	r6, r0, #0x0000000f		@ revision
-	orr	r6, r6, r5, lsr #20-4		@ combine variant and revision
+	and	r2, r0, #0x00f00000		@ variant
+	and	r3, r0, #0x0000000f		@ revision
+	orr	r3, r3, r2, lsr #20-4		@ combine variant and revision
 	ubfx	r0, r0, #4, #12			@ primary part number
 
 	/* Cortex-A8 Errata */
-	ldr	r10, =0x00000c08		@ Cortex-A8 primary part number
-	teq	r0, r10
+	ldr	r1, =0x00000c08			@ Cortex-A8 primary part number
+	teq	r0, r1
 	bne	2f
 #ifdef CONFIG_ARM_ERRATA_430973
-	teq	r5, #0x00100000			@ only present in r1p*
-	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orreq	r10, r10, #(1 << 6)		@ set IBE to 1
-	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+	teq	r2, #0x00100000			@ only present in r1p*
+	mrceq	p15, 0, r1, c1, c0, 1		@ read aux control register
+	orreq	r1, r1, #(1 << 6)		@ set IBE to 1
+	mcreq	p15, 0, r1, c1, c0, 1		@ write aux control register
 #endif
 #ifdef CONFIG_ARM_ERRATA_458693
-	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orreq	r10, r10, #(1 << 5)		@ set L1NEON to 1
-	orreq	r10, r10, #(1 << 9)		@ set PLDNOP to 1
-	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+	teq	r3, #0x20			@ only present in r2p0
+	mrceq	p15, 0, r1, c1, c0, 1		@ read aux control register
+	orreq	r1, r1, #(1 << 5)		@ set L1NEON to 1
+	orreq	r1, r1, #(1 << 9)		@ set PLDNOP to 1
+	mcreq	p15, 0, r1, c1, c0, 1		@ write aux control register
 #endif
 #ifdef CONFIG_ARM_ERRATA_460075
-	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 1, r10, c9, c0, 2		@ read L2 cache aux ctrl register
-	tsteq	r10, #1 << 22
-	orreq	r10, r10, #(1 << 22)		@ set the Write Allocate disable bit
-	mcreq	p15, 1, r10, c9, c0, 2		@ write the L2 cache aux ctrl register
+	teq	r3, #0x20			@ only present in r2p0
+	mrceq	p15, 1, r1, c9, c0, 2		@ read L2 cache aux ctrl register
+	tsteq	r1, #1 << 22
+	orreq	r1, r1, #(1 << 22)		@ set the Write Allocate disable bit
+	mcreq	p15, 1, r1, c9, c0, 2		@ write the L2 cache aux ctrl register
 #endif
 	b	3f
 
 	/* Cortex-A9 Errata */
-2:	ldr	r10, =0x00000c09		@ Cortex-A9 primary part number
-	teq	r0, r10
+2:	ldr	r1, =0x00000c09			@ Cortex-A9 primary part number
+	teq	r0, r1
 	bne	3f
 #ifdef CONFIG_ARM_ERRATA_742230
-	cmp	r6, #0x22			@ only present up to r2p2
-	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrle	r10, r10, #1 << 4		@ set bit #4
-	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	cmp	r3, #0x22			@ only present up to r2p2
+	mrcle	p15, 0, r1, c15, c0, 1		@ read diagnostic register
+	orrle	r1, r1, #1 << 4			@ set bit #4
+	mcrle	p15, 0, r1, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_742231
-	teq	r6, #0x20			@ present in r2p0
-	teqne	r6, #0x21			@ present in r2p1
-	teqne	r6, #0x22			@ present in r2p2
-	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orreq	r10, r10, #1 << 12		@ set bit #12
-	orreq	r10, r10, #1 << 22		@ set bit #22
-	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	teq	r3, #0x20			@ present in r2p0
+	teqne	r3, #0x21			@ present in r2p1
+	teqne	r3, #0x22			@ present in r2p2
+	mrceq	p15, 0, r1, c15, c0, 1		@ read diagnostic register
+	orreq	r1, r1, #1 << 12		@ set bit #12
+	orreq	r1, r1, #1 << 22		@ set bit #22
+	mcreq	p15, 0, r1, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_743622
-	teq	r6, #0x20			@ present in r2p0
-	teqne	r6, #0x21			@ present in r2p1
-	teqne	r6, #0x22			@ present in r2p2
-	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orreq	r10, r10, #1 << 6		@ set bit #6
-	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	teq	r3, #0x20			@ present in r2p0
+	teqne	r3, #0x21			@ present in r2p1
+	teqne	r3, #0x22			@ present in r2p2
+	mrceq	p15, 0, r1, c15, c0, 1		@ read diagnostic register
+	orreq	r1, r1, #1 << 6			@ set bit #6
+	mcreq	p15, 0, r1, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_751472
-	cmp	r6, #0x30			@ present prior to r3p0
-	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrlt	r10, r10, #1 << 11		@ set bit #11
-	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	cmp	r3, #0x30			@ present prior to r3p0
+	mrclt	p15, 0, r1, c15, c0, 1		@ read diagnostic register
+	orrlt	r1, r1, #1 << 11		@ set bit #11
+	mcrlt	p15, 0, r1, c15, c0, 1		@ write diagnostic register
 #endif
 
-3:	mov	r10, #0
+3:	mov	r1, #0
 #ifdef HARVARD_CACHE
-	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
+	mcr	p15, 0, r1, c7, c5, 0		@ I+BTB cache invalidate
 #endif
 	dsb
 #ifdef CONFIG_MMU
-	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
-	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
+	mcr	p15, 0, r1, c8, c7, 0		@ invalidate I + D TLBs
+	mcr	p15, 0, r1, c2, c0, 2		@ TTB control register
 	ALT_SMP(orr	r4, r4, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r4, r4, #TTB_FLAGS_UP)
 	ALT_SMP(orr	r8, r8, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r8, r8, #TTB_FLAGS_UP)
 	mcr	p15, 0, r8, c2, c0, 1		@ load TTB1
-	ldr	r5, =PRRR			@ PRRR
-	ldr	r6, =NMRR			@ NMRR
-	mcr	p15, 0, r5, c10, c2, 0		@ write PRRR
-	mcr	p15, 0, r6, c10, c2, 1		@ write NMRR
+	ldr	r2, =PRRR			@ PRRR
+	ldr	r3, =NMRR			@ NMRR
+	mcr	p15, 0, r2, c10, c2, 0		@ write PRRR
+	mcr	p15, 0, r3, c10, c2, 1		@ write NMRR
 #endif
-	adr	r5, v7_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, v7_crval
+	ldmia	r2, {r2, r3}
 #ifdef CONFIG_CPU_ENDIAN_BE8
-	orr	r6, r6, #1 << 25		@ big-endian page tables
+	orr	r3, r3, #1 << 25		@ big-endian page tables
 #endif
 #ifdef CONFIG_SWP_EMULATE
-	orr     r5, r5, #(1 << 10)              @ set SW bit in "clear"
-	bic     r6, r6, #(1 << 10)              @ clear it in "mmuset"
+	orr     r2, r2, #(1 << 10)              @ set SW bit in "clear"
+	bic     r3, r3, #(1 << 10)              @ clear it in "mmuset"
 #endif
    	mrc	p15, 0, r0, c1, c0, 0		@ read control register
-	bic	r0, r0, r5			@ clear bits them
-	orr	r0, r0, r6			@ set them
+	bic	r0, r0, r2			@ clear bits them
+	orr	r0, r0, r3			@ set them
  THUMB(	orr	r0, r0, #1 << 30	)	@ Thumb exceptions
 	mov	pc, lr				@ return to head.S:__ret
 ENDPROC(__v7_setup)
@@ -415,7 +415,7 @@ v7_crval:
 	crval	clear=0x0120c302, mmuset=0x10c03c7d, ucset=0x00c01c7c
 
 __v7_setup_stack:
-	.space	4 * 11				@ 11 registers
+	.space	4 * 8				@ 8 registers
 
 	__INITDATA
 
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index abf0507a08..f6a4d73488 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -461,18 +461,18 @@ __xsc3_setup:
 	orr	r0, r0, #(1 << 10)		@ enable L2 for LLR cache
 	mcr	p15, 0, r0, c1, c0, 1		@ set auxiliary control reg
 
-	adr	r5, xsc3_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, xsc3_crval
+	ldmia	r2, {r2, r3}
 
 #ifdef CONFIG_CACHE_XSC3L2
 	mrc	p15, 1, r0, c0, c0, 1		@ get L2 present information
 	ands	r0, r0, #0xf8
-	orrne	r6, r6, #(1 << 26)		@ enable L2 if present
+	orrne	r3, r3, #(1 << 26)		@ enable L2 if present
 #endif
 
 	mrc	p15, 0, r0, c1, c0, 0		@ get control register
-	bic	r0, r0, r5			@ ..V. ..R. .... ..A.
-	orr	r0, r0, r6			@ ..VI Z..S .... .C.M (mmu)
+	bic	r0, r0, r2			@ ..V. ..R. .... ..A.
+	orr	r0, r0, r3			@ ..VI Z..S .... .C.M (mmu)
 						@ ...I Z..S .... .... (uc)
 	mov	pc, lr
 
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 3277904beb..2a8552c5f1 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -562,11 +562,11 @@ __xscale_setup:
 	orr	r0, r0, #1 << 13		@ Its undefined whether this
 	mcr	p15, 0, r0, c15, c1, 0		@ affects USR or SVC modes
 
-	adr	r5, xscale_crval
-	ldmia	r5, {r5, r6}
+	adr	r2, xscale_crval
+	ldmia	r2, {r2, r3}
 	mrc	p15, 0, r0, c1, c0, 0		@ get control register
-	bic	r0, r0, r5
-	orr	r0, r0, r6
+	bic	r0, r0, r2
+	orr	r0, r0, r3
 	mov	pc, lr
 	.size	__xscale_setup, . - __xscale_setup
 
