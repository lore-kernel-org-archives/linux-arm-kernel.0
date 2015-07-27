From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 27 Jul 2015 12:16:15 +0100
Subject: [PATCH] ARM: asm/unified.h: guard the IT macros against
 redefinition when using LTO
In-Reply-To: <alpine.LFD.2.20.1507241739280.1806@knanqh.ubzr>
References: <alpine.LFD.2.20.1507241739280.1806@knanqh.ubzr>
Message-ID: <20150727111613.GL10670@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 05:42:15PM -0400, Nicolas Pitre wrote:
> 
> With LTO, the intermediate representation for each .c file contains those
> global assembly macro definitions. When the lot is merged together during
> the final link, we get duplicate definition errors:
> 
> [...]
> /tmp/cc48fUMp.s:42352: Error: Macro `it' was already defined
> /tmp/cc48fUMp.s:42354: Error: Macro `itt' was already defined
> /tmp/cc48fUMp.s:42356: Error: Macro `ite' was already defined
> [...]
> 
> Guard those against redefinitions.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

I have a vague memory of hitting this before, but LTO had other problems
at the time...

Another scary thing with LTO is asms that use directives like
.arch_extension, .fpu etc. that will stay active for the rest of the LTO
unit of nothing is done about it.

I can't remember whether that was resolved somehow.

Cheers
---Dave
 
> diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
> index a91ae49961..ee257a3de7 100644
> --- a/arch/arm/include/asm/unified.h
> +++ b/arch/arm/include/asm/unified.h
> @@ -103,6 +103,8 @@
>  	.endm
>  #else	/* !__ASSEMBLY__ */
>  __asm__(
> +/* the .L_it_macros_defined guards against redefinition in the LTO case */
> +"	.ifndef	.L_it_macros_defined\n"
>  "	.macro	it, cond\n"
>  "	.endm\n"
>  "	.macro	itt, cond\n"
> @@ -132,7 +134,9 @@ __asm__(
>  "	.macro	iteet, cond\n"
>  "	.endm\n"
>  "	.macro	iteee, cond\n"
> -"	.endm\n");
> +"	.endm\n"
> +"	.set	.L_it_macros_defined,1\n"
> +"	.endif");
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif	/* CONFIG_ARM_ASM_UNIFIED */
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
