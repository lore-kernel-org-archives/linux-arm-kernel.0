From: johan@kernel.org (Johan Hovold)
Date: Tue, 23 Sep 2014 12:33:26 +0200
Subject: [PATCH v7 08/10] rtc: at91sam9: use clk API instead of relying
 on AT91_SLOW_CLOCK
In-Reply-To: <1411465130-29011-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1411465130-29011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411465130-29011-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140923103326.GA404@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 11:38:48AM +0200, Boris BREZILLON wrote:

> @@ -328,6 +328,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  	struct sam9_rtc	*rtc;
>  	int		ret, irq;
>  	u32		mr;
> +	unsigned int	sclk_rate;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -385,11 +386,27 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	rtc->sclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rtc->sclk))
> +		return PTR_ERR(rtc->sclk);
> +
> +	sclk_rate = clk_get_rate(rtc->sclk);
> +	if (!sclk_rate || sclk_rate > AT91_RTT_RTTRST) {

You probably meant AT91_RTT_RTPRES here.

> +		dev_err(&pdev->dev, "Invalid slow clock rate");
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_prepare_enable(rtc->sclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not enable slow clock");
> +		return ret;
> +	}
> +
>  	mr = rtt_readl(rtc, MR);
>  
>  	/* unless RTT is counting at 1 Hz, re-initialize it */
> -	if ((mr & AT91_RTT_RTPRES) != AT91_SLOW_CLOCK) {
> -		mr = AT91_RTT_RTTRST | (AT91_SLOW_CLOCK & AT91_RTT_RTPRES);
> +	if ((mr & AT91_RTT_RTPRES) != sclk_rate) {
> +		mr = AT91_RTT_RTTRST | (sclk_rate & AT91_RTT_RTPRES);
>  		gpbr_writel(rtc, 0);
>  	}

Johan
