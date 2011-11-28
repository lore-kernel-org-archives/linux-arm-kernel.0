From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 28 Nov 2011 11:30:06 -0500 (EST)
Subject: [PATCH] ARM: kprobes: Restrict probing SWP instructions to ARMv5
 and below
In-Reply-To: <1322396080.2408.5.camel@computer2>
References: <1322396080.2408.5.camel@computer2>
Message-ID: <alpine.LFD.2.02.1111281129260.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Nov 2011, Tixy wrote:

> The SWP instruction is deprecated on ARMv6 and with ARMv7 it will be
> UNDEFINED when CONFIG_SWP_EMULATE is selected. In this case, probing a
> SWP instruction will cause an oops when the kprobes emulation code
> executes an undefined instruction.
> 
> As the SWP instruction should be rare or non-existent in kernels for
> ARMv6 and later, we can simply avoid these problems by not allowing
> probing of these.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/kprobes-arm.c      |    4 +++-
>  arch/arm/kernel/kprobes-test-arm.c |   25 ++++++++++++++++---------
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
> index 9fe8910..8a30c89 100644
> --- a/arch/arm/kernel/kprobes-arm.c
> +++ b/arch/arm/kernel/kprobes-arm.c
> @@ -519,10 +519,12 @@ static const union decode_item arm_cccc_0000_____1001_table[] = {
>  static const union decode_item arm_cccc_0001_____1001_table[] = {
>  	/* Synchronization primitives					*/
>  
> +#if __LINUX_ARM_ARCH__ < 6
> +	/* Deprecated on ARMv6 and may be UNDEFINED on v7		*/
>  	/* SMP/SWPB		cccc 0001 0x00 xxxx xxxx xxxx 1001 xxxx */
>  	DECODE_EMULATEX	(0x0fb000f0, 0x01000090, emulate_rd12rn16rm0_rwflags_nopc,
>  						 REGS(NOPC, NOPC, 0, 0, NOPC)),
> -
> +#endif
>  	/* LDREX/STREX{,D,B,H}	cccc 0001 1xxx xxxx xxxx xxxx 1001 xxxx */
>  	/* And unallocated instructions...				*/
>  	DECODE_END
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index edf9ad8..ba32b39 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -427,18 +427,25 @@ void kprobe_arm_test_cases(void)
>  
>  	TEST_GROUP("Synchronization primitives")
>  
> -	/*
> -	 * Use hard coded constants for SWP instructions to avoid warnings
> -	 * about deprecated instructions.
> -	 */
> -	TEST_RP( ".word 0xe108e097 @ swp	lr, r",7,VAL2,", [r",8,0,"]")
> -	TEST_R(  ".word 0x610d0091 @ swpvs	r0, r",1,VAL1,", [sp]")
> -	TEST_RP( ".word 0xe10cd09e @ swp	sp, r",14,VAL2,", [r",12,13*4,"]")
> +#if __LINUX_ARM_ARCH__ < 6
> +	TEST_RP("swp	lr, r",7,VAL2,", [r",8,0,"]")
> +	TEST_R( "swpvs	r0, r",1,VAL1,", [sp]")
> +	TEST_RP("swp	sp, r",14,VAL2,", [r",12,13*4,"]")
> +#else
> +	TEST_UNSUPPORTED(".word 0xe108e097 @ swp	lr, r7, [r8]")
> +	TEST_UNSUPPORTED(".word 0x610d0091 @ swpvs	r0, r1, [sp]")
> +	TEST_UNSUPPORTED(".word 0xe10cd09e @ swp	sp, r14 [r12]")
> +#endif
>  	TEST_UNSUPPORTED(".word 0xe102f091 @ swp pc, r1, [r2]")
>  	TEST_UNSUPPORTED(".word 0xe102009f @ swp r0, pc, [r2]")
>  	TEST_UNSUPPORTED(".word 0xe10f0091 @ swp r0, r1, [pc]")
> -	TEST_RP( ".word 0xe148e097 @ swpb	lr, r",7,VAL2,", [r",8,0,"]")
> -	TEST_R(  ".word 0x614d0091 @ swpvsb	r0, r",1,VAL1,", [sp]")
> +#if __LINUX_ARM_ARCH__ < 6
> +	TEST_RP("swpb	lr, r",7,VAL2,", [r",8,0,"]")
> +	TEST_R( "swpvsb	r0, r",1,VAL1,", [sp]")
> +#else
> +	TEST_UNSUPPORTED(".word 0xe148e097 @ swpb	lr, r7, [r8]")
> +	TEST_UNSUPPORTED(".word 0x614d0091 @ swpvsb	r0, r1, [sp]")
> +#endif
>  	TEST_UNSUPPORTED(".word 0xe142f091 @ swpb pc, r1, [r2]")
>  
>  	TEST_UNSUPPORTED(".word	0xe1100090") /* Unallocated space */
> -- 
> 1.7.2.5
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
