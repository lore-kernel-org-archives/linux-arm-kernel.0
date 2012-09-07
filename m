From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 7 Sep 2012 11:14:19 +0800
Subject: [PATCH] serial: mxs-auart: put the device when exit or error
In-Reply-To: <1346985187-30459-1-git-send-email-b32955@freescale.com>
References: <20120907024349.GH26709@S2101-09.ap.freescale.net>
 <1346985187-30459-1-git-send-email-b32955@freescale.com>
Message-ID: <20120907031416.GJ26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:33:07AM +0800, Huang Shijie wrote:
> We call the get_device() in the mxs_auart_probe().
> For the balance of the reference count, we should put the
> device in the mxs_auart_remove() or in the error path of
> probe.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/mxs-auart.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 3a667ee..203e512 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -781,6 +781,7 @@ out_free_irq:
>  	auart_port[pdev->id] = NULL;
>  	free_irq(s->irq, s);
>  out_free_clk:
> +	put_device(s->dev);
>  	clk_put(s->clk);
>  out_free:
>  	kfree(s);
> @@ -796,6 +797,7 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
>  
>  	auart_port[pdev->id] = NULL;
>  
> +	put_device(s->dev);
>  	clk_put(s->clk);
>  	free_irq(s->irq, s);
>  	kfree(s);
> -- 
> 1.7.0.4
> 
> 
