From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Jun 2017 11:00:14 +0100
Subject: [PATCH v7 3/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #126
In-Reply-To: <1496145821-3411-4-git-send-email-gakula@caviumnetworks.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
 <1496145821-3411-4-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170609100014.GB13955@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geetha,

On Tue, May 30, 2017 at 05:33:41PM +0530, Geetha sowjanya wrote:
> From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> 
> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> lines for gerror, eventq and cmdq-sync.
> 
> This patch addresses the issue by checking if any interrupt sources are
> using same irq number, then they are registered as shared irqs.
> 
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt |    1 +
>  drivers/iommu/arm-smmu-v3.c            |   29 +++++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 4693a32..42422f6 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -63,6 +63,7 @@ stable kernels.
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
>  | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
> +| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>  |                |                 |                 |                             |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>  |                |                 |                 |                             |
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4e80205..d2db01f 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2232,6 +2232,25 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	devm_add_action(dev, arm_smmu_free_msis, dev);
>  }
>  
> +static int get_irq_flags(struct arm_smmu_device *smmu, int irq)
> +{
> +	int match_count = 0;
> +
> +	if (irq == smmu->evtq.q.irq)
> +		match_count++;
> +	if (irq == smmu->cmdq.q.irq)
> +		match_count++;
> +	if (irq == smmu->gerr_irq)
> +		match_count++;
> +	if (irq == smmu->priq.q.irq)
> +		match_count++;
> +
> +	if (match_count > 1)
> +		return IRQF_SHARED | IRQF_ONESHOT;
> +
> +	return IRQF_ONESHOT;
> +}

I really think this is the wrong way of solving the problem: using
IRQF_SHARED has implications elsewhere in the driver (for example, we must
then pass a unique dev_id otherwise freeing the IRQs won't work properly)
and I don't want to have to worry about these constraints just because of
this broken platform.

Please do what I suggested instead: register a single threaded interrupt
handler that acts as a multiplexer and manually calls the other routines.

Will
