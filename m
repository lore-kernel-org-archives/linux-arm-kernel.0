From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 21 Sep 2010 01:24:20 +0100
Subject: [PATCH v2 2/2] sdhci-s3c: Add support no internal clock divider
	in	host controller
In-Reply-To: <1284716701-5140-3-git-send-email-kgene.kim@samsung.com>
References: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
	<1284716701-5140-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C97FB34.1000802@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/10 10:45, Kukjin Kim wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
> 
> This patch adds to support no internal clock divider in SDHCI.
> The external clock divider can be used to make a proper clock
> because SDHCI doesn't support internal clock divider by itself.
> 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   60 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index e6e0438..5ad5ed7 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -96,6 +96,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
>  	unsigned int rate, max;
>  	int clk;
>  
> +	/*
> +	 * There is only one clock source(sclk) if there is no clock divider
> +	 * in the host controller
> +	 */
> +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> +		return clk_round_rate(ourhost->clk_bus[2], UINT_MAX);

interesting, <linux/clk.h> doesn't have a second parameter to
clk_round_rate().


>  	/* note, a reset will reset the clock source */
>  
>  	sdhci_s3c_check_sclk(host);
> @@ -130,6 +137,15 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>  	if (!clksrc)
>  		return UINT_MAX;
>  
> +	/*
> +	 * There is only one clock source(sclk) if there is no clock divider
> +	 * in the host controller
> +	 */
> +	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
> +		rate = clk_round_rate(clksrc, wanted);
> +		return wanted - rate;
> +	}

Why does this need a quirk, instead of just having one clock available
in the list of usable clocks?

-- 
Ben
