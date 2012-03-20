From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 20:35:20 -0600
Subject: [PATCH v4 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <1331740593-10807-7-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-7-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F67ECE8.8030307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 09:56 AM, Thierry Reding wrote:
> This commit adds a generic PWM framework driver for the PWFM controller
> found on NVIDIA Tegra SoCs. The driver is based on code from the
> Chromium kernel tree and was originally written by Gary King (NVIDIA)
...
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
...
> +static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
> +	int rc = 0;
> +
> +	if (!pc->enable[pwm->hwpwm]) {

IIRC, the new PWM core only calls the enable() op for a disabled ->
enabled transition, so this driver probably doesn't need to check the
same thing, and you can get rid of tegra_pwm_chip.enable[] and have
tegra_pwm_config() read the enable flag from the core pwm device instead.

> +		rc = clk_enable(pc->clk);
> +		if (!rc) {
> +			unsigned long offset = pwm->hwpwm << 4;
> +			u32 val;
> +
> +			val = readl(pc->mmio_base + offset);
> +			val |= PWM_ENABLE;
> +			writel(val, pc->mmio_base + offset);

It seems a little of for the driver to define a pwm_writel() function
but only use it in some places but not others. I guess it's because in
some places the code knows the clock is on, so doesn't need the
clk_enable()/disable() helper in pwm_writel(), but I'd tend towards
always using pwm_readl()/pwm_writel() throughout the driver, and lifting
the clock management out of those low-level functions myself.

> +static int __devexit tegra_pwm_remove(struct platform_device *pdev)
> +{
> +	struct tegra_pwm_chip *pwm = platform_get_drvdata(pdev);
> +	int i;
> +
> +	if (WARN_ON(!pwm))
> +		return -ENODEV;
> +
> +	pwmchip_remove(&pwm->chip);
> +
> +	for (i = 0; i < NUM_PWM; i++) {
> +		pwm_writel(pwm, i, 0);
> +
> +		if (pwm->enable[i])
> +			clk_disable(pwm->clk);

Should the core call the disable() op before the remove() op so drivers
don't need to check this? I'm a little in two minds about this; if this
decision is deferred to drivers (as the code above assumes), then I
suppose the whole remove() path might be marginally more efficient.
