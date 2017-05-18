From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 May 2017 23:30:00 +0100
Subject: [PATCH 1/3] rtc: gemini: Add optional clock handling
In-Reply-To: <20170518215635.13505-1-linus.walleij@linaro.org>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
Message-ID: <20170518223000.GP22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 11:56:33PM +0200, Linus Walleij wrote:
> +	rtc->pclk = clk_get(dev, "PCLK");
> +	if (IS_ERR(rtc->pclk)) {
> +		dev_err(dev, "could not get PCLK\n");
> +	} else {
> +		ret = clk_prepare_enable(rtc->pclk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable PCLK\n");
> +			return ret;

Proper cleanup?  Maybe consider using devm_clk_get() right from the get-go?

> +		}
> +	}
> +	rtc->extclk = clk_get(dev, "EXTCLK");
> +	if (IS_ERR(rtc->extclk)) {
> +		dev_err(dev, "could not get EXTCLK\n");
> +	} else {
> +		ret = clk_prepare_enable(rtc->extclk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable EXTCLK\n");
> +			return ret;

Ditto.

> +		}
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!res)
>  		return -ENODEV;
> @@ -156,6 +180,10 @@ static int gemini_rtc_remove(struct platform_device *pdev)
>  {
>  	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
>  
> +	if (!IS_ERR(rtc->extclk))
> +		clk_disable_unprepare(rtc->extclk);
> +	if (!IS_ERR(rtc->pclk))
> +		clk_disable_unprepare(rtc->pclk);

No clk_put(), but if you used devm_clk_get(), you don't need it.

>  	rtc_device_unregister(rtc->rtc_dev);
>  
>  	return 0;
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
