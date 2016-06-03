From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 3 Jun 2016 15:13:00 +0200
Subject: [PATCH] iommu: convert DT component matching to
 component_match_add_release()
In-Reply-To: <E1b8jzj-00046r-Pd@rmk-PC.armlinux.org.uk>
References: <E1b8jzj-00046r-Pd@rmk-PC.armlinux.org.uk>
Message-ID: <5751825C.40703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/06/16 09:58, Russell King wrote:
> Convert DT component matching to use component_match_add_release().
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   drivers/iommu/mtk_iommu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c3043d8754e3..c036df1c49ca 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -557,6 +557,11 @@ static int compare_of(struct device *dev, void *data)
>   	return dev->of_node == data;
>   }
>
> +static void release_of(struct device *dev, void *data)
> +{
> +	of_node_put(data);
> +}
> +
>   static int mtk_iommu_bind(struct device *dev)
>   {
>   	struct mtk_iommu_data *data = dev_get_drvdata(dev);
> @@ -630,17 +635,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			continue;
>
>   		plarbdev = of_find_device_by_node(larbnode);
> -		of_node_put(larbnode);
>   		if (!plarbdev) {
>   			plarbdev = of_platform_device_create(
>   						larbnode, NULL,
>   						platform_bus_type.dev_root);
> -			if (!plarbdev)
> +			if (!plarbdev) {
> +				of_node_put(larbnode);
>   				return -EPROBE_DEFER;
> +			}
>   		}
>   		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
>
> -		component_match_add(dev, &match, compare_of, larbnode);
> +		component_match_add_release(dev, &match, release_of,
> +					    compare_of, larbnode);
>   	}
>
>   	platform_set_drvdata(pdev, data);
>
