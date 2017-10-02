From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 2 Oct 2017 10:50:14 +0100
Subject: [RFC 11/11] hack: Revert "iommu/io-pgtable: Sanitise map/unmap
 addresses"
In-Reply-To: <1506690553-27357-12-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1506690553-27357-12-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <8c438c56-b5c1-52ee-bc3b-2d8390cb552c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

On 29/09/17 14:09, Ulrich Hecht wrote:
> This check breaks DRM initialization on Acer Chromebook R13, paddr is above
> 4GB. Haven't looked into this yet.

I think you mean "DRM initialisation was happening to still work with
silently truncated addresses..." ;)

Anyway, the Mediatek-specific fix is in rc3 now - 1ff9b17cedb3
("iommu/mediatek: Limit the physical address in 32bit for v7s")

Robin.

> This reverts commit 76557391433c77d330cede1a531b358d2f90df66.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 6 ------
>  drivers/iommu/io-pgtable-arm.c     | 7 -------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index d665d0d..af330f5 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -479,9 +479,6 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>  		return 0;
>  
> -	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> -		return -ERANGE;
> -
>  	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
>  	/*
>  	 * Synchronise all PTE updates for the new mapping before there's
> @@ -662,9 +659,6 @@ static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>  	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
>  	size_t unmapped;
>  
> -	if (WARN_ON(upper_32_bits(iova)))
> -		return 0;
> -
>  	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
>  	if (unmapped)
>  		io_pgtable_tlb_sync(&data->iop);
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index e8018a3..b182039 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -452,10 +452,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>  		return 0;
>  
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> -		    paddr >= (1ULL << data->iop.cfg.oas)))
> -		return -ERANGE;
> -
>  	prot = arm_lpae_prot_to_pte(data, iommu_prot);
>  	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep);
>  	/*
> @@ -614,9 +610,6 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int lvl = ARM_LPAE_START_LVL(data);
>  
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
> -		return 0;
> -
>  	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
>  	if (unmapped)
>  		io_pgtable_tlb_sync(&data->iop);
> 
