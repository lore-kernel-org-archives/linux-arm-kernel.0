From: joe@perches.com (Joe Perches)
Date: Wed, 16 Apr 2014 05:56:34 -0700
Subject: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397652994.30935.5.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-16 at 14:40 +0200, Antoine T?nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin SoCs.
> This controller supports 3 sockets.

trivial notes:

> diff --git a/drivers/mmc/host/sdhci-berlin.c b/drivers/mmc/host/sdhci-berlin.c
[]
> +static struct sdhci_ops sdhci_berlin_ops = {
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2_pdata = {
> +	.quirks	= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_ADMA |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops = &sdhci_berlin_ops,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2q_pdata = {
> +	.quirks	= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops = &sdhci_berlin_ops,
> +};

Perhaps const?

> +static int sdhci_berlin_probe(struct platform_device *pdev)
> +{
[]
> +	host = sdhci_pltfm_init(pdev,
> +				(struct sdhci_pltfm_data *)device->data, 0);

Unnecessary cast?  Maybe:

	host = sdhci_pltfm_init(pdev, device->data, 0);

> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "could not get clock: %ld\n", PTR_ERR(clk));
> +		ret = PTR_ERR(clk);

PTR_ERR is an int.  Does this produce a compile warning?
Maybe reverse these lines and use ret?

		ret = PTR_ERR(clk);
		dev_err(dev, count not get clock: %d\n", ret);
