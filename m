From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Nov 2015 17:23:06 +0100
Subject: [PATCH] pwm: berlin: Add PM support
In-Reply-To: <1448343785-1540-1-git-send-email-jszhang@marvell.com>
References: <1448343785-1540-1-git-send-email-jszhang@marvell.com>
Message-ID: <20151124162306.GC32623@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 01:43:05PM +0800, Jisheng Zhang wrote:
> This patch adds S2R support for berlin pwm driver.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pwm/pwm-berlin.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> index 6510812..2afdb40 100644
> --- a/drivers/pwm/pwm-berlin.c
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -27,10 +27,20 @@
>  #define BERLIN_PWM_TCNT			0xc
>  #define  BERLIN_PWM_MAX_TCNT		65535
>  
> +#define NUM_PWM_CHANNEL			4	/* berlin PWM channels */
> +
> +struct berlin_pwm_context {
> +	u32	enable;
> +	u32	ctrl;
> +	u32	duty;
> +	u32	tcnt;
> +};
> +
>  struct berlin_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	void __iomem *base;
> +	struct berlin_pwm_context ctx[NUM_PWM_CHANNEL];

Please don't do this. You can easily attach per-PWM data using the
pwm_set_chip_data() function and retrieve it using pwm_get_chip_data().

>  };
>  
>  static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
> @@ -176,7 +186,7 @@ static int berlin_pwm_probe(struct platform_device *pdev)
>  	pwm->chip.dev = &pdev->dev;
>  	pwm->chip.ops = &berlin_pwm_ops;
>  	pwm->chip.base = -1;
> -	pwm->chip.npwm = 4;
> +	pwm->chip.npwm = NUM_PWM_CHANNEL;
>  	pwm->chip.can_sleep = true;
>  	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
>  	pwm->chip.of_pwm_n_cells = 3;
> @@ -204,12 +214,57 @@ static int berlin_pwm_remove(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int berlin_pwm_suspend(struct device *dev)
> +{
> +	int i;

unsigned int, please.

> +	struct berlin_pwm_chip *pwm = dev_get_drvdata(dev);
> +
> +	for (i = 0; i < pwm->chip.npwm; i++) {
> +		struct berlin_pwm_context *ctx = &pwm->ctx[i];
> +
> +		ctx->enable = berlin_pwm_readl(pwm, i, BERLIN_PWM_ENABLE);
> +		ctx->ctrl = berlin_pwm_readl(pwm, i, BERLIN_PWM_CONTROL);
> +		ctx->duty = berlin_pwm_readl(pwm, i, BERLIN_PWM_DUTY);
> +		ctx->tcnt = berlin_pwm_readl(pwm, i, BERLIN_PWM_TCNT);
> +	}
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_resume(struct device *dev)
> +{
> +	int i;

unsigned int, please.

> +	struct berlin_pwm_chip *pwm = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(pwm->clk);

Always check the return value of this function.

> +	for (i = 0; i < pwm->chip.npwm; i++) {
> +		struct berlin_pwm_context *ctx = &pwm->ctx[i];
> +
> +		berlin_pwm_writel(pwm, i, ctx->ctrl, BERLIN_PWM_CONTROL);
> +		berlin_pwm_writel(pwm, i, ctx->duty, BERLIN_PWM_DUTY);
> +		berlin_pwm_writel(pwm, i, ctx->tcnt, BERLIN_PWM_TCNT);
> +		berlin_pwm_writel(pwm, i, ctx->enable, BERLIN_PWM_ENABLE);
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
> +			 berlin_pwm_resume);
> +#define BERLIN_PWM_PM_OPS	(&berlin_pwm_pm_ops)
> +#else
> +#define BERLIN_PWM_PM_OPS	NULL
> +#endif

This is a weird way of writing this. I think a more typical way would be
to have the #ifdef contain only the implementation and then define the
dev_pm_ops variable unconditonally, so you don't need a separate macro
for it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/cfd1cd17/attachment-0001.sig>
