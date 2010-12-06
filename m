From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Dec 2010 08:43:59 +0100
Subject: [PATCH] mx51: add support for FIQ on TZIC
In-Reply-To: <20101203161626.GA1149@porta-pete.localdomain>
References: <20101203161626.GA1149@porta-pete.localdomain>
Message-ID: <20101206074359.GR6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 04:16:26PM +0000, Peter Horton wrote:
> Add support for FIQ on mx51 TZIC
> 
> TZIC changes tested with FIQ audio on an mx51 board
> 
> AVIC changes build with mx3_defconfig, not tested
> 
> Signed-off-by: Peter Horton <phorton@bitbox.co.uk>
> 
> ---
> 
> Patch is against Sascha's "for-next" tree
> 
>  arch/arm/plat-mxc/Makefile                   |    2 +-
>  arch/arm/plat-mxc/avic.c                     |   32 ++++++++------
>  arch/arm/plat-mxc/include/mach/entry-macro.S |   11 +++++
>  arch/arm/plat-mxc/irq-common.c               |   60 ++++++++++++++++++++++++++
>  arch/arm/plat-mxc/irq-common.h               |   29 ++++++++++++
>  arch/arm/plat-mxc/tzic.c                     |   46 +++++++++++++++++---
>  6 files changed, 159 insertions(+), 21 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/irq-common.c
>  create mode 100644 arch/arm/plat-mxc/irq-common.h
> 
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 6aee27e..2f1b990 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y := clock.o gpio.o time.o devices.o cpu.o system.o
> +obj-y := clock.o gpio.o time.o devices.o cpu.o system.o irq-common.o
>  
>  # MX51 uses the TZIC interrupt controller, older platforms use AVIC
>  obj-$(CONFIG_MXC_TZIC) += tzic.o
> diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
> index 7331f2a..9a4e8a2 100644
> --- a/arch/arm/plat-mxc/avic.c
> +++ b/arch/arm/plat-mxc/avic.c
> @@ -24,6 +24,8 @@
>  #include <asm/mach/irq.h>
>  #include <mach/hardware.h>
>  
> +#include "irq-common.h"
> +
>  #define AVIC_INTCNTL		0x00	/* int control reg */
>  #define AVIC_NIMASK		0x04	/* int mask reg */
>  #define AVIC_INTENNUM		0x08	/* int enable number reg */
> @@ -46,9 +48,9 @@
>  
>  void __iomem *avic_base;
>  
> -int imx_irq_set_priority(unsigned char irq, unsigned char prio)
> -{
>  #ifdef CONFIG_MXC_IRQ_PRIOR
> +static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
> +{
>  	unsigned int temp;
>  	unsigned int mask = 0x0F << irq % 8 * 4;
>  
> @@ -62,14 +64,11 @@ int imx_irq_set_priority(unsigned char irq, unsigned char prio)
>  	__raw_writel(temp, avic_base + AVIC_NIPRIORITY(irq / 8));
>  
>  	return 0;
> -#else
> -	return -ENOSYS;
> -#endif
>  }
> -EXPORT_SYMBOL(imx_irq_set_priority);
> +#endif
>  
>  #ifdef CONFIG_FIQ
> -int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
> +static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
>  {
>  	unsigned int irqt;
>  
> @@ -87,7 +86,6 @@ int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(mxc_set_irq_fiq);
>  #endif /* CONFIG_FIQ */
>  
>  /* Disable interrupt number "irq" in the AVIC */
> @@ -102,10 +100,18 @@ static void mxc_unmask_irq(unsigned int irq)
>  	__raw_writel(irq, avic_base + AVIC_INTENNUM);
>  }
>  
> -static struct irq_chip mxc_avic_chip = {
> -	.ack = mxc_mask_irq,
> -	.mask = mxc_mask_irq,
> -	.unmask = mxc_unmask_irq,
> +static struct mxc_irq_chip mxc_avic_chip = {
> +	.base = {
> +		.ack = mxc_mask_irq,
> +		.mask = mxc_mask_irq,
> +		.unmask = mxc_unmask_irq,
> +	},
> +#ifdef CONFIG_MXC_IRQ_PRIOR
> +	.set_priority = avic_irq_set_priority,
> +#endif
> +#ifdef CONFIG_FIQ
> +	.set_irq_fiq = avic_set_irq_fiq,
> +#endif
>  };
>  
>  /*
> @@ -133,7 +139,7 @@ void __init mxc_init_irq(void __iomem *irqbase)
>  	__raw_writel(0, avic_base + AVIC_INTTYPEH);
>  	__raw_writel(0, avic_base + AVIC_INTTYPEL);
>  	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
> -		set_irq_chip(i, &mxc_avic_chip);
> +		set_irq_chip(i, &mxc_avic_chip.base);
>  		set_irq_handler(i, handle_level_irq);
>  		set_irq_flags(i, IRQF_VALID);
>  	}
> diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
> index aeb0869..c7dd4a9 100644
> --- a/arch/arm/plat-mxc/include/mach/entry-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
> @@ -54,8 +54,18 @@
>  #elif defined CONFIG_MXC_TZIC
>  	@ Load offset & priority of the highest priority
>  	@ interrupt pending.
> +	@ 0x080 is INTSEC0 register
>  	@ 0xD80 is HIPND0 register
>  	mov     \irqnr, #0
> +#ifdef CONFIG_FIQ
> +1000:
> +	add	\irqstat, \base, \irqnr, lsr #3
> +	ldr	\tmp, [\irqstat, #0xd80]
> +	ldr	\irqstat, [\irqstat, #0x080]
> +	ands	\tmp, \tmp, \irqstat
> +	bne	1001f
> +	add	\irqnr, \irqnr, #32
> +#else
>  	mov     \irqstat, #0x0D80
>  1000:
>  	ldr     \tmp,   [\irqstat, \base]
> @@ -63,6 +73,7 @@
>  	bne     1001f
>  	addeq   \irqnr, \irqnr, #32
>  	addeq   \irqstat, \irqstat, #4
> +#endif

Can't we skip the #ifdef? The CONFIG_FIQ path should also work without FIQs
enabled, right?

>  	cmp     \irqnr, #128
>  	blo     1000b
>  	b       2001f

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
