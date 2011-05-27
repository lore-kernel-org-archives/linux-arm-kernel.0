From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 17:46:04 +0200
Subject: [PATCH v2 1/3] mmc: support sdhci-mmp2
In-Reply-To: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201105271746.04775.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 May 2011, Zhangfei Gao wrote:
> 	Instead of sharing sdhci-pxa.c, use sdhci-mmp2.c specificlly for mmp2.
> 	sdhci-pxa.c is used to share among pxa serious, like pxa910, mmp2, etc.
> 	The platfrom difference are put under arch/arm, while is not easy to track.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/sdhci.h |   43 ++++-
>  drivers/mmc/host/Kconfig               |   11 +-
>  drivers/mmc/host/Makefile              |    2 +-
>  drivers/mmc/host/sdhci-mmp2.c          |  303 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pxa.c           |  303 --------------------------------
>  5 files changed, 349 insertions(+), 313 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-mmp2.c
>  delete mode 100644 drivers/mmc/host/sdhci-pxa.c

Yes, looks good for the most part. I was rather confused by the fact that the old
and new file are both 303 lines, so I assumed they would be identical, when they
are really completely different.

There is a little room for simplification, I think:

> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
> +{
> +	/* Micro SD does not support write-protect feature */
> +	return 0;
> +}

You shouldn't need to provide an empty get_ro function, the
default is that there is no write-protect.

> +static void mmp2_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_pxa *pxa = pltfm_host->priv;
> +
> +	if (clock)
> +		mmp2_soc_set_timing(host, pxa->pdata);
> +}

The mmp2_soc_set_timing() function is only called here, so you can easily
merge the two into one, starting with

	if (!clock)
		return;

> +static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_host *host = NULL;
> +	struct sdhci_pxa *pxa = NULL;
> +	int ret;
> +	struct clk *clk;

The probe and release functions for mmp2 and pxa910 are almost identical.
I'd suggest you leave them in sdhci-pxa.c as a library, and export them
using EXPORT_SYMBOL_GPL. Then you can call them from the respective
probe functions, e.g.

static struct sdhci_mmp2_ops = {
	.set_clock = mmp2_set_clock,
	.set_uhs_signaling = mmp2_set_uhs_signaling,
	.get_ro = mmp2_get_ro,
};
static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
{
	 unsigned int quirks = SDHCI_QUIRK_BROKEN_ADMA
		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
		| SDHCI_QUIRK_32BIT_DMA_ADDR
		| SDHCI_QUIRK_32BIT_DMA_SIZE
		| SDHCI_QUIRK_32BIT_ADMA_SIZE
		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;

	return sdhci_pxa_probe(pdev, quirks, sdhci_mmp2_ops);
}

> +	pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
> +	if (!pxa) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
> +	if (!pxa->ops) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

I think you really shouldn't allocate the sdhci_ops dynamically.
In fact, it would be much better if we were able to mark them
as const in all drivers.

> +
> +#ifdef CONFIG_PM
> +static int sdhci_mmp2_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(dev);
> +
> +	return sdhci_suspend_host(host, state);
> +}
> +
> +static int sdhci_mmp2_resume(struct platform_device *dev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(dev);
> +
> +	return sdhci_resume_host(host);
> +}
> +#else
> +#define sdhci_mmp2_suspend	NULL
> +#define sdhci_mmp2_resume	NULL
> +#endif

Similarly, I think it would be good if sdhci-pltfm.c would simply
export these functions so you could refer to them in your driver.
There is no need to have identical copies in each variant.

	Arnd
