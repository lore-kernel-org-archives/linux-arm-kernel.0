From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 18:11:09 -0700
Subject: [PATCH v2 3/7] ARM: KVM: handle 64bit values passed to mrcc or
 from mcrr instructions in BE case
In-Reply-To: <1392183693-21238-4-git-send-email-victor.kamensky@linaro.org>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-4-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320011109.GI1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:41:29PM -0800, Victor Kamensky wrote:
> In some cases the mcrr and mrrc instructions in combination with the ldrd
> and strd instructions need to deal with 64bit value in memory. The ldrd
> and strd instructions already handle endianness within word (register)
> boundaries but to get effect of the whole 64bit value represented correctly,
> rr_lo_hi macro is introduced and is used to swap registers positions when
> the mcrr and mrrc instructions are used. That has the effect of swapping
> two words.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/include/asm/kvm_asm.h | 23 +++++++++++++++++++++--
>  arch/arm/kvm/init.S            |  4 ++--
>  arch/arm/kvm/interrupts.S      |  4 ++--
>  arch/arm/kvm/interrupts_head.S | 18 +++++++++---------
>  4 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> index 661da11..c6ae937 100644
> --- a/arch/arm/include/asm/kvm_asm.h
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -26,9 +26,9 @@
>  #define c1_ACTLR	4	/* Auxilliary Control Register */
>  #define c1_CPACR	5	/* Coprocessor Access Control */
>  #define c2_TTBR0	6	/* Translation Table Base Register 0 */
> -#define c2_TTBR0_high	7	/* TTBR0 top 32 bits */
> +#define c2_TTBR0_hilo	7	/* TTBR0 top 32 bits in LE case, low 32 bits in BE case */
>  #define c2_TTBR1	8	/* Translation Table Base Register 1 */
> -#define c2_TTBR1_high	9	/* TTBR1 top 32 bits */
> +#define c2_TTBR1_hilo	9	/* TTBR1 top 32 bits in LE case, low 32 bits in BE case */
>  #define c2_TTBCR	10	/* Translation Table Base Control R. */
>  #define c3_DACR		11	/* Domain Access Control Register */
>  #define c5_DFSR		12	/* Data Fault Status Register */
> @@ -59,6 +59,25 @@
>  #define ARM_EXCEPTION_FIQ	  6
>  #define ARM_EXCEPTION_HVC	  7
>  

Thanks for writing this comment below, a few language corrections:

> +/*
> + * The rr_lo_hi macro swap pair of registers positions depending on

swaps a pair of registers depending on

> + * current endianness. It is used in conjunction with ldrd and strd
> + * instructions that loads/store 64 bit value from/to memory to/from

that load/store a 64-bit value

> + * pair of registers which are used with the mrrc and mcrr instructions.

a pair of

> + * The a1 parameter is register that typically holds lower address
> + * word (least significant word in LE, most significant in BE). The
> + * a2 parameter is register that holds higher address word. 

I would rewrite this as:

If used with the ldrd/strd instructions, the a1 parameter is the first
source/destination register and the a2 parameter is the second
source/destination register.

> Note
> + * within word (single register) the ldrd/strd instruction already
> + * swap data correctly, only additional manipulation required with order
> + * of register to have effect of 64 bit value beeing effectively
> + * swapped.

Note that the ldrd/strd instructions already swap the bytes within the
words correctly according to the endianness setting, but the order of
the registers need to be effectively swapped when used with the
mrrc/mcrr instructions.


> + */
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define rr_lo_hi(a1, a2) a2, a1
> +#else
> +#define rr_lo_hi(a1, a2) a1, a2
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  struct kvm;
>  struct kvm_vcpu;
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 74f0718..2d10b2d 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -74,7 +74,7 @@ __do_hyp_init:
>  ARM_BE8(setend	be) @ Switch to Big Endian mode if needed
>  
>  	@ Set the HTTBR to point to the hypervisor PGD pointer passed
> -	mcrr	p15, 4, r2, r3, c2
> +	mcrr	p15, 4, rr_lo_hi(r2, r3), c2
>  
>  	@ Set the HTCR and VTCR to the same shareability and cacheability
>  	@ settings as the non-secure TTBCR and with T0SZ == 0.
> @@ -140,7 +140,7 @@ phase2:
>  	mov	pc, r0
>  
>  target:	@ We're now in the trampoline code, switch page tables
> -	mcrr	p15, 4, r2, r3, c2
> +	mcrr	p15, 4, rr_lo_hi(r2, r3), c2
>  	isb
>  
>  	@ Invalidate the old TLBs
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index ddc1553..f0696bd 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -52,7 +52,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>  	dsb	ishst
>  	add	r0, r0, #KVM_VTTBR
>  	ldrd	r2, r3, [r0]
> -	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
> +	mcrr	p15, 6, rr_lo_hi(r2, r3), c2	@ Write VTTBR
>  	isb
>  	mcr     p15, 0, r0, c8, c3, 0	@ TLBIALLIS (rt ignored)
>  	dsb	ish
> @@ -135,7 +135,7 @@ ENTRY(__kvm_vcpu_run)
>  	ldr	r1, [vcpu, #VCPU_KVM]
>  	add	r1, r1, #KVM_VTTBR
>  	ldrd	r2, r3, [r1]
> -	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
> +	mcrr	p15, 6, rr_lo_hi(r2, r3), c2	@ Write VTTBR
>  
>  	@ We're all done, just restore the GPRs and go to the guest
>  	restore_guest_regs
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 1e9be2f..3409ed6 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -252,8 +252,8 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mrc	p15, 0, r3, c1, c0, 2	@ CPACR
>  	mrc	p15, 0, r4, c2, c0, 2	@ TTBCR
>  	mrc	p15, 0, r5, c3, c0, 0	@ DACR
> -	mrrc	p15, 0, r6, r7, c2	@ TTBR 0
> -	mrrc	p15, 1, r8, r9, c2	@ TTBR 1
> +	mrrc	p15, 0, rr_lo_hi(r6, r7), c2	@ TTBR 0
> +	mrrc	p15, 1, rr_lo_hi(r8, r9), c2	@ TTBR 1
>  	mrc	p15, 0, r10, c10, c2, 0	@ PRRR
>  	mrc	p15, 0, r11, c10, c2, 1	@ NMRR
>  	mrc	p15, 2, r12, c0, c0, 0	@ CSSELR
> @@ -303,7 +303,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	.endif
>  
>  	mrc	p15, 0, r2, c14, c1, 0	@ CNTKCTL
> -	mrrc	p15, 0, r4, r5, c7	@ PAR
> +	mrrc	p15, 0, rr_lo_hi(r4, r5), c7	@ PAR
>  
>  	.if \store_to_vcpu == 0
>  	push	{r2,r4-r5}
> @@ -331,7 +331,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	.endif
>  
>  	mcr	p15, 0, r2, c14, c1, 0	@ CNTKCTL
> -	mcrr	p15, 0, r4, r5, c7	@ PAR
> +	mcrr	p15, 0, rr_lo_hi(r4, r5), c7	@ PAR
>  
>  	.if \read_from_vcpu == 0
>  	pop	{r2-r12}
> @@ -381,8 +381,8 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mcr	p15, 0, r3, c1, c0, 2	@ CPACR
>  	mcr	p15, 0, r4, c2, c0, 2	@ TTBCR
>  	mcr	p15, 0, r5, c3, c0, 0	@ DACR
> -	mcrr	p15, 0, r6, r7, c2	@ TTBR 0
> -	mcrr	p15, 1, r8, r9, c2	@ TTBR 1
> +	mcrr	p15, 0, rr_lo_hi(r6, r7), c2	@ TTBR 0
> +	mcrr	p15, 1, rr_lo_hi(r8, r9), c2	@ TTBR 1
>  	mcr	p15, 0, r10, c10, c2, 0	@ PRRR
>  	mcr	p15, 0, r11, c10, c2, 1	@ NMRR
>  	mcr	p15, 2, r12, c0, c0, 0	@ CSSELR
> @@ -512,7 +512,7 @@ ARM_BE8(rev	r6, r6  )
>  	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
>  	isb
>  
> -	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
> +	mrrc	p15, 3, rr_lo_hi(r2, r3), c14	@ CNTV_CVAL
>  	ldr	r4, =VCPU_TIMER_CNTV_CVAL
>  	add	r5, vcpu, r4
>  	strd	r2, r3, [r5]
> @@ -552,12 +552,12 @@ ARM_BE8(rev	r6, r6  )
>  
>  	ldr	r2, [r4, #KVM_TIMER_CNTVOFF]
>  	ldr	r3, [r4, #(KVM_TIMER_CNTVOFF + 4)]
> -	mcrr	p15, 4, r2, r3, c14	@ CNTVOFF
> +	mcrr	p15, 4, rr_lo_hi(r2, r3), c14	@ CNTVOFF
>  
>  	ldr	r4, =VCPU_TIMER_CNTV_CVAL
>  	add	r5, vcpu, r4
>  	ldrd	r2, r3, [r5]
> -	mcrr	p15, 3, r2, r3, c14	@ CNTV_CVAL
> +	mcrr	p15, 3, rr_lo_hi(r2, r3), c14	@ CNTV_CVAL
>  	isb
>  
>  	ldr	r2, [vcpu, #VCPU_TIMER_CNTV_CTL]
> -- 
> 1.8.1.4
> 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
