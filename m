From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 10:34:59 +0000
Subject: [PATCH 6/7] rtc: sa1100: enable clk support
In-Reply-To: <1329815096-6200-7-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120223103459.GO22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:04:55PM +0800, Haojian Zhuang wrote:
> @@ -306,6 +308,13 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -ENOMEM;
>  
> +	info->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(info->clk)) {
> +		dev_err(&pdev->dev, "failed to find rtc clock source\n");
> +		ret = PTR_ERR(info->clk);
> +		goto err_clk;
> +	}
> +	clk_prepare_enable(info->clk);

What about checking for errors from clk_prepare_enable() ?

I assume that this is the clock required to access the peripheral, rather
than the timekeeping clock?  If so, does it need to be kept enabled all
the time the driver is probed, or can the clock be prepared & enabled and
disabled & unprepared when the device is opened/closed ?
