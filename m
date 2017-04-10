From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 10 Apr 2017 16:35:58 +0200
Subject: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
In-Reply-To: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170410163558.494cf9be@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Apr 2017 17:20:20 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Implement suspend and resume power management specific
> function to allow PWM controller to correctly suspend
> and resume.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 530d7dc..75177c6 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -58,6 +58,8 @@
>  #define PWM_MAX_PRD		0xFFFF
>  #define PRD_MAX_PRES		10
>  
> +#define PWM_MAX_CH_NUM		(4)
> +
>  struct atmel_pwm_registers {
>  	u8 period;
>  	u8 period_upd;
> @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
>  	u8 duty_upd;
>  };
>  
> +struct atmel_pwm_pm_ctx {
> +	u32 cmr;
> +	u32 cdty;
> +	u32 cprd;
> +};
> +
>  struct atmel_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	void __iomem *base;
>  	const struct atmel_pwm_registers *regs;
> +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];

Hm, I'm pretty sure you can rely on the current PWM state and call
atmel_pwm_apply() at resume time instead of doing that. See what I did
here [1].

Thierry, maybe it's time to start thinking about a generic solution to
save/restore PWM states.

>  
>  	unsigned int updated_pwms;
>  	/* ISR is cleared when read, ensure only one thread does that */
> @@ -333,6 +342,77 @@ atmel_pwm_get_driver_data(struct platform_device *pdev)
>  	return (struct atmel_pwm_registers *)id->driver_data;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int atmel_pwm_suspend(struct device *dev)
> +{
> +	struct atmel_pwm_chip *atmel_pwm = dev_get_drvdata(dev);
> +	struct pwm_device *pwm = atmel_pwm->chip.pwms;
> +	int i;
> +	bool disable_clk = false;
> +
> +	for (i = 0; i < atmel_pwm->chip.npwm; i++, pwm++) {
> +		if (!pwm_is_enabled(pwm))
> +			continue;
> +
> +		disable_clk = true;
> +		atmel_pwm->ctx[i].cdty =
> +			atmel_pwm_ch_readl(atmel_pwm, i,
> +					   atmel_pwm->regs->duty);
> +		atmel_pwm->ctx[i].cprd =
> +			atmel_pwm_ch_readl(atmel_pwm, i,
> +					   atmel_pwm->regs->period);
> +		atmel_pwm->ctx[i].cmr =
> +			atmel_pwm_ch_readl(atmel_pwm, i, PWM_CMR);
> +
> +		atmel_pwm_disable(&atmel_pwm->chip, pwm, false);
> +	}
> +
> +	if (disable_clk)
> +		clk_disable(atmel_pwm->clk);

I'm not so sure we want to disable the PWM and the PWM chip clk when
entering suspend. What if the PWM is driving a critical device (like a
regulator) that has to stay enabled in suspend?
Shouldn't we delegate this responsibility to the PWM user?

[1]http://patchwork.ozlabs.org/patch/734306/
