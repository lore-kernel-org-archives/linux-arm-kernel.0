From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 12 Mar 2015 16:32:03 -0400 (EDT)
Subject: [RFT/RFC PATCH 3/6] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <1426181892-15440-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426181892-15440-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1503121625401.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Mar 2015, Ard Biesheuvel wrote:

> These macros execute PC-relative branches, but with a larger
> reach than the 24 bits that are available in the b and bl opcodes.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index f67fd3afebdf..bd08c3c1b73f 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -108,6 +108,35 @@
>  	.endm
>  #endif
>  
> +	/*
> +	 * Macros to emit relative branches that may exceed the range
> +	 * of the 24-bit immediate of the ordinary b/bl instructions.
> +	 * NOTE: this doesn't work with locally defined symbols, as they
> +	 * might lack the ARM/Thumb annotation (even if they are annotated
> +	 * as functions)

I really hope you won't need a far call with local symbols ever!

> +	 */
> +	.macro  b_far, target, tmpreg
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> + ARM(	movt	\tmpreg, #:upper16:(\target - (8888f + 8))	)
> + ARM(	movw	\tmpreg, #:lower16:(\target - (8888f + 8))	)
> + THUMB(	movt    \tmpreg, #:upper16:(\target - (8888f + 4))	)
> + THUMB(	movw	\tmpreg, #:lower16:(\target - (8888f + 4))	)
> +8888:	add	pc, pc, \tmpreg
> +#else
> +	ldr	\tmpreg, 8889f
> +8888:	add	pc, pc, \tmpreg
> +	.align 	2
> +8889:
> + ARM(	.word   \target - (8888b + 8)           )

The Thumb relocation value is missing here.

> +#endif
> +	.endm
> +
> +	.macro	bl_far, target, tmpreg=ip
> +	adr	lr, 8887f
> +	b_far	\target, \tmpreg
> +8887:
> +	.endm
> +
>  	.macro asm_trace_hardirqs_off
>  #if defined(CONFIG_TRACE_IRQFLAGS)
>  	stmdb   sp!, {r0-r3, ip, lr}
> -- 
> 1.8.3.2
> 
> 
