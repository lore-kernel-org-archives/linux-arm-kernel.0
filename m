From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Jul 2014 10:18:17 +0100
Subject: [PATCH] iommu/arm-smmu: avoid calling request_irq in atomic
 context
In-Reply-To: <1406330819-25323-1-git-send-email-mitchelh@codeaurora.org>
References: <1406330819-25323-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140726091817.GA20396@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 04:26:59PM -0700, Mitchel Humpherys wrote:
> -	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> -	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> -			  "arm-smmu-context-fault", domain);
> -	if (IS_ERR_VALUE(ret)) {
> -		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> -			cfg->irptndx, irq);
> -		cfg->irptndx = INVALID_IRPTNDX;
> -		goto out_free_context;
> -	}
> -
>  	smmu_domain->smmu = smmu;
>  	arm_smmu_init_context_bank(smmu_domain);
>  	return 0;
> -
> -out_free_context:
> -	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> -	return ret;

This returns 'ret' from request_irq.

> +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> +			  "arm-smmu-context-fault", domain);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> +			cfg->irptndx, irq);
> +		cfg->irptndx = INVALID_IRPTNDX;
> +		return -ENODEV;

This returns -ENODEV instead.

> +	}
> +
>  	/* Looks ok, so add the device to the domain */
> -	cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
> -	if (!cfg)
> +	master_cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
> +	if (!master_cfg)
>  		return -ENODEV;

If this fails, we exit leaving the interrupt registered.  This is a
bug introduced by this change.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
