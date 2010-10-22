From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 22 Oct 2010 08:15:37 +0200
Subject: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <1287696028-27854-1-git-send-email-eric@eukrea.com>
References: <4CC0A281.1010202@eukrea.com>
	<1287696028-27854-1-git-send-email-eric@eukrea.com>
Message-ID: <20101022061537.GA5572@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 11:20:27PM +0200, Eric B?nard wrote:
> this patch fix timeout problems on i.MX's sdhci as suggested by
> Richard Zhu.
> 
> Tested on :
> - i.MX257 : not needed
> - i.MX357 : needed
> - i.MX515 : needed
> 
> more details can be found here :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029748.html
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index afbac9a..11e1ae1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -130,6 +130,12 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
>  		gpio_request(boarddata->wp_gpio, "SD_WP");
>  		gpio_direction_input(boarddata->wp_gpio);
>  	}
> +
> +	if (cpu_is_mx35() || cpu_is_mx51()) {
> +		dev_info(mmc_dev(host->mmc), "using broken timeout quirk\n");

Please drop this line. The boot log is full enough IMO :)

Other than that:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> +		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.0.4
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101022/ed08e96b/attachment.sig>
