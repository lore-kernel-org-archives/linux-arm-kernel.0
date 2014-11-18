From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Nov 2014 13:14:34 +0000
Subject: [PATCH V2 4/5] mfd: t7l66xb: prepare/unprepare clocks
In-Reply-To: <1416236863-20898-4-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-4-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141118131434.GA24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Dmitry Eremin-Solenikov wrote:

> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unprepare().
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/mfd/t7l66xb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
> index 9e04a74..439d905 100644
> --- a/drivers/mfd/t7l66xb.c
> +++ b/drivers/mfd/t7l66xb.c
> @@ -87,7 +87,7 @@ static int t7l66xb_mmc_enable(struct platform_device *mmc)
>  	unsigned long flags;
>  	u8 dev_ctl;
>  
> -	clk_enable(t7l66xb->clk32k);
> +	clk_prepare_enable(t7l66xb->clk32k);
>  
>  	spin_lock_irqsave(&t7l66xb->lock, flags);
>  
> @@ -118,7 +118,7 @@ static int t7l66xb_mmc_disable(struct platform_device *mmc)
>  
>  	spin_unlock_irqrestore(&t7l66xb->lock, flags);
>  
> -	clk_disable(t7l66xb->clk32k);
> +	clk_disable_unprepare(t7l66xb->clk32k);
>  
>  	return 0;
>  }
> @@ -285,7 +285,7 @@ static int t7l66xb_suspend(struct platform_device *dev, pm_message_t state)
>  
>  	if (pdata && pdata->suspend)
>  		pdata->suspend(dev);
> -	clk_disable(t7l66xb->clk48m);
> +	clk_disable_unprepare(t7l66xb->clk48m);
>  
>  	return 0;
>  }
> @@ -295,7 +295,7 @@ static int t7l66xb_resume(struct platform_device *dev)
>  	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
>  	struct t7l66xb_platform_data *pdata = dev_get_platdata(&dev->dev);
>  
> -	clk_enable(t7l66xb->clk48m);
> +	clk_prepare_enable(t7l66xb->clk48m);
>  	if (pdata && pdata->resume)
>  		pdata->resume(dev);
>  
> @@ -369,7 +369,7 @@ static int t7l66xb_probe(struct platform_device *dev)
>  		goto err_ioremap;
>  	}
>  
> -	clk_enable(t7l66xb->clk48m);
> +	clk_prepare_enable(t7l66xb->clk48m);
>  
>  	if (pdata && pdata->enable)
>  		pdata->enable(dev);
> @@ -414,9 +414,9 @@ static int t7l66xb_remove(struct platform_device *dev)
>  	int ret;
>  
>  	ret = pdata->disable(dev);
> -	clk_disable(t7l66xb->clk48m);
> +	clk_disable_unprepare(t7l66xb->clk48m);
>  	clk_put(t7l66xb->clk48m);
> -	clk_disable(t7l66xb->clk32k);
> +	clk_disable_unprepare(t7l66xb->clk32k);
>  	clk_put(t7l66xb->clk32k);
>  	t7l66xb_detach_irq(dev);
>  	iounmap(t7l66xb->scr);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
