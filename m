From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 22 Jun 2013 14:26:24 +0200
Subject: [PATCH v2 1/3] ARM: KVM: perform save/restore of PAR
In-Reply-To: <20130621184748.GA2816@lvm>
References: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
 <1371816528-25078-2-git-send-email-marc.zyngier@arm.com>
 <20130621184748.GA2816@lvm>
Message-ID: <e09c6bebe40c399c065ec33a599725f4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013 11:47:48 -0700, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Fri, Jun 21, 2013 at 01:08:46PM +0100, Marc Zyngier wrote:
>> Not saving PAR is an unfortunate oversight. If the guest performs
>> an AT* operation and gets scheduled out before reading the result
>> of the translation from PAR, it could become corrupted by another
>> guest or the host.
>> 
>> Saving this register is made slightly more complicated as KVM also
>> uses it on the permission fault handling path, leading to an ugly
>> "stash and restore" sequence. Fortunately, this is already a slow
>> path so we don't really care. Also, Linux doesn't do any AT*
>> operation, so Linux guests are not impacted by this bug.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/kvm_asm.h | 22 ++++++++++++----------
>>  arch/arm/kvm/coproc.c          |  4 ++++
>>  arch/arm/kvm/interrupts.S      | 12 +++++++++++-
>>  arch/arm/kvm/interrupts_head.S | 10 ++++++++--
>>  4 files changed, 35 insertions(+), 13 deletions(-)
>> 
>> diff --git a/arch/arm/include/asm/kvm_asm.h
>> b/arch/arm/include/asm/kvm_asm.h
>> index 18d5032..4bb08e3 100644
>> --- a/arch/arm/include/asm/kvm_asm.h
>> +++ b/arch/arm/include/asm/kvm_asm.h
>> @@ -37,16 +37,18 @@
>>  #define c5_AIFSR	15	/* Auxilary Instrunction Fault Status R */
>>  #define c6_DFAR		16	/* Data Fault Address Register */
>>  #define c6_IFAR		17	/* Instruction Fault Address Register */
>> -#define c9_L2CTLR	18	/* Cortex A15 L2 Control Register */
>> -#define c10_PRRR	19	/* Primary Region Remap Register */
>> -#define c10_NMRR	20	/* Normal Memory Remap Register */
>> -#define c12_VBAR	21	/* Vector Base Address Register */
>> -#define c13_CID		22	/* Context ID Register */
>> -#define c13_TID_URW	23	/* Thread ID, User R/W */
>> -#define c13_TID_URO	24	/* Thread ID, User R/O */
>> -#define c13_TID_PRIV	25	/* Thread ID, Privileged */
>> -#define c14_CNTKCTL	26	/* Timer Control Register (PL1) */
>> -#define NR_CP15_REGS	27	/* Number of regs (incl. invalid) */
>> +#define c7_PAR		18	/* Physical Address Register */
>> +#define c7_PAR_high	19	/* PAR top 32 bits */
>> +#define c9_L2CTLR	20	/* Cortex A15 L2 Control Register */
>> +#define c10_PRRR	21	/* Primary Region Remap Register */
>> +#define c10_NMRR	22	/* Normal Memory Remap Register */
>> +#define c12_VBAR	23	/* Vector Base Address Register */
>> +#define c13_CID		24	/* Context ID Register */
>> +#define c13_TID_URW	25	/* Thread ID, User R/W */
>> +#define c13_TID_URO	26	/* Thread ID, User R/O */
>> +#define c13_TID_PRIV	27	/* Thread ID, Privileged */
>> +#define c14_CNTKCTL	28	/* Timer Control Register (PL1) */
>> +#define NR_CP15_REGS	29	/* Number of regs (incl. invalid) */
>>  
>>  #define ARM_EXCEPTION_RESET	  0
>>  #define ARM_EXCEPTION_UNDEFINED   1
>> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
>> index 8eea97b..4a51990 100644
>> --- a/arch/arm/kvm/coproc.c
>> +++ b/arch/arm/kvm/coproc.c
>> @@ -180,6 +180,10 @@ static const struct coproc_reg cp15_regs[] = {
>>  			NULL, reset_unknown, c6_DFAR },
>>  	{ CRn( 6), CRm( 0), Op1( 0), Op2( 2), is32,
>>  			NULL, reset_unknown, c6_IFAR },
>> +
>> +	/* PAR swapped by interrupt.S */
>> +	{ CRn( 7), Op1( 0), is64, NULL, reset_unknown64, c7_PAR },
>> +
>>  	/*
>>  	 * DC{C,I,CI}SW operations:
>>  	 */
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index f7793df..d0a8fa3 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -414,6 +414,10 @@ guest_trap:
>>  	mrcne	p15, 4, r2, c6, c0, 4	@ HPFAR
>>  	bne	3f
>>  
>> +	/* Preserve PAR */
>> +	mrrc	p15, 0, r0, r1, c7	@ PAR
>> +	push	{r0, r1}
>> +
>>  	/* Resolve IPA using the xFAR */
>>  	mcr	p15, 0, r2, c7, c8, 0	@ ATS1CPR
>>  	isb
>> @@ -424,13 +428,19 @@ guest_trap:
>>  	lsl	r2, r2, #4
>>  	orr	r2, r2, r1, lsl #24
>>  
>> +	/* Restore PAR */
>> +	pop	{r0, r1}
>> +	mcrr	p15, 0, r0, r1, c7	@ PAR
>> +
>>  3:	load_vcpu			@ Load VCPU pointer to r0
>>  	str	r2, [r0, #VCPU_HPFAR]
>>  
>>  1:	mov	r1, #ARM_EXCEPTION_HVC
>>  	b	__kvm_vcpu_return
>>  
>> -4:	pop	{r0, r1, r2}		@ Failed translation, return to guest
>> +4:	pop	{r0, r1}		@ Failed translation, return to guest
>> +	mcrr	p15, 0, r0, r1, c7	@ PAR
>> +	pop	{r0, r1, r2}
>>  	eret
>>  
>>  /*
>> diff --git a/arch/arm/kvm/interrupts_head.S
>> b/arch/arm/kvm/interrupts_head.S
>> index 3c8f2f0..2478af1 100644
>> --- a/arch/arm/kvm/interrupts_head.S
>> +++ b/arch/arm/kvm/interrupts_head.S
>> @@ -302,11 +302,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>>  	.endif
>>  
>>  	mrc	p15, 0, r2, c14, c1, 0	@ CNTKCTL
>> +	mrrc	p15, 0, r3, r4, c7	@ PAR
>>  
>>  	.if \store_to_vcpu == 0
>> -	push	{r2}
>> +	push	{r2-r4}
>>  	.else
>>  	str	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
>> +	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
>> +	strd	r3, r4, [r12]
> 
> my compiler complains that the load should start with an even register,
> so I've changed this with the patch below.

Ah, ARM kernel - I get bitten by this all the time.
Note to self: test ARM builds as well as Thumb2... ;-)

Thanks for noticing this.

>>  	.endif
>>  .endm
>>  
>> @@ -319,12 +322,15 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>>   */
>>  .macro write_cp15_state read_from_vcpu
>>  	.if \read_from_vcpu == 0
>> -	pop	{r2}
>> +	pop	{r2-r4}
>>  	.else
>>  	ldr	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
>> +	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
>> +	ldrd	r3, r4, [r12]
> 
> ditto
> 
>>  	.endif
>>  
>>  	mcr	p15, 0, r2, c14, c1, 0	@ CNTKCTL
>> +	mcrr	p15, 0, r3, r4, c7	@ PAR
>>  
>>  	.if \read_from_vcpu == 0
>>  	pop	{r2-r12}
>> -- 
>> 1.8.2.3
>> 
> 
> Here's the fixup patch:
> 
> diff --git a/arch/arm/kvm/interrupts_head.S
> b/arch/arm/kvm/interrupts_head.S
> index 2478af1..2b44b95 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -302,14 +302,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	.endif
>  
>  	mrc	p15, 0, r2, c14, c1, 0	@ CNTKCTL
> -	mrrc	p15, 0, r3, r4, c7	@ PAR
> +	mrrc	p15, 0, r4, r5, c7	@ PAR
>  
>  	.if \store_to_vcpu == 0
> -	push	{r2-r4}
> +	push	{r2,r4-r5}
>  	.else
>  	str	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
>  	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
> -	strd	r3, r4, [r12]
> +	strd	r4, r5, [r12]
>  	.endif
>  .endm
>  
> @@ -322,15 +322,15 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>   */
>  .macro write_cp15_state read_from_vcpu
>  	.if \read_from_vcpu == 0
> -	pop	{r2-r4}
> +	pop	{r2,r4-r5}
>  	.else
>  	ldr	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
>  	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
> -	ldrd	r3, r4, [r12]
> +	ldrd	r4, r5, [r12]
>  	.endif
>  
>  	mcr	p15, 0, r2, c14, c1, 0	@ CNTKCTL
> -	mcrr	p15, 0, r3, r4, c7	@ PAR
> +	mcrr	p15, 0, r4, r5, c7	@ PAR
>  
>  	.if \read_from_vcpu == 0
>  	pop	{r2-r12}

Looks good. Thanks for taking care of this.

        M.
-- 
Fast, cheap, reliable. Pick two.
