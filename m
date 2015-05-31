From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 1 Jun 2015 00:55:12 +0200
Subject: [v2] rtc: Fix suspend/resume for APM X-Gene SoC RTC driver
In-Reply-To: <1397498944-8486-1-git-send-email-lho@apm.com>
References: <1397498944-8486-1-git-send-email-lho@apm.com>
Message-ID: <20150531225512.GA4710@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch was never merged, can you check whether it is still useful
(I'd would say it is)?

On 14/04/2014 at 12:09:04 -0600, Loc Ho wrote :
> This patch fixes suspend/resume functions properly for the APM X-Gene
> SoC RTC driver. This patch requires the merged v2 of the APM X-Gene 
> SoC RTC driver.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Reviewed-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/rtc/rtc-xgene.c |   41 ++++++++++++++++++++++++++++++++---------
>  1 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
> index 14129cc..d533edd 100644
> --- a/drivers/rtc/rtc-xgene.c
> +++ b/drivers/rtc/rtc-xgene.c
> @@ -52,6 +52,7 @@ struct xgene_rtc_dev {
>  	void __iomem *csr_base;
>  	struct clk *clk;
>  	unsigned int irq_wake;
> +	unsigned int irq_enabled;
>  };
>  
>  static int xgene_rtc_read_time(struct device *dev, struct rtc_time *tm)
> @@ -104,15 +105,19 @@ static int xgene_rtc_alarm_irq_enable(struct device *dev, u32 enabled)
>  	return 0;
>  }
>  
> +static int xgene_rtc_alarm_irq_enabled(struct device *dev)
> +{
> +	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
> +
> +	return readl(pdata->csr_base + RTC_CCR) & RTC_CCR_IE ? 1 : 0;
> +}
> +
>  static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
> -	unsigned long rtc_time;
>  	unsigned long alarm_time;
>  
> -	rtc_time = readl(pdata->csr_base + RTC_CCVR);
>  	rtc_tm_to_time(&alrm->time, &alarm_time);
> -
>  	pdata->alarm_time = alarm_time;
>  	writel((u32) pdata->alarm_time, pdata->csr_base + RTC_CMR);
>  
> @@ -180,12 +185,18 @@ static int xgene_rtc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Couldn't get the clock for RTC\n");
>  		return -ENODEV;
>  	}
> -	clk_prepare_enable(pdata->clk);
> +	ret = clk_prepare_enable(pdata->clk);
> +	if (ret)
> +		return ret;
>  
>  	/* Turn on the clock and the crystal */
>  	writel(RTC_CCR_EN, pdata->csr_base + RTC_CCR);
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	ret = device_init_wakeup(&pdev->dev, 1);
> +	if (ret) {
> +		clk_disable_unprepare(pdata->clk);
> +		return ret;
> +	}
>  
>  	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
>  					 &xgene_rtc_ops, THIS_MODULE);
> @@ -218,14 +229,20 @@ static int xgene_rtc_suspend(struct device *dev)
>  	int irq;
>  
>  	irq = platform_get_irq(pdev, 0);
> +
> +	/*
> +	 * If this RTC alarm will be used for waking the system up,
> +	 * don't disable it of course. Else we just disable the alarm
> +	 * and await suspension.
> +	 */
>  	if (device_may_wakeup(&pdev->dev)) {
>  		if (!enable_irq_wake(irq))
>  			pdata->irq_wake = 1;
>  	} else {
> +		pdata->irq_enabled = xgene_rtc_alarm_irq_enabled(dev);
>  		xgene_rtc_alarm_irq_enable(dev, 0);
> -		clk_disable(pdata->clk);
> +		clk_disable_unprepare(pdata->clk);
>  	}
> -
>  	return 0;
>  }
>  
> @@ -234,16 +251,22 @@ static int xgene_rtc_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct xgene_rtc_dev *pdata = platform_get_drvdata(pdev);
>  	int irq;
> +	int rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> +
>  	if (device_may_wakeup(&pdev->dev)) {
>  		if (pdata->irq_wake) {
>  			disable_irq_wake(irq);
>  			pdata->irq_wake = 0;
>  		}
>  	} else {
> -		clk_enable(pdata->clk);
> -		xgene_rtc_alarm_irq_enable(dev, 1);
> +		rc = clk_prepare_enable(pdata->clk);
> +		if (rc) {
> +			dev_err(dev, "Unable to enable clock error %d\n", rc);
> +			return rc;
> +		}
> +		xgene_rtc_alarm_irq_enable(dev, pdata->irq_enabled);
>  	}
>  
>  	return 0;

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
