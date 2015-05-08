From: Dave.Martin@arm.com (Dave P Martin)
Date: Fri, 8 May 2015 17:31:28 +0100
Subject: [PATCH 2/2] ARM: replace BSYM() with badr assembly macro
In-Reply-To: <E1YqkpT-0006zF-Vj@rmk-PC.arm.linux.org.uk>
References: <E1YqkpT-0006zF-Vj@rmk-PC.arm.linux.org.uk>
Message-ID: <20150508163127.GC17900@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 05:08:47PM +0100, Russell King wrote:
> BSYM() was invented to allow us to work around a problem with the
> assembler, where local symbols resolved by the assembler for the 'adr'
> instruction did not take account of their ISA.
> 
> Since we don't want BSYM() used elsewhere, replace BSYM() with a new
> macro 'badr', which is like the 'adr' pseudo-op, but with the BSYM()
> mechanics integrated into it.  This ensures that the BSYM()-ification
> is only used in conjunction with 'adr'.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks OK to me.

Acked-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm/boot/compressed/head.S          |  4 ++--
>  arch/arm/common/mcpm_head.S              |  2 +-
>  arch/arm/include/asm/assembler.h         | 17 ++++++++++++++++-
>  arch/arm/include/asm/entry-macro-multi.S |  4 ++--
>  arch/arm/include/asm/unified.h           |  2 --
>  arch/arm/kernel/entry-armv.S             | 12 ++++++------
>  arch/arm/kernel/entry-common.S           |  6 +++---
>  arch/arm/kernel/entry-ftrace.S           |  2 +-
>  arch/arm/kernel/head-nommu.S             |  6 +++---
>  arch/arm/kernel/head.S                   |  8 ++++----
>  arch/arm/kernel/sleep.S                  |  2 +-
>  arch/arm/lib/call_with_stack.S           |  2 +-
>  arch/arm/mm/proc-v7m.S                   |  2 +-
>  13 files changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 2c45b5709fa4..06e983f59980 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -130,7 +130,7 @@ start:
>  		.endr
>     ARM(		mov	r0, r0		)
>     ARM(		b	1f		)
> - THUMB(		adr	r12, BSYM(1f)	)
> + THUMB(		badr	r12, 1f		)
>   THUMB(		bx	r12		)
>  
>  		.word	_magic_sig	@ Magic numbers to help the loader
> @@ -447,7 +447,7 @@ dtb_check_done:
>  
>  		bl	cache_clean_flush
>  
> -		adr	r0, BSYM(restart)
> +		badr	r0, restart
>  		add	r0, r0, r6
>  		mov	pc, r0
>  
> diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
> index e02db4b81a66..08b3bb9bc6a2 100644
> --- a/arch/arm/common/mcpm_head.S
> +++ b/arch/arm/common/mcpm_head.S
> @@ -49,7 +49,7 @@
>  ENTRY(mcpm_entry_point)
>  
>   ARM_BE8(setend        be)
> - THUMB(	adr	r12, BSYM(1f)	)
> + THUMB(	badr	r12, 1f		)
>   THUMB(	bx	r12		)
>   THUMB(	.thumb			)
>  1:
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 186270b3e194..4abe57279c66 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -178,6 +178,21 @@
>  	.endm
>  
>  /*
> + * Assembly version of "adr rd, BSYM(sym)".  This should only be used to
> + * reference local symbols in the same assembly file which are to be
> + * resolved by the assembler.  Other usage is undefined.
> + */
> +	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
> +	.macro	badr\c, rd, sym
> +#ifdef CONFIG_THUMB2_KERNEL
> +	adr\c	\rd, \sym + 1
> +#else
> +	adr\c	\rd, \sym
> +#endif
> +	.endm
> +	.endr
> +
> +/*
>   * Get current thread_info.
>   */
>  	.macro	get_thread_info, rd
> @@ -326,7 +341,7 @@
>  THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	bne	1f
>  	orr	\reg, \reg, #PSR_A_BIT
> -	adr	lr, BSYM(2f)
> +	badr	lr, 2f
>  	msr	spsr_cxsf, \reg
>  	__MSR_ELR_HYP(14)
>  	__ERET
> diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
> index 469a2b30fa27..609184f522ee 100644
> --- a/arch/arm/include/asm/entry-macro-multi.S
> +++ b/arch/arm/include/asm/entry-macro-multi.S
> @@ -10,7 +10,7 @@
>  	@
>  	@ routine called with r0 = irq number, r1 = struct pt_regs *
>  	@
> -	adrne	lr, BSYM(1b)
> +	badrne	lr, 1b
>  	bne	asm_do_IRQ
>  
>  #ifdef CONFIG_SMP
> @@ -23,7 +23,7 @@
>  	ALT_SMP(test_for_ipi r0, r2, r6, lr)
>  	ALT_UP_B(9997f)
>  	movne	r1, sp
> -	adrne	lr, BSYM(1b)
> +	badrne	lr, 1b
>  	bne	do_IPI
>  #endif
>  9997:
> diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
> index 200f9a7cd623..a91ae499614c 100644
> --- a/arch/arm/include/asm/unified.h
> +++ b/arch/arm/include/asm/unified.h
> @@ -45,7 +45,6 @@
>  #define THUMB(x...)	x
>  #ifdef __ASSEMBLY__
>  #define W(instr)	instr.w
> -#define BSYM(sym)	sym + 1
>  #else
>  #define WASM(instr)	#instr ".w"
>  #endif
> @@ -59,7 +58,6 @@
>  #define THUMB(x...)
>  #ifdef __ASSEMBLY__
>  #define W(instr)	instr
> -#define BSYM(sym)	sym
>  #else
>  #define WASM(instr)	#instr
>  #endif
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 570306c49406..f8f7398c74c2 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -40,7 +40,7 @@
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
>  	ldr	r1, =handle_arch_irq
>  	mov	r0, sp
> -	adr	lr, BSYM(9997f)
> +	badr	lr, 9997f
>  	ldr	pc, [r1]
>  #else
>  	arch_irq_handler_default
> @@ -273,7 +273,7 @@ __und_svc:
>  	str	r4, [sp, #S_PC]
>  	orr	r0, r9, r0, lsl #16
>  #endif
> -	adr	r9, BSYM(__und_svc_finish)
> +	badr	r9, __und_svc_finish
>  	mov	r2, r4
>  	bl	call_fpe
>  
> @@ -469,7 +469,7 @@ __und_usr:
>  	@ instruction, or the more conventional lr if we are to treat
>  	@ this as a real undefined instruction
>  	@
> -	adr	r9, BSYM(ret_from_exception)
> +	badr	r9, ret_from_exception
>  
>  	@ IRQs must be enabled before attempting to read the instruction from
>  	@ user space since that could cause a page/translation fault if the
> @@ -486,7 +486,7 @@ __und_usr:
>  	@ r2 = PC value for the following instruction (:= regs->ARM_pc)
>  	@ r4 = PC value for the faulting instruction
>  	@ lr = 32-bit undefined instruction function
> -	adr	lr, BSYM(__und_usr_fault_32)
> +	badr	lr, __und_usr_fault_32
>  	b	call_fpe
>  
>  __und_usr_thumb:
> @@ -522,7 +522,7 @@ ARM_BE8(rev16	r0, r0)				@ little endian instruction
>  	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
>  	str	r2, [sp, #S_PC]			@ it's a 2x16bit instr, update
>  	orr	r0, r0, r5, lsl #16
> -	adr	lr, BSYM(__und_usr_fault_32)
> +	badr	lr, __und_usr_fault_32
>  	@ r0 = the two 16-bit Thumb instructions which caused the exception
>  	@ r2 = PC value for the following Thumb instruction (:= regs->ARM_pc)
>  	@ r4 = PC value for the first 16-bit Thumb instruction
> @@ -716,7 +716,7 @@ __und_usr_fault_32:
>  __und_usr_fault_16:
>  	mov	r1, #2
>  1:	mov	r0, sp
> -	adr	lr, BSYM(ret_from_exception)
> +	badr	lr, ret_from_exception
>  	b	__und_fault
>  ENDPROC(__und_usr_fault_32)
>  ENDPROC(__und_usr_fault_16)
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index f8ccc21fa032..6ab159384667 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -88,7 +88,7 @@ ENTRY(ret_from_fork)
>  	bl	schedule_tail
>  	cmp	r5, #0
>  	movne	r0, r4
> -	adrne	lr, BSYM(1f)
> +	badrne	lr, 1f
>  	retne	r5
>  1:	get_thread_info tsk
>  	b	ret_slow_syscall
> @@ -196,7 +196,7 @@ local_restart:
>  	bne	__sys_trace
>  
>  	cmp	scno, #NR_syscalls		@ check upper syscall limit
> -	adr	lr, BSYM(ret_fast_syscall)	@ return address
> +	badr	lr, ret_fast_syscall		@ return address
>  	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
>  
>  	add	r1, sp, #S_OFF
> @@ -231,7 +231,7 @@ __sys_trace:
>  	add	r0, sp, #S_OFF
>  	bl	syscall_trace_enter
>  
> -	adr	lr, BSYM(__sys_trace_return)	@ return address
> +	badr	lr, __sys_trace_return		@ return address
>  	mov	scno, r0			@ syscall number (possibly new)
>  	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
>  	cmp	scno, #NR_syscalls		@ check upper syscall limit
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index fe57c73e70a4..c73c4030ca5d 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -87,7 +87,7 @@
>  
>  1: 	mcount_get_lr	r1			@ lr of instrumented func
>  	mcount_adjust_addr	r0, lr		@ instrumented function
> -	adr	lr, BSYM(2f)
> +	badr	lr, 2f
>  	mov	pc, r2
>  2:	mcount_exit
>  .endm
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 84da14b7cd04..c9660167ef1a 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -46,7 +46,7 @@ ENTRY(stext)
>  	.arm
>  ENTRY(stext)
>  
> - THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
> + THUMB(	badr	r9, 1f		)	@ Kernel is always entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
>   THUMB(	.thumb			)	@ switch to Thumb now.
>   THUMB(1:			)
> @@ -79,7 +79,7 @@ ENTRY(stext)
>  #endif
>  	ldr	r13, =__mmap_switched		@ address to jump to after
>  						@ initialising sctlr
> -	adr	lr, BSYM(1f)			@ return (PIC) address
> +	badr	lr, 1f				@ return (PIC) address
>  	ldr	r12, [r10, #PROCINFO_INITFUNC]
>  	add	r12, r12, r10
>  	ret	r12
> @@ -115,7 +115,7 @@ ENTRY(secondary_startup)
>  	bl      __setup_mpu			@ Initialize the MPU
>  #endif
>  
> -	adr	lr, BSYM(__after_proc_init)	@ return address
> +	badr	lr, __after_proc_init		@ return address
>  	mov	r13, r12			@ __secondary_switched address
>  	ldr	r12, [r10, #PROCINFO_INITFUNC]
>  	add	r12, r12, r10
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 7304b4c44b52..1eecd57453be 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -80,7 +80,7 @@
>  ENTRY(stext)
>   ARM_BE8(setend	be )			@ ensure we are in BE8 mode
>  
> - THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
> + THUMB(	badr	r9, 1f		)	@ Kernel is always entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
>   THUMB(	.thumb			)	@ switch to Thumb now.
>   THUMB(1:			)
> @@ -148,7 +148,7 @@ ENTRY(stext)
>  	 */
>  	ldr	r13, =__mmap_switched		@ address to jump to after
>  						@ mmu has been enabled
> -	adr	lr, BSYM(1f)			@ return (PIC) address
> +	badr	lr, 1f				@ return (PIC) address
>  #ifdef CONFIG_ARM_LPAE
>  	mov	r5, #0				@ high TTBR0
>  	mov	r8, r4, lsr #12			@ TTBR1 is swapper_pg_dir pfn
> @@ -364,7 +364,7 @@ __turn_mmu_on_loc:
>  	.text
>  ENTRY(secondary_startup_arm)
>  	.arm
> - THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is entered in ARM.
> + THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
>   THUMB(	.thumb			)	@ switch to Thumb now.
>   THUMB(1:			)
> @@ -400,7 +400,7 @@ ENTRY(secondary_startup)
>  	add	r3, r7, lr
>  	ldrd	r4, [r3, #0]			@ get secondary_data.pgdir
>  	ldr	r8, [r3, #8]			@ get secondary_data.swapper_pg_dir
> -	adr	lr, BSYM(__enable_mmu)		@ return address
> +	badr	lr, __enable_mmu		@ return address
>  	mov	r13, r12			@ __secondary_switched address
>  	ldr	r12, [r10, #PROCINFO_INITFUNC]
>  	add	r12, r12, r10			@ initialise processor
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 7d37bfc50830..76bb3128e135 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -81,7 +81,7 @@ ENTRY(__cpu_suspend)
>  	mov	r1, r4			@ size of save block
>  	add	r0, sp, #8		@ pointer to save block
>  	bl	__cpu_suspend_save
> -	adr	lr, BSYM(cpu_suspend_abort)
> +	badr	lr, cpu_suspend_abort
>  	ldmfd	sp!, {r0, pc}		@ call suspend fn
>  ENDPROC(__cpu_suspend)
>  	.ltorg
> diff --git a/arch/arm/lib/call_with_stack.S b/arch/arm/lib/call_with_stack.S
> index ed1a421813cb..bf3a40889205 100644
> --- a/arch/arm/lib/call_with_stack.S
> +++ b/arch/arm/lib/call_with_stack.S
> @@ -35,7 +35,7 @@ ENTRY(call_with_stack)
>  	mov	r2, r0
>  	mov	r0, r1
>  
> -	adr	lr, BSYM(1f)
> +	badr	lr, 1f
>  	ret	r2
>  
>  1:	ldr	lr, [sp]
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index e08e1f2bab76..67d9209077c6 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -98,7 +98,7 @@ __v7m_setup:
>  	str	r5, [r0, V7M_SCB_SHPR3]	@ set PendSV priority
>  
>  	@ SVC to run the kernel in this mode
> -	adr	r1, BSYM(1f)
> +	badr	r1, 1f
>  	ldr	r5, [r12, #11 * 4]	@ read the SVC vector entry
>  	str	r1, [r12, #11 * 4]	@ write the temporary SVC vector entry
>  	mov	r6, lr			@ save LR
> -- 
> 1.8.3.1
> 
