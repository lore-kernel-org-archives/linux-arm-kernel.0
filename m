From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 20 Jul 2013 22:51:47 +0100
Subject: [PATCH 1/4] arm64: KVM: perform save/restore of PAR_EL1
In-Reply-To: <1374242035-13199-2-git-send-email-marc.zyngier@arm.com>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130720215147.GB35165@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 02:53:52PM +0100, Marc Zyngier wrote:
> Not saving PAR_EL1 is an unfortunate oversight. If the guest
> performs an AT* operation and gets scheduled out before reading
> the result of the translation from PAREL1, it could become
> corrupted by another guest or the host.
> 
> Saving this register is made slightly more complicated as KVM also
> uses it on the permission fault handling path, leading to an ugly
> "stash and restore" sequence. Fortunately, this is already a slow
> path so we don't really care. Also, Linux doesn't do any AT*
> operation, so Linux guests are not impacted by this bug.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h | 17 ++++++++++-------
>  arch/arm64/kvm/hyp.S             | 10 ++++++++++
>  arch/arm64/kvm/sys_regs.c        |  3 +++
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index c92de41..b25763b 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -42,14 +42,15 @@
>  #define	TPIDR_EL1	18	/* Thread ID, Privileged */
>  #define	AMAIR_EL1	19	/* Aux Memory Attribute Indirection Register */
>  #define	CNTKCTL_EL1	20	/* Timer Control Register (EL1) */
> +#define	PAR_EL1		21	/* Physical Address Register */
>  /* 32bit specific registers. Keep them at the end of the range */
> -#define	DACR32_EL2	21	/* Domain Access Control Register */
> -#define	IFSR32_EL2	22	/* Instruction Fault Status Register */
> -#define	FPEXC32_EL2	23	/* Floating-Point Exception Control Register */
> -#define	DBGVCR32_EL2	24	/* Debug Vector Catch Register */
> -#define	TEECR32_EL1	25	/* ThumbEE Configuration Register */
> -#define	TEEHBR32_EL1	26	/* ThumbEE Handler Base Register */
> -#define	NR_SYS_REGS	27
> +#define	DACR32_EL2	22	/* Domain Access Control Register */
> +#define	IFSR32_EL2	23	/* Instruction Fault Status Register */
> +#define	FPEXC32_EL2	24	/* Floating-Point Exception Control Register */
> +#define	DBGVCR32_EL2	25	/* Debug Vector Catch Register */
> +#define	TEECR32_EL1	26	/* ThumbEE Configuration Register */
> +#define	TEEHBR32_EL1	27	/* ThumbEE Handler Base Register */
> +#define	NR_SYS_REGS	28
>  
>  /* 32bit mapping */
>  #define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
> @@ -69,6 +70,8 @@
>  #define c5_AIFSR	(AFSR1_EL1 * 2)	/* Auxiliary Instr Fault Status R */
>  #define c6_DFAR		(FAR_EL1 * 2)	/* Data Fault Address Register */
>  #define c6_IFAR		(c6_DFAR + 1)	/* Instruction Fault Address Register */
> +#define c7_PAR		(PAR_EL1 * 2)	/* Physical Address Register */
> +#define c7_PAR_high	(c7_PAR + 1)	/* PAR top 32 bits */
>  #define c10_PRRR	(MAIR_EL1 * 2)	/* Primary Region Remap Register */
>  #define c10_NMRR	(c10_PRRR + 1)	/* Normal Memory Remap Register */
>  #define c12_VBAR	(VBAR_EL1 * 2)	/* Vector Base Address Register */
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index ff985e3..218802f 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -214,6 +214,7 @@ __kvm_hyp_code_start:
>  	mrs	x21,	tpidr_el1
>  	mrs	x22, 	amair_el1
>  	mrs	x23, 	cntkctl_el1
> +	mrs	x24,	par_el1
>  
>  	stp	x4, x5, [x3]
>  	stp	x6, x7, [x3, #16]
> @@ -225,6 +226,7 @@ __kvm_hyp_code_start:
>  	stp	x18, x19, [x3, #112]
>  	stp	x20, x21, [x3, #128]
>  	stp	x22, x23, [x3, #144]
> +	str	x24, [x3, #160]
>  .endm
>  
>  .macro restore_sysregs
> @@ -243,6 +245,7 @@ __kvm_hyp_code_start:
>  	ldp	x18, x19, [x3, #112]
>  	ldp	x20, x21, [x3, #128]
>  	ldp	x22, x23, [x3, #144]
> +	ldr	x24, [x3, #160]
>  
>  	msr	vmpidr_el2,	x4
>  	msr	csselr_el1,	x5
> @@ -264,6 +267,7 @@ __kvm_hyp_code_start:
>  	msr	tpidr_el1,	x21
>  	msr	amair_el1,	x22
>  	msr	cntkctl_el1,	x23
> +	msr	par_el1,	x24
>  .endm
>  
>  .macro skip_32bit_state tmp, target
> @@ -753,6 +757,10 @@ el1_trap:
>  	 */
>  	tbnz	x1, #7, 1f	// S1PTW is set
>  
> +	/* Preserve PAR_EL1 */
> +	mrs	x3, par_el1
> +	push	x3, xzr
> +
>  	/*
>  	 * Permission fault, HPFAR_EL2 is invalid.
>  	 * Resolve the IPA the hard way using the guest VA.
> @@ -766,6 +774,8 @@ el1_trap:
>  
>  	/* Read result */
>  	mrs	x3, par_el1
> +	pop	x0, xzr			// Restore PAR_EL1 from the stack
> +	msr	par_el1, x0
>  	tbnz	x3, #0, 3f		// Bail out if we failed the translation
>  	ubfx	x3, x3, #12, #36	// Extract IPA
>  	lsl	x3, x3, #4		// and present it like HPFAR
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 9492360..02e9d09 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -211,6 +211,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	/* FAR_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b0110), CRm(0b0000), Op2(0b000),
>  	  NULL, reset_unknown, FAR_EL1 },
> +	/* PAR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0111), CRm(0b0100), Op2(0b000),
> +	  NULL, reset_unknown, PAR_EL1 },
>  
>  	/* PMINTENSET_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
> -- 
> 1.8.2.3
> 
> 

Looks good to me,
-Christoffer
