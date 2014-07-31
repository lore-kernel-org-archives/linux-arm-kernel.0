From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 19:30:22 +0100
Subject: [PATCH v4] iommu/arm-smmu: avoid calling request_irq in atomic
 context
In-Reply-To: <1406743093-17227-1-git-send-email-mitchelh@codeaurora.org>
References: <1406743093-17227-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140731183021.GJ26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 06:58:13PM +0100, Mitchel Humpherys wrote:
> request_irq shouldn't be called from atomic context since it might
> sleep, but we're calling it with a spinlock held, resulting in:

[...]

> @@ -900,22 +905,23 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->irptndx = cfg->cbndx;
>  	}
>  
> +	ACCESS_ONCE(smmu_domain->smmu) = smmu;
> +	arm_smmu_init_context_bank(smmu_domain);
> +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> +
>  	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
>  	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> -			  "arm-smmu-context-fault", domain);
> +			  "arm-smmu-context-fault", smmu_domain);

This blew up in testing since we free_irq using the iommu_domain as the
token, so we should leave the domain parameter as it is (not actually
sure why this got changed). No need to resend anything, I'll fix it
locally.

Cheers,

Will
