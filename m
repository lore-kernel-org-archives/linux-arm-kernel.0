From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Nov 2014 12:04:29 +0000
Subject: [PATCH V2 5/5] mfd: tc6387xb: prepare/unprepare clocks
In-Reply-To: <1416236863-20898-5-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-5-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141118120429.GZ24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Dmitry Eremin-Solenikov wrote:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/mfd/tc6387xb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Looks good.  Applied, thanks.

> diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
> index e71f880..85fab37 100644
> --- a/drivers/mfd/tc6387xb.c
> +++ b/drivers/mfd/tc6387xb.c
> @@ -52,7 +52,7 @@ static int tc6387xb_suspend(struct platform_device *dev, pm_message_t state)
>  
>  	if (pdata && pdata->suspend)
>  		pdata->suspend(dev);
> -	clk_disable(tc6387xb->clk32k);
> +	clk_disable_unprepare(tc6387xb->clk32k);
>  
>  	return 0;
>  }
> @@ -62,7 +62,7 @@ static int tc6387xb_resume(struct platform_device *dev)
>  	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
>  	struct tc6387xb_platform_data *pdata = dev_get_platdata(&dev->dev);
>  
> -	clk_enable(tc6387xb->clk32k);
> +	clk_prepare_enable(tc6387xb->clk32k);
>  	if (pdata && pdata->resume)
>  		pdata->resume(dev);
>  
> @@ -100,7 +100,7 @@ static int tc6387xb_mmc_enable(struct platform_device *mmc)
>  	struct platform_device *dev      = to_platform_device(mmc->dev.parent);
>  	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
>  
> -	clk_enable(tc6387xb->clk32k);
> +	clk_prepare_enable(tc6387xb->clk32k);
>  
>  	tmio_core_mmc_enable(tc6387xb->scr + 0x200, 0,
>  		tc6387xb_mmc_resources[0].start & 0xfffe);
> @@ -113,7 +113,7 @@ static int tc6387xb_mmc_disable(struct platform_device *mmc)
>  	struct platform_device *dev      = to_platform_device(mmc->dev.parent);
>  	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
>  
> -	clk_disable(tc6387xb->clk32k);
> +	clk_disable_unprepare(tc6387xb->clk32k);
>  
>  	return 0;
>  }
> @@ -214,7 +214,7 @@ static int tc6387xb_remove(struct platform_device *dev)
>  	mfd_remove_devices(&dev->dev);
>  	iounmap(tc6387xb->scr);
>  	release_resource(&tc6387xb->rscr);
> -	clk_disable(tc6387xb->clk32k);
> +	clk_disable_unprepare(tc6387xb->clk32k);
>  	clk_put(tc6387xb->clk32k);
>  	kfree(tc6387xb);
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
