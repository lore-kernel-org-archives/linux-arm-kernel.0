From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Jun 2014 11:03:59 +0200
Subject: [PATCH v4 02/14] mfd: max77686: Allow the max77686 rtc to wakeup
 the system
In-Reply-To: <1403723019-6212-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1403723019-6212-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403723019-6212-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1403773439.27156.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-06-25 at 21:03 +0200, Javier Martinez Canillas wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> The max77686 includes an RTC that keeps power during suspend.  It's
> convenient to be able to use it as a wakeup source.
> 
> NOTE: due to wakeup ordering problems this patch alone doesn't work so
> well on exynos5250-snow.  You also need something that brings the i2c
> bus up before the max77686 wakeup runs.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Changes since v3:
>  - Keep the note that this patch needs another change due wakeup
>    ordering problems.
> 
>  drivers/rtc/rtc-max77686.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index d20a7f0..c1c6055 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -583,6 +583,33 @@ static void max77686_rtc_shutdown(struct platform_device *pdev)
>  #endif /* MAX77686_RTC_WTSR_SMPL */
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int max77686_rtc_suspend(struct device *dev)
> +{
> +	if (device_may_wakeup(dev)) {
> +		struct max77686_rtc_info *info = dev_get_drvdata(dev);
> +
> +		return enable_irq_wake(info->virq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77686_rtc_resume(struct device *dev)
> +{
> +	if (device_may_wakeup(dev)) {
> +		struct max77686_rtc_info *info = dev_get_drvdata(dev);
> +
> +		return disable_irq_wake(info->virq);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(max77686_rtc_pm_ops,
> +			 max77686_rtc_suspend, max77686_rtc_resume);
> +
>  static const struct platform_device_id rtc_id[] = {
>  	{ "max77686-rtc", 0 },
>  	{},
> @@ -592,6 +619,7 @@ static struct platform_driver max77686_rtc_driver = {
>  	.driver		= {
>  		.name	= "max77686-rtc",
>  		.owner	= THIS_MODULE,
> +		.pm	= &max77686_rtc_pm_ops,
>  	},
>  	.probe		= max77686_rtc_probe,
>  	.shutdown	= max77686_rtc_shutdown,
