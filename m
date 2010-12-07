From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Dec 2010 14:48:19 +0000
Subject: [PATCHv2] support PMIC mc13892
In-Reply-To: <1291708905-23645-1-git-send-email-b00984@freescale.com>
References: <1291708905-23645-1-git-send-email-b00984@freescale.com>
Message-ID: <20101207144818.GB9689@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 04:01:45PM +0800, b00984 at freescale.com wrote:

> +	mc13xxx_lock(priv->mc13xxx);
> +	ret = mc13xxx_reg_read(priv->mc13xxx,
> +				mc13892_regulators[id].vsel_reg, &val);
> +	mc13xxx_unlock(priv->mc13xxx);
> +	if (ret)
> +		return ret;
> +
> +	hi  = val & MC13892_SWITCHERS0_SWxHI;
> +	if (value > 1375)
> +		hi = 1;
> +	if (value < 1100)
> +		hi = 0;
> +
> +	if (hi) {
> +		value = (value - 1100000) / 25000;
> +		value |= MC13892_SWITCHERS0_SWxHI;
> +	} else
> +		value = (value - 600000) / 25000;
> +
> +	mask = mc13892_regulators[id].vsel_mask | MC13892_SWITCHERS0_SWxHI;
> +	mc13xxx_lock(priv->mc13xxx);
> +	ret = mc13xxx_reg_rmw(priv->mc13xxx, mc13892_regulators[id].vsel_reg,
> +			mask,
> +			value << mc13892_regulators[id].vsel_shift);
> +	mc13xxx_unlock(priv->mc13xxx);

This section here reads like it's all one big read/modify/write cycle
and therefore the mutex ought to be held throughout?  

Otherwise the patch looks good.
