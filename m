From: s-anna@ti.com (Anna, Suman)
Date: Mon, 23 Dec 2013 13:05:52 -0600
Subject: [PATCH 4/7] iommu/omap: Allow enable/disable even without pdata
In-Reply-To: <1387284818-28739-5-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-5-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <52B88990.5020807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 12/17/2013 06:53 AM, Florian Vaussard wrote:
> When booting with a devietree, no platform data is provided. Do not prematurely
> exit iommu_enable() and iommu_disable() in such a case.

Platform data may still be needed if we were to go with the pdata quirks 
approach for handling resets. You may need to revise the patch 
description then, but the change itself may be ok if supporting only DT 
devices.

regards
Suman

>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>   drivers/iommu/omap-iommu.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 51efcc4..0a9854d 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -149,13 +149,10 @@ static int iommu_enable(struct omap_iommu *obj)
>   	struct platform_device *pdev = to_platform_device(obj->dev);
>   	struct iommu_platform_data *pdata = pdev->dev.platform_data;
>
> -	if (!pdata)
> -		return -EINVAL;
> -
>   	if (!arch_iommu)
>   		return -ENODEV;
>
> -	if (pdata->deassert_reset) {
> +	if (pdata && pdata->deassert_reset) {
>   		err = pdata->deassert_reset(pdev, pdata->reset_name);
>   		if (err) {
>   			dev_err(obj->dev, "deassert_reset failed: %d\n", err);
> @@ -175,14 +172,11 @@ static void iommu_disable(struct omap_iommu *obj)
>   	struct platform_device *pdev = to_platform_device(obj->dev);
>   	struct iommu_platform_data *pdata = pdev->dev.platform_data;
>
> -	if (!pdata)
> -		return;
> -
>   	arch_iommu->disable(obj);
>
>   	pm_runtime_put_sync(obj->dev);
>
> -	if (pdata->assert_reset)
> +	if (pdata && pdata->assert_reset)
>   		pdata->assert_reset(pdev, pdata->reset_name);
>   }
>
>
