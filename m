From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2016 17:45:20 +0000
Subject: [PATCH] iommu/arm-smmu: Fix out-of-bounds dereference
In-Reply-To: <dea89ff1b2bd97b08d72f5c32fcf228bec767142.1478533142.git.robin.murphy@arm.com>
References: <dea89ff1b2bd97b08d72f5c32fcf228bec767142.1478533142.git.robin.murphy@arm.com>
Message-ID: <20161107174519.GE20591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 03:39:02PM +0000, Robin Murphy wrote:
> When we iterate a master's config entries, what we generally care
> about is the entry's stream map index, rather than the entry index
> itself, so it's nice to have the iterator automatically assign the
> former from the latter. Unfortunately, booting with KASAN reveals
> the oversight that using a simple comma operator results in the
> entry index being dereferenced before being checked for validity,
> so we always access one element past the end of the fwspec array.
> 
> Flip things around so that the check always happens before the index
> may be dereferenced.
> 
> Fixes: adfec2e709d2 ("iommu/arm-smmu: Convert to iommu_fwspec")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f86683eec446..44ffe3a391d6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -324,8 +324,10 @@ struct arm_smmu_master_cfg {
>  #define INVALID_SMENDX			-1
>  #define __fwspec_cfg(fw) ((struct arm_smmu_master_cfg *)fw->iommu_priv)
>  #define fwspec_smmu(fw)  (__fwspec_cfg(fw)->smmu)
> -#define for_each_cfg_sme(fw, i, idx) \
> -	for (i = 0; idx = __fwspec_cfg(fw)->smendx[i], i < fw->num_ids; ++i)
> +#define for_each_cfg_sme(fw, i, idx)					\
> +	for (i = 0;							\
> +	     i < fw->num_ids && (idx = __fwspec_cfg(fw)->smendx[i], true); \
> +	     ++i)

Urgh, that's vile. Is it worth wrapping that in (yet another) macro, which
either returns the index or -ENOENT if i is out of bounds?

Will
