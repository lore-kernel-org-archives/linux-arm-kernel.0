From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 12:19:37 -0700
Subject: [PATCHv7 10/12] iommu/tegra: smmu: allow duplicate ASID wirte
In-Reply-To: <1386835033-4701-11-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-11-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF5249.6050802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> The device, which belongs to the same ASID, can try to enable the same
> ASID as the other swgroup devices. This should be allowed but just
> skip the actual register write. If the write value is different, it
> will return -EINVAL.

I guess this simplifies the body of the code a lot. Given this, I would
revise the code I suggested in response to a previous patch, to
something more like:

		offs = HWGRP_ASID_REG(i);
		val = smmu_read(smmu, offs);
		if (on) {
			if (WARN_ON(val && val != new_val))
				return -ENODEV;
			memcpy(c->hwgrp, map, sizeof(u64));
		} else {
			WARN_ON(val);
		}
		smmu_write(smmu, val, offs);

> +			if (val) {
> +				if (WARN_ON(val != mask))
> +					return -EINVAL;
> +				goto skip;

That means that:

a) No error is returned when the ASIDs don't match. Surely you still
want to return an error?

b) "skip" skips setting up all HWGRP IDs for the device, whereas perhaps
only 1 was shared yet the rest still need to be set up. If you really do
want to ignore the error, then surely you want "continue;" here not
"goto skip;"?

> +			}
...
> +skip:
>  	return 0;
