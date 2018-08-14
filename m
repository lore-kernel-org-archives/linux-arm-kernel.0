From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 14 Aug 2018 17:59:08 +0100
Subject: [PATCH 4/5] iommu/arm-smmu: Make way to add Qcom's smmu-500
 errata handling
In-Reply-To: <20180814105528.20592-5-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814105528.20592-5-vivek.gautam@codeaurora.org>
Message-ID: <cfca5369-eacd-bb4b-6f1e-68a56f72c327@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/18 11:55, Vivek Gautam wrote:
> Cleanup to re-use some of the stuff
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)

I think the overall diffstat would be an awful lot smaller if the 
erratum workaround just has its own readl_poll_timeout() as it does in 
the vendor kernel. The burst-polling loop is for minimising latency in 
high-throughput situations, and if you're in a workaround which has to 
lock *every* register write and issue two firmware calls around each 
sync I think you're already well out of that game.

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 32e86df80428..75c146751c87 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -391,21 +391,31 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>   	clear_bit(idx, map);
>   }
>   
> -/* Wait for any pending TLB invalidations to complete */
> -static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
> -				void __iomem *sync, void __iomem *status)
> +static int __arm_smmu_tlb_sync_wait(void __iomem *status)
>   {
>   	unsigned int spin_cnt, delay;
>   
> -	writel_relaxed(0, sync);
>   	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>   		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
>   			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
> -				return;
> +				return 0;
>   			cpu_relax();
>   		}
>   		udelay(delay);
>   	}
> +
> +	return -EBUSY;
> +}
> +
> +/* Wait for any pending TLB invalidations to complete */
> +static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
> +				void __iomem *sync, void __iomem *status)
> +{
> +	writel_relaxed(0, sync);
> +
> +	if (!__arm_smmu_tlb_sync_wait(status))
> +		return;
> +
>   	dev_err_ratelimited(smmu->dev,
>   			    "TLB sync timed out -- SMMU may be deadlocked\n");
>   }
> @@ -461,8 +471,9 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
>   	arm_smmu_tlb_sync_global(smmu);
>   }
>   
> -static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> -					  size_t granule, bool leaf, void *cookie)
> +static void __arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					    size_t granule, bool leaf,
> +					    void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> @@ -498,6 +509,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>   	}
>   }
>   
> +static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					  size_t granule, bool leaf,
> +					  void *cookie)
> +{
> +	__arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
> +}
> +

AFAICS even after patch #5 this does absolutely nothing except make the 
code needlessly harder to read :(

Robin.

>   /*
>    * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
>    * almost negligible, but the benefit of getting the first one in as far ahead
> 
