From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 21 Sep 2016 11:35:50 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Using for_each_set_bit to simplify
 the code
In-Reply-To: <1474436491-26220-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1474436491-26220-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <3dd248de-5ef6-6255-fa7f-4f2c6a6de417@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/16 06:41, Kefeng Wang wrote:
> Using for_each_set_bit() to simplify the code.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 5 +----
>  drivers/iommu/io-pgtable-arm.c     | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index def8ca1..f23821b 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -789,8 +789,7 @@ static int __init arm_v7s_do_selftests(void)
>  	 * Distinct mappings of different granule sizes.
>  	 */
>  	iova = 0;
> -	i = find_first_bit(&cfg.pgsize_bitmap, BITS_PER_LONG);
> -	while (i != BITS_PER_LONG) {
> +	for_each_set_bit(i, &cfg.pgsize_bitmap, BITS_PER_LONG) {
>  		size = 1UL << i;
>  		if (ops->map(ops, iova, iova, size, IOMMU_READ |
>  						    IOMMU_WRITE |
> @@ -807,8 +806,6 @@ static int __init arm_v7s_do_selftests(void)
>  			return __FAIL(ops);
>  
>  		iova += SZ_16M;
> -		i++;
> -		i = find_next_bit(&cfg.pgsize_bitmap, BITS_PER_LONG, i);
>  		loopnr++;
>  	}
>  
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5c90e1..8c3dfb7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -980,8 +980,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>  		 * Distinct mappings of different granule sizes.
>  		 */
>  		iova = 0;
> -		j = find_first_bit(&cfg->pgsize_bitmap, BITS_PER_LONG);
> -		while (j != BITS_PER_LONG) {
> +		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
>  			size = 1UL << j;
>  
>  			if (ops->map(ops, iova, iova, size, IOMMU_READ |
> @@ -999,8 +998,6 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>  				return __FAIL(ops, i);
>  
>  			iova += SZ_1G;
> -			j++;
> -			j = find_next_bit(&cfg->pgsize_bitmap, BITS_PER_LONG, j);
>  		}
>  
>  		/* Partial unmap */
> 
