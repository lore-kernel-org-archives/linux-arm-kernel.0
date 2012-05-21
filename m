From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 21 May 2012 23:17:38 +0200 (CEST)
Subject: [PATCH] mmc: mxs-mmc: Add wp-inverted property
In-Reply-To: <1337634071-8531-1-git-send-email-marex@denx.de>
References: <1337634071-8531-1-git-send-email-marex@denx.de>
Message-ID: <Pine.LNX.4.64.1205212314070.5421@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 May 2012, Marek Vasut wrote:

> The write-protect GPIO is inverted on some boards. Handle such case.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Lothar Wa?mann <LW@karo-electronics.de>
> ---
>  drivers/mmc/host/mxs-mmc.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 277161d..9bfd08e 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -164,16 +164,23 @@ struct mxs_mmc_host {
>  	spinlock_t			lock;
>  	int				sdio_irq_en;
>  	int				wp_gpio;
> +	int				wp_inverted:1;

I think, many mmc drivers could use such a flag, so, I proposed this

http://www.mail-archive.com/linux-mmc at vger.kernel.org/msg14018.html

and I'm planning to respin that entire patch-series, taking reviews into 
account. However, that specific patch doesn't depend on anything, so, it 
can be taken directly. Then drivers would just use the new CAP2 flag, 
instead of adding similar flags to their private data. Another advantage 
of having that flag centrally is, that it will enable its use from the 
slot function helper module

http://www.mail-archive.com/linux-mmc at vger.kernel.org/msg14031.html

which I'll also respin soon.

Thanks
Guennadi

>  };
>  
>  static int mxs_mmc_get_ro(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
> +	int ret;
>  
>  	if (!gpio_is_valid(host->wp_gpio))
>  		return -EINVAL;
>  
> -	return gpio_get_value(host->wp_gpio);
> +	ret = gpio_get_value(host->wp_gpio);
> +
> +	if (host->wp_inverted)
> +		ret = !ret;
> +
> +	return ret;
>  }
>  
>  static int mxs_mmc_get_cd(struct mmc_host *mmc)
> @@ -707,6 +714,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	struct pinctrl *pinctrl;
>  	int ret = 0, irq_err, irq_dma;
>  	dma_cap_mask_t mask;
> +	enum of_gpio_flags flags;
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> @@ -785,7 +793,10 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA;
>  		else if (bus_width == 8)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -		host->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
> +		host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0,
> +							&flags);
> +		if (flags & OF_GPIO_ACTIVE_LOW)
> +			host->wp_inverted = 1;
>  	} else {
>  		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
