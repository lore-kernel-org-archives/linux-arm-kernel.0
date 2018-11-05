From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2018 19:00:30 +0000
Subject: [PATCH 3/6] ARM: compressed: move xscale startup code into
 subroutine
In-Reply-To: <20181105184438.19494-4-ard.biesheuvel@linaro.org>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
 <20181105184438.19494-4-ard.biesheuvel@linaro.org>
Message-ID: <20181105190030.GU30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 07:44:35PM +0100, Ard Biesheuvel wrote:
> Instead of relying on unspecified linker behavior, move the
> XScale startup code into a subroutine and call it from the
> location we expect the linker to put the code.

Same as patch 1, I don't think this is warranted.

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/boot/compressed/head-xscale.S | 7 ++++---
>  arch/arm/boot/compressed/head.S        | 3 +++
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head-xscale.S b/arch/arm/boot/compressed/head-xscale.S
> index 20fa44d59f82..89e14a55ec3d 100644
> --- a/arch/arm/boot/compressed/head-xscale.S
> +++ b/arch/arm/boot/compressed/head-xscale.S
> @@ -8,10 +8,9 @@
>  
>  #include <linux/linkage.h>
>  
> -		.section        ".start", "ax"
> -
> -__XScale_start:
> +		.text
>  
> +ENTRY(__XScale_start)
>  		@ Preserve r8/r7 i.e. kernel entry values
>  
>  		@ Data cache might be active.
> @@ -33,3 +32,5 @@ __XScale_start:
>  		bic	r0, r0, #0x1000		@ clear Icache
>  		mcr	p15, 0, r0, c1, c0, 0
>  
> +		mov	pc, lr
> +ENDPROC(__XScale_start)
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index c5355f929cee..da93f419d1f4 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -219,6 +219,9 @@ not_angel:
>  #ifdef CONFIG_ARCH_SA1100
>  		bl	__SA1100_start
>  #endif
> +#ifdef CONFIG_CPU_XSCALE
> +		bl	__XScale_start
> +#endif
>  
>  #ifdef CONFIG_AUTO_ZRELADDR
>  		/*
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
