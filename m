From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 02 Jan 2014 01:13:42 +0100
Subject: [PATCH 3/7] iommu/omap: Convert to devicetree
In-Reply-To: <1387284818-28739-4-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-4-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1764051.JiGg1d3s1L@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Thank you for the patch.

On Tuesday 17 December 2013 13:53:34 Florian Vaussard wrote:
> As OMAP2+ is moving to a full DT boot for 3.14, commit 7ce93f3
> "ARM: OMAP2+: Fix more missing data for omap3.dtsi file" adds
> basic DT bits. But the driver is not yet converted, so this will
> not work and driver will not be probed. Convert it!
> 
> Apart from standard bindings, this patch uses 'dma-window' (already
> used by Tegra SMMU) and adds a custom 'ti,#tlb-entries' binding.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 19 ++++++++++++
>  arch/arm/mach-omap2/omap-iommu.c                   |  5 +++
>  drivers/iommu/omap-iommu.c                         | 36 ++++++++++++++++---
>  3 files changed, 55 insertions(+), 5 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt

[snip]

> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 385bf5e..51efcc4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c

[snip]

> @@ -1260,11 +1277,20 @@ static int omap_iommu_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> +#if defined(CONFIG_OF)
> +static struct of_device_id omap_iommu_of_match[] = {
> +	{ .compatible = "ti,omap3-mmu-isp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap_iommu_of_match);
> +#endif
> +
>  static struct platform_driver omap_iommu_driver = {
>  	.probe	= omap_iommu_probe,
>  	.remove	= omap_iommu_remove,
>  	.driver	= {
>  		.name	= "omap-iommu",
> +		.of_match_table = omap_iommu_of_match,

If CONFIG_OF isn't defined (pretty unlikely I agree, but a possibility you 
seem to be prepared for nonetheless given the above #if), this will fail to 
compile.

>  	},
>  };

-- 
Regards,

Laurent Pinchart
