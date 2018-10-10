From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 18:08:37 +0100
Subject: [PATCH] iommu: arm-smmu: handle client iommu translation fault
 handlers
In-Reply-To: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
References: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
Message-ID: <20181010170837.GC16512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 05:44:07PM +0300, Stanimir Varbanov wrote:
> Call iommu client translation fault handler(s).
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/iommu/arm-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 066f4c8daf4e..02a8aab0cc59 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  			    fsr, iova, fsynr, cfg->cbndx);
>  
>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> +
> +	report_iommu_fault(domain, smmu->dev, iova, 0);

Who's using this? Generally, the callback here isn't so useful because it's
called in irq context. We also don't enable stalling since 3714ce1d6655.

We previously had fairly detailed discussions on the list with Rob Clark
about alternative ways to design this, but I don't remember where it ended
up.

Will
