From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Sep 2012 14:08:45 +0800
Subject: [PATCH] mmc: mxs-mmc: implement broken-cd
In-Reply-To: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20120910060840.GT26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 02:45:17PM +0300, Lauri Hintsala wrote:
> This feature allows to use SDIO bus without wiring card detect
> signal.

This looks like a case of "broken-cd" ...

> This is relevant in cases where SDIO device is connected to
> SDIO bus and there is no way to disconnect device from bus (device
> is always present).
> 
... while this sounds like a case of "non-removable".

> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> ---
>  drivers/mmc/host/mxs-mmc.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index ad3fcea..992760e 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -165,6 +165,7 @@ struct mxs_mmc_host {
>  	int				sdio_irq_en;
>  	int				wp_gpio;
>  	bool				wp_inverted;
> +	bool				broken_cd;
>  };
>  
>  static int mxs_mmc_get_ro(struct mmc_host *mmc)
> @@ -187,6 +188,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
>  
> +	if (host->broken_cd)
> +		return -ENOSYS;
> +

The .get_cd caller does not check for error.  This change makes no
sense to me.  Instead, the driver needs to set MMC_CAP_NEEDS_POLL in
case of "broken-cd".

Regards,
Shawn

>  	return !(readl(host->base + HW_SSP_STATUS(host)) &
>  		 BM_SSP_STATUS_CARD_DETECT);
>  }
> @@ -808,6 +812,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  							&flags);
>  		if (flags & OF_GPIO_ACTIVE_LOW)
>  			host->wp_inverted = 1;
> +
> +		if (of_get_property(np, "broken-cd", NULL))
> +			host->broken_cd = 1;
>  	} else {
>  		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -- 
> 1.7.9.5
> 
