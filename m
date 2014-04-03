From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Apr 2014 17:26:48 +0100
Subject: [rtc-linux] [PATCH v3 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <1396505873-5507-3-git-send-email-lho@apm.com>
References: <1396505873-5507-1-git-send-email-lho@apm.com>
 <1396505873-5507-2-git-send-email-lho@apm.com>
 <1396505873-5507-3-git-send-email-lho@apm.com>
Message-ID: <20140403162648.GW14763@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 12:17:52AM -0600, Loc Ho wrote:

> +static int xgene_rtc_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xgene_rtc_dev *pdata = platform_get_drvdata(pdev);
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (device_may_wakeup(&pdev->dev)) {
> +		if (!enable_irq_wake(irq))
> +			pdata->irq_wake = 1;
> +	} else {
> +		xgene_rtc_alarm_irq_enable(dev, 0);
> +		clk_disable(pdata->clk);
> +	}

Why does the driver only disable the clock over suspend rather than also
unpreparing it?

> +	if (device_may_wakeup(&pdev->dev)) {
> +		if (pdata->irq_wake) {
> +			disable_irq_wake(irq);
> +			pdata->irq_wake = 0;
> +		}
> +	} else {
> +		clk_enable(pdata->clk);

It's also not checking for errors here.

> +		xgene_rtc_alarm_irq_enable(dev, 1);
> +	}

Won't this unconditionally enable the interrupt regardless of what the
setting was prior to suspend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/031f94a7/attachment.sig>
