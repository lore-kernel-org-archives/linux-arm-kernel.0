From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Apr 2017 15:34:40 +0200
Subject: [PATCH] pwm: sun4i: switch to atomic PWM
In-Reply-To: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
References: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170428133440.sxeyrcmkqfwqg6fm@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/04/2017 at 00:00:02 +0200, Alexandre Belloni wrote:
> +static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
>  {
>  	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> -	u32 val;
> -	int ret;
> -
> -	ret = clk_prepare_enable(sun4i_pwm->clk);
> -	if (ret) {
> -		dev_err(chip->dev, "failed to enable PWM clock\n");
> -		return ret;
> +	struct pwm_state cstate;
> +	u32 ctrl;
> +	int delay_us, ret;
> +	bool needs_delay = false, prescaler_changed = false;
> +
> +	pwm_get_state(pwm, &cstate);
> +
> +	if (!cstate.enabled) {
> +		ret = clk_prepare_enable(sun4i_pwm->clk);
> +		if (ret) {
> +			dev_err(chip->dev, "failed to enable PWM clock\n");
> +			return ret;
> +		}
>  	}
>  
>  	spin_lock(&sun4i_pwm->ctrl_lock);
> -	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  
> -	if (polarity != PWM_POLARITY_NORMAL)
> -		val &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> -	else
> -		val |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> +	if ((cstate.period != state->period) ||
> +	    (cstate.duty_cycle != state->duty_cycle)) {
> +		u32 period, duty, val;
> +		unsigned int prescaler;
>  
> -	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +		needs_delay = true;
>  
> -	spin_unlock(&sun4i_pwm->ctrl_lock);
> -	clk_disable_unprepare(sun4i_pwm->clk);
> +		ret = sun4i_pwm_calculate(sun4i_pwm, state,
> +					  &duty, &period, &prescaler);
> +		if (ret) {
> +			dev_err(chip->dev, "period exceeds the maximum value\n");
> +			spin_unlock(&sun4i_pwm->ctrl_lock);
> +			if (!cstate.enabled)
> +				clk_disable_unprepare(sun4i_pwm->clk);
> +			return ret;
> +		}
>  
> -	return 0;
> -}
> +		if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
> +			prescaler_changed = true;
> +			/* Prescaler changed, the clock has to be gated */
> +			ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  
> -static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> -	u32 val;
> -	int ret;
> +			ctrl &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
> +			ctrl |= BIT_CH(prescaler, pwm->hwpwm);
> +		}
>  
> -	ret = clk_prepare_enable(sun4i_pwm->clk);
> -	if (ret) {
> -		dev_err(chip->dev, "failed to enable PWM clock\n");
> -		return ret;
> +		val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
> +		sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>  	}
>  
> -	spin_lock(&sun4i_pwm->ctrl_lock);
> -	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -	val |= BIT_CH(PWM_EN, pwm->hwpwm);
> -	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> -	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> -	spin_unlock(&sun4i_pwm->ctrl_lock);
> -
> -	return 0;
> -}
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> +	else
> +		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
> +
> +	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	if (state->enabled) {
> +		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
> +	} else if (!needs_delay) {
> +		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
> +		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	}
>  
> -static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> -	u32 val;
> +	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  
> -	spin_lock(&sun4i_pwm->ctrl_lock);
> -	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
> -	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> -	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
>  	spin_unlock(&sun4i_pwm->ctrl_lock);
>  
> -	clk_disable_unprepare(sun4i_pwm->clk);
> +	if (!needs_delay)
> +		return 0;
> +
> +	/* We need a full (previous) period to elapse before disabling the
> +	 * channel. If a ready bit is available, wait for it instead of waiting
> +	 * for a full period.
> +	 *
> +	 * If the new period is greater than the previous one, the prescaler may
> +	 * have changed and the previous period may go slower.
> +	 *
> +	 */
> +	delay_us = max(state->period / 1000 + 1, cstate.period / 1000 + 1);
> +	if ((cstate.enabled && !state->enabled) || !sun4i_pwm->data->has_rdy)

This condition doesn't always work as expected if the non atomic path is
used (using sysfs for example). I'll resubmit.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
