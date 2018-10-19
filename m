From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Oct 2018 18:44:48 +0100
Subject: [PATCH] iommu: arm-smmu: handle client iommu translation fault
 handlers
In-Reply-To: <6edd8f71-4363-01b6-6b45-aebc92604559@linaro.org>
References: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
 <20181010170837.GC16512@arm.com>
 <6edd8f71-4363-01b6-6b45-aebc92604559@linaro.org>
Message-ID: <20181019174447.GB4429@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 03:26:57PM +0300, Stanimir Varbanov wrote:
> On 10/10/2018 08:08 PM, Will Deacon wrote:
> > On Wed, Oct 10, 2018 at 05:44:07PM +0300, Stanimir Varbanov wrote:
> >> Call iommu client translation fault handler(s).
> >>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 066f4c8daf4e..02a8aab0cc59 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>  			    fsr, iova, fsynr, cfg->cbndx);
> >>  
> >>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >> +
> >> +	report_iommu_fault(domain, smmu->dev, iova, 0);
> > 
> > Who's using this? Generally, the callback here isn't so useful because it's
> 
> The idea was to use it from video driver to dump few multimedia
> interconnect registers which will give us some more info about the fault.
> 
> > called in irq context. We also don't enable stalling since 3714ce1d6655.
> > 
> > We previously had fairly detailed discussions on the list with Rob Clark
> > about alternative ways to design this, but I don't remember where it ended
> > up.
> 
> It will be useful if you point me to the discussion. Thanks!

There's more, but some stuff I managed to dig up is here:

https://lists.linuxfoundation.org/pipermail/iommu/2017-January/019931.html
https://lists.linuxfoundation.org/pipermail/iommu/2017-September/024143.html

Will
