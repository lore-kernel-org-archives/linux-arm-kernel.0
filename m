From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 03 Sep 2009 15:15:48 +0100
Subject: [PATCH 1/2] AB3100 regulator support v4
In-Reply-To: <1251982396-23790-1-git-send-email-linus.walleij@stericsson.com>
References: <1251982396-23790-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1251987348.6735.49.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-09-03 at 14:53 +0200, Linus Walleij wrote:
> This adds support for the regulators found in the AB3100
> Mixed-Signal IC.
> 
> It further also defines platform data for the ST-Ericsson
> U300 platform and extends the AB3100 MFD driver so that
> platform/board data with regulation constraints and an init
> function can be passed down all the way from the board to
> the regulators.
> 

<snip>

> +static int ab3100_disable_regulator(struct regulator_dev *reg)
> +{
> +	struct ab3100_regulator *abreg = reg->reg_data;
> +	int err;
> +	u8 regval;
> +
> +	/*
> +	 * LDO D is a special regulator. When it is disabled, the entire
> +	 * system is shut down. So this is handled specially.
> +	 */
> +	if (abreg->regreg == AB3100_LDO_D) {
> +		int i;
> +
> +		dev_info(&reg->dev, "disabling LDO D - shut down system\n");
> +		/*
> +		 * Set regulators to default values, ignore any errors,
> +		 * we're going DOWN
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(ab3100_reg_init_order); i++) {
> +			(void) ab3100_set_register_interruptible(abreg->ab3100,
> +					ab3100_reg_init_order[i],
> +					abreg->plfdata->reg_initvals[i]);
> +		}
> +
> +		/* Setting LDO D to 0x00 cuts the power to the SoC */
> +		return ab3100_set_register_interruptible(abreg->ab3100,
> +							 AB3100_LDO_D, 0x00U);
> +
> +	}
> +
> +	/*
> +	 * All other regulators are handled here
> +	 */
> +	err = ab3100_get_register_interruptible(abreg->ab3100, abreg->regreg,
> +						&regval);
> +	if (err) {
> +		dev_err(&reg->dev, "unable to get register 0x%x\n",
> +			abreg->regreg);
> +		return err;
> +	}
> +	regval &= ~AB3100_REG_ON_MASK;
> +	return ab3100_set_register_interruptible(abreg->ab3100, abreg->regreg,
> +						 regval);
> +}

Just wondering if you had looked at the regulator supplier field in
struct regulator_init_data. It's intention was to allow LDO D to be
switched OFF only when all it's consumer regulators were OFF. Likewise
it would also switch this regulator ON if any of it's children were
switched ON.

I assume for this PMIC it would not be useful as it looks like this LDO
is supplying all other PMIC regulators and is ultimately being used as
master power ON/OFF switch ? 

Samuel, are you happy for this to go via mfd for simpler merging ?
If so :-

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

Thanks

Liam
