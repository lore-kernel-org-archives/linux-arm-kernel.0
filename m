From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 10 Jan 2018 07:27:24 +0100
Subject: [PATCH v2] iommu/exynos: Don't unconditionally steal bus ops
In-Reply-To: <da24d31fc6f4be7b44ceef215f672c0ed3c37979.1515511941.git.robin.murphy@arm.com>
References: <CGME20180109153413epcas2p2edcbf10c5a256acb473b03d140fd6bcd@epcas2p2.samsung.com>
 <da24d31fc6f4be7b44ceef215f672c0ed3c37979.1515511941.git.robin.murphy@arm.com>
Message-ID: <8ed83858-83c9-0920-19c7-b780b9089d22@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 2018-01-09 16:34, Robin Murphy wrote:
> Removing the early device registration hook overlooked the fact that
> it only ran conditionally on a compatible device being present in the
> DT. With exynos_iommu_init() now running as an unconditional initcall,
> problems arise on non-Exynos systems when other IOMMU drivers find
> themselves unable to install their ops on the platform bus, or at worst
> the Exynos ops get called with someone else's domain and all hell breaks
> loose.
>
> The global ops/cache setup could probably all now be triggered from the
> first IOMMU probe, as with dma_dev assigment, but for the time being the
> simplest fix is to resurrect the logic from commit a7b67cd5d9af
> ("iommu/exynos: Play nice in multi-platform builds") to explicitly check
> the DT for the presence of an Exynos IOMMU before trying anything.
>
> Fixes: 928055a01b3f ("iommu/exynos: Remove custom platform device registration code")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> v2: Use the simpler explicit DT check.
>
>   drivers/iommu/exynos-iommu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 79c45650f8de..736d4552d96f 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1353,8 +1353,15 @@ static const struct iommu_ops exynos_iommu_ops = {
>   
>   static int __init exynos_iommu_init(void)
>   {
> +	struct device_node *np;
>   	int ret;
>   
> +	np = of_find_matching_node(NULL, sysmmu_of_match);
> +	if (!np)
> +		return 0;
> +
> +	of_node_put(np);
> +
>   	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
>   				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
>   	if (!lv2table_kmem_cache) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
