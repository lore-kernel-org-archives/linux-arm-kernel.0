From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 17:27:21 -0700
Subject: [PATCHv4 7/7] iommu/tegra: smmu: Allow duplicate ASID wirte
In-Reply-To: <1384158718-4756-8-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-8-git-send-email-hdoyu@nvidia.com>
Message-ID: <5282C769.9040202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> The device, which belongs to the same ASID, can try to enable the same
> ASID as the other swgroup devices. This should be allowed but just
> skip the actual register write. If the write value is different, it
> will return -EINVAL.

That's pretty confusing. I'm not at all sure I understand what it means.

I /think/ you're saying that multiple devices can exist whose swgroup
values are the same, and when setting up those devices, the ASID
register for that swgroup gets written multiple times, once per device.
This change allows that, assuming that all the different devices attempt
to select the same ASID for that swgroup. If so,

Giving some specific examples of devices with the same swgroup value
would be useful. Along with sternly talking to the HW designers and
telling them to just give everything unique IDs:-(

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> @@ -346,8 +346,11 @@ static int __smmu_client_set_swgroups(struct smmu_client *c,
>  		offs = SWGROUP_ASID_REG(i);
>  		val = smmu_read(smmu, offs);
>  		if (on) {
> -			if (WARN_ON(val & mask))
> -				goto err_hw_busy;
> +			if (val) {

Why only check this if (val)? Surely the check is valid if (val == 0)
too; you don't want to go writing 0 into the ASID register if it's
already configured to point at something else?

Or, is "val" a bitmask of ASIDs, not an integer representing the ASID?

> +				if (WARN_ON(val != mask))
> +					return -EINVAL;
> +				goto skip;
> +			}
>  			val |= mask;

... I guess this would imply it's a bitmask.

But then that begs the question: if (on) means that ASID mapping is
being enabled, then isn't that invalid if (!mask)?
