From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 May 2011 21:32:02 +0200
Subject: [PATCH v2 3/7] mmc: sdhci: make sdhci-of device drivers self
	registered
In-Reply-To: <1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110524193202.GB25727@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 09:22:54PM +0800, Shawn Guo wrote:
> The patch turns the sdhci-of-core common stuff into helper functions
> added into sdhci-pltfm.c, and makes sdhci-of device drviers self
> registered using the same pair of .probe and .remove used by
> sdhci-pltfm device drivers.
> 
> As a result, sdhci-of-core.c and sdhci-of.h can be eliminated with
> those common things merged into sdhci-pltfm.c and sdhci-pltfm.h
> respectively.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

After taking care of Anton's comment and fixing this minor thingie...

> +#ifdef CONFIG_OF
> +static bool sdhci_of_wp_inverted(struct device_node *np)
> +{
> +	if (of_get_property(np, "sdhci,wp-inverted", NULL))
> +		return true;
> +
> +	/* Old device trees don't have the wp-inverted property. */
> +#ifdef CONFIG_PPC
> +	return machine_is(mpc837x_rdb) || machine_is(mpc837x_mds);
> +#else
> +	return false;
> +#endif

/* CONFIG_PPC */ after #endif

> +}
> +
> +void sdhci_get_of_property(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	const __be32 *clk;
> +	int size;
> +
> +	if (of_device_is_available(np)) {
> +		if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +
> +		if (of_get_property(np, "sdhci,1-bit-only", NULL))
> +			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> +
> +		if (sdhci_of_wp_inverted(np))
> +			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> +
> +		clk = of_get_property(np, "clock-frequency", &size);
> +		if (clk && size == sizeof(*clk) && *clk)
> +			pltfm_host->clock = be32_to_cpup(clk);
> +	}
> +}
> +#else
> +void sdhci_get_of_property(struct platform_device *pdev) {}
> +#endif

/* CONFIG_OF */

you can add

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110524/bd195ba8/attachment.sig>
