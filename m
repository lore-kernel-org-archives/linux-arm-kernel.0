From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Mar 2014 10:57:08 +0000
Subject: [PATCH] iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte
In-Reply-To: <1395396367-19110-1-git-send-email-binw@marvell.com>
References: <1395396367-19110-1-git-send-email-binw@marvell.com>
Message-ID: <532C1B04.2040601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bin,

On 21/03/14 10:06, Bin Wang wrote:
> kernel panic happened when iommu_unmap a buffer larger than 2MB,
> more than expected pmd entries got ?invalidated?, due to a wrong range
> passed to arm_smmu_alloc_init_pte. it was likely a typo, now we fix
> it, passing the correct "end" address to arm_smmu_alloc_init_pte.
> 
> Signed-off-by: Bin Wang <binw@marvell.com>
> ---
>  drivers/iommu/arm-smmu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 1d9ab39..52d0c34 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1346,7 +1346,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
>  
>  	do {
>  		next = pmd_addr_end(addr, end);
> -		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
> +		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
>  					      flags, stage);
>  		phys += next - addr;
>  	} while (pmd++, addr = next, addr < end);
> 

Looks like a valid fix. In Will's absence ([1]), I'll queue it for 3.15,
and CC stable.

Joerg: are you still taking pull requests for 3.15, or shall I wait
until rc1?

Thanks,

	M.

[1]: http://www.spinics.net/lists/arm-kernel/msg315615.html
-- 
Jazz is not dead. It just smells funny...
