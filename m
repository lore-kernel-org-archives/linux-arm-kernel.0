From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 Jun 2014 12:05:42 +0200
Subject: [PATCH v3 02/14] mfd: max77686: Allow the max77686 rtc to wakeup
 the system
In-Reply-To: <1403202040-12641-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403202040-12641-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1403690742.22107.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-06-19 at 20:20 +0200, Javier Martinez Canillas wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> The max77686 includes an RTC that keeps power during suspend.  It's
> convenient to be able to use it as a wakeup source.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/rtc/rtc-max77686.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
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

Haven't you noticed un-acked interrupts after first resume? Does the
alarm IRQ works after first suspend-resume?

This happens quite often (at least on boards with max14577, max77836 and
s2m/s5m). The drivers implementing own irq_chip often just call irq
worker thread (see max77693_irq_resume [1]). With regmap_irq_chip you
can disable/enable the IRQ [2][3].


P.S. Sorry for late reply. I was on holidays.


[1] http://lxr.free-electrons.com/source/drivers/mfd/max77693-irq.c#L233
[2] http://lxr.free-electrons.com/source/drivers/mfd/max14577.c#L181
[2] http://lxr.free-electrons.com/source/drivers/mfd/sec-core.c#L444

Best regards,
Krzysztof
