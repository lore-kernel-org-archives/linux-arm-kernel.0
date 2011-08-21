From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 21 Aug 2011 16:07:37 -0400 (EDT)
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <20110821192242.GB19678@n2100.arm.linux.org.uk>
References: <20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<20110821192242.GB19678@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1108211557440.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:

> And further to this, I'll point out that the debugging functions are
> *explicitly* designed to avoid corrupting any more than just r0-r3
> and lr.  That's not just the IO functions but also the hex and string
> printing functions.
> 
> And the head*.S code is explicitly written to expect r0-r3 to be
> corrupted - which basically means that no long-term values are held in
> those registers.

Well, not exactly.  I actually have a patch to that effect I made a 
while ago so all the early code could be unaffected by inserted function 
call, but held on to it because nothing yet justified its need.  Here it 
is for reference:

commit f2c97ae9f677c4abca8efe87539beab7e32e3e6c
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Thu Feb 24 23:02:20 2011 -0500

    ARM: make head.S register allocation more convenient
    
    The r1 (machine ID) and r2 (boot data pointer) values are getting
    in the way of standard procedure calls as those registers are normally
    clobbered by function calls.  Move those to r6 and r7 respectively,
    and adjust the code accordingly.
    
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index c84b57d..6421c90 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -26,32 +26,32 @@
  */
 	__HEAD
 
-/* Determine validity of the r2 atags pointer.  The heuristic requires
- * that the pointer be aligned, in the first 16k of physical RAM and
- * that the ATAG_CORE marker is first and present.  Future revisions
+/* Determine validity of the r2 (now in r7) atags pointer.  The heuristic
+ * requires that the pointer be aligned, in the first 16k of physical RAM
+ * and that the ATAG_CORE marker is first and present.  Future revisions
  * of this function may be more lenient with the physical address and
  * may also be able to move the ATAGS block if necessary.
  *
  * Returns:
- *  r2 either valid atags pointer, or zero
- *  r5, r6 corrupted
+ *  r7 either valid atags pointer, or zero
+ *  r1, r5 corrupted
  */
 __vet_atags:
-	tst	r2, #0x3			@ aligned?
+	tst	r7, #0x3			@ aligned?
 	bne	1f
 
-	ldr	r5, [r2, #0]			@ is first tag ATAG_CORE?
+	ldr	r5, [r7, #0]			@ is first tag ATAG_CORE?
 	cmp	r5, #ATAG_CORE_SIZE
 	cmpne	r5, #ATAG_CORE_SIZE_EMPTY
 	bne	1f
-	ldr	r5, [r2, #4]
-	ldr	r6, =ATAG_CORE
-	cmp	r5, r6
+	ldr	r5, [r7, #4]
+	ldr	r1, =ATAG_CORE
+	cmp	r5, r1
 	bne	1f
 
 	mov	pc, lr				@ atag pointer is ok
 
-1:	mov	r2, #0
+1:	mov	r7, #0
 	mov	pc, lr
 ENDPROC(__vet_atags)
 
@@ -60,48 +60,48 @@ ENDPROC(__vet_atags)
  * and uses absolute addresses; this is not position independent.
  *
  *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags pointer
+ *  r6  = machine ID
+ *  r7  = atags pointer
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
 
@@ -109,11 +109,10 @@ __mmap_switched_data:
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
@@ -125,25 +124,25 @@ ENDPROC(lookup_processor_type)
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
index 6b1e0ad..c210e01 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -36,13 +36,15 @@
 ENTRY(stext)
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
index 8f96ca0..a52aa76 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -75,9 +75,11 @@
 ENTRY(stext)
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
+	mov	r6, r1				@ preserve machine ID
+	mov	r7, r2				@ preserve boot data pointer
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
-	movs	r10, r5				@ invalid processor (r5=0)?
+	movs	r10, r0				@ invalid processor (r5=0)?
  THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p			@ yes, error 'p'
 
@@ -91,7 +93,7 @@ ENTRY(stext)
 #endif
 
 	/*
-	 * r1 = machine no, r2 = atags,
+	 * r6 = machine no, r7 = atags,
 	 * r8 = phys_offset, r9 = cpuid, r10 = procinfo
 	 */
 	bl	__vet_atags
@@ -132,7 +134,7 @@ ENDPROC(stext)
  * r8 = phys_offset, r9 = cpuid, r10 = procinfo
  *
  * Returns:
- *  r0, r3, r5-r7 corrupted
+ *  r0, r1, r2, r3, r5 corrupted
  *  r4 = physical page table address
  */
 __create_page_tables:
@@ -143,49 +145,49 @@ __create_page_tables:
 	 */
 	mov	r0, r4
 	mov	r3, #0
-	add	r6, r0, #0x4000
+	add	r1, r0, #0x4000
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
+	mov	r3, r3, lsr #20
 	mov	r5, r5, lsr #20
-	mov	r6, r6, lsr #20
 
-1:	orr	r3, r7, r5, lsl #20		@ flags + kernel base
-	str	r3, [r4, r5, lsl #2]		@ identity mapping
-	teq	r5, r6
-	addne	r5, r5, #1			@ next section
+1:	orr	r1, r2, r3, lsl #20		@ flags + kernel base
+	str	r1, [r4, r3, lsl #2]		@ identity mapping
+	teq	r3, r5
+	addne	r3, r3, #1			@ next section
 	bne	1b
 
 	/*
 	 * Now setup the pagetables for our kernel direct
 	 * mapped region.
 	 */
-	mov	r3, pc
-	mov	r3, r3, lsr #20
-	orr	r3, r7, r3, lsl #20
+	mov	r5, pc
+	mov	r5, r5, lsr #20
+	orr	r5, r2, r5, lsl #20
 	add	r0, r4,  #(KERNEL_START & 0xff000000) >> 18
-	str	r3, [r0, #(KERNEL_START & 0x00f00000) >> 18]!
-	ldr	r6, =(KERNEL_END - 1)
+	str	r5, [r0, #(KERNEL_START & 0x00f00000) >> 18]!
+	ldr	r3, =(KERNEL_END - 1)
 	add	r0, r0, #4
-	add	r6, r4, r6, lsr #18
-1:	cmp	r0, r6
-	add	r3, r3, #1 << 20
-	strls	r3, [r0], #4
+	add	r3, r4, r3, lsr #18
+1:	cmp	r0, r3
+	add	r5, r5, #1 << 20
+	strls	r5, [r0], #4
 	bls	1b
 
 #ifdef CONFIG_XIP_KERNEL
@@ -193,30 +195,30 @@ __create_page_tables:
 	 * Map some ram to cover our .data and .bss areas.
 	 */
 	add	r3, r8, #TEXT_OFFSET
-	orr	r3, r3, r7
+	orr	r3, r3, r2
 	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> 18
 	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> 18]!
-	ldr	r6, =(_end - 1)
+	ldr	r1, =(_end - 1)
 	add	r0, r0, #4
-	add	r6, r4, r6, lsr #18
-1:	cmp	r0, r6
+	add	r1, r4, r1, lsr #18
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
-	mov	r0, r2, lsr #20
+	mov	r0, r7, lsr #20
 	movs	r0, r0, lsl #20
 	moveq	r0, r8
 	sub	r3, r0, r8
 	add	r3, r3, #PAGE_OFFSET
 	add	r3, r4, r3, lsr #18
-	orr	r6, r7, r0
-	str	r6, [r3]
+	orr	r1, r2, r0
+	str	r1, [r3]
 
 #ifdef CONFIG_DEBUG_LL
 #ifndef CONFIG_DEBUG_ICEDCC
@@ -225,7 +227,7 @@ __create_page_tables:
 	 * This allows debug messages to be output
 	 * via a serial console before paging_init.
 	 */
-	addruart r7, r3
+	addruart r2, r3
 
 	mov	r3, r3, lsr #20
 	mov	r3, r3, lsl #2
@@ -234,18 +236,18 @@ __create_page_tables:
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
-	add	r6, r0, r3
-	mov	r3, r7, lsr #20
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
-	orr	r3, r7, r3, lsl #20
+	add	r1, r0, r3
+	mov	r3, r2, lsr #20
+	ldr	r2, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+	orr	r3, r2, r3, lsl #20
 1:	str	r3, [r0], #4
 	add	r3, r3, #1 << 20
-	teq	r0, r6
+	teq	r0, r1
 	bne	1b
 
 #else /* CONFIG_DEBUG_ICEDCC */
 	/* we don't need any serial debugging mappings for ICEDCC */
-	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
+	ldr	r2, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 #endif /* !CONFIG_DEBUG_ICEDCC */
 
 #if defined(CONFIG_ARCH_NETWINDER) || defined(CONFIG_ARCH_CATS)
@@ -254,7 +256,7 @@ __create_page_tables:
 	 * in the 16550-type serial port for the debug messages
 	 */
 	add	r0, r4, #0xff000000 >> 18
-	orr	r3, r7, #0x7c000000
+	orr	r3, r2, #0x7c000000
 	str	r3, [r0]
 #endif
 #ifdef CONFIG_ARCH_RPC
@@ -264,7 +266,7 @@ __create_page_tables:
 	 * only for Acorn RiscPC architectures.
 	 */
 	add	r0, r4, #0x02000000 >> 18
-	orr	r3, r7, #0x02000000
+	orr	r3, r2, #0x02000000
 	str	r3, [r0]
 	add	r0, r4, #0xd8000000 >> 18
 	str	r3, [r0]
@@ -301,9 +303,9 @@ ENTRY(secondary_startup)
 	 * Use the page tables supplied from  __cpu_up.
 	 */
 	adr	r4, __secondary_data
-	ldmia	r4, {r5, r7, r12}		@ address to jump to after
-	sub	r4, r4, r5			@ mmu has been enabled
-	ldr	r4, [r7, r4]			@ get secondary_data.pgdir
+	ldmia	r4, {r2, r3, r12}		@ address to jump to after
+	sub	r4, r4, r2			@ mmu has been enabled
+	ldr	r4, [r3, r4]			@ get secondary_data.pgdir
 	adr	lr, BSYM(__enable_mmu)		@ return address
 	mov	r13, r12			@ __secondary_switched address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
@@ -313,10 +315,10 @@ ENTRY(secondary_startup)
 ENDPROC(secondary_startup)
 
 	/*
-	 * r6  = &secondary_data
+	 * r1  = &secondary_data
 	 */
 ENTRY(__secondary_switched)
-	ldr	sp, [r7, #4]			@ get secondary_data.stack
+	ldr	sp, [r2, #4]			@ get secondary_data.stack
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
@@ -338,9 +340,9 @@ __secondary_data:
  * registers.
  *
  *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags pointer
  *  r4  = page table pointer
+ *  r6  = machine ID
+ *  r7  = atags pointer
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  */
@@ -375,8 +377,8 @@ ENDPROC(__enable_mmu)
  * mailing list archives BEFORE sending another post to the list.
  *
  *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags pointer
+ *  r6  = machine ID
+ *  r7  = atags pointer
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  *
@@ -440,25 +442,25 @@ smp_on_up:
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
@@ -471,20 +473,20 @@ ENDPROC(fixup_smp)
 	__HEAD
 __fixup_pv_table:
 	adr	r0, 1f
-	ldmia	r0, {r3-r5, r7}
-	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
-	add	r4, r4, r3	@ adjust table start address
-	add	r5, r5, r3	@ adjust table end address
-	str	r8, [r7, r3]!	@ save computed PHYS_OFFSET to __pv_phys_offset
+	ldmia	r0, {r2 - r5}
+	sub	r2, r0, r2	@ PHYS_OFFSET - PAGE_OFFSET
+	add	r3, r3, r2	@ adjust table start address
+	add	r4, r4, r2	@ adjust table end address
+	str	r8, [r5, r2]!	@ save computed PHYS_OFFSET to __pv_phys_offset
 #ifndef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
-	mov	r6, r3, lsr #24	@ constant for add/sub instructions
-	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+	mov	r1, r2, lsr #24	@ constant for add/sub instructions
+	teq	r2, r1, lsl #24 @ must be 16MiB aligned
 #else
-	mov	r6, r3, lsr #16	@ constant for add/sub instructions
-	teq	r3, r6, lsl #16	@ must be 64kiB aligned
+	mov	r1, r2, lsr #16	@ constant for add/sub instructions
+	teq	r2, r1, lsl #16	@ must be 64kiB aligned
 #endif
 	bne	__error
-	str	r6, [r7, #4]	@ save to __pv_offset
+	str	r1, [r5, #4]	@ save to __pv_offset
 	b	__fixup_a_pv_table
 ENDPROC(__fixup_pv_table)
 
@@ -497,33 +499,33 @@ ENDPROC(__fixup_pv_table)
 	.text
 __fixup_a_pv_table:
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
-	and	r0, r6, #255	@ offset bits 23-16
-	mov	r6, r6, lsr #8	@ offset bits 31-24
+	and	r0, r1, #255	@ offset bits 23-16
+	mov	r1, r1, lsr #8	@ offset bits 31-24
 #else
 	mov	r0, #0		@ just in case...
 #endif
 	b	3f
-2:	ldr	ip, [r7, r3]
+2:	ldr	ip, [r5, r2]
 	bic	ip, ip, #0x000000ff
 	tst	ip, #0x400	@ rotate shift tells us LS or MS byte
-	orrne	ip, ip, r6	@ mask in offset bits 31-24
+	orrne	ip, ip, r1	@ mask in offset bits 31-24
 	orreq	ip, ip, r0	@ mask in offset bits 23-16
-	str	ip, [r7, r3]
-3:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
+	str	ip, [r5, r2]
+3:	cmp	r3, r4
+	ldrcc	r5, [r3], #4	@ use branch for delay slot
 	bcc	2b
 	mov	pc, lr
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
