From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 02 Jun 2011 19:07:07 +0100
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
Message-ID: <1307038027.28002.12.camel@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Thu, 2011-06-02 at 16:44 +0100, Frank Hofmann wrote:
> Hi,
> 
> 
> I'm trying to find a way to do an MMU off / on transition.
> 
> What I want to do is to call cpu_do_resume() from the hibernation restore 
> codepath.
> 
> I've succeeded to make this work by adding a test whether the MMU is 
> already on when cpu_resume_mmu() is called.
> 
> I'm not sure that sort of thing is proper; hence I've been trying to find 
> a way to disable the MMU before calling cpu_do_resume().
> 
> Can't seem to get this to work though; even though I'm creating a separate 
> MMU context that's given 1:1 mappings for all of kernel code/data, 
> execution still hangs as soon as I enable the code section below that 
> switches the MMU off.
> 
> 
> What I have at the moment is code that looks like this:
> 
> ==============================================================================
> [ ... ]
> unsigned long notrace __swsusp_arch_restore_image(void)
> {
>  	extern struct pbe *restore_pblist;
>  	struct pbe *pbe;
> 
>  	/* __swsusp_pg_dir has been created using pgd_alloc(&init_mm); */
> 
>  	cpu_switch_mm(__swsusp_pg_dir, &init_mm);
> 
>  	for (pbe = restore_pblist; pbe; pbe = pbe->next)
>  		copy_page(pbe->orig_address, pbe->address);
> 
>  	flush_tlb_all();
>  	flush_cache_all();
> 
>  	identity_mapping_add(__swsusp_pg_dir, __pa(_stext), __pa(_etext));
>  	identity_mapping_add(__swsusp_pg_dir, __pa(_sdata), __pa(_edata));
> 
>  	cpu_switch_mm(__swsusp_pg_dir, &init_mm);
> 
>  	flush_tlb_all();
>  	flush_cache_all();
> 
>  	cpu_proc_fin();		/* turns caches off */
> 
>  	/* caller requires v:p offset to calculate physical addresses */
>  	return (unsigned long)(PHYS_OFFSET - PAGE_OFFSET);
> }
> 
> [ ... ]
> ENTRY(swsusp_arch_resume)
>  	mov	r2, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
>  	msr	cpsr_c, r2
>  	/*
>  	 * Switch stack to a nosavedata region to make sure image restore
>  	 * doesn't clobber it underneath itself.
>  	 */
>  	ldr	sp, =(__swsusp_resume_stk + PAGE_SIZE / 2)
>  	bl	__swsusp_arch_restore_image
> 
>  	/*
>  	 * Restore the CPU registers.
>  	 */
>  	mov	r1, r0
>  	ldr	r0, =(__swsusp_arch_ctx + (NREGS * 4))
> /*
>   * This is what I'm trying to switch off; yet, doing so makes things hang
>   */
> #if 0
>  	ldr	r2, =cpu_do_resume
>  	sub	r2, r1			@ __pa()
>  	ldr	r3, =.Lmmu_is_off
>  	sub	r3, r1			@ __pa()
>  	sub	r0, r1			@ __pa()
>  	ldr	lr, =.Lpost_mmu
>  	mrc	p15, 0, r1, c1, c0, 0
>  	bic	r1, #CR_M
>  	mcr	p15, 0, r1, c1, c0, 0	@ MMU OFF

I know it is a silly question, but are you sure your pc is pointing
to a 1:1 physical address here ? This might explain also why if you call
cpu_do_resume straight off you have to skip the mmu resume code since it
creates a temporary mapping based on the current program counter. if it
is a virtual address it goes pop, methinks.

> 
>  	mrc	p15, 0, r1, c2, c0, 0	@ queue a dependency on CP15
>          sub     pc, r3, r1, lsr #32	@ to local label, phys addr
> .ltorg
> .align 5
> .Lmmu_is_off:
>  	mov	pc, r2			@ jump to phys cpu_v6_do_resume
> .Lpost_mmu:
> #else
>  	bl	cpu_do_resume
> #endif
>  	ldr	r0, =__swsusp_arch_ctx
>  	ldmia	r0!, {r1-r11,lr}	@ nonvolatile regs
>  	ldr	sp, [r0]		@ stack
>  	msr	cpsr, r1
>  	msr	spsr, r2
> 
>  	mov	r0, #0
>  	stmfd	sp!, {r0, lr}
>  	bl	cpu_init		@ reinitialize other modes
>  	ldmfd	sp!, {r0, pc}
> ENDPROC(swsusp_arch_resume)
> ==============================================================================
> 
> I.e. it performs the steps:
> 
>  	- flush all caches, tlbs
>  	- setup identity mappings for all kernel code & data
>  	- switch to a self-contained pagedir
>  	- flush again
>  	- finish cpu (disable caches)
>  	- switch MMU off, re-read config reg to force necessary wait,
>  	  and jump to physical address of "self".
> 
> 
> As said, things work just fine if simply doing the "bl cpu_do_resume" and 
> adding a "MMU already on" check to cpu_resume_mmu().

See comment above, cpu_resume_mmu creates a 1:1 mapping based on the
current PC (it uses adr), it should do no harm unless PC is running
virtual.

Lorenzo
