From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 13 Aug 2014 14:17:21 -0700
Subject: [PATCH 2/6] iommu/arm-smmu: add support for specifying regulators
In-Reply-To: <1407891099-24641-3-git-send-email-mitchelh@codeaurora.org>
 (Mitchel Humpherys's message of "Tue, 12 Aug 2014 17:51:35 -0700")
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-3-git-send-email-mitchelh@codeaurora.org>
Message-ID: <vnkwiolwf5su.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12 2014 at 05:51:35 PM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> On some power-constrained platforms it's useful to disable power when a
> device is not in use. Add support for specifying regulators for SMMUs
> and only leave power on as long as the SMMU is in use (attached).
>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   3 +
>  drivers/iommu/arm-smmu.c                           | 102 ++++++++++++++++++---
>  2 files changed, 93 insertions(+), 12 deletions(-)

[...]

> @@ -2124,13 +2192,19 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	}
>  	dev_notice(dev, "registered %d master devices\n", i);
>  
> +	err = arm_smmu_init_regulators(smmu);
> +	if (err)
> +		goto out_put_masters;
> +
>  	err = arm_smmu_init_clocks(smmu);
>  	if (err)
>  		goto out_put_masters;
>  
> +	arm_smmu_enable_regulators(smmu);
>  	arm_smmu_enable_clocks(smmu);
> -
>  	err = arm_smmu_device_cfg_probe(smmu);
> +	arm_smmu_disable_clocks(smmu);
> +	arm_smmu_disable_regulators(smmu);
>  	if (err)
>  		goto out_disable_clocks;

The out_disable_clocks label can go away now that arm_smmu_device_reset
is done in arm_smmu_attach_dev.


>  
> @@ -2163,8 +2237,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	list_add(&smmu->list, &arm_smmu_devices);
>  	spin_unlock(&arm_smmu_devices_lock);
>  
> -	arm_smmu_device_reset(smmu);
> -	arm_smmu_disable_clocks(smmu);
>  	return 0;
>  
>  out_free_irqs:
> @@ -2173,6 +2245,7 @@ out_free_irqs:
>  
>  out_disable_clocks:
>  	arm_smmu_disable_clocks(smmu);
> +	arm_smmu_disable_regulators(smmu);
>  
>  out_put_masters:
>  	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
