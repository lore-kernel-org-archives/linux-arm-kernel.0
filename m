From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Nov 2013 11:31:49 +0100
Subject: [PATCH v2 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <20131120153103.GG2674@sirena.org.uk>
References: <1384956732-19526-1-git-send-email-k.kozlowski@samsung.com>
 <1384956732-19526-2-git-send-email-k.kozlowski@samsung.com>
 <20131120153103.GG2674@sirena.org.uk>
Message-ID: <1385029909.26695.5.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 15:31 +0000, Mark Brown wrote:
> On Wed, Nov 20, 2013 at 03:12:08PM +0100, Krzysztof Kozlowski wrote:
> 
> > +static irqreturn_t max14577_irq_thread(int irq, void *data)
> > +{
> > +	struct max14577 *max14577 = data;
> > +	u8 irq_reg[MAX14577_IRQ_REGS_NUM] = {0};
> > +	u8 tmp_irq_reg[MAX14577_IRQ_REGS_NUM] = {};
> > +	int i, cur_irq;
> > +
> > +	max14577_bulk_read(max14577->regmap, MAX14577_REG_INT1,
> > +			&tmp_irq_reg[MAX14577_IRQ_INT1],
> > +			MAX14577_IRQ_REGS_NUM);
> 
> All this interrupt handling looks like a straight copy of the regmap
> code?

You are right, I will convert it to regmap_irq_chip.

> > +int max14577_irq_resume(struct max14577 *max14577)
> > +{
> > +	int ret = 0;
> > +
> > +	if (max14577->irq && max14577->irq_domain)
> > +		ret = max14577_irq_thread(0, max14577);
> 
> Are you sure that this is not going to race nastily if the interrupt
> goes off during resume?

I believe this code came from max77693. At least it looks very similar.
Also it seems it was a fast workaround for interrupt occurring during
device resume (before I2C bus resume). Handling this interrupt failed
and interrupt registers were not cleared.

This code is not needed now, especially after using regmap IRQ handling.

> 
> > +
> > +	return ret >= 0 ? 0 : ret;
> 
> This check isn't a triumph of legibility.  

OK.

> 
> > +	if (IS_ERR_OR_NULL(pdata)) {
> > +		dev_err(&i2c->dev, "No platform data found: %ld\n",
> > +				PTR_ERR(pdata));
> > +		return -EINVAL;
> > +	}
> 
> Why IS_ERR_OR_NULL().

Right, it should be just check for null.

> 
> > +#else
> > +#define max14577_suspend	NULL
> > +#define max14577_resume		NULL
> > +#endif /* CONFIG_PM */
> 
> You don't need these since you use SIMPLE_DEV_PM_OPS().

OK.

> 
> > +#else
> > +#define max14577_dt_match	NULL
> > +#endif
> 
> Similarly here.

OK.

Thanks for comments.

Best regards,
Krzysztof
