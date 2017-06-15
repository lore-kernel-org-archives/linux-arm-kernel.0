From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 15 Jun 2017 11:59:59 +0800
Subject: [PATCH 1/2] ARM64/irqchip: Update ACPI_IORT symbol selection logic
In-Reply-To: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
References: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
Message-ID: <a5733e34-22f7-2ae9-b873-fee222a3f1c0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/6/15 0:37, Lorenzo Pieralisi wrote:
> ACPI IORT is an ACPI addendum to describe the connection topology of
> devices with IOMMUs and interrupt controllers on ARM64 ACPI systems.
> 
> Currently the ACPI IORT Kbuild symbol is selected whenever the Kbuild
> symbol ARM_GIC_V3_ITS is enabled, which in turn is selected by ARM64
> Kbuild defaults. This makes the logic behind ACPI_IORT selection a bit
> twisted and not easy to follow. On ARM64 systems enabling ACPI the
> kbuild symbol ACPI_IORT should always be selected in that it is a kernel
> layer provided to the ARM64 arch code to parse and enable ACPI firmware
> bindings.
> 
> Make the ACPI_IORT selection explicit in ARM64 Kbuild and remove the
> selection from ARM_GIC_V3_ITS entry, making the ACPI_IORT selection
> logic clearer to follow.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/Kconfig      | 1 +
>   drivers/irqchip/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b2024db..2424fb4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>   	select ACPI_CCA_REQUIRED if ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_GTDT if ACPI
> +	select ACPI_IORT if ACPI
>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>   	select ACPI_MCFG if ACPI
>   	select ACPI_SPCR_TABLE if ACPI
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 478f8ac..4a57b8f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -39,7 +39,6 @@ config ARM_GIC_V3_ITS
>   	bool
>   	depends on PCI
>   	depends on PCI_MSI
> -	select ACPI_IORT if ACPI

Make sense to me, IORT also describe SMMU+IO topology. I
give this patch a light test with CONFIG combination compile
test, and see no issues,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

>   
>   config ARM_NVIC
>   	bool
> 
