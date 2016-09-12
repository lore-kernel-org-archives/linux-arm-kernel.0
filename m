From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Sep 2016 10:12:15 +0100
Subject: [PATCH 22/20] iommu/arm-smmu: Fall back to global bypass
In-Reply-To: <9c467662ca0fb562cff6d5c9443d77eacb257060.1473443407.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
 <9c467662ca0fb562cff6d5c9443d77eacb257060.1473443407.git.robin.murphy@arm.com>
Message-ID: <20160912091215.GA23211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 07:17:47PM +0100, Robin Murphy wrote:
> Unlike SMMUv2, SMMUv3 has no easy way to bypass unknown stream IDs,
> other than allocating and filling in the entire stream table with bypass
> entries, which for some configurations would waste *gigabytes* of RAM.
> Otherwise, all transactions on unknown stream IDs will simply be aborted
> with a C_BAD_STREAMID event.
> 
> Rather than render the system unusable in the case of an invalid DT,
> avoid enabling the SMMU altogether such that everything bypasses
> (though letting the explicit disable_bypass option take precedence).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index be293b5aa896..859b80c83946 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -126,6 +126,9 @@
>  #define CR2_RECINVSID			(1 << 1)
>  #define CR2_E2H				(1 << 0)
>  
> +#define ARM_SMMU_GBPA			0x44
> +#define GBPA_ABORT			(1 << 20)
> +
>  #define ARM_SMMU_IRQ_CTRL		0x50
>  #define IRQ_CTRL_EVTQ_IRQEN		(1 << 2)
>  #define IRQ_CTRL_PRIQ_IRQEN		(1 << 1)
> @@ -2242,7 +2245,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>  	return ret;
>  }
>  
> -static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  {
>  	int ret;
>  	u32 reg, enables;
> @@ -2343,8 +2346,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> -	/* Enable the SMMU interface */
> -	enables |= CR0_SMMUEN;
> +
> +	/* Enable the SMMU interface, or ensure bypass */
> +	if (!bypass || disable_bypass) {
> +		enables |= CR0_SMMUEN;
> +	} else {
> +		reg = readl_relaxed(smmu->base + ARM_SMMU_GBPA);
> +		writel_relaxed(reg & ~GBPA_ABORT, smmu->base + ARM_SMMU_GBPA);
> +	}

I think this invokes the CONSTRAINED UNPREDICTABLE monster, because the
GBPA register has some a special update procedure involving the 'update'
bit (bit 31).

You might be able to reuse arm_smmu_write_reg_sync to poll for completion
with offset 0. I'm happy to assume that the update bit is initially clear.

Will
