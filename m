From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 27 Jun 2017 15:56:10 +0200
Subject: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
 for Cavium ThunderX2 erratum #126
In-Reply-To: <1498224876-5200-1-git-send-email-gakula@caviumnetworks.com>
References: <1498224876-5200-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170627135610.GX658@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.06.17 19:04:36, Geetha sowjanya wrote:
> From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> 
> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> lines for gerror, eventq and cmdq-sync.
> 
> New named irq "combined" is set as a errata workaround, which allows to
> share the irq line by register single irq handler for all the interrupts.
> 
> Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
> ---
>  Documentation/arm64/silicon-errata.txt             |    1 +
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
>  drivers/acpi/arm64/iort.c                          |   57 ++++++++---
>  drivers/iommu/arm-smmu-v3.c                        |  100 ++++++++++++++-----
>  4 files changed, 121 insertions(+), 43 deletions(-)

> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +
> +	/* Disable IRQs first */
> +	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> +				      ARM_SMMU_IRQ_CTRLACK);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to disable irqs\n");
> +		return ret;
> +	}
> +
> +	irq = smmu->combined_irq;
> +	if (irq) {
> +		/*
> +		 * Cavium ThunderX2 implementation doesn't not support unique
> +		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
> +		 */
> +		ret = devm_request_threaded_irq(smmu->dev, irq,
> +					arm_smmu_combined_irq_handler,
> +					arm_smmu_combined_irq_thread,
> +					IRQF_ONESHOT,

Without the IRQF_SHARED flag set I see the following on a dual node
system now:

[   17.403260] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x2
[   17.408853] arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.417259] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x2
[   17.422856] arm-smmu-v3 arm-smmu-v3.1.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.431193] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x2
[   17.436787] arm-smmu-v3 arm-smmu-v3.2.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.445123] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x2
[   17.450697] arm-smmu-v3 arm-smmu-v3.3.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.458984] genirq: Flags mismatch irq 5. 00002001 (arm-smmu-v3-combined-irq) vs. 00002001 (arm-smmu-v3-combined-irq)
[   17.610636] arm-smmu-v3 arm-smmu-v3.3.auto: failed to enable combined irq
[   17.617491] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x2
[   17.623073] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.631339] genirq: Flags mismatch irq 6. 00002001 (arm-smmu-v3-combined-irq) vs. 00002001 (arm-smmu-v3-combined-irq)
[   17.782944] arm-smmu-v3 arm-smmu-v3.4.auto: failed to enable combined irq
[   17.789780] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x2
[   17.795367] arm-smmu-v3 arm-smmu-v3.5.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.803640] genirq: Flags mismatch irq 7. 00002001 (arm-smmu-v3-combined-irq) vs. 00002001 (arm-smmu-v3-combined-irq)
[   17.955248] arm-smmu-v3 arm-smmu-v3.5.auto: failed to enable combined irq

In __setup_irq() in kernel/irq/manage.c there is a check if that flag
is set which causes the error is shown.

-Robert

> +					"arm-smmu-v3-combined-irq", smmu);
> +		if (ret < 0)
> +			dev_warn(smmu->dev, "failed to enable combined irq\n");
> +	} else
> +		arm_smmu_setup_unique_irqs(smmu);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
>  
>  	/* Enable interrupt generation on the SMMU */
>  	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
