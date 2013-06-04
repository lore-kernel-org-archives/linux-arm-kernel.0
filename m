From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jun 2013 14:07:29 -0400 (EDT)
Subject: [PATCH v2 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <20130604173737.GZ18614@n2100.arm.linux.org.uk>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
 <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
 <20130604145958.GY18614@n2100.arm.linux.org.uk>
 <51AE21A7.5080907@free-electrons.com>
 <20130604173737.GZ18614@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1306041348400.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013, Russell King - ARM Linux wrote:

> On Tue, Jun 04, 2013 at 07:19:35PM +0200, Gregory CLEMENT wrote:
> > At least we can detect the PJ4B and maybe even the detect the if it
> > is the PJ4B or the PJ4B-MP.
> > 
> > Do you mean to add this test in the cpu_v7_do_idle() function?
> > 
> > Or patching the pointer to the cpu_v7_do_idle() on the fly? In this
> > last case it seems a little tricky to me, as we should have to modify
> > a pointer function in the .proc.info.init section.
> 
> No.  We already have a pj4 cpu type entry in the tables, so we just need
> to specify a separate set of processor functions.  This isn't 100%
> trivial to do with the macro-isation of stuff, but here's an attempt

It could be nicer on the symbol table especially when debugging if the 
pj4b was made into a separate branch table e.g.:

ENTRY(cpu_pj4b_switch_mm)
	b	cpu_v7_switch_mm
ENDPROC(cpu_pj4b_switch_mm)

Otherwise the objdump output will always select the first symbol for any 
given address in alphabetical order, masking away cpu_v7_switch_mm.

Alternatively, the following could be done:

#ifdef CONFIG_CPU_PJ4B

	.equ	cpu_pj4b_switch_mm,	cpu_v7_switch_mm
	.equ	cpu_pj4b_set_pte_ex,	cpu_v7_set_pte_ex
	...

#ifdef CONFIG_PJ4B_ERRATA_4742
ENTRY(cpu_pj4b_do_idle)
	dsb
	wfi
	dsb
	mov     pc, lr
ENDPROC(cpu_pj4b_do_idle)
#else
	.equ	cpu_pj4b_do_idle,	cpu_v7_do_idle
#endif

#endif

That saves on the extra branch cost and allows for removing the pj4b 
symbols entirely when not configured in, and keeps the changes gathered 
together which is IMHO a little prettier.

> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> index 9704097..d03c15c 100644
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -38,6 +38,7 @@
>   *	- we are not using split page tables
>   */
>  ENTRY(cpu_v7_switch_mm)
> +ENTRY(cpu_pj4b_switch_mm)
>  #ifdef CONFIG_MMU
>  	mov	r2, #0
>  	mmid	r1, r1				@ get mm->context.id
> @@ -61,6 +62,7 @@ ENTRY(cpu_v7_switch_mm)
>  #endif
>  	mov	pc, lr
>  ENDPROC(cpu_v7_switch_mm)
> +ENDPROC(cpu_pj4b_switch_mm)
>  
>  /*
>   *	cpu_v7_set_pte_ext(ptep, pte)
> @@ -73,6 +75,7 @@ ENDPROC(cpu_v7_switch_mm)
>   *	- ext	- value for extended PTE bits
>   */
>  ENTRY(cpu_v7_set_pte_ext)
> +ENTRY(cpu_pj4b_set_pte_ext)
>  #ifdef CONFIG_MMU
>  	str	r1, [r0]			@ linux version
>  
> @@ -115,6 +118,7 @@ ENTRY(cpu_v7_set_pte_ext)
>  #endif
>  	mov	pc, lr
>  ENDPROC(cpu_v7_set_pte_ext)
> +ENDPROC(cpu_pj4b_set_pte_ext)
>  
>  	/*
>  	 * Memory region attributes with SCTLR.TRE=1
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index 363027e..2d819ff 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -46,6 +46,7 @@
>   * the new TTB).
>   */
>  ENTRY(cpu_v7_switch_mm)
> +ENTRY(cpu_pj4b_switch_mm)
>  #ifdef CONFIG_MMU
>  	mmid	r1, r1				@ get mm->context.id
>  	asid	r3, r1
> @@ -55,6 +56,7 @@ ENTRY(cpu_v7_switch_mm)
>  #endif
>  	mov	pc, lr
>  ENDPROC(cpu_v7_switch_mm)
> +ENDPROC(cpu_pj4b_switch_mm)
>  
>  /*
>   * cpu_v7_set_pte_ext(ptep, pte)
> @@ -64,6 +66,7 @@ ENDPROC(cpu_v7_switch_mm)
>   * - pte - PTE value to store (64-bit in r2 and r3)
>   */
>  ENTRY(cpu_v7_set_pte_ext)
> +ENTRY(cpu_pj4b_set_pte_ext)
>  #ifdef CONFIG_MMU
>  	tst	r2, #L_PTE_VALID
>  	beq	1f
> @@ -78,6 +81,7 @@ ENTRY(cpu_v7_set_pte_ext)
>  #endif
>  	mov	pc, lr
>  ENDPROC(cpu_v7_set_pte_ext)
> +ENDPROC(cpu_pj4b_set_pte_ext)
>  
>  	/*
>  	 * Memory region attributes for LPAE (defined in pgtable-3level.h):
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 2c73a73..9964e84 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -26,16 +26,20 @@
>  #endif
>  
>  ENTRY(cpu_v7_proc_init)
> +ENTRY(cpu_pj4b_proc_init)
>  	mov	pc, lr
>  ENDPROC(cpu_v7_proc_init)
> +ENDPROC(cpu_pj4b_proc_init)
>  
>  ENTRY(cpu_v7_proc_fin)
> +ENTRY(cpu_pj4b_proc_fin)
>  	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
>  	bic	r0, r0, #0x1000			@ ...i............
>  	bic	r0, r0, #0x0006			@ .............ca.
>  	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
>  	mov	pc, lr
>  ENDPROC(cpu_v7_proc_fin)
> +ENDPROC(cpu_pj4b_proc_fin)
>  
>  /*
>   *	cpu_v7_reset(loc)
> @@ -52,6 +56,7 @@ ENDPROC(cpu_v7_proc_fin)
>  	.align	5
>  	.pushsection	.idmap.text, "ax"
>  ENTRY(cpu_v7_reset)
> +ENTRY(cpu_pj4b_reset)
>  	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
>  	bic	r1, r1, #0x1			@ ...............m
>   THUMB(	bic	r1, r1, #1 << 30 )		@ SCTLR.TE (Thumb exceptions)
> @@ -59,6 +64,7 @@ ENTRY(cpu_v7_reset)
>  	isb
>  	bx	r0
>  ENDPROC(cpu_v7_reset)
> +ENDPROC(cpu_pj4b_reset)
>  	.popsection
>  
>  /*
> @@ -74,7 +80,17 @@ ENTRY(cpu_v7_do_idle)
>  	mov	pc, lr
>  ENDPROC(cpu_v7_do_idle)
>  
> +ENTRY(cpu_pj4b_do_idle)
> +	dsb
> +	wfi
> +#ifdef CONFIG_PJ4B_ERRATA_4742
> +	dsb
> +#endif
> +	mov	pc, lr
> +ENDPROC(cpu_pj4b_do_idle)
> +
>  ENTRY(cpu_v7_dcache_clean_area)
> +ENTRY(cpu_pj4b_dcache_clean_area)
>  	ALT_SMP(mov	pc, lr)			@ MP extensions imply L1 PTW
>  	ALT_UP(W(nop))
>  	dcache_line_size r2, r3
> @@ -85,6 +101,7 @@ ENTRY(cpu_v7_dcache_clean_area)
>  	dsb
>  	mov	pc, lr
>  ENDPROC(cpu_v7_dcache_clean_area)
> +ENDPROC(cpu_pj4b_dcache_clean_area)
>  
>  	string	cpu_v7_name, "ARMv7 Processor"
>  	.align
> @@ -94,6 +111,7 @@ ENDPROC(cpu_v7_dcache_clean_area)
>  .equ	cpu_v7_suspend_size, 4 * 8
>  #ifdef CONFIG_ARM_CPU_SUSPEND
>  ENTRY(cpu_v7_do_suspend)
> +ENTRY(cpu_pj4b_do_suspend)
>  	stmfd	sp!, {r4 - r10, lr}
>  	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
>  	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
> @@ -107,8 +125,10 @@ ENTRY(cpu_v7_do_suspend)
>  	stmia	r0, {r6 - r11}
>  	ldmfd	sp!, {r4 - r10, pc}
>  ENDPROC(cpu_v7_do_suspend)
> +ENDPROC(cpu_pj4b_do_suspend)
>  
>  ENTRY(cpu_v7_do_resume)
> +ENTRY(cpu_pj4b_do_resume)
>  	mov	ip, #0
>  	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
>  	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
> @@ -138,6 +158,7 @@ ENTRY(cpu_v7_do_resume)
>  	mov	r0, r8			@ control register
>  	b	cpu_resume_mmu
>  ENDPROC(cpu_v7_do_resume)
> +ENDPROC(cpu_pj4b_do_resume)
>  #endif
>  
>  	__CPUINIT
> @@ -350,6 +371,7 @@ __v7_setup_stack:
>  
>  	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
>  	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
> +	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
>  
>  	.section ".rodata"
>  
> @@ -362,7 +384,7 @@ __v7_setup_stack:
>  	/*
>  	 * Standard v7 proc info content
>  	 */
> -.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0
> +.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0, proc_fns = v7_processor_functions
>  	ALT_SMP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
>  			PMD_SECT_AF | PMD_FLAGS_SMP | \mm_mmuflags)
>  	ALT_UP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
> @@ -375,7 +397,7 @@ __v7_setup_stack:
>  	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT | \
>  		HWCAP_EDSP | HWCAP_TLS | \hwcaps
>  	.long	cpu_v7_name
> -	.long	v7_processor_functions
> +	.long	proc_fns
>  	.long	v7wbi_tlb_fns
>  	.long	v6_user_fns
>  	.long	v7_cache_fns
> @@ -411,7 +433,7 @@ __v7_ca9mp_proc_info:
>  __v7_pj4b_proc_info:
>  	.long	0x562f5840
>  	.long	0xfffffff0
> -	__v7_proc __v7_pj4b_setup
> +	__v7_proc __v7_pj4b_setup, proc_fns = pj4b_processor_functions
>  	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
>  
>  	/*
> 
