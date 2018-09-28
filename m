From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Sep 2018 13:19:01 +0100
Subject: [PATCH v8 5/7] iommu/arm-smmu-v3: Add support for non-strict mode
In-Reply-To: <b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
Message-ID: <20180928121900.GB1577@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 05:10:25PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Now that io-pgtable knows how to dodge strict TLB maintenance, all
> that's left to do is bridge the gap between the IOMMU core requesting
> DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE for default domains, and showing the
> appropriate IO_PGTABLE_QUIRK_NON_STRICT flag to alloc_io_pgtable_ops().
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: convert to domain attribute, tweak commit message]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v8:
>  - Use nested switches for attrs
>  - Document barrier semantics
> 
>  drivers/iommu/arm-smmu-v3.c | 79 ++++++++++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f10c852479fc..db402e8b068b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -612,6 +612,7 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  
>  	struct io_pgtable_ops		*pgtbl_ops;
> +	bool				non_strict;
>  
>  	enum arm_smmu_domain_stage	stage;
>  	union {
> @@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  	}
>  
> +	/*
> +	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> +	 * PTEs previously cleared by unmaps on the current CPU not yet visible
> +	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
> +	 * to guarantee those are observed before the TLBI. Do be careful, 007.
> +	 */

Good, so you can ignore my comment on the previous patch :)

Will
