From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Fri, 19 May 2017 20:11:31 +0200 (CEST)
Subject: [PATCH 1/3] rtc: gemini: Add optional clock handling
In-Reply-To: <20170518215635.13505-1-linus.walleij@linaro.org>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1705192011140.15369@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, 18 May 2017, Linus Walleij wrote:

> This makes the Gemini optionally take two clock references to
> the PCLK and EXTCLK. As we are adding a clock framework to the
> Gemini platform we need to make sure that we get the right
> references.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/rtc/rtc-gemini.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
> index 5279390bb42d..d69a35aa80e7 100644
> --- a/drivers/rtc/rtc-gemini.c
> +++ b/drivers/rtc/rtc-gemini.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/clk.h>
>  
>  #define DRV_NAME        "rtc-gemini"
>  
> @@ -38,6 +39,8 @@ struct gemini_rtc {
>  	struct rtc_device	*rtc_dev;
>  	void __iomem		*rtc_base;
>  	int			rtc_irq;
> +	struct clk		*pclk;
> +	struct clk		*extclk;
>  };
>  
>  enum gemini_rtc_offsets {
> @@ -127,6 +130,27 @@ static int gemini_rtc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, rtc);
>  
> +	rtc->pclk = clk_get(dev, "PCLK");
> +	if (IS_ERR(rtc->pclk)) {
> +		dev_err(dev, "could not get PCLK\n");
> +	} else {
> +		ret = clk_prepare_enable(rtc->pclk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable PCLK\n");
> +			return ret;
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
>  	rtc_device_unregister(rtc->rtc_dev);
>  
>  	return 0;
> -- 
> 2.9.3
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
