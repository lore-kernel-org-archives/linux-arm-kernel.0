From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 12:02:42 -0700
Subject: [PATCHv7 08/12] iommu/tegra: smmu: calculate ASID register offset
 by ID
In-Reply-To: <1386835033-4701-9-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-9-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF4E52.9010000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> ASID register offset is caclulated by SWGROUP ID so that we can get
> rid of old SoC specific MACROs. This ID conversion is needed for the
> unified SMMU driver over Tegra SoCs. We use dt-bindings MACRO instead
> of SoC dependent MACROs. The formula is:
> 
>   MC_SMMU_<swgroup name>_ASID_0 = MC_SMMU_AFI_ASID_0 + ID * 4;
> 
> Now SWGROUP ID is the global HardWare Accelerator(HWA) identifier
> among all Tegra SoC except Tegra2.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static int __smmu_client_set_hwgrp(struct smmu_client *c,
> -				   unsigned long map, int on)
> +				   unsigned long *map, int on)
>  {
>  	int i;
>  	struct smmu_as *as = c->as;
>  	u32 val, offs, mask = SMMU_ASID_ENABLE(as->asid);
>  	struct smmu_device *smmu = as->smmu;
>  
>  	if (!on)
> +		map = c->hwgrp;
>  
> +	for_each_set_bit(i, map, TEGRA_SWGROUP_MAX) {
>  		offs = HWGRP_ASID_REG(i);
>  		val = smmu_read(smmu, offs);
>  		if (on) {
>  			if (WARN_ON(val & mask))
>  				goto err_hw_busy;
>  			val |= mask;
> +			memcpy(c->hwgrp, map, sizeof(u64));
>  		} else {
>  			WARN_ON((val & mask) == mask);
>  			val &= ~mask;
>  		}
>  		smmu_write(smmu, val, offs);
>  	}

This function doesn't make a lot of sense to me. The registers it's
manipulating aren't a bitmask, so I don't see why the code is performing
bitmask AND/OR operations on the register. Instead, don't you want the
following:

#define SMMU_ASID_ENABLE	(1 << 31)
#define SMMU_ASID_ENABLED(asid)	(SMMU_ASID_ENABLE | asid)
#define SMMU_ASID_DISABLE	0

static int __smmu_client_set_hwgrp(struct smmu_client *c,
				   unsigned long *map, int on)
{
	int i;
	struct smmu_as *as = c->as;
	u32 val, offs, new_val;
	struct smmu_device *smmu = as->smmu;

	if (!on)
		map = c->hwgrp;

	for_each_set_bit(i, map, TEGRA_SWGROUP_MAX) {
		offs = HWGRP_ASID_REG(i);
		val = smmu_read(smmu, offs);
		if (on)
			new_val = SMMU_ASID_ENABLED(as->asid);
		else
			new_val = 0;
		WARN_ON(val & SMMU_ASID_ENABLE ==
			new_val & SMMU_ASID_ENABLE);
		if (on) {
			if (val & SMMU_ASID_ENABLE)
				goto err_hw_busy;
			memcpy(c->hwgrp, map, sizeof(u64));
		}
		smmu_write(smmu, val, offs);
	}

> @@ -804,7 +727,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
>  		return -ENOMEM;
>  	client->dev = dev;
>  	client->as = as;
> -	map = (unsigned long)dev->platform_data;
> +	map = (unsigned long *)dev->platform_data;
>  	if (!map)
>  		return -EINVAL;

Presumably we can simply delete that now since everything using this
driver is on DT; we can't rely on the platform_data of client struct
devices...
