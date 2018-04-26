From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 26 Apr 2018 19:48:43 +0200
Subject: [PATCH v4 1/6] ARM: at91: add TCB registers definitions
In-Reply-To: <20180426165242.x5pvpyfirkmvvqjo@breakpoint.cc>
References: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
 <20180418105143.3577-2-alexandre.belloni@bootlin.com>
 <20180426165242.x5pvpyfirkmvvqjo@breakpoint.cc>
Message-ID: <20180426174843.GT4813@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/2018 18:52:43+0200, Sebastian Andrzej Siewior wrote:
> On 2018-04-18 12:51:38 [+0200], Alexandre Belloni wrote:
> > diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> > new file mode 100644
> > index 000000000000..d263ea677225
> > --- /dev/null
> > +++ b/include/soc/at91/atmel_tcb.h
> ?
> > +static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
> > +{
> > +	struct clk *clk;
> > +	char clk_name[] = "t0_clk";
> > +
> > +	clk_name[1] += channel;
> > +	clk = of_clk_get_by_name(node->parent, clk_name);
> > +	if (!IS_ERR(clk))
> > +		return clk;
> > +
> > +	return of_clk_get_by_name(node->parent, "t0_clk");
> > +}
> > +
> > +static inline int tcb_irq_get(struct device_node *node, int channel)
> > +{
> > +	int irq;
> > +
> > +	irq = of_irq_get(node->parent, channel);
> > +	if (irq > 0)
> > +		return irq;
> > +
> > +	return of_irq_get(node->parent, 0);
> > +}
> > +
> > +static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> > +
> > +struct atmel_tcb_info {
> > +	int bits;
> > +};
> > +
> > +static const struct atmel_tcb_info atmel_tcb_infos[] = {
> > +	{ .bits = 16 },
> > +	{ .bits = 32 },
> > +};
> > +
> > +static const struct of_device_id atmel_tcb_dt_ids[] = {
> > +	{
> > +		.compatible = "atmel,at91rm9200-tcb",
> > +		.data = &atmel_tcb_infos[0],
> > +	}, {
> > +		.compatible = "atmel,at91sam9x5-tcb",
> > +		.data = &atmel_tcb_infos[1],
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> 
> After the series is applied, I see only one user of that file. The data
> structures don't look like they belong here. Same goes for the static
> inline of the code above.
> 

There is another user coming later (the pwm driver) but I didn't repost,
I'll do so after this series is applied.

> > +#endif /* __SOC_ATMEL_TCB_H */
> 
> Sebastian

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
