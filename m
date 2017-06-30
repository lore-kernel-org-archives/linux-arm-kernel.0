From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Jun 2017 18:11:03 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Implement shutdown method
In-Reply-To: <5f655f54-a843-af16-e9e3-0e0d84565994@codeaurora.org>
References: <1498758015-7072-1-git-send-email-nwatters@codeaurora.org>
 <20170629183438.GF5592@arm.com>
 <5f655f54-a843-af16-e9e3-0e0d84565994@codeaurora.org>
Message-ID: <20170630171103.GA15682@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 06:20:00PM -0400, Nate Watterson wrote:
> On 6/29/2017 2:34 PM, Will Deacon wrote:
> >On Thu, Jun 29, 2017 at 01:40:15PM -0400, Nate Watterson wrote:
> >>The shutdown method disables the SMMU and its interrupts to avoid
> >>potentially corrupting a new kernel started with kexec.
> >>
> >>Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> >>---
> >>  drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >
> >We should update arm-smmu.c as well.
> >
> >>diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >>index 380969a..907d576 100644
> >>--- a/drivers/iommu/arm-smmu-v3.c
> >>+++ b/drivers/iommu/arm-smmu-v3.c
> >>@@ -2765,9 +2765,19 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
> >>  	arm_smmu_device_disable(smmu);
> >>+
> >>+	/* Disable IRQs */
> >>+	arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> >>+				ARM_SMMU_IRQ_CTRLACK);
> >>+
> >
> >Can you justify the need for this? If we actually need to disable
> >interrupts, then I'd like to understand why so that we can make sure we
> >get the ordering right with respect to disabling the device. Also, do we
> >need to clear the MSI registers too?
> 
> I have no justification. Based on the number of drivers that take care
> to prevent their HW from generating an interrupt, I thought it would be
> required, but I can't find any such requirement explicitly laid out in
> the documentation.
> 
> When you mention the MSI registers do you mean, for instance,
> SMMU_GERROR_IRQ_CFG0? It looks like those are always cleared while
> initializing the SMMU so the case where an SMMU transitions from using
> MSIs to using wired interrupts between kernels will be handled properly.

Sure, but if it's only the re-init path you're concerned about, then I
don't think we have a problem for wired interrupts either. They're masked
at the GIC until we do request_irq, and our handler can tolerate a spurious
IRQ anyway.

I assumed the race you were trying to close was an IRQ firing after we've
disabled the device, but actually, I think the GIC is the right place to
handle that too because propagation delay can cause late IRQs anyway.

So unless there's a case I'm missing, let's not confuse the code by
disabling IRQs for the sake of it.

Will
