From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 18 Mar 2014 22:52:32 +0100
Subject: [PATCH v3 2/5] pwm: kona: Introduce Kona PWM controller support
In-Reply-To: <1394655346-30048-3-git-send-email-tim.kryger@linaro.org>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <1394655346-30048-3-git-send-email-tim.kryger@linaro.org>
Message-ID: <20140318215231.GH5917@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:15:43PM -0700, Tim Kryger wrote:
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 22f2f28..1fd42af 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -62,6 +62,16 @@ config PWM_ATMEL_TCB
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel-tcb.
>  
> +config PWM_BCM_KONA
> +	tristate "Kona PWM support"
> +	depends on ARCH_BCM_MOBILE
> +	default y

No "default y", please.

> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
[...]
> +static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
> +{
> +	unsigned long value = readl(kp->base + PWM_CONTROL_OFFSET);
> +
> +	/*
> +	 * New duty and period settings are only reflected in the PWM output
> +	 * after a rising edge of the enable bit.  When smooth bit is set, the
> +	 * new settings are delayed until the prior PWM period has completed.
> +	 * Furthermore, if the smooth bit is set, the PWM continues to output a
> +	 * waveform based on the old settings during the time that the enable
> +	 * bit is low.  Otherwise the output is a constant high signal while
> +	 * the enable bit is low.
> +	 */
> +
> +	/* clear enable bit but set smooth bit to maintain old output */
> +	value |= (1 << PWM_CONTROL_SMOOTH_SHIFT(chan));

There's no need for the parentheses here.

> +	value &= ~(1 << PWM_CONTROL_ENABLE_SHIFT(chan));
> +	writel(value, kp->base + PWM_CONTROL_OFFSET);
> +
> +	/* set enable bit and clear smooth bit to apply new settings */
> +	value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
> +	value |= (1 << PWM_CONTROL_ENABLE_SHIFT(chan));

Nor here.

> +	writel(value, kp->base + PWM_CONTROL_OFFSET);

I'm curious about how this work. The above writes the control register
once with smooth set and enable cleared, then immediately rewrites it
again with smooth cleared and enable set. Are these writes somehow
queued in hardware, so that the subsequent write becomes active only
after the current period?

> +static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +				int duty_ns, int period_ns)

Please align arguments on subsequent lines with those on the first line.

> +{
> +	struct kona_pwmc *kp = dev_get_drvdata(chip->dev);

The proper way to do this would be upcasting using container_of().
Better yet, define a static inline function that wraps container_of(),
just like very other driver does.

> +	u64 val, div, clk_rate;
> +	unsigned long prescale = PRESCALE_MIN, pc, dc;
> +	unsigned int value, chan = pwm->hwpwm;
> +
> +	/*
> +	 * Find period count, duty count and prescale to suit duty_ns and
> +	 * period_ns. This is done according to formulas described below:
> +	 *
> +	 * period_ns = 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
> +	 * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
> +	 *
> +	 * PC = (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
> +	 * DC = (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
> +	 */
> +
> +	clk_rate = clk_get_rate(kp->clk);

"rate" is 50% shorter and would do equally well.

> +
> +	/* There is polarity support in HW but it is easier to manage in SW */
> +	if (pwm->polarity == PWM_POLARITY_INVERSED)
> +		duty_ns = period_ns - duty_ns;

No, this is wrong. You're not actually changing the *polarity* here.

Also I think this is missing a pair of clk_prepare_enable() and
clk_disable_unprepare().

> +static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +				  enum pwm_polarity polarity)
> +{
> +	/*
> +	 * The framework only allows the polarity to be changed when a PWM is
> +	 * disabled so no immediate action is required here.  When a channel is
> +	 * enabled, the polarity gets handled as part of the re-config step.
> +	 */
> +
> +	return 0;
> +}

See above. If you don't want to implement the hardware support for
inversed polarity, then simply don't implement this.

> +static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct kona_pwmc *kp = dev_get_drvdata(chip->dev);
> +	int ret;
> +
> +	/*
> +	 * The PWM framework does not clear the enable bit in the flags if an
> +	 * error is returned from a PWM driver's enable function so it must be
> +	 * cleared here if any trouble is encountered.
> +	 */
> +
> +	ret = clk_prepare_enable(kp->clk);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
> +		clear_bit(PWMF_ENABLED, &pwm->flags);

You're not supposed to touch these. This is a bug in the core, and it
should be fixed in the core.

> +		return ret;
> +	}
> +
> +	ret = kona_pwmc_config(chip, pwm, pwm->duty_cycle, pwm->period);
> +	if (ret < 0) {
> +		clk_disable_unprepare(kp->clk);
> +		clear_bit(PWMF_ENABLED, &pwm->flags);
> +		return ret;
> +	}

Why are you doing this? .config() should be setting everything up
according to the given duty cycle and period and .enable() should only
be enabling a specific channel. Please don't conflate the two.

> +static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct kona_pwmc *kp = dev_get_drvdata(chip->dev);
> +	unsigned int chan = pwm->hwpwm;
> +
> +	/*
> +	 * The "enable" bits in the control register only affect when settings
> +	 * start to take effect so the only real way to disable the PWM output
> +	 * is to program a zero duty cycle.
> +	 */

What's wrong about waiting for the settings to take effect? There's
nothing about disable that says it should happen *immediately*.

> +
> +	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> +	kona_pwmc_apply_settings(kp, chan);
> +
> +	/*
> +	 * When the PWM clock is disabled, the output is pegged high or low
> +	 * depending on its state at that instant.  To guarantee that the new
> +	 * settings have taken effect and the output is low a delay of 400ns is
> +	 * required.
> +	 */
> +
> +	ndelay(400);

Where does this number come from?

> +static int kona_pwmc_probe(struct platform_device *pdev)
> +{
> +	struct kona_pwmc *kp;
> +	struct resource *res;
> +	unsigned int chan, value;
[...]
> +	/* Set smooth mode, push/pull, and normal polarity for all channels */
> +	for (value = 0, chan = 0; chan < kp->chip.npwm; chan++) {

Can't you initialize value to 0 when you declare it? That way the for
loop becomes much more idiomatic.

> +		value |= (1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
> +		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
> +		value |= (1 << PWM_CONTROL_POLARITY_SHIFT(chan));
> +	}
> +	writel(value, kp->base + PWM_CONTROL_OFFSET);

I'd prefer a blank line between the above two for readability.

> +static struct platform_driver kona_pwmc_driver = {
> +

Gratuitous blank line.

> +	.driver = {
> +		.name = "bcm-kona-pwm",
> +		.of_match_table = bcm_kona_pwmc_dt,
> +	},
> +	.probe = kona_pwmc_probe,
> +	.remove = kona_pwmc_remove,
> +};
> +

And here.

> +module_platform_driver(kona_pwmc_driver);
> +
> +MODULE_AUTHOR("Broadcom Corporation <bcm-kernel-feedback-list@broadcom.com>");
> +MODULE_AUTHOR("Tim Kryger <tkryger@broadcom.com>");
> +MODULE_DESCRIPTION("Driver for Kona PWM controller");

Perhaps "Broadcom Kona PWM"?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/b399d44c/attachment.sig>
