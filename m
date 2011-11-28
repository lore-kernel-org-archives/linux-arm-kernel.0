From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Nov 2011 10:40:12 +0000
Subject: [PATCH v2 1/4] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <20111125161500.GD2098@localhost.localdomain>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <1322060508-11298-2-git-send-email-pawel.moll@arm.com>
 <20111125161500.GD2098@localhost.localdomain>
Message-ID: <1322476812.3164.13.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-11-25 at 16:15 +0000, Dave Martin wrote:
> Try this (untested):
> 
> diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> index d397a1f..0be2efc 100644
> --- a/arch/arm/plat-versatile/headsmp.S
> +++ b/arch/arm/plat-versatile/headsmp.S
> @@ -28,6 +28,7 @@ ENTRY(versatile_secondary_startup)
>  pen:   ldr     r7, [r6]
>         cmp     r7, r0
>         bne     pen
> +ENDPROC(versatile_secondary_startup)
> 
>         /*
>          * we've been released from the holding pen: secondary_stack
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 2b5f7ac..124ffb1 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -13,8 +13,6 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
> 
> -#include <asm/unified.h>
> -
>  #include <mach/motherboard.h>
>  #define V2M_PA_CS7 0x10000000
> 
> @@ -46,6 +44,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>          * secondary CPU branches to this address.
>          */
>         writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
> -       writel(BSYM(virt_to_phys(versatile_secondary_startup)),
> +       writel(virt_to_phys(versatile_secondary_startup),
>                 MMIO_P2V(V2M_SYS_FLAGSSET));
>  }

Sure thing, will try that.

Cheers!

Pawe?
