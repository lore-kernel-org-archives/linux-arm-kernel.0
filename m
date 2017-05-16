From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 16 May 2017 14:22:11 +0200
Subject: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
In-Reply-To: <20170516061720.1755-1-jszhang@marvell.com>
References: <20170516061720.1755-1-jszhang@marvell.com>
Message-ID: <20170516122211.GA27959@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 02:17:20PM +0800, Jisheng Zhang wrote:
> Currently, the xenon_clean_phy() is only used for freeing phy_params.
> The phy_params is allocated by devm_kzalloc(), there's no need to free
> is explicitly.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 14 +-------------
>  drivers/mmc/host/sdhci-xenon.c     |  6 +-----
>  drivers/mmc/host/sdhci-xenon.h     |  1 -
>  3 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 6356781f1cca..f7e26b031e76 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -787,14 +787,6 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
>  	return ret;
>  }
>  
> -void xenon_clean_phy(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -
> -	kfree(priv->phy_params);

Hi Jisheng

If the memory has been allocated using the devm_ API, calling kfree
here is wrong, and can lead to a double free.

So this patch should probably have a fixes: tag. Should it also goto
stable?

	Andrew
