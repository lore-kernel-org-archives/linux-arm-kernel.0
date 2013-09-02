From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 2 Sep 2013 03:33:37 +0000
Subject: [PATCHv2 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20130830174909.GF30088@pengutronix.de>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-2-git-send-email-Li.Xiubo@freescale.com>
 <20130830174909.GF30088@pengutronix.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F785F@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct fsl_pwm_chip *fpc;
> > +	struct fsl_pwm_data *pwm_data;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
> > +	pwm_data = pwm_get_chip_data(pwm);
> > +	if (!pwm_data)
> > +		return;
> 
> THis check seems unnecessary.
> 

But if do not check it here, I must check it in the following code.

> > +
> > +	if (pwm_data->available != FSL_AVAILABLE)
> > +		return;
> > +

So the ' struct fsl_pwm_data' may be removed in the future.

> 
> > +
> > +
> > +	pwm_data->period_cycles = period_cycles;
> > +	pwm_data->duty_cycles = duty_cycles;
> 
> These fields are set but never read. Please drop them.
> 
> If you drop the 'available' field also the you can drop chip_data
> completely.
> 

I think I may move the 'available' field to the PWM driver data struct.

> > +
> > +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> > +
> > +	writel(0xF0, fpc->base + FTM_OUTMASK);
> > +	writel(0x0F, fpc->base + FTM_OUTINIT);
> > +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);
> > +
> > +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> > +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				enum pwm_polarity polarity)
> > +{
> > +	unsigned long reg;
> > +	struct fsl_pwm_data *pwm_data;
> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
> > +	pwm_data = pwm_get_chip_data(pwm);
> > +	if (!pwm_data)
> > +		return -EINVAL;
> > +
> > +	if (pwm_data->available != FSL_AVAILABLE)
> > +		return -EINVAL;
> > +
> > +	reg = readl(fpc->base + FTM_POL);
> > +	reg &= ~BIT(pwm->hwpwm);
> 
> Either drop this line...
> 

This is just for unmasking this bit field.
Here it's not needed, so I will revise it.

> > +	if (polarity == PWM_POLARITY_INVERSED)
> > +		reg |= BIT(pwm->hwpwm);
> > +	else
> > +		reg &= ~BIT(pwm->hwpwm);
> 
> ...or this one
> 

> > +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	int ret;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct pinctrl_state *pins_state;
> > +	struct fsl_pwm_data *pwm_data;
> > +	const char *statename;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
> > +	pwm_data = pwm_get_chip_data(pwm);
> > +	if (!pwm_data)
> > +		return -EINVAL;
> > +
> > +	if (pwm_data->available != FSL_AVAILABLE)
> > +		return -EINVAL;
> > +
> > +	statename = kasprintf(GFP_KERNEL, "ch%d-active", pwm->hwpwm);
> 
> You loose memory here and in fsl_pwm_disable aswell.
> 

Yes, I will revise it.

> > +	pins_state = pinctrl_lookup_state(fpc->pinctrl,
> > +			statename);
> > +	/* enable pins to be muxed in and configured */
> > +	if (!IS_ERR(pins_state)) {
> > +		ret = pinctrl_select_state(fpc->pinctrl, pins_state);
> > +		if (ret)
> > +			dev_warn(chip->dev, "could not set default pins\n");
> > +	} else
> > +		dev_warn(chip->dev, "could not get default pinstate\n");
> 
> Either it's ok to do without pinctrl or it's not ok, so either return an
> error or drop the warnings. Polluting the kernel log with such messages
> from a frequently called function is not a good idea.
> 

Well, I will just print out some error logs and return the error.

--
Best Regards.
Xiubo
