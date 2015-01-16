From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Jan 2015 10:45:59 +0000
Subject: [PATCH v7 12/17] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
In-Reply-To: <1421247905-3749-13-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-13-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B8EBE7.808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/15 15:05, Hanjun Guo wrote:
> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
> used, and then register device's gsi with the core IRQ subsystem.
> 
> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
> since gsi is unique in the system, so use hwirq number directly
> for the mapping.
> 
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c       |  3 ++
>  include/linux/acpi.h     |  1 +
>  3 files changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 0b7c3a6..c3e24c4 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -37,6 +37,12 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>  static int enabled_cpus;	/* Processors (GICC) with enabled flag in MADT */
>  
>  /*
> + * Since we're on ARM, the default interrupt routing model
> + * clearly has to be GIC.
> + */
> +enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
> +
> +/*
>   * __acpi_map_table() will be called before page_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
>   */
> @@ -184,6 +190,73 @@ void __init acpi_smp_init_cpus(void)
>  	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
>  }
>  
> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> +{
> +	*irq = irq_find_mapping(NULL, gsi);

Is the ACPI implementation really expecting to only deal with a single
domain for interrupts?

This is likely to lead to a number of issues as we're now implementing
stacked domains (GICv2m, GICv3 ITS are already using that model, and
"wire-to MSI translators" will certainly do the same).

This means that, despite having a single GIC described in ACPI, you may
end-up with multiple domains. I expect you'll be safe with MSI (assuming
you never describe them in ACPI), but any form of wire-to-MSI
translation won't work at all.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
