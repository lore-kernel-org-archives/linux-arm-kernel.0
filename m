From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 17 Jun 2016 15:07:36 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Fix iova_to_phys for block entries
In-Reply-To: <1466099078-3919-1-git-send-email-will.deacon@arm.com>
References: <1466099078-3919-1-git-send-email-will.deacon@arm.com>
Message-ID: <57640428.408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/16 18:44, Will Deacon wrote:
> The implementation of iova_to_phys for the long-descriptor ARM
> io-pgtable code always masks with the granule size when inserting the
> low virtual address bits into the physical address determined from the
> page tables. In cases where the leaf entry is found before the final
> level of table (i.e. due to a block mapping), this results in rounding
> down to the bottom page of the block mapping. Consequently, the physical
> address range batching in the vfio_unmap_unpin is defeated and we end
> up taking the long way home.
>
> This patch fixes the problem by masking the virtual address with the
> appropriate mask for the level at which the leaf descriptor is located.
> The short-descriptor code already gets this right, so no change is
> needed there.

With this, I now see VFIO unmapping at the same granularity as the 
initial mapping. To think of all the cumulative hours we've spent 
watching it split the blocks and go 4K at a time... *sigh*

Tested-by: Robin Murphy <robin.murphy@arm.com>

> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a1ed1b73fed4..f5c90e1366ce 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -576,7 +576,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>   	return 0;
>
>   found_translation:
> -	iova &= (ARM_LPAE_GRANULE(data) - 1);
> +	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
>   	return ((phys_addr_t)iopte_to_pfn(pte,data) << data->pg_shift) | iova;
>   }
>
>
