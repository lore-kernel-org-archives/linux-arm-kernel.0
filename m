From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 5 Sep 2012 23:48:51 +0200 (CEST)
Subject: [PATCH 7/8] pwm i.MX: fix clock lookup
In-Reply-To: <1346852127-25226-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1698432111.3713458.1346881731396.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 5, 2012 3:35:26 PM, Sascha Hauer wrote:
> 
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The i.MX pwm core has two clocks: The ipg clock and the ipg highfreq
> (peripheral) clock. The ipg clock has to be enabled for this hardware
> to work. The actual pwm output can either be driven by the ipg clock
> or the ipg highfreq. The ipg highfreq has the advantage that it runs
> even when the SoC is in low power modes.
> This patch requests both clocks and enables the ipg clock for
> accessing
> registers and the peripheral clock to actually turn on the pwm.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx.c |   33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index b234288..5b03ace 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -40,7 +40,8 @@
>  #define MX3_PWMCR_EN              (1 << 0)
>  
>  struct imx_chip {
> -	struct clk	*clk;
> +	struct clk	*clk_per;
> +	struct clk	*clk_ipg;
>  
>  	int		enabled;
>  	void __iomem	*mmio_base;
> @@ -105,7 +106,7 @@ static int imx_pwm_config_v2(struct pwm_chip
> *chip,
>  	unsigned long period_cycles, duty_cycles, prescale;
>  	u32 cr;
>  
> -	c = clk_get_rate(imx->clk);
> +	c = clk_get_rate(imx->clk_per);
>  	c = c * period_ns;
>  	do_div(c, 1000000000);
>  	period_cycles = c;
> @@ -160,8 +161,15 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
>  	struct imx_chip *imx = to_imx_chip(chip);
> +	int ret;
>  
> -	return imx->config(chip, pwm, duty_ns, period_ns);
> +	clk_prepare_enable(imx->clk_ipg);

Why don't you test the return value like in imx_pwm_enable()?

> +
> +	ret = imx->config(chip, pwm, duty_ns, period_ns);
> +
> +	clk_disable_unprepare(imx->clk_ipg);
> +
> +	return ret;
>  }
>  
>  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device
>  *pwm)
> @@ -169,7 +177,7 @@ static int imx_pwm_enable(struct pwm_chip *chip,
> struct pwm_device *pwm)
>  	struct imx_chip *imx = to_imx_chip(chip);
>  	int rc;
>  
> -	rc = clk_prepare_enable(imx->clk);
> +	rc = clk_prepare_enable(imx->clk_per);
>  	if (rc)
>  		return rc;
>  
> @@ -186,7 +194,7 @@ static void imx_pwm_disable(struct pwm_chip
> *chip, struct pwm_device *pwm)
>  
>  	imx->set_enable(chip, false);
>  
> -	clk_disable_unprepare(imx->clk);
> +	clk_disable_unprepare(imx->clk_per);
>  	imx->enabled = 0;
>  }
>  
> @@ -238,10 +246,19 @@ static int __devinit imx_pwm_probe(struct
> platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	imx->clk = devm_clk_get(&pdev->dev, "pwm");
> +	imx->clk_per = devm_clk_get(&pdev->dev, "per");
> +	if (IS_ERR(imx->clk_per)) {
> +		dev_err(&pdev->dev, "getting per clock failed with %ld\n",
> +				PTR_ERR(imx->clk_per));
> +		return PTR_ERR(imx->clk_per);
> +	}
>  
> -	if (IS_ERR(imx->clk))
> -		return PTR_ERR(imx->clk);
> +	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(imx->clk_ipg)) {
> +		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> +				PTR_ERR(imx->clk_ipg));
> +		return PTR_ERR(imx->clk_ipg);
> +	}
>  
>  	imx->chip.ops = &imx_pwm_ops;
>  	imx->chip.dev = &pdev->dev;

I have reviewed the whole series. Apart from the comments I made, it looks good
to me.

Best regards,
Beno?t
