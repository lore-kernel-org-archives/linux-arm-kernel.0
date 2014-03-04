From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Mar 2014 21:15:01 +0100 (CET)
Subject: [PATCH v2 RESEND 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <1391328466-30873-1-git-send-email-shc_work@mail.ru>
References: <1391328466-30873-1-git-send-email-shc_work@mail.ru>
Message-ID: <alpine.DEB.2.02.1403041957320.18573@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2 Feb 2014, Alexander Shiyan wrote:

> +static const struct {
> +#define CLPS711X_FLAG_EN	(1 << 0)
> +#define CLPS711X_FLAG_FIQ	(1 << 1)
> +	unsigned int	flags;
> +	phys_addr_t	eoi;
> +} clps711x_irqs[] = {
> +	[1]	= { CLPS711X_FLAG_FIQ, CLPS711X_BLEOI, },
> +	[3]	= { CLPS711X_FLAG_FIQ, CLPS711X_MCEOI, },
> +	[4]	= { CLPS711X_FLAG_EN, CLPS711X_COEOI, },
> +	[5]	= { CLPS711X_FLAG_EN, },
> +	[6]	= { CLPS711X_FLAG_EN, },
> +	[7]	= { CLPS711X_FLAG_EN, },
> +	[8]	= { CLPS711X_FLAG_EN, CLPS711X_TC1EOI, },
> +	[9]	= { CLPS711X_FLAG_EN, CLPS711X_TC2EOI, },
> +	[10]	= { CLPS711X_FLAG_EN, CLPS711X_RTCEOI, },
> +	[11]	= { CLPS711X_FLAG_EN, CLPS711X_TEOI, },
> +	[12]	= { CLPS711X_FLAG_EN, },
> +	[13]	= { CLPS711X_FLAG_EN, },
> +	[14]	= { CLPS711X_FLAG_EN, CLPS711X_UMSEOI, },
> +	[15]	= { CLPS711X_FLAG_EN, CLPS711X_SRXEOF, },
> +	[16]	= { CLPS711X_FLAG_EN, CLPS711X_KBDEOI, },
> +	[17]	= { CLPS711X_FLAG_EN, },
> +	[18]	= { CLPS711X_FLAG_EN, },
> +	[28]	= { CLPS711X_FLAG_EN, },
> +	[29]	= { CLPS711X_FLAG_EN, },
> +	[32]	= { CLPS711X_FLAG_FIQ, },

Is anything really using the FIQs on those clps711x machines?

If yes, I have no objections to export the no_action handler.

> +};

> +static void clps711x_intc_mask(struct irq_data *d)
> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(intmr);
> +	tmp &= ~(1 << (hwirq % 16));
> +	writel_relaxed(tmp, intmr);

Why can't you use a generic irq chip for all of this ?

Thanks,

	tglx
