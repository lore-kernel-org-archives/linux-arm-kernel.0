From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 25 Jun 2014 20:09:42 +0200
Subject: [PATCH v2] i2c: s3c2410: resume the I2C controller earlier
In-Reply-To: <1403654214-25072-1-git-send-email-dianders@chromium.org>
References: <1403654214-25072-1-git-send-email-dianders@chromium.org>
Message-ID: <53AB1066.8000305@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 06/25/2014 01:56 AM, Doug Anderson wrote:
> From: Vincent Palatin <vpalatin@chromium.org>
> 
> When the wake-up is triggered by the PMIC RTC, the RTC driver is trying
> to read the PMIC interrupt status over I2C and fails because the I2C
> controller is not resumed yet.
> Let's resume the I2C controller earlier in the _noirq phase
> (as other hardwares are doing), so we can properly get the wake-up
> condition.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Added missing freeze/thaw/poweroff/restore
> 
>  drivers/i2c/busses/i2c-s3c2410.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index e828a1d..ecb389c 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1267,7 +1267,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
>  	return 0;
>  }
>  
> -static int s3c24xx_i2c_resume(struct device *dev)
> +static int s3c24xx_i2c_resume_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
> @@ -1285,7 +1285,11 @@ static int s3c24xx_i2c_resume(struct device *dev)
>  static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
>  #ifdef CONFIG_PM_SLEEP
>  	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
> -	.resume = s3c24xx_i2c_resume,
> +	.resume_noirq = s3c24xx_i2c_resume_noirq,
> +	.freeze_noirq = s3c24xx_i2c_suspend_noirq,
> +	.thaw_noirq = s3c24xx_i2c_resume_noirq,
> +	.poweroff_noirq = s3c24xx_i2c_suspend_noirq,
> +	.restore_noirq = s3c24xx_i2c_resume_noirq,
>  #endif
>  };
>  
> 

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
