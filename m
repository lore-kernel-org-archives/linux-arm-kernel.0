From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 5 Jun 2014 15:50:12 -0400 (EDT)
Subject: [RFC v3 3/9] irqchip: gic: Provide support for interrupt grouping
In-Reply-To: <1401961994-18033-4-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.LFD.2.11.1406051545380.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Jun 2014, Daniel Thompson wrote:

> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 57d165e..aa8efe4 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -408,13 +408,27 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  		writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
>  
>  	/*
> +	 * Set all global interrupts to be group 1.
> +	 *
> +	 * If grouping is not available (not implemented or prohibited by
> +	 * security mode) these registers a read-as-zero/write-ignored.
> +	 */
> +	for (i = 32; i < gic_irqs; i += 32)
> +		writel_relaxed(0xffffffff, base + GIC_DIST_IGROUP + i * 4 / 32);
> +
> +	/*
>  	 * Disable all interrupts.  Leave the PPI and SGIs alone
>  	 * as these enables are banked registers.
>  	 */
>  	for (i = 32; i < gic_irqs; i += 32)
>  		writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
>  
> -	writel_relaxed(1, base + GIC_DIST_CTRL);
> +	/*
> +	 * Set EnableGrp1/EnableGrp0 (bit 1 and 0) or EnableGrp (bit 0 only,
> +	 * bit 1 ignored)
> +	 */
> +	writel_relaxed(GIC_DIST_CTRL_ENABLE_GRP0_BIT |
> +		       GIC_DIST_CTRL_ENABLE_GRP1_BIT, base + GIC_DIST_CTRL);

Could there be more meaningful defines than GIC_DIST_CTRL_ENABLE_GRP0_BIT
and GIC_DIST_CTRL_ENABLE_GRP1_BIT for those bits?  Otherwise the code 
would look just as clear and possibly cleaner by simply using 0x3.


Nicolas
