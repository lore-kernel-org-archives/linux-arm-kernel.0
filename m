From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 5 Feb 2018 18:08:31 +0000
Subject: [PATCH 1/1] iommu/io-pgtable: use size_t return type for all
 foo_unmap
In-Reply-To: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <9c91b0a0-3163-09c6-e0d8-6cb69fbf76b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/18 17:59, Vivek Gautam wrote:
> Unmap returns a size_t all throughout the IOMMU framework.
> Make io-pgtable match this convention.
> Moreover, there isn't a need to have a signed int return type
> as we return 0 in case of failures.

That makes sense (the code itself has always followed that convention, 
even if the prototypes didn't), and at a glance it looks like you've 
caught all the sites which need it.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 21 +++++++++++----------
>   drivers/iommu/io-pgtable-arm.c     | 24 ++++++++++++------------
>   drivers/iommu/io-pgtable.h         |  4 ++--
>   3 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 2ca08dc9331c..10e4a3d11c02 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -357,8 +357,8 @@ static bool arm_v7s_pte_is_cont(arm_v7s_iopte pte, int lvl)
>   	return false;
>   }
>   
> -static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *, unsigned long,
> -			   size_t, int, arm_v7s_iopte *);
> +static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *, unsigned long,
> +			      size_t, int, arm_v7s_iopte *);
>   
>   static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
>   			    unsigned long iova, phys_addr_t paddr, int prot,
> @@ -541,9 +541,10 @@ static arm_v7s_iopte arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
>   	return pte;
>   }
>   
> -static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
> -				   unsigned long iova, size_t size,
> -				   arm_v7s_iopte blk_pte, arm_v7s_iopte *ptep)
> +static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
> +				      unsigned long iova, size_t size,
> +				      arm_v7s_iopte blk_pte,
> +				      arm_v7s_iopte *ptep)
>   {
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>   	arm_v7s_iopte pte, *tablep;
> @@ -584,9 +585,9 @@ static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
>   	return size;
>   }
>   
> -static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
> -			    unsigned long iova, size_t size, int lvl,
> -			    arm_v7s_iopte *ptep)
> +static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
> +			      unsigned long iova, size_t size, int lvl,
> +			      arm_v7s_iopte *ptep)
>   {
>   	arm_v7s_iopte pte[ARM_V7S_CONT_PAGES];
>   	struct io_pgtable *iop = &data->iop;
> @@ -656,8 +657,8 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
>   	return __arm_v7s_unmap(data, iova, size, lvl + 1, ptep);
>   }
>   
> -static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> -			 size_t size)
> +static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> +			    size_t size)
>   {
>   	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
>   
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 51e5c43caed1..8faaaa04d7a7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -268,9 +268,9 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>   		__arm_lpae_sync_pte(ptep, cfg);
>   }
>   
> -static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> -			    unsigned long iova, size_t size, int lvl,
> -			    arm_lpae_iopte *ptep);
> +static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> +			       unsigned long iova, size_t size, int lvl,
> +			       arm_lpae_iopte *ptep);
>   
>   static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   				phys_addr_t paddr, arm_lpae_iopte prot,
> @@ -506,10 +506,10 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
>   	kfree(data);
>   }
>   
> -static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
> -				    unsigned long iova, size_t size,
> -				    arm_lpae_iopte blk_pte, int lvl,
> -				    arm_lpae_iopte *ptep)
> +static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
> +				       unsigned long iova, size_t size,
> +				       arm_lpae_iopte blk_pte, int lvl,
> +				       arm_lpae_iopte *ptep)
>   {
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>   	arm_lpae_iopte pte, *tablep;
> @@ -560,9 +560,9 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   	return size;
>   }
>   
> -static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> -			    unsigned long iova, size_t size, int lvl,
> -			    arm_lpae_iopte *ptep)
> +static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> +			       unsigned long iova, size_t size, int lvl,
> +			       arm_lpae_iopte *ptep)
>   {
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> @@ -606,8 +606,8 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   	return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
>   }
>   
> -static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> -			  size_t size)
> +static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> +			     size_t size)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>   	arm_lpae_iopte *ptep = data->pgd;
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index cd2e1eafffe6..2df79093cad9 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -119,8 +119,8 @@ struct io_pgtable_cfg {
>   struct io_pgtable_ops {
>   	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot);
> -	int (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
> -		     size_t size);
> +	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
> +			size_t size);
>   	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
>   				    unsigned long iova);
>   };
> 
