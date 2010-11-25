From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Nov 2010 21:38:19 +0100
Subject: MX51: add FIQ support for TZIC
In-Reply-To: <20101125151909.GB19343@numbat.localnet>
References: <20101125151909.GB19343@numbat.localnet>
Message-ID: <20101125203819.GK4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 25, 2010 at 03:19:09PM +0000, Peter Horton wrote:
> Add support for FIQ on MX51 TZIC.
> 
> (patch is against Sascha's "imx-for-2.6.38" branch)
<nitpick>The comment about which tree this applies to isn't of interest
anymore when the patch is applied, so better write it after the triple
(eww, double?) dash below.  Then it won't make it into git.</nitpick>
 
> Signed-off-by: Peter Horton <phorton@bitbox.co.uk>
> 
> --
> 
Back some time I tried to achieve something similar.  IIRC my patch was
easier.  I definitly didn't patch entry-macro.S.  But OTOH I had some
problems with it so this might have been my problem.  I cannot find it
at the moment, will talk to Sascha tomorrow about it.

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
>  	cmp     \irqnr, #128
>  	blo     1000b
>  	b       2001f
> diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> index 3703ab2..b648a76 100644
> --- a/arch/arm/plat-mxc/tzic.c
> +++ b/arch/arm/plat-mxc/tzic.c
> @@ -47,6 +47,33 @@
>  
>  void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
>  
> +#ifdef CONFIG_FIQ
> +
> +/*
> + * switch interrupt between IRQ and FIQ mode.
> + *
> + * 'type' is true for FIQ mode and false for IRQ mode.
> + */
> +int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
> +{
> +	unsigned int index, mask, value;
> +
> +	index = irq >> 5;
> +	if (unlikely(index >= 4))
> +		return -EBUSY;
> +	mask = 1U << (irq & 0x1F);
> +
> +	value = __raw_readl(tzic_base + TZIC_INTSEC0(index));
> +	value = (value | mask) ^ (type ? mask : 0);
> +	__raw_writel(value, tzic_base + TZIC_INTSEC0(index));
Does this result in better code than the straigt forward

	value = __raw_readl(...) & ~mask;
	if (type)
		vale |= mask
	__raw_writel(...);

If not, what is the idea to write it this way?
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(mxc_set_irq_fiq);
Hmm, I guess this makes it impossible to compile avic.c and tzic.c with
FIQ=y into a single binary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
