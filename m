From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Dec 2013 12:05:12 +0800
Subject: [PATCH 5/6] mmc: sdhci: calculate max_discard_to dynamically for
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
In-Reply-To: <1386680168-5227-6-git-send-email-b29396@freescale.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-6-git-send-email-b29396@freescale.com>
Message-ID: <20131211040511.GJ18380@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 08:56:07PM +0800, Dong Aisheng wrote:
>  static inline void sdhci_update_clock(struct sdhci_host *host)
> @@ -2939,10 +2952,12 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>  		host->timeout_clk = mmc->f_max / 1000;

Since max_discard_to calculation below will not happen for
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK case, does it still make sense to
keep the above code?

Or put it in the other way, if we keep the above code and do not make
the change below, will there be any problem besides the max_discard_to
initialization plays for nothing?

All in all, I'm just confused why we keep the above code and make the
change below at the same time.

Shawn

>  
> -	if (host->ops->get_max_timeout)
> -		mmc->max_discard_to = host->ops->get_max_timeout(host);
> -	else
> -		mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> +		if (host->ops->get_max_timeout)
> +			mmc->max_discard_to = host->ops->get_max_timeout(host);
> +		else
> +			mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	}
>  
>  	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>  
> -- 
> 1.7.2.rc3
> 
> 
