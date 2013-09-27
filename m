From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 09:41:54 +0100
Subject: [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to
 avoid divide by zero exception
In-Reply-To: <1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20130927084154.GB8319@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 11:36:16PM +0100, Andreas Herrmann wrote:
> With the right (or wrong;-) definition of v1 SMMU node in DTB it is
> possible to trigger a division by zero in arm_smmu_init_domain_context
> (if number of context irqs is 0):
> 
>        if (smmu->version == 1) {
>                root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
>  =>            root_cfg->irptndx %= smmu->num_context_irqs;
>        } else {
> 
> Avoid this by checking for num_context_irqs > 0 when probing
> for SMMU devices.
> 
> Rationale: Assuming that at least one context bank for non-secure
> usage is provided per SMMU, it follows (from ARM SMMU Architecture
> Spec) that at least one context interrupt must be available.

One problem with this reasoning is that the interrupt line might just not be
wired up to the GIC, despite existing on the SMMU. Still, we needn't solve
that now (let's wait for somebody to build it first...).

> Also remove the line of code that derived num_context_irqs from
> num_irqs and num_global_irqs. If DT is wrong and interrupt property
> contains less interrupts than num_global_irqs this would set
> num_context_irqs to a big u32 value which most likely causes trouble
> in other parts of the driver.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 4307fbc..de9dd60 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1822,7 +1822,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  			 num_irqs, smmu->num_global_irqs);
>  		smmu->num_global_irqs = num_irqs;
>  	}
> -	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;

Why are you deleting this line?

> +
> +	if (!smmu->num_context_irqs) {
> +		dev_err(dev, "no context interrupt specified in DT\n");

I'd avoid mentioning "DT" in the log message, just in case this ever starts
probing from something else.

Will
