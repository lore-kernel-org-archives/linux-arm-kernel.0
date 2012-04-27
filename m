From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 27 Apr 2012 13:06:20 -0600
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <1335515957-1798-4-git-send-email-haojian.zhuang@gmail.com>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20120427190620.D3C313E0B4D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Apr 2012 16:39:11 +0800, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> Append new interrupt driver that could support both pxa168 and mmp2
> silicon. And this driver supports device tree.
> 
> Since CONFIG_SPARSE_IRQ is enabled in arch-mmp, irq driver should
> handle reserved NR_IRQS_LEGACY in irq domain.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-mmp/Makefile                   |    2 +-
>  arch/arm/mach-mmp/include/mach/entry-macro.S |    9 +
>  arch/arm/mach-mmp/irq.c                      |  287 ++++++++++++++++++++++++++

It shouldn't be necessary to create an entirely new irq controller
driver that duplicates the functionality of irq-mmp2.c and
irq-pxa168.c.  Instead, the existing drivers should be refactored to
work with both DT and non-DT user.

> diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
> index 9cff9e7..6b9d925 100644
> --- a/arch/arm/mach-mmp/include/mach/entry-macro.S
> +++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
> @@ -6,13 +6,19 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <asm/irq.h>
>  #include <mach/regs-icu.h>
>  
>  	.macro	get_irqnr_preamble, base, tmp
>  	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
>  	and	\tmp, \tmp, #0xff00
>  	cmp	\tmp, #0x5800
> +#ifdef CONFIG_OF
> +	ldr	\base, =mmp_icu_base
> +	ldr	\base, [\base, #0]
> +#else
>  	ldr	\base, =ICU_VIRT_BASE
> +#endif
>  	addne	\base, \base, #0x10c		@ PJ1 AP INT SEL register
>  	addeq	\base, \base, #0x104		@ PJ4 IRQ SEL register
>  	.endm
> @@ -20,5 +26,8 @@
>  	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
>  	ldr	\tmp, [\base, #0]
>  	and	\irqnr, \tmp, #0x3f
> +#ifdef CONFIG_OF
> +	add	\irqnr, \irqnr, #NR_IRQS_LEGACY
> +#endif

What do these do?  Does turning on CONFIG_OF break booting with atags?
If so then this will need to be reworked.  CONFIG_OF must not disable
non-devicetree usage.

g.
