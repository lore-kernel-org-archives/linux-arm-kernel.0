From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 24 Feb 2012 00:41:05 -0800
Subject: [V1 3/4] mfd: Add ability to wake the system for 88pm860x
In-Reply-To: <1329997662-2931-3-git-send-email-jtzhou@marvell.com>
References: <1329997662-2931-1-git-send-email-jtzhou@marvell.com>
 <1329997662-2931-3-git-send-email-jtzhou@marvell.com>
Message-ID: <20120224084105.GB10763@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jett,

On Thu, Feb 23, 2012 at 07:47:41PM +0800, Jett.Zhou wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static int pm860x_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (device_may_wakeup(dev))
> +		chip->wakeup_flag |= 1 << PM8607_IRQ_ONKEY;
> +	return 0;
> +}
> +static int pm860x_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (device_may_wakeup(dev))
> +		chip->wakeup_flag &= ~(1 << PM8607_IRQ_ONKEY);
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(pm860x_onkey_pm_ops, pm860x_onkey_suspend, pm860x_onkey_resume);
> +
>  static struct platform_driver pm860x_onkey_driver = {
>  	.driver		= {
>  		.name	= "88pm860x-onkey",
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM

This ifdef is not needed, SIMPLE_DEV_PM_OPS() will produce at least
empty dev_pm_ops structure.

Thanks.

-- 
Dmitry
