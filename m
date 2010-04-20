From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 20 Apr 2010 10:39:36 +0100
Subject: [PATCH] i2c-s3c2410: Enable i2c clock only on xfer
In-Reply-To: <201004172342.43440.anarsoul@gmail.com>
References: <201004172342.43440.anarsoul@gmail.com>
Message-ID: <20100420093936.GE6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 17, 2010 at 11:42:32PM +0300, Vasily Khoruzhick wrote:
> I don't see any reason to keep i2c clock enabled all the time when i2c bus 
> driver is loaded, and even more: it prevents me to disable uda1380 codec power 
> - uda1380 doesn't respond on i2c xfers if its power was disabled during i2c 
> clock is enabled.

Weird. The SCL line should only be clocked when the block is generating
transfers.
 
> WinMobile enables i2c clock only on xfer (same for i2s clock)
> 
> Regards
> Vasily

> From 398bcaeb1bde17d4e33052d99dea914dad8378e0 Mon Sep 17 00:00:00 2001
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Date: Sat, 17 Apr 2010 23:32:52 +0300
> Subject: [PATCH] i2c-s3c2410: Enable i2c clock only on xfer
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 1d8c986..662f6e4 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -541,7 +541,9 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
>  
>  	for (retry = 0; retry < adap->retries; retry++) {
>  
> +		clk_enable(i2c->clk);
>  		ret = s3c24xx_i2c_doxfer(i2c, msgs, num);
> +		clk_disable(i2c->clk);

I'll try and find out if there is any setup requirement between clock
enable and the block being used.

It is probably worth moving the clk_enable() outside the loop to avoid
calling it each time we try an transfer.

>  		if (ret != -EAGAIN)
>  			return ret;
> @@ -812,8 +814,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  
>  	dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
>  
> -	clk_enable(i2c->clk);
> -

I'm not sure, but I think the clock should also be enabled when reading
or writing registers. I'd be happier to see a patch where the setup
functions also ensure that the clock is enabled.

>  	/* map the registers */
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 1.7.0.4
> 




> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
