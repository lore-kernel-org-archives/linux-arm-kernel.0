From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Nov 2013 15:31:03 +0000
Subject: [PATCH v2 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <1384956732-19526-2-git-send-email-k.kozlowski@samsung.com>
References: <1384956732-19526-1-git-send-email-k.kozlowski@samsung.com>
 <1384956732-19526-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131120153103.GG2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 03:12:08PM +0100, Krzysztof Kozlowski wrote:

> +static irqreturn_t max14577_irq_thread(int irq, void *data)
> +{
> +	struct max14577 *max14577 = data;
> +	u8 irq_reg[MAX14577_IRQ_REGS_NUM] = {0};
> +	u8 tmp_irq_reg[MAX14577_IRQ_REGS_NUM] = {};
> +	int i, cur_irq;
> +
> +	max14577_bulk_read(max14577->regmap, MAX14577_REG_INT1,
> +			&tmp_irq_reg[MAX14577_IRQ_INT1],
> +			MAX14577_IRQ_REGS_NUM);

All this interrupt handling looks like a straight copy of the regmap
code?

> +int max14577_irq_resume(struct max14577 *max14577)
> +{
> +	int ret = 0;
> +
> +	if (max14577->irq && max14577->irq_domain)
> +		ret = max14577_irq_thread(0, max14577);

Are you sure that this is not going to race nastily if the interrupt
goes off during resume?

> +
> +	return ret >= 0 ? 0 : ret;

This check isn't a triumph of legibility.  

> +	if (IS_ERR_OR_NULL(pdata)) {
> +		dev_err(&i2c->dev, "No platform data found: %ld\n",
> +				PTR_ERR(pdata));
> +		return -EINVAL;
> +	}

Why IS_ERR_OR_NULL().

> +#else
> +#define max14577_suspend	NULL
> +#define max14577_resume		NULL
> +#endif /* CONFIG_PM */

You don't need these since you use SIMPLE_DEV_PM_OPS().

> +#else
> +#define max14577_dt_match	NULL
> +#endif

Similarly here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/7c4eabf3/attachment.sig>
