From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 20 Jan 2014 17:18:35 -0800
Subject: [PATCH REPOST 2/5] ARM: fix KVM assembler files to work in BE case
In-Reply-To: <1387558125-3460-3-git-send-email-victor.kamensky@linaro.org>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-3-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140121011835.GJ13432@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 08:48:42AM -0800, Victor Kamensky wrote:
> ARM v7 KVM assembler files fixes to work in big endian mode:

I don't think 'files fixes' is proper English, could be something like:

Fix ARM v7 KVM assembler files to work...

> 
> vgic h/w registers are little endian; when asm code reads/writes from/to

the vgic h/w registers

> them, it needs to do byteswap after/before. Byte swap code uses ARM_BE8

Byteswap

> wrapper to add swap only if BIG_ENDIAN kernel is configured

what is the config symbol, CONFIG_BIG_ENDIAN?

> 
> mcrr and mrrc instructions take couple 32 bit registers as argument, one

The mcrr and mrrc...

a couple of

as their arguments

> is supposed to be high part of 64 bit value and another is low part of
> 64 bit. Typically those values are loaded/stored with ldrd and strd

one is supposed to be?

> instructions and those will load high and low parts in opposite register
> depending on endianity. Introduce and use rr_lo_hi macro that swap

opposite register?  This text is more confusing that clarifying, I think
you need to explain what how the rr_lo_hi macro is intended to be used
if anything.

> registers in BE mode when they are passed to mcrr and mrrc instructions.
> 
> function that returns 64 bit result __kvm_vcpu_run in couple registers
> has to be adjusted for BE case.

The __kvm_vcpu_run function returns a 64-bit result in two registers,
which has...

> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/include/asm/assembler.h |  7 +++++++
>  arch/arm/include/asm/kvm_asm.h   |  4 ++--
>  arch/arm/kvm/init.S              |  7 +++++--
>  arch/arm/kvm/interrupts.S        | 12 +++++++++---
>  arch/arm/kvm/interrupts_head.S   | 27 ++++++++++++++++++++-------
>  5 files changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 5c22851..ad1ad31 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -60,6 +60,13 @@
>  #define ARM_BE8(code...)
>  #endif
>  
> +/* swap pair of registers position depending on current endianity */
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define rr_lo_hi(a1, a2) a2, a1
> +#else
> +#define rr_lo_hi(a1, a2) a1, a2
> +#endif
> +

I'm not convinced that this is needed generally in the kernel and not
locally to KVM, but if it is, then I think it needs to be documented
more.  I assume the idea here is that a1 is always the lowered number
register in an ldrd instruction loading the values to write to the
register?

>  /*
>   * Data preload for architectures that support it
>   */
> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> index 661da11..12981d6 100644
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

These lines far exceed 80 chars, but not sure how to improve on that...

>  #define c2_TTBCR	10	/* Translation Table Base Control R. */
>  #define c3_DACR		11	/* Domain Access Control Register */
>  #define c5_DFSR		12	/* Data Fault Status Register */
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 1b9844d..2d10b2d 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -22,6 +22,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/assembler.h>
>  
>  /********************************************************************
>   * Hypervisor initialization
> @@ -70,8 +71,10 @@ __do_hyp_init:
>  	cmp	r0, #0			@ We have a SP?
>  	bne	phase2			@ Yes, second stage init
>  
> +ARM_BE8(setend	be) @ Switch to Big Endian mode if needed
> +
>  	@ Set the HTTBR to point to the hypervisor PGD pointer passed
> -	mcrr	p15, 4, r2, r3, c2
> +	mcrr	p15, 4, rr_lo_hi(r2, r3), c2
>  
>  	@ Set the HTCR and VTCR to the same shareability and cacheability
>  	@ settings as the non-secure TTBCR and with T0SZ == 0.
> @@ -137,7 +140,7 @@ phase2:
>  	mov	pc, r0
>  
>  target:	@ We're now in the trampoline code, switch page tables
> -	mcrr	p15, 4, r2, r3, c2
> +	mcrr	p15, 4, rr_lo_hi(r2, r3), c2
>  	isb

I guess you could switch r2 and r3 (without a third register or using
stack space) on big endian to avoid the need for the macro in a header
file and define the macro locally in the interrupts*.S files...  Hmmm,
undecided.

>  
>  	@ Invalidate the old TLBs
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index df19133..0784ec3 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -25,6 +25,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/vfpmacros.h>
> +#include <asm/assembler.h>
>  #include "interrupts_head.S"
>  
>  	.text
> @@ -52,14 +53,14 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>  	dsb	ishst
>  	add	r0, r0, #KVM_VTTBR
>  	ldrd	r2, r3, [r0]
> -	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
> +	mcrr	p15, 6, rr_lo_hi(r2, r3), c2	@ Write VTTBR
>  	isb
>  	mcr     p15, 0, r0, c8, c3, 0	@ TLBIALLIS (rt ignored)
>  	dsb	ish
>  	isb
>  	mov	r2, #0
>  	mov	r3, #0
> -	mcrr	p15, 6, r2, r3, c2	@ Back to VMID #0
> +	mcrr	p15, 6, rr_lo_hi(r2, r3), c2	@ Back to VMID #0
>  	isb				@ Not necessary if followed by eret
>  
>  	ldmia	sp!, {r2, r3}
> @@ -135,7 +136,7 @@ ENTRY(__kvm_vcpu_run)
>  	ldr	r1, [vcpu, #VCPU_KVM]
>  	add	r1, r1, #KVM_VTTBR
>  	ldrd	r2, r3, [r1]
> -	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
> +	mcrr	p15, 6, rr_lo_hi(r2, r3), c2	@ Write VTTBR
>  
>  	@ We're all done, just restore the GPRs and go to the guest
>  	restore_guest_regs
> @@ -199,8 +200,13 @@ after_vfp_restore:
>  
>  	restore_host_regs
>  	clrex				@ Clear exclusive monitor
> +#ifndef __ARMEB__
>  	mov	r0, r1			@ Return the return code
>  	mov	r1, #0			@ Clear upper bits in return value
> +#else
> +	@ r1 already has return code
> +	mov	r0, #0			@ Clear upper bits in return value
> +#endif /* __ARMEB__ */
>  	bx	lr			@ return to IOCTL
>  
>  /********************************************************************
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index c371db7..67b4002 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -251,8 +251,8 @@ vcpu	.req	r0		@ vcpu pointer always in r0
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
> @@ -380,8 +380,8 @@ vcpu	.req	r0		@ vcpu pointer always in r0
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
> @@ -413,13 +413,21 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r9, [r2, #GICH_ELRSR1]
>  	ldr	r10, [r2, #GICH_APR]
>  
> +ARM_BE8(rev	r3, r3	)
>  	str	r3, [r11, #VGIC_CPU_HCR]
> +ARM_BE8(rev	r4, r4	)
>  	str	r4, [r11, #VGIC_CPU_VMCR]
> +ARM_BE8(rev	r5, r5	)
>  	str	r5, [r11, #VGIC_CPU_MISR]
> +ARM_BE8(rev	r6, r6	)
>  	str	r6, [r11, #VGIC_CPU_EISR]
> +ARM_BE8(rev	r7, r7	)
>  	str	r7, [r11, #(VGIC_CPU_EISR + 4)]
> +ARM_BE8(rev	r8, r8	)
>  	str	r8, [r11, #VGIC_CPU_ELRSR]
> +ARM_BE8(rev	r9, r9	)
>  	str	r9, [r11, #(VGIC_CPU_ELRSR + 4)]
> +ARM_BE8(rev	r10, r10	)
>  	str	r10, [r11, #VGIC_CPU_APR]

Wouldn't it be semantically cleaner to to the byteswap after the loads
from the hardware instead?

>  
>  	/* Clear GICH_HCR */
> @@ -431,6 +439,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
>  1:	ldr	r6, [r2], #4
> +ARM_BE8(rev	r6, r6	)
>  	str	r6, [r3], #4
>  	subs	r4, r4, #1
>  	bne	1b
> @@ -459,8 +468,11 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r4, [r11, #VGIC_CPU_VMCR]
>  	ldr	r8, [r11, #VGIC_CPU_APR]
>  
> +ARM_BE8(rev	r3, r3	)
>  	str	r3, [r2, #GICH_HCR]
> +ARM_BE8(rev	r4, r4	)
>  	str	r4, [r2, #GICH_VMCR]
> +ARM_BE8(rev	r8, r8	)
>  	str	r8, [r2, #GICH_APR]
>  
>  	/* Restore list registers */
> @@ -468,6 +480,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
>  1:	ldr	r6, [r3], #4
> +ARM_BE8(rev	r6, r6  )
>  	str	r6, [r2], #4
>  	subs	r4, r4, #1
>  	bne	1b
> @@ -498,7 +511,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
>  	isb
>  
> -	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
> +	mrrc	p15, 3, rr_lo_hi(r2, r3), c14	@ CNTV_CVAL
>  	ldr	r4, =VCPU_TIMER_CNTV_CVAL
>  	add	r5, vcpu, r4
>  	strd	r2, r3, [r5]
> @@ -538,12 +551,12 @@ vcpu	.req	r0		@ vcpu pointer always in r0
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

Thanks,
-- 
Christoffer
