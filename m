From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 7 Jan 2014 16:01:13 +0000
Subject: [PATCH 1/5] ARM: kvm: replace push and pop with stdmb and ldmia
 instrs to enable assembler.h inclusion
In-Reply-To: <1387524419-4216-2-git-send-email-victor.kamensky@linaro.org>
References: <1387524419-4216-1-git-send-email-victor.kamensky@linaro.org>
 <1387524419-4216-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140107160113.GB3350@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:26:55PM -0800, Victor Kamensky wrote:
> Before fix kvm interrupt.S and interrupt_head.S used push and pop assembler
> instruction. It causes problem if <asm/assembler.h> file should be include. In
> assembler.h "push" is defined as macro so it causes compilation errors like
> this:
> 
> arch/arm/kvm/interrupts.S: Assembler messages:
> arch/arm/kvm/interrupts.S:51: Error: ARM register expected -- `lsr {r2,r3}'
> 
> Solution implemented by this patch replaces all 'push {...}' with
> 'stdmb sp!, {...}' instruction; and all 'pop {...}' with 'ldmia sp!, {...}'.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kvm/interrupts.S      | 38 +++++++++++++++++++-------------------
>  arch/arm/kvm/interrupts_head.S | 34 +++++++++++++++++-----------------
>  2 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index ddc1553..df19133 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -47,7 +47,7 @@ __kvm_hyp_code_start:
>   * instead, ignoring the ipa value.
>   */
>  ENTRY(__kvm_tlb_flush_vmid_ipa)
> -	push	{r2, r3}
> +	stmdb	sp!, {r2, r3}

Minor nit: when pushing and popping the stack, the convention for kernel
code is to write

	stmfd	sp!,
	ldmfd	sp!,

instead of

	stmdb	sp!,
	ldmia	sp!,

This will have no effect on the assembly, but may be slightly easier to
read.

>  
>  	dsb	ishst
>  	add	r0, r0, #KVM_VTTBR
> @@ -62,7 +62,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>  	mcrr	p15, 6, r2, r3, c2	@ Back to VMID #0
>  	isb				@ Not necessary if followed by eret
>  
> -	pop	{r2, r3}
> +	ldmia	sp!, {r2, r3}
>  	bx	lr
>  ENDPROC(__kvm_tlb_flush_vmid_ipa)
>  
> @@ -110,7 +110,7 @@ ENTRY(__kvm_vcpu_run)
>  #ifdef CONFIG_VFPv3
>  	@ Set FPEXC_EN so the guest doesn't trap floating point instructions
>  	VFPFMRX r2, FPEXC		@ VMRS
> -	push	{r2}
> +	stmdb	sp!, {r2}

For saving or restoring a single register, you may want to do:

	str	r2, [sp, #-4]!

	...

	ldr	r2, [sp], #4

This is the commonly used convention, and may be marginally more
efficient.  The "push" and "pop" assembler mnemonics generate
these instead of stm/ldm if the list only contains a single register,
whereas ldm/stm always generate a real load or store multiple even
if there is only one register in the list.

This is a trivial issue, so only worth fixing if you are going to repost
the patch anyway.

>  	orr	r2, r2, #FPEXC_EN
>  	VFPFMXR FPEXC, r2		@ VMSR
>  #endif
> @@ -175,7 +175,7 @@ __kvm_vcpu_return:
>  
>  after_vfp_restore:
>  	@ Restore FPEXC_EN which we clobbered on entry
> -	pop	{r2}
> +	ldmia	sp!, {r2}
>  	VFPFMXR FPEXC, r2
>  #endif
>  
> @@ -260,7 +260,7 @@ ENTRY(kvm_call_hyp)
>  
>  /* Handle undef, svc, pabt, or dabt by crashing with a user notice */
>  .macro bad_exception exception_code, panic_str
> -	push	{r0-r2}
> +	stmdb   sp!, {r0-r2}
>  	mrrc	p15, 6, r0, r1, c2	@ Read VTTBR
>  	lsr	r1, r1, #16
>  	ands	r1, r1, #0xff
> @@ -338,7 +338,7 @@ hyp_hvc:
>  	 * Getting here is either becuase of a trap from a guest or from calling
>  	 * HVC from the host kernel, which means "switch to Hyp mode".
>  	 */
> -	push	{r0, r1, r2}
> +	stmdb	sp!, {r0, r1, r2}
>  
>  	@ Check syndrome register
>  	mrc	p15, 4, r1, c5, c2, 0	@ HSR
> @@ -361,11 +361,11 @@ hyp_hvc:
>  	bne	guest_trap		@ Guest called HVC
>  
>  host_switch_to_hyp:
> -	pop	{r0, r1, r2}
> +	ldmia	sp!, {r0, r1, r2}
>  
> -	push	{lr}
> +	stmdb	sp!, {lr}
>  	mrs	lr, SPSR
> -	push	{lr}
> +	stmdb	sp!, {lr}
>  
>  	mov	lr, r0
>  	mov	r0, r1
> @@ -375,9 +375,9 @@ host_switch_to_hyp:
>  THUMB(	orr	lr, #1)
>  	blx	lr			@ Call the HYP function
>  
> -	pop	{lr}
> +	ldmia	sp!, {lr}
>  	msr	SPSR_csxf, lr
> -	pop	{lr}
> +	ldmia	sp!, {lr}
>  	eret
>  
>  guest_trap:
> @@ -418,7 +418,7 @@ guest_trap:
>  
>  	/* Preserve PAR */
>  	mrrc	p15, 0, r0, r1, c7	@ PAR
> -	push	{r0, r1}
> +	stmdb	sp!, {r0, r1}
>  
>  	/* Resolve IPA using the xFAR */
>  	mcr	p15, 0, r2, c7, c8, 0	@ ATS1CPR
> @@ -431,7 +431,7 @@ guest_trap:
>  	orr	r2, r2, r1, lsl #24
>  
>  	/* Restore PAR */
> -	pop	{r0, r1}
> +	ldmia	sp!, {r0, r1}
>  	mcrr	p15, 0, r0, r1, c7	@ PAR
>  
>  3:	load_vcpu			@ Load VCPU pointer to r0
> @@ -440,10 +440,10 @@ guest_trap:
>  1:	mov	r1, #ARM_EXCEPTION_HVC
>  	b	__kvm_vcpu_return
>  
> -4:	pop	{r0, r1}		@ Failed translation, return to guest
> +4:	ldmia	sp!, {r0, r1}		@ Failed translation, return to guest
>  	mcrr	p15, 0, r0, r1, c7	@ PAR
>  	clrex
> -	pop	{r0, r1, r2}
> +	ldmia	sp!, {r0, r1, r2}
>  	eret
>  
>  /*
> @@ -455,7 +455,7 @@ guest_trap:
>  #ifdef CONFIG_VFPv3
>  switch_to_guest_vfp:
>  	load_vcpu			@ Load VCPU pointer to r0
> -	push	{r3-r7}
> +	stmdb	sp!, {r3-r7}
>  
>  	@ NEON/VFP used.  Turn on VFP access.
>  	set_hcptr vmexit, (HCPTR_TCP(10) | HCPTR_TCP(11))
> @@ -467,15 +467,15 @@ switch_to_guest_vfp:
>  	add	r7, r0, #VCPU_VFP_GUEST
>  	restore_vfp_state r7
>  
> -	pop	{r3-r7}
> -	pop	{r0-r2}
> +	ldmia	sp!, {r3-r7}
> +	ldmia	sp!, {r0-r2}
>  	clrex
>  	eret
>  #endif
>  
>  	.align
>  hyp_irq:
> -	push	{r0, r1, r2}
> +	stmdb	sp!, {r0, r1, r2}
>  	mov	r1, #ARM_EXCEPTION_IRQ
>  	load_vcpu			@ Load VCPU pointer to r0
>  	b	__kvm_vcpu_return
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 6f18695..c371db7 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -63,7 +63,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mrs	r2, SP_\mode
>  	mrs	r3, LR_\mode
>  	mrs	r4, SPSR_\mode
> -	push	{r2, r3, r4}
> +	stmdb	sp!, {r2, r3, r4}
>  .endm
>  
>  /*
> @@ -73,13 +73,13 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  .macro save_host_regs
>  	/* Hyp regs. Only ELR_hyp (SPSR_hyp already saved) */
>  	mrs	r2, ELR_hyp
> -	push	{r2}
> +	stmdb	sp!, {r2}
>  
>  	/* usr regs */
> -	push	{r4-r12}	@ r0-r3 are always clobbered
> +	stmdb	sp!, {r4-r12}	@ r0-r3 are always clobbered
>  	mrs	r2, SP_usr
>  	mov	r3, lr
> -	push	{r2, r3}
> +	stmdb	sp!, {r2, r3}
>  
>  	push_host_regs_mode svc
>  	push_host_regs_mode abt
> @@ -95,11 +95,11 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mrs	r7, SP_fiq
>  	mrs	r8, LR_fiq
>  	mrs	r9, SPSR_fiq
> -	push	{r2-r9}
> +	stmdb	sp!, {r2-r9}
>  .endm
>  
>  .macro pop_host_regs_mode mode
> -	pop	{r2, r3, r4}
> +	ldmia	sp!, {r2, r3, r4}
>  	msr	SP_\mode, r2
>  	msr	LR_\mode, r3
>  	msr	SPSR_\mode, r4
> @@ -110,7 +110,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>   * Clobbers all registers, in all modes, except r0 and r1.
>   */
>  .macro restore_host_regs
> -	pop	{r2-r9}
> +	ldmia	sp!, {r2-r9}
>  	msr	r8_fiq, r2
>  	msr	r9_fiq, r3
>  	msr	r10_fiq, r4
> @@ -125,12 +125,12 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	pop_host_regs_mode abt
>  	pop_host_regs_mode svc
>  
> -	pop	{r2, r3}
> +	ldmia	sp!, {r2, r3}
>  	msr	SP_usr, r2
>  	mov	lr, r3
> -	pop	{r4-r12}
> +	ldmia	sp!, {r4-r12}
>  
> -	pop	{r2}
> +	ldmia	sp!, {r2}
>  	msr	ELR_hyp, r2
>  .endm
>  
> @@ -218,7 +218,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	add	r2, vcpu, #VCPU_USR_REG(3)
>  	stm	r2, {r3-r12}
>  	add	r2, vcpu, #VCPU_USR_REG(0)
> -	pop	{r3, r4, r5}		@ r0, r1, r2
> +	ldmia	sp!, {r3, r4, r5}		@ r0, r1, r2
>  	stm	r2, {r3, r4, r5}
>  	mrs	r2, SP_usr
>  	mov	r3, lr
> @@ -258,7 +258,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mrc	p15, 2, r12, c0, c0, 0	@ CSSELR
>  
>  	.if \store_to_vcpu == 0
> -	push	{r2-r12}		@ Push CP15 registers
> +	stmdb	sp!, {r2-r12}		@ Push CP15 registers
>  	.else
>  	str	r2, [vcpu, #CP15_OFFSET(c1_SCTLR)]
>  	str	r3, [vcpu, #CP15_OFFSET(c1_CPACR)]
> @@ -286,7 +286,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mrc	p15, 0, r12, c12, c0, 0	@ VBAR
>  
>  	.if \store_to_vcpu == 0
> -	push	{r2-r12}		@ Push CP15 registers
> +	stmdb	sp!, {r2-r12}		@ Push CP15 registers
>  	.else
>  	str	r2, [vcpu, #CP15_OFFSET(c13_CID)]
>  	str	r3, [vcpu, #CP15_OFFSET(c13_TID_URW)]
> @@ -305,7 +305,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mrrc	p15, 0, r4, r5, c7	@ PAR
>  
>  	.if \store_to_vcpu == 0
> -	push	{r2,r4-r5}
> +	stmdb	sp!, {r2,r4-r5}
>  	.else
>  	str	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
>  	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
> @@ -322,7 +322,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>   */
>  .macro write_cp15_state read_from_vcpu
>  	.if \read_from_vcpu == 0
> -	pop	{r2,r4-r5}
> +	ldmia	sp!, {r2,r4-r5}
>  	.else
>  	ldr	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
>  	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
> @@ -333,7 +333,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mcrr	p15, 0, r4, r5, c7	@ PAR
>  
>  	.if \read_from_vcpu == 0
> -	pop	{r2-r12}
> +	ldmia	sp!, {r2-r12}
>  	.else
>  	ldr	r2, [vcpu, #CP15_OFFSET(c13_CID)]
>  	ldr	r3, [vcpu, #CP15_OFFSET(c13_TID_URW)]
> @@ -361,7 +361,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mcr	p15, 0, r12, c12, c0, 0	@ VBAR
>  
>  	.if \read_from_vcpu == 0
> -	pop	{r2-r12}
> +	ldmia	sp!, {r2-r12}
>  	.else
>  	ldr	r2, [vcpu, #CP15_OFFSET(c1_SCTLR)]
>  	ldr	r3, [vcpu, #CP15_OFFSET(c1_CPACR)]
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
