From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 25 Sep 2017 10:47:35 +0100
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Need dma-sync while there is no
 QUIRK_NO_DMA
In-Reply-To: <1506331727-25018-1-git-send-email-yong.wu@mediatek.com>
References: <1506331727-25018-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <cd5a5dc4-85c2-b923-1110-d69d7b0d7aea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/17 10:28, Yong Wu wrote:
> Fix the commit 81b3c2521844 ("iommu/io-pgtable: Introduce explicit
> coherency"). If there is no IO_PGTABLE_QUIRK_NO_DMA, we should call
> dma_sync_single_for_device for cache synchronization.

Oops!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Rebased on v4.14-rc1.
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index d665d0d..6961fc3 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -245,7 +245,7 @@ static void __arm_v7s_free_table(void *table, int lvl,
>  static void __arm_v7s_pte_sync(arm_v7s_iopte *ptep, int num_entries,
>  			       struct io_pgtable_cfg *cfg)
>  {
> -	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)
>  		return;
>  
>  	dma_sync_single_for_device(cfg->iommu_dev, __arm_v7s_dma_addr(ptep),
> 
