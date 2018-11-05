From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Nov 2018 14:25:30 -0500 (EST)
Subject: [PATCH 1/6] ARM: compressed: move sharpsl startup code into
 subroutine
In-Reply-To: <20181105184438.19494-2-ard.biesheuvel@linaro.org>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
 <20181105184438.19494-2-ard.biesheuvel@linaro.org>
Message-ID: <nycvar.YSQ.7.76.1811051413250.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Nov 2018, Ard Biesheuvel wrote:

> Instead of relying on unspecified linker behavior, move the
> SharpSL startup code into a subroutine and call it from the
> location we expect the linker to put the code.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
[...]
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -213,6 +213,9 @@ not_angel:
>  		 */
>  
>  		.text
> +#ifdef CONFIG_PXA_SHARPSL_DETECT_MACH_ID
> +		bl	__SharpSL_start
> +#endif

Independently from Russell's points, I don't like the above. that will 
turn into an ugly list of #ifdefs and machine specific calls. I think 
you should use:

		bl	__early_arch_specific_start

and somewhere else in head.S:

WEAK(__early_arch_specific_start)
		mov	pc, lr
ENDPROC(__early_arch_specific_start)

That would make this change more palatable.



Nicolas
