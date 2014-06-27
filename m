From: hdoyu@nvidia.com (Hiroshi DOyu)
Date: Fri, 27 Jun 2014 12:46:02 +0300
Subject: [RFC 10/10] mmc: sdhci-tegra: Add IOMMU support
In-Reply-To: <1403815790-8548-11-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-11-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140627124602.53d046dae5d7e269815e56a0@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thierry Reding <thierry.reding@gmail.com> writes:

> From: Thierry Reding <treding@nvidia.com>
>
> Attach to the device's master interface of the IOMMU at .probe() time.
> IOMMU support becomes available via the DMA mapping API interoperation
> code, but this explicit attachment is necessary to ensure proper probe
> order.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 33100d10d176..b884614fa4e6 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/iommu.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> @@ -237,6 +238,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
>  	if (!match)
>  		return -EINVAL;
> +
> +	rc = iommu_attach(&pdev->dev);
> +	if (rc < 0)
> +		return rc;
> +

I thought that, if we consider that ->probe() should include minimal H/W
probing so that DMA API call in ->probe() could be deferred after
->probe() and till it's in use actually, like opening a device node. For
me this decision(minimal h/w probe) seemed logical but it would add a
new restriction. One advantage is that we could still keep all drivers
wihtout any IOMMU code if it doesn't call DMA API in ->probe().

>  	soc_data = match->data;
>  
>  	host = sdhci_pltfm_init(pdev, soc_data->pdata, 0);
> @@ -310,6 +316,8 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_put(pltfm_host->clk);
>  
> +	iommu_detach(&pdev->dev);
> +
>  	sdhci_pltfm_free(pdev);
>  
>  	return 0;
