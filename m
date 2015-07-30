From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 11:28:52 +0200
Subject: [PATCH 1/5] rtc: at91sam9: properly handle error case
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150730112852.79dcb30a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Jul 2015 02:24:28 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> In case of a probe error, it is possible to abort after issuing
> clk_prepare_enable(). Ensure the clock is disabled and unprepared in that
> case.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

To the whole series:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/rtc/rtc-at91sam9.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 5ccaee32df72..152cd816cc43 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -451,8 +451,10 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  
>  	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
>  					&at91_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtcdev))
> -		return PTR_ERR(rtc->rtcdev);
> +	if (IS_ERR(rtc->rtcdev)) {
> +		ret = PTR_ERR(rtc->rtcdev);
> +		goto err_clk;
> +	}
>  
>  	/* register irq handler after we know what name we'll use */
>  	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
> @@ -460,7 +462,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  			       dev_name(&rtc->rtcdev->dev), rtc);
>  	if (ret) {
>  		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
> -		return ret;
> +		goto err_clk;
>  	}
>  
>  	/* NOTE:  sam9260 rev A silicon has a ROM bug which resets the
> @@ -474,6 +476,11 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  				dev_name(&rtc->rtcdev->dev));
>  
>  	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(rtc->sclk);
> +
> +	return ret;
>  }
>  
>  /*



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
