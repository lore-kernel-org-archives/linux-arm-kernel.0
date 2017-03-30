From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 15:09:00 +0100
Subject: [PATCH 1/4] iommu/arm-smmu: Handle size mismatches better
In-Reply-To: <6e61306e6823943b3eeb0c405d4505dd565e723e.1488907474.git.robin.murphy@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
 <6e61306e6823943b3eeb0c405d4505dd565e723e.1488907474.git.robin.murphy@arm.com>
Message-ID: <20170330140900.GF22160@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Mar 07, 2017 at 06:09:04PM +0000, Robin Murphy wrote:
> We currently warn if the firmware-described region size differs from the
> SMMU address space size reported by the hardware, but continue to use
> the former to calculate where our context bank base should be,
> effectively guaranteeing that things will not work correctly.
> 
> Since over-mapping is effectively harmless, and under-mapping can be OK
> provided all the usable context banks are still covered, let's let the
> hardware information take precedence in the case of a mismatch, such
> that we get the correct context bank base and in most cases things will
> actually work instead of silently misbehaving. And at worst, if the
> firmware is wrong enough to have not mapped something we actually try to
> use, the resulting out-of-bounds access will hopefully provide a much
> more obvious clue.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index abf6496843a6..bc7ef6a0c54d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1864,10 +1864,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  	/* Check for size mismatch of SMMU address space from mapped region */
>  	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
>  	size *= 2 << smmu->pgshift;
> -	if (smmu->size != size)
> +	if (smmu->size != size) {
>  		dev_warn(smmu->dev,
>  			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
>  			size, smmu->size);
> +		smmu->size = size;
> +	}

I'm not really in favour of this, but I admit that this case is a bit weird.
Basically, we always have two ways to determine the size of the SMMU:

  1. The device-tree reg property, since we need the base address to be
     passed there and this will include a size.

  2. The ID register on the hardware itself

Generally, I prefer that properties passed by firmware override those
baked into the hardware, since this allows us to deal with broken ID
registers easily. In this case, we basically have the size override from
the reg property, so it takes precedence, but we warn if it differs from
the hardware value so hopefully broken DTs are easily diagnosed.

Will
