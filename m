From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 27 Apr 2017 15:39:10 +0200
Subject: [PATCH 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
In-Reply-To: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170427133910.GB31368@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.04.17 17:16:21, Geetha sowjanya wrote:
> From: Geetha <gakula@cavium.com>
> 
> Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
> 1. Errata ID #74
>    SMMU register alias Page 1 is not implemented
> 2. Errata ID #126
>    SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync
> 
> The following patchset does software workaround for these two erratas.
> 
> This series is based on RFC patch.  
> https://www.spinics.net/lists/arm-kernel/msg575739.html
> 
> As suggested by Will Deacon, code is modified to use silicon id to
> enable errata#74 workaround.

Can we go with the previous series [1] and:

 * drop the iort model numbering part,

 * add an enablement function that enables flags (smmu->options)
   depending on midr values (which replaces the macro code)?

E.g.:

static void acpi_smmu_enable_cavium(struct arm_smmu_device *smmu)
{
	u32 cpu_model;

	if (!IS_ENABLED(CONFIG_ARM64))
		return;

	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
	switch (cpu_model) {
	case ...:
	case ...:
		break;
	default:
		/* No Cavium CN99xx SMMU v3 */
		return;
	}

	smmu->options |= (ARM_SMMU_OPT_PAGE0_REGS_ONLY |
		      	 ARM_SMMU_OPT_USE_SHARED_IRQS);
}

-Robert


[1] [RFC PATCH 0/7] Cavium CN99xx SMMUv3 Errata workarounds
    https://marc.info/?l=linux-acpi&m=149192179623708&w=2

> 
> Linu Cherian (1):
>   iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74
> 
> Geetha (2):
>   arm64: Add MIDR values for Cavium cn99xx SoCs
>   iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126
> 
>  Documentation/arm64/silicon-errata.txt |  2 ++
>  arch/arm64/include/asm/cputype.h       |  3 ++
>  drivers/acpi/arm64/iort.c              | 14 +++++++-
>  drivers/iommu/arm-smmu-v3.c            | 64 +++++++++++++++++++++++++++++-----
>  4 files changed, 73 insertions(+), 10 deletions(-)
> 
> -- 
> 1.9.1
> 
