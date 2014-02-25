From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 25 Feb 2014 22:15:32 +0100
Subject: [PATCHv2 07/16] iommu/omap: allow enable/disable even without
 pdata
In-Reply-To: <1392315347-32967-8-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-8-git-send-email-s-anna@ti.com>
Message-ID: <5986613.CineS9pX88@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

Thank you for the patch.

On Thursday 13 February 2014 12:15:38 Suman Anna wrote:
> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> When booting with a devicetree, no platform data is provided.
> Do not prematurely exit iommu_enable() and iommu_disable() in
> such a case.
> 
> Note: As OMAP do not yet has a proper reset controller driver,
> IOMMUs requiring a reset signal should use pdata-quirks as a
> transitional solution.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

This looks good to me, but you should move this patch before 04/16, otherwise 
you'll break bisection.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/omap-iommu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index f6afe8f..7672eb4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -149,13 +149,10 @@ static int iommu_enable(struct omap_iommu *obj)
>  	struct platform_device *pdev = to_platform_device(obj->dev);
>  	struct iommu_platform_data *pdata = pdev->dev.platform_data;
> 
> -	if (!pdata)
> -		return -EINVAL;
> -
>  	if (!arch_iommu)
>  		return -ENODEV;
> 
> -	if (pdata->deassert_reset) {
> +	if (pdata && pdata->deassert_reset) {
>  		err = pdata->deassert_reset(pdev, pdata->reset_name);
>  		if (err) {
>  			dev_err(obj->dev, "deassert_reset failed: %d\n", err);
> @@ -175,14 +172,11 @@ static void iommu_disable(struct omap_iommu *obj)
>  	struct platform_device *pdev = to_platform_device(obj->dev);
>  	struct iommu_platform_data *pdata = pdev->dev.platform_data;
> 
> -	if (!pdata)
> -		return;
> -
>  	arch_iommu->disable(obj);
> 
>  	pm_runtime_put_sync(obj->dev);
> 
> -	if (pdata->assert_reset)
> +	if (pdata && pdata->assert_reset)
>  		pdata->assert_reset(pdev, pdata->reset_name);
>  }

-- 
Regards,

Laurent Pinchart
