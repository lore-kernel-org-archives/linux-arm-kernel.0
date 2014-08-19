From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Aug 2014 13:58:34 +0100
Subject: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
In-Reply-To: <1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140819125833.GO23128@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:51:34AM +0100, Mitchel Humpherys wrote:
> On some platforms with tight power constraints it is polite to only
> leave your clocks on for as long as you absolutely need them. Currently
> we assume that all clocks necessary for SMMU register access are always
> on.
> 
> Add some optional device tree properties to specify any clocks that are
> necessary for SMMU register access and turn them on and off as needed.
> 
> If no clocks are specified in the device tree things continue to work
> the way they always have: we assume all necessary clocks are always
> turned on.

How does this interact with an SMMU in bypass mode?

[...]

> +static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < smmu->num_clocks; ++i) {
> +		ret = clk_prepare_enable(smmu->clocks[i]);
> +		if (ret) {
> +			dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
> +			while (i--)
> +				clk_disable_unprepare(smmu->clocks[i]);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
> +{
> +	int i;
> +
> +	for (i = 0; i < smmu->num_clocks; ++i)
> +		clk_disable_unprepare(smmu->clocks[i]);
> +}

What stops theses from racing with each other when there are multiple
clocks? I also assume that the clk API ignores calls to clk_enable_prepare
for a clk that's already enabled? I couldn't find that code...

>  /* Wait for any pending TLB invalidations to complete */
>  static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>  {
> @@ -644,11 +672,15 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	void __iomem *cb_base;
>  
> +	arm_smmu_enable_clocks(smmu);

How can I get a context interrupt from an SMMU without its clocks enabled?

[...]

> +int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  {
>  	unsigned long size;
>  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> @@ -2027,10 +2124,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	}
>  	dev_notice(dev, "registered %d master devices\n", i);
>  
> -	err = arm_smmu_device_cfg_probe(smmu);
> +	err = arm_smmu_init_clocks(smmu);
>  	if (err)
>  		goto out_put_masters;
>  
> +	arm_smmu_enable_clocks(smmu);
> +
> +	err = arm_smmu_device_cfg_probe(smmu);
> +	if (err)
> +		goto out_disable_clocks;
> +
>  	parse_driver_options(smmu);
>  
>  	if (smmu->version > 1 &&
> @@ -2039,7 +2142,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  			"found only %d context interrupt(s) but %d required\n",
>  			smmu->num_context_irqs, smmu->num_context_banks);
>  		err = -ENODEV;
> -		goto out_put_masters;
> +		goto out_disable_clocks;
>  	}
>  
>  	for (i = 0; i < smmu->num_global_irqs; ++i) {
> @@ -2061,12 +2164,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	spin_unlock(&arm_smmu_devices_lock);
>  
>  	arm_smmu_device_reset(smmu);
> +	arm_smmu_disable_clocks(smmu);

I wonder if this is really the right thing to do. Rather than the
fine-grained clock enable/disable you have, why don't we just enable in
domain_init and disable in domain_destroy, with refcounting for the clocks?

Will
