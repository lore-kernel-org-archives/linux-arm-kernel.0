From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 27 Jan 2016 17:17:54 +0100
Subject: [PATCH] mmc: sdhci-of-at91: fix pm runtime unbalanced issue in
 error path
In-Reply-To: <1453804954-3490-1-git-send-email-jszhang@marvell.com>
References: <1453804954-3490-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160127161754.GE6149@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 06:42:34PM +0800, Jisheng Zhang wrote:
> The device power usage counter is increased by pm_runtime_get_noresume
> but isn't decreased in err_add_host error path.
> 
> Fix this issue by calling pm_runtime_put_noidle() in the error path to
> restore the device's power usage counter.
> 

Well spotted, thanks.

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> Fixes: f5f17813ae9b ("mmc: sdhci-of-at91: add PM support)
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 7db7163..3bf6f31 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -210,7 +210,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  
>  pm_runtime_disable:
>  	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
>  clocks_disable_unprepare:
>  	clk_disable_unprepare(priv->gck);
>  	clk_disable_unprepare(priv->mainck);
> -- 
> 2.7.0
> 
