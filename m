From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 13:21:50 +0100
Subject: [PATCH 6/6] ARM: ux500: get rid of <mach/[hardware|db8500-regs].h>
In-Reply-To: <1363866553-15054-7-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-7-git-send-email-linus.walleij@stericsson.com>
Message-ID: <18952950.WVCFaaGPFa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013 12:49:13 Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This removes <mach/hardware.h> and <mach/db8500-regs.h>
> from the Ux500, merging them into the local include
> "db8500-regs.h" in mach-ux500. There is some impact
> outside the ux500 machine, but most of it is dealt with
> in earlier patches.

Nice

> diff --git a/arch/arm/include/debug/ux500.S b/arch/arm/include/debug/ux500.S
> index 6703522..2848857 100644
> --- a/arch/arm/include/debug/ux500.S
> +++ b/arch/arm/include/debug/ux500.S
> @@ -8,7 +8,7 @@
>   * published by the Free Software Foundation.
>   *
>   */
> -#include <mach/hardware.h>
> +
>  
>  #if CONFIG_UX500_DEBUG_UART > 2
>  #error Invalid Ux500 debug UART
> @@ -21,19 +21,28 @@
>   */
>  
>  #ifdef CONFIG_UX500_SOC_DB8500
> -#define __UX500_UART(n)	U8500_UART##n##_BASE
> +#define U8500_UART0_PHYS_BASE	(0x80120000)
> +#define U8500_UART1_PHYS_BASE	(0x80121000)
> +#define U8500_UART2_PHYS_BASE	(0x80007000)
> +#define U8500_UART0_VIRT_BASE	(0xa8120000)
> +#define U8500_UART1_VIRT_BASE	(0xa8121000)
> +#define U8500_UART2_VIRT_BASE	(0xa8007000)
> +#define __UX500_PHYS_UART(n)	U8500_UART##n##_PHYS_BASE
> +#define __UX500_VIRT_UART(n)	U8500_UART##n##_VIRT_BASE
>  #endif
>  
> -#ifndef __UX500_UART
> +#if !defined(__UX500_PHYS_UART) || !defined(__UX500_VIRT_UART)
>  #error Unknown SOC
>  #endif
>  
> -#define UX500_UART(n)	__UX500_UART(n)
> -#define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
> +#define UX500_PHYS_UART(n)	__UX500_PHYS_UART(n)
> +#define UX500_VIRT_UART(n)	__UX500_VIRT_UART(n)
> +#define UART_PHYS_BASE	UX500_PHYS_UART(CONFIG_UX500_DEBUG_UART)
> +#define UART_VIRT_BASE	UX500_VIRT_UART(CONFIG_UX500_DEBUG_UART)
>  
>  	.macro	addruart, rp, rv, tmp
> -	ldr	\rp, =UART_BASE				@ no, physical address
> -	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
> +	ldr	\rp, =UART_PHYS_BASE		@ no, physical address
> +	ldr	\rv, =UART_VIRT_BASE		@ yes, virtual address
>  	.endm
>  
>  #include <asm/hardware/debug-pl01x.S>

I would suggest splitting this change out into a separate patch, or
folding it into the one that creates the ux500.S file.

> diff --git a/arch/arm/mach-ux500/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
> new file mode 100644
> index 0000000..b2d7a0b
> --- /dev/null
> +++ b/arch/arm/mach-ux500/db8500-regs.h
> @@ -0,0 +1,201 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */

Did you forget to pass '-M' to git-format-patch?

You can set 'git config diff.renames true' to get this right in the future.

> @@ -228,6 +228,12 @@ static struct resource db8500_prcmu_res[] = {
>  		.end   = U8500_PRCMU_TCPM_BASE + SZ_4K - 1,
>  		.flags = IORESOURCE_MEM,
>  	},
> +	{
> +		.name  = "gic-distbase",
> +		.start = U8500_GIC_DIST_BASE,
> +		.end   = U8500_GIC_DIST_BASE + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
>  };
>  
>  struct platform_device db8500_prcmu_device = {

Was this meant to have been in a different patch? I don't see what it does here.

	Arnd
