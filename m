From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 10 Apr 2014 16:24:18 -0700
Subject: [rtc-linux] [PATCH v2 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <1396287370-1011-3-git-send-email-lho@apm.com>
References: <1396287370-1011-1-git-send-email-lho@apm.com>
 <1396287370-1011-2-git-send-email-lho@apm.com>
 <1396287370-1011-3-git-send-email-lho@apm.com>
Message-ID: <20140410162418.e926ea069f046baf7845a9a1@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Mar 2014 11:36:09 -0600 Loc Ho <lho@apm.com> wrote:

> This patch adds support for the APM X-Gene SoC RTC driver.
> 
> ...
>
> +static int xgene_rtc_probe(struct platform_device *pdev)
> +{
> +	struct xgene_rtc_dev *pdata;
> +	struct resource *res;
> +	int ret;
> +	int irq;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, pdata);
> +	pdata->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pdata->csr_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pdata->csr_base))
> +		return PTR_ERR(pdata->csr_base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ resource\n");
> +		return irq;
> +	}
> +	ret = devm_request_irq(&pdev->dev, irq, xgene_rtc_interrupt, 0,
> +			       dev_name(&pdev->dev), pdata);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not request IRQ\n");
> +		return ret;
> +	}
> +
> +	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pdata->clk)) {
> +		dev_err(&pdev->dev, "Couldn't get the clock for RTC\n");
> +		return -ENODEV;
> +	}
> +	clk_prepare_enable(pdata->clk);
> +
> +	/* Turn on the clock and the crystal */
> +	writel(RTC_CCR_EN, pdata->csr_base + RTC_CCR);
> +
> +	device_init_wakeup(&pdev->dev, 1);

Forgot to check the returns values from clk_prepare_enable() and
device_init_wakeup()?

> +	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					 &xgene_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(pdata->rtc)) {
> +		clk_disable_unprepare(pdata->clk);
> +		return PTR_ERR(pdata->rtc);
> +	}
> +
> +	/* HW does not support update faster than 1 seconds */
> +	pdata->rtc->uie_unsupported = 1;
> +
> +	return 0;
> +}

Otherwise it looks OK to me - I queued all three patches, thanks.
