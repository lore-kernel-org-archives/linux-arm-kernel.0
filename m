From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 8 Oct 2014 09:45:25 +0200 (CEST)
Subject: [PATCH v3 7/9] irqchip/irq-mxs.c: add asm9260 support
In-Reply-To: <1412672123-16694-8-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
 <1412672123-16694-8-git-send-email-linux@rempel-privat.de>
Message-ID: <alpine.DEB.2.11.1410080919510.4292@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Oct 2014, Oleksij Rempel wrote:
> --- /dev/null
> +++ b/drivers/irqchip/alphascale,asm9260-icoll.h

Eew. We really can do without the comma in the filename.

> +struct icoll_priv {
> +	void __iomem *vector;
> +	void __iomem *levelack;
> +	void __iomem *ctrl;
> +	void __iomem *stat;
> +	void __iomem *intr;
> +	/* number of interrupts per register */
> +	int intr_reg_num;

So why on earth can't you find a name for this variable which reflects
its meaning? intr_per_reg would be pretty clear, but intr_reg_num is
just confusing as hell.

> +	void __iomem *clear;
> +};
> +
> +struct icoll_priv icoll_priv;

Why is this global?

>  static struct irq_domain *icoll_domain;
>  
> +static u32 icoll_intr_bitshift(struct irq_data *d, u32 bit)
> +{
> +	int n = icoll_priv.intr_reg_num - 1;

Newline between declaration and code.

> +	return bit << ((d->hwirq & n) << n);

I really had to twist my brain around this. A comment would be helpful
for the casual reader/reviewer.

> +}
> +
> +static void __iomem *icoll_intr_reg(struct irq_data *d)
> +{
> +	int n = icoll_priv.intr_reg_num;
> +	return icoll_priv.intr + ((d->hwirq / n) * 0x10);

See above. And aside of that, this should be implemented with a shift
to avoid a divide in the hot path.

> +}
> +
>  static void icoll_ack_irq(struct irq_data *d)
>  {
>  	/*
> @@ -51,19 +88,25 @@ static void icoll_ack_irq(struct irq_data *d)
>  	 * BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0 unconditionally.
>  	 */
>  	__raw_writel(BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0,
> -			icoll_base + HW_ICOLL_LEVELACK);
> +			icoll_priv.levelack);

The icoll_priv conversion of that code wants to be a separate
patch. First change existing code then add new functionality.

>  static void icoll_unmask_irq(struct irq_data *d)
>  {
> -	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
> -			icoll_base + HW_ICOLL_INTERRUPTn_SET(d->hwirq));
> +	if (!IS_ERR(icoll_priv.clear)) {

This is a horrible construct. Why isn't it sufficient to do

     if (icoll_priv.clear)

and initialize it to NULL for the IMX case?

> +	icoll_priv.clear	= ERR_PTR(-ENODEV);

Thanks,

	tglx
