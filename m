From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 05 Jul 2012 09:56:22 -0700
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FF5C736.8080001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/12 08:38, Shawn Guo wrote:
> Add an RTC driver for Freescale Secure Non-Volatile Storage (SNVS)
> Low Power (LP) RTC.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>

Besides the minor comment below, please add

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> +#ifdef CONFIG_PM
> +static int snvs_rtc_suspend(struct device *dev)
> +{
> +	struct snvs_rtc_data *data = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(data->irq);
> +
> +	return 0;
> +}
> +
> +static int snvs_rtc_resume(struct device *dev)
> +{
> +	struct snvs_rtc_data *data = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(data->irq);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops snvs_rtc_pm_ops = {
> +	.suspend = snvs_rtc_suspend,
> +	.resume = snvs_rtc_resume,
> +};

Can you use the SIMPLE_DEV_PM_OPS? Then we get the same callbacks for
hibernation.

> +#endif
> +
> +static const struct of_device_id __devinitconst snvs_dt_ids[] = {
> +	{ .compatible = "fsl,sec-v4.0-mon-rtc-lp", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, snvs_dt_ids);
> +
> +static struct platform_driver snvs_rtc_driver = {
> +	.driver = {
> +		.name	= "snvs_rtc",
> +		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm	= &snvs_rtc_pm_ops,
> +#endif

Doing that avoids having an ifdef here.

> +		.of_match_table = snvs_dt_ids,
> +	},
> +	.probe		= snvs_rtc_probe,
> +	.remove		= __devexit_p(snvs_rtc_remove),
> +};
> +module_platform_driver(snvs_rtc_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("Freescale SNVS RTC Driver");
> +MODULE_LICENSE("GPL");


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
