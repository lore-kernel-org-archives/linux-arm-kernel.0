From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 15 Mar 2010 20:36:05 +0100
Subject: [PATCH] ARM: SAMSUNG: Add suspend/resume support for S3C PWM
	driver
In-Reply-To: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
References: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4B9E8C25.80904@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> Reset period_ns and duty_ns values in suspend handler to avoid skip of
> configuration if same values passed to pwm_config;
> Restore invertion bit in resume handler.
>
> Without this patch PWM works incorrectly after resume from suspend.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>   
Hi

There is still one big issue left regarding pwm suspend/resume.
If the invert bit is not set, the pwm will generate a HIGH signal when
being inactive, when the bit is set it will generate a HIGH signal when
active.
As a result any pin to which the pwm signal is routed will appear as
active until the pwm resume handler is called. This usually takes a few
100 ms seconds and so for a short period of time we'll get the wrong
signal on pwm pins.
For correct behavior the pwm driver would have to check all pins to
which it's signal might be routed and if it's actually is configure the
pin as LOW output.
Upon resume the pin then has to be reconfigured as a pwm pin, only after
the invert bit has been set.

I know that it previously has been stated, that it is not desired for
the pwm driver to know about gpio pins. But in my opinion to ensure
correct behavior it is unavoidable.

- Lars

> ---
>  arch/arm/plat-samsung/pwm.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
> index ef019f2..f2d1139 100644
> --- a/arch/arm/plat-samsung/pwm.c
> +++ b/arch/arm/plat-samsung/pwm.c
> @@ -379,6 +379,39 @@ static int __devexit s3c_pwm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int s3c_pwm_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct pwm_device *pwm = platform_get_drvdata(pdev);
> +
> +	/* No one preserve these values during suspend so reset them
> +	 * Otherwise driver leaves PWM unconfigured if same values
> +	 * passed to pwm_config
> +	 */
> +	pwm->period_ns = 0;
> +	pwm->duty_ns = 0;
> +
> +	return 0;
> +}
> +
> +static int s3c_pwm_resume(struct platform_device *pdev)
> +{
> +	struct pwm_device *pwm = platform_get_drvdata(pdev);
> +	unsigned long tcon;
> +
> +	/* Restore invertion */
> +	tcon = __raw_readl(S3C2410_TCON);
> +	tcon |= pwm_tcon_invert(pwm);
> +	__raw_writel(tcon, S3C2410_TCON);
> +
> +	return 0;
> +}
> +
> +#else
> +#define s3c_pwm_suspend NULL
> +#define s3c_pwm_resume NULL
> +#endif
> +
>  static struct platform_driver s3c_pwm_driver = {
>  	.driver		= {
>  		.name	= "s3c24xx-pwm",
> @@ -386,6 +419,8 @@ static struct platform_driver s3c_pwm_driver = {
>  	},
>  	.probe		= s3c_pwm_probe,
>  	.remove		= __devexit_p(s3c_pwm_remove),
> +	.suspend	= s3c_pwm_suspend,
> +	.resume		= s3c_pwm_resume,
>  };
>  
>  static int __init pwm_init(void)
>   
