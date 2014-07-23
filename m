From: varkabhadram@gmail.com (Varka Bhadram)
Date: Wed, 23 Jul 2014 21:32:39 +0530
Subject: [PATCH v2 1/6] rtc: sun6i: Add sun6i RTC driver
In-Reply-To: <1406126338-15062-2-git-send-email-wens@csie.org>
References: <1406126338-15062-1-git-send-email-wens@csie.org>
 <1406126338-15062-2-git-send-email-wens@csie.org>
Message-ID: <53CFDC9F.9060208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wednesday 23 July 2014 08:08 PM, Chen-Yu Tsai wrote:
> This patch introduces the driver for the RTC in the Allwinner A31 and
> A23 SoCs.
>
> Unlike the RTC found in A10/A20 SoCs, which was part of the timer, the
> RTC in A31/A23 are a separate hardware block, which also contain a few
> controls for the RTC block hardware (a regulator and RTC block GPIO pin
> latches), while also having separate interrupts for the alarms.
>
> The hardware is different enough to make a different driver for it.
>
(...)

> +Required properties:
> +- compatible : Should be "allwinner,sun6i-a31-rtc"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: IRQ line for the RTC alarm 0.
> +

proper indentation..
- compatible	: Should be "allwinner,sun6i-a31-rtc"
- reg		: physical base address of the controller and length of memory mapped
		  region.
- interrupts	: IRQ line for the RTC alarm 0.
....

> +Example:
> +

(...)

> +
> +	ret = devm_request_irq(&pdev->dev, chip->irq, sun6i_rtc_alarmirq,
> +			0, dev_name(&pdev->dev), chip);

should match open parenthesis...

devm_request_irq(&pdev->dev, chip->irq, sun6i_rtc_alarmirq,
		 0, dev_name(&pdev->dev), chip);

> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not request IRQ\n");
> +		return ret;
> +	}
> +
> +	/* clear the alarm counter value */
> +	writel(0, chip->base + SUN6I_ALRM_COUNTER);
> +
> +	/* disable counter alarm */
> +	writel(0, chip->base + SUN6I_ALRM_EN);
> +
> +	/* disable counter alarm interrupt */
> +	writel(0, chip->base + SUN6I_ALRM_IRQ_EN);
> +
> +	/* disable week alarm */
> +	writel(0, chip->base + SUN6I_ALRM1_EN);
> +
> +	/* disable week alarm interrupt */
> +	writel(0, chip->base + SUN6I_ALRM1_IRQ_EN);
> +
> +	/* clear counter alarm pending interrupts */
> +	writel(SUN6I_ALRM_IRQ_STA_CNT_IRQ_PEND, chip->base +
> +			SUN6I_ALRM_IRQ_STA);
> +
> +	/* clear week alarm pending interrupts */
> +	writel(SUN6I_ALRM1_IRQ_STA_WEEK_IRQ_PEND, chip->base +
> +			SUN6I_ALRM1_IRQ_STA);
> +
> +	/* disable alarm wakeup */
> +	writel(0, chip->base + SUN6I_ALARM_CONFIG);
> +
> +	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
> +			&sun6i_rtc_ops, THIS_MODULE);

dto....

> +	if (IS_ERR(chip->rtc)) {
> +		dev_err(&pdev->dev, "unable to register device\n");
> +		return PTR_ERR(chip->rtc);
> +	}
> +
> +	dev_info(&pdev->dev, "RTC enabled\n");
> +
> +	return 0;
> +}
> +
> +static int sun6i_rtc_remove(struct platform_device *pdev)
> +{
> +	struct sun6i_rtc_dev *chip = platform_get_drvdata(pdev);
> +
> +	rtc_device_unregister(chip->rtc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun6i_rtc_dt_ids[] = {
> +	{ .compatible = "allwinner,sun6i-a31-rtc" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
> +
> +static struct platform_driver sun6i_rtc_driver = {
> +	.probe		= sun6i_rtc_probe,
> +	.remove		= sun6i_rtc_remove,
> +	.driver		= {
> +		.name		= "sun6i-rtc",
> +		.owner		= THIS_MODULE,

we can drop owner field....

> +		.of_match_table = sun6i_rtc_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(sun6i_rtc_driver);
> +
> +MODULE_DESCRIPTION("sun6i RTC driver");
> +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
> +MODULE_LICENSE("GPL");

-- 
-Varka Bhadram
