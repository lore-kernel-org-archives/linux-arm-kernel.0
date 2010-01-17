From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 17 Jan 2010 05:40:11 +0200
Subject: [PATCH] IMX serial: Check platform data pointer before use
In-Reply-To: <1263677310-14244-1-git-send-email-jekhor@gmail.com>
References: <1263677310-14244-1-git-send-email-jekhor@gmail.com>
Message-ID: <20100117034010.GA11157@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yauhen,

On Sat, Jan 16, 2010 at 11:28:30PM +0200, Yauhen Kharuzhy wrote:
> pdev->dev.platform_data can be NULL in driver probe function. This is
> should be checked before any use of imxuart_platform_data structure.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

A similar patch is already in Greg's tty tree.

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/tty/serial-imx-fix-null-dereference-oops-when-pdata-null.patch

> ---
>  drivers/serial/imx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index 18130f1..8c0dd13 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
> @@ -1279,7 +1279,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		sport->use_irda = 1;
>  #endif
>  
> -	if (pdata->init) {
> +	if (pdata && pdata->init) {
>  		ret = pdata->init(pdev);
>  		if (ret)
>  			goto clkput;
> @@ -1292,7 +1292,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  
>  	return 0;
>  deinit:
> -	if (pdata->exit)
> +	if (pdata && pdata->exit)
>  		pdata->exit(pdev);
>  clkput:
>  	clk_put(sport->clk);
> @@ -1321,7 +1321,7 @@ static int serial_imx_remove(struct platform_device *pdev)
>  
>  	clk_disable(sport->clk);
>  
> -	if (pdata->exit)
> +	if (pdata && pdata->exit)
>  		pdata->exit(pdev);
>  
>  	iounmap(sport->port.membase);
> -- 
> 1.6.5.7

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
