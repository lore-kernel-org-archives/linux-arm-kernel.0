From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2018 19:00:07 +0000
Subject: [PATCH 2/6] ARM: compressed: move sa1100 startup code into
 subroutine
In-Reply-To: <20181105184438.19494-3-ard.biesheuvel@linaro.org>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
 <20181105184438.19494-3-ard.biesheuvel@linaro.org>
Message-ID: <20181105190007.GT30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 07:44:34PM +0100, Ard Biesheuvel wrote:
> Instead of relying on unspecified linker behavior, move the
> SA1100 startup code into a subroutine and call it from the
> location we expect the linker to put the code.

Same comments as patch 1, I don't think this is warranted.

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/boot/compressed/head-sa1100.S | 9 +++++----
>  arch/arm/boot/compressed/head.S        | 3 +++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head-sa1100.S b/arch/arm/boot/compressed/head-sa1100.S
> index 95abdd850fe3..89a7e9dfd5c0 100644
> --- a/arch/arm/boot/compressed/head-sa1100.S
> +++ b/arch/arm/boot/compressed/head-sa1100.S
> @@ -4,18 +4,17 @@
>   * 
>   * Copyright (C) 1999 Nicolas Pitre <nico@fluxnic.net>
>   * 
> - * SA1100 specific tweaks.  This is merged into head.S by the linker.
> + * SA1100 specific tweaks.
>   *
>   */
>  
>  #include <linux/linkage.h>
>  #include <asm/mach-types.h>
>  
> -		.section        ".start", "ax"
> +		.text
>  		.arch	armv4
>  
> -__SA1100_start:
> -
> +ENTRY(__SA1100_start)
>  		@ Preserve r8/r7 i.e. kernel entry values
>  #ifdef CONFIG_SA1100_COLLIE
>  		mov	r7, #MACH_TYPE_COLLIE
> @@ -47,3 +46,5 @@ __SA1100_start:
>  		bic	r0, r0, #0x1000		@ clear Icache
>  		mcr	p15, 0, r0, c1, c0, 0
>  99:
> +		mov	pc, lr
> +ENDPROC(__SA1100_start)
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 5067f287fa5a..c5355f929cee 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -216,6 +216,9 @@ not_angel:
>  #ifdef CONFIG_PXA_SHARPSL_DETECT_MACH_ID
>  		bl	__SharpSL_start
>  #endif
> +#ifdef CONFIG_ARCH_SA1100
> +		bl	__SA1100_start
> +#endif
>  
>  #ifdef CONFIG_AUTO_ZRELADDR
>  		/*
> -- 
> 2.19.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
