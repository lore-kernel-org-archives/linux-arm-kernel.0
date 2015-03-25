From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 13:20:44 +0000
Subject: [PATCH 1/5] ACPI: move arm64 GSI IRQ model to generic GSI IRQ
 layer
In-Reply-To: <1427219940-27201-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5512B62C.7030500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/15 17:58, Lorenzo Pieralisi wrote:
> The code deployed to implement GSI linux IRQ numbers mapping on arm64 turns
> out to be generic enough so that it can be moved to ACPI core code along
> with its respective config option ACPI_GENERIC_GSI selectable on
> architectures that can reuse the same code.
> 
> Current ACPI IRQ mapping code is not integrated in the kernel IRQ domain
> infrastructure, in particular there is no way to look-up the
> IRQ domain associated with a particular interrupt controller, so this
> first version of GSI generic code carries out the GSI<->IRQ mapping relying
> on the IRQ default domain which is supposed to be always set on a
> specific architecture in case the domain structure passed to
> irq_create/find_mapping() functions is missing.
> 
> This patch moves the arm64 acpi functions that implement the gsi mappings:
> 
> acpi_gsi_to_irq()
> acpi_register_gsi()
> acpi_unregister_gsi()
> 
> to ACPI core code. Since the generic GSI<->domain mapping is based on IRQ
> domains, it can be extended as soon as a way to map an interrupt
> controller to an IRQ domain is implemented for ACPI in the IRQ domain
> layer.
> 
> x86 and ia64 code for GSI mappings cannot rely on the generic GSI
> layer at present for legacy reasons, so they do not select the
> ACPI_GENERIC_GSI config options and keep relying on their arch
> specific GSI mapping layer.

This looks like the right thing to do. I definitely like the sanity
checking that has been added here.

FWIW: Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/Kconfig        |   1 +
>  arch/arm64/kernel/acpi.c  |  73 --------------------------------
>  drivers/acpi/Kconfig      |   3 ++
>  drivers/acpi/Makefile     |   1 +
>  drivers/acpi/gsi.c        | 105 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic.c |   2 +
>  6 files changed, 112 insertions(+), 73 deletions(-)
>  create mode 100644 drivers/acpi/gsi.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e5aa081..0659db3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1,5 +1,6 @@
>  config ARM64
>  	def_bool y
> +	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index fe9d8f0..a70f714 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -76,12 +76,6 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
>  }
>  
>  /*
> - * Since we're on ARM, the default interrupt routing model
> - * clearly has to be GIC.
> - */
> -enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
> -
> -/*
>   * __acpi_map_table() will be called before page_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
>   */
> @@ -224,73 +218,6 @@ void __init acpi_init_cpus(void)
>  	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
>  }
>  
> -int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> -{
> -	*irq = irq_find_mapping(NULL, gsi);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> -
> -/*
> - * success: return IRQ number (>0)
> - * failure: return =< 0
> - */
> -int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> -{
> -	unsigned int irq;
> -	unsigned int irq_type;
> -
> -	/*
> -	 * ACPI have no bindings to indicate SPI or PPI, so we
> -	 * use different mappings from DT in ACPI.
> -	 *
> -	 * For FDT
> -	 * PPI interrupt: in the range [0, 15];
> -	 * SPI interrupt: in the range [0, 987];
> -	 *
> -	 * For ACPI, GSI should be unique so using
> -	 * the hwirq directly for the mapping:
> -	 * PPI interrupt: in the range [16, 31];
> -	 * SPI interrupt: in the range [32, 1019];
> -	 */
> -
> -	if (trigger == ACPI_EDGE_SENSITIVE &&
> -				polarity == ACPI_ACTIVE_LOW)
> -		irq_type = IRQ_TYPE_EDGE_FALLING;
> -	else if (trigger == ACPI_EDGE_SENSITIVE &&
> -				polarity == ACPI_ACTIVE_HIGH)
> -		irq_type = IRQ_TYPE_EDGE_RISING;
> -	else if (trigger == ACPI_LEVEL_SENSITIVE &&
> -				polarity == ACPI_ACTIVE_LOW)
> -		irq_type = IRQ_TYPE_LEVEL_LOW;
> -	else if (trigger == ACPI_LEVEL_SENSITIVE &&
> -				polarity == ACPI_ACTIVE_HIGH)
> -		irq_type = IRQ_TYPE_LEVEL_HIGH;
> -	else
> -		irq_type = IRQ_TYPE_NONE;
> -
> -	/*
> -	 * Since only one GIC is supported in ACPI 5.0, we can
> -	 * create mapping refer to the default domain
> -	 */
> -	irq = irq_create_mapping(NULL, gsi);
> -	if (!irq)
> -		return irq;
> -
> -	/* Set irq type if specified and different than the current one */
> -	if (irq_type != IRQ_TYPE_NONE &&
> -		irq_type != irq_get_trigger_type(irq))
> -		irq_set_irq_type(irq, irq_type);
> -	return irq;
> -}
> -EXPORT_SYMBOL_GPL(acpi_register_gsi);
> -
> -void acpi_unregister_gsi(u32 gsi)
> -{
> -}
> -EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> -
>  static int __init acpi_parse_fadt(struct acpi_table_header *table)
>  {
>  	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index a8f531e2..ab2cbb5 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -48,6 +48,9 @@ config ACPI_LEGACY_TABLES_LOOKUP
>  config ARCH_MIGHT_HAVE_ACPI_PDC
>  	bool
>  
> +config ACPI_GENERIC_GSI
> +	bool
> +
>  config ACPI_SYSTEM_POWER_STATES_SUPPORT
>  	bool
>  
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index db153c6..8a063e2 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -56,6 +56,7 @@ ifdef CONFIG_ACPI_VIDEO
>  acpi-y				+= video_detect.o
>  endif
>  acpi-y				+= acpi_lpat.o
> +acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
>  
>  # These are (potentially) separate modules
>  
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> new file mode 100644
> index 0000000..38208f2
> --- /dev/null
> +++ b/drivers/acpi/gsi.c
> @@ -0,0 +1,105 @@
> +/*
> + * ACPI GSI IRQ layer
> + *
> + * Copyright (C) 2015 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/acpi.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +
> +enum acpi_irq_model_id acpi_irq_model;
> +
> +static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
> +{
> +	switch (polarity) {
> +	case ACPI_ACTIVE_LOW:
> +		return trigger == ACPI_EDGE_SENSITIVE ?
> +		       IRQ_TYPE_EDGE_FALLING :
> +		       IRQ_TYPE_LEVEL_LOW;
> +	case ACPI_ACTIVE_HIGH:
> +		return trigger == ACPI_EDGE_SENSITIVE ?
> +		       IRQ_TYPE_EDGE_RISING :
> +		       IRQ_TYPE_LEVEL_HIGH;
> +	case ACPI_ACTIVE_BOTH:
> +		if (trigger == ACPI_EDGE_SENSITIVE)
> +			return IRQ_TYPE_EDGE_BOTH;
> +	default:
> +		return IRQ_TYPE_NONE;
> +	}
> +}
> +
> +/**
> + * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
> + * @gsi: GSI IRQ number to map
> + * @irq: pointer where linux IRQ number is stored
> + *
> + * irq location updated with irq value [>0 on success, 0 on failure]
> + *
> + * Returns: linux IRQ number on success (>0)
> + *          -EINVAL on failure
> + */
> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> +{
> +	/*
> +	 * Only default domain is supported at present, always find
> +	 * the mapping corresponding to default domain by passing NULL
> +	 * as irq_domain parameter
> +	 */
> +	*irq = irq_find_mapping(NULL, gsi);
> +	/*
> +	 * *irq == 0 means no mapping, that should
> +	 * be reported as a failure
> +	 */
> +	return (*irq > 0) ? *irq : -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> +
> +/**
> + * acpi_register_gsi() - Map a GSI to a linux IRQ number
> + * @dev: device for which IRQ has to be mapped
> + * @gsi: GSI IRQ number
> + * @trigger: trigger type of the GSI number to be mapped
> + * @polarity: polarity of the GSI to be mapped
> + *
> + * Returns: a valid linux IRQ number on success
> + *          -EINVAL on failure
> + */
> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
> +		      int polarity)
> +{
> +	unsigned int irq;
> +	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
> +
> +	/*
> +	 * There is no way at present to look-up the IRQ domain on ACPI,
> +	 * hence always create mapping referring to the default domain
> +	 * by passing NULL as irq_domain parameter
> +	 */
> +	irq = irq_create_mapping(NULL, gsi);
> +	if (!irq)
> +		return -EINVAL;
> +
> +	/* Set irq type if specified and different than the current one */
> +	if (irq_type != IRQ_TYPE_NONE &&
> +		irq_type != irq_get_trigger_type(irq))
> +		irq_set_irq_type(irq, irq_type);
> +	return irq;
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> +
> +/**
> + * acpi_unregister_gsi() - Free a GSI<->linux IRQ number mapping
> + * @gsi: GSI IRQ number
> + */
> +void acpi_unregister_gsi(u32 gsi)
> +{
> +	int irq = irq_find_mapping(NULL, gsi);
> +
> +	irq_dispose_mapping(irq);
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index d15a36a..f1efb53 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1189,6 +1189,8 @@ gic_v2_acpi_init(struct acpi_table_header *table)
>  	 */
>  	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
>  	irq_set_default_host(gic_data[0].domain);
> +
> +	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
>  	return 0;
>  }
>  #endif
> 


-- 
Jazz is not dead. It just smells funny...
