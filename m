From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Jun 2017 19:34:39 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Implement shutdown method
In-Reply-To: <1498758015-7072-1-git-send-email-nwatters@codeaurora.org>
References: <1498758015-7072-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <20170629183438.GF5592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 01:40:15PM -0400, Nate Watterson wrote:
> The shutdown method disables the SMMU and its interrupts to avoid
> potentially corrupting a new kernel started with kexec.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

We should update arm-smmu.c as well.

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 380969a..907d576 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2765,9 +2765,19 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>  
>  	arm_smmu_device_disable(smmu);
> +
> +	/* Disable IRQs */
> +	arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> +				ARM_SMMU_IRQ_CTRLACK);
> +

Can you justify the need for this? If we actually need to disable
interrupts, then I'd like to understand why so that we can make sure we
get the ordering right with respect to disabling the device. Also, do we
need to clear the MSI registers too?

My understanding is that kexec will mask irqs at the GIC, so there's not
actually an issue here.

Will
