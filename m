From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 21 Sep 2010 16:58:23 +0400
Subject: [PATCH 3/4] mmc: sdhci-of-esdhc: factor out common stuff
In-Reply-To: <1285072210-10207-4-git-send-email-w.sang@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<1285072210-10207-4-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100921125823.GA31408@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 02:30:09PM +0200, Wolfram Sang wrote:
> Put everything which can be shared between the OF and platform version
> of this driver into a local .h-file.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
[...]
> +
> +static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	int pre_div = 2;
> +	int div = 1;
> +	u32 temp;
> +
> +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> +	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
> +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +
> +	if (clock == 0)
> +		goto out;
> +
> +	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> +		pre_div *= 2;
> +
> +	while (host->max_clk / pre_div / div > clock && div < 16)
> +		div++;
> +
> +	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
> +		clock, host->max_clk / pre_div / div);
> +
> +	pre_div >>= 1;
> +	div--;
> +
> +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> +	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
> +		  (div << ESDHC_DIVIDER_SHIFT) | (pre_div << ESDHC_PREDIV_SHIFT));
> +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> +	mdelay(100);
> +out:
> +	host->clock = clock;
> +}

This function is too big for a header. How about moving it
to sdhci-esdhc.c, which would hold common bits for eSDHC?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
