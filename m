From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Wed, 25 May 2016 10:38:07 -0400
Subject: [PATCH V3 1/2] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <1463156203-10970-2-git-send-email-agustinv@codeaurora.org>
References: <1463156203-10970-1-git-send-email-agustinv@codeaurora.org>
 <1463156203-10970-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <24448d48e2e62cec20993d0d0ac96737@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-arm-kernel and linux-acpi

On 2016-05-13 12:16, Agustin Vega-Frias wrote:
> This allows irqchip drivers to associate an ACPI DSDT device to
> an IRQ domain and provides support for using the ResourceSource
> in Extended IRQ Resources to find the domain and map the IRQs
> specified on that domain.
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/irqdomain.c | 108 
> +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/resource.c  |  23 ++++++----
>  include/linux/acpi.h     |   6 +++
>  4 files changed, 130 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/acpi/irqdomain.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index b12fa64..79db78f 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -56,6 +56,7 @@ acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y				+= acpi_lpat.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
> +acpi-y				+= irqdomain.o
> 
>  # These are (potentially) separate modules
> 
> diff --git a/drivers/acpi/irqdomain.c b/drivers/acpi/irqdomain.c
> new file mode 100644
> index 0000000..0fd10a9
> --- /dev/null
> +++ b/drivers/acpi/irqdomain.c
> @@ -0,0 +1,108 @@
> +/*
> + * ACPI ResourceSource/IRQ domain mapping support
> + *
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or 
> modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/acpi.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +
> +/**
> + * acpi_irq_domain_register_irq() - Register the mapping for an IRQ 
> produced
> + *                                  by the given acpi_resource_source 
> to a
> + *                                  Linux IRQ number
> + * @source: IRQ source
> + * @rcirq: IRQ number
> + * @trigger: trigger type of the IRQ number to be mapped
> + * @polarity: polarity of the IRQ to be mapped
> + *
> + * Returns: a valid linux IRQ number on success
> + *          -ENODEV if the given acpi_resource_source cannot be found
> + *          -EPROBE_DEFER if the IRQ domain has not been registered
> + *          -EINVAL for all other errors
> + */
> +int acpi_irq_domain_register_irq(struct acpi_resource_source *source,
> u32 rcirq,
> +				 int trigger, int polarity)
> +{
> +	struct irq_domain *domain;
> +	struct acpi_device *device;
> +	acpi_handle handle;
> +	acpi_status status;
> +	unsigned int type;
> +	int ret;
> +
> +	status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	device = acpi_bus_get_acpi_device(handle);
> +	if (!device)
> +		return -ENODEV;
> +
> +	domain = irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY);
> +	if (!domain) {
> +		ret = -EPROBE_DEFER;
> +		goto out_put_device;
> +	}
> +
> +	type = acpi_dev_get_irq_type(trigger, polarity);
> +	ret = irq_create_mapping(domain, rcirq);
> +	if (ret)
> +		irq_set_irq_type(ret, type);
> +
> +out_put_device:
> +	acpi_bus_put_acpi_device(device);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_domain_register_irq);
> +
> +/**
> + * acpi_irq_domain_unregister_irq() - Delete the mapping for an IRQ 
> produced
> + *                                    by the given 
> acpi_resource_source to a
> + *                                    Linux IRQ number
> + * @source: IRQ source
> + * @rcirq: IRQ number
> + *
> + * Returns: 0 on success
> + *          -ENODEV if the given acpi_resource_source cannot be found
> + *          -EINVAL for all other errors
> + */
> +int acpi_irq_domain_unregister_irq(struct acpi_resource_source 
> *source,
> +				   u32 rcirq)
> +{
> +	struct irq_domain *domain;
> +	struct acpi_device *device;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	device = acpi_bus_get_acpi_device(handle);
> +	if (!device)
> +		return -ENODEV;
> +
> +	domain = irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY);
> +	if (!domain) {
> +		ret = -EINVAL;
> +		goto out_put_device;
> +	}
> +
> +	irq_dispose_mapping(irq_find_mapping(domain, rcirq));
> +
> +out_put_device:
> +	acpi_bus_put_acpi_device(device);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_domain_unregister_irq);
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..1551698 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -381,14 +381,15 @@ static void acpi_dev_irqresource_disabled(struct
> resource *res, u32 gsi)
>  	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>  }
> 
> -static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
> +static void acpi_dev_get_irqresource(struct resource *res, u32 rcirq,
> +				     struct acpi_resource_source *source,
>  				     u8 triggering, u8 polarity, u8 shareable,
>  				     bool legacy)
>  {
>  	int irq, p, t;
> 
> -	if (!valid_IRQ(gsi)) {
> -		acpi_dev_irqresource_disabled(res, gsi);
> +	if ((source->string_length == 0) && !valid_IRQ(rcirq)) {
> +		acpi_dev_irqresource_disabled(res, rcirq);
>  		return;
>  	}
> 
> @@ -402,12 +403,12 @@ static void acpi_dev_get_irqresource(struct
> resource *res, u32 gsi,
>  	 * using extended IRQ descriptors we take the IRQ configuration
>  	 * from _CRS directly.
>  	 */
> -	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
> +	if (legacy && !acpi_get_override_irq(rcirq, &t, &p)) {
>  		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>  		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> 
>  		if (triggering != trig || polarity != pol) {
> -			pr_warning("ACPI: IRQ %d override to %s, %s\n", gsi,
> +			pr_warning("ACPI: IRQ %d override to %s, %s\n", rcirq,
>  				   t ? "level" : "edge", p ? "low" : "high");
>  			triggering = trig;
>  			polarity = pol;
> @@ -415,12 +416,16 @@ static void acpi_dev_get_irqresource(struct
> resource *res, u32 gsi,
>  	}
> 
>  	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> -	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
> +	if (source->string_length > 0)
> +		irq = acpi_irq_domain_register_irq(source, rcirq, triggering,
> +						   polarity);
> +	else
> +		irq = acpi_register_gsi(NULL, rcirq, triggering, polarity);
>  	if (irq >= 0) {
>  		res->start = irq;
>  		res->end = irq;
>  	} else {
> -		acpi_dev_irqresource_disabled(res, gsi);
> +		acpi_dev_irqresource_disabled(res, rcirq);
>  	}
>  }
> 
> @@ -448,6 +453,7 @@ bool acpi_dev_resource_interrupt(struct
> acpi_resource *ares, int index,
>  {
>  	struct acpi_resource_irq *irq;
>  	struct acpi_resource_extended_irq *ext_irq;
> +	struct acpi_resource_source dummy = { 0, 0, NULL };
> 
>  	switch (ares->type) {
>  	case ACPI_RESOURCE_TYPE_IRQ:
> @@ -460,7 +466,7 @@ bool acpi_dev_resource_interrupt(struct
> acpi_resource *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, irq->interrupts[index],
> +		acpi_dev_get_irqresource(res, irq->interrupts[index], &dummy,
>  					 irq->triggering, irq->polarity,
>  					 irq->sharable, true);
>  		break;
> @@ -471,6 +477,7 @@ bool acpi_dev_resource_interrupt(struct
> acpi_resource *ares, int index,
>  			return false;
>  		}
>  		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> +					 &ext_irq->resource_source,
>  					 ext_irq->triggering, ext_irq->polarity,
>  					 ext_irq->sharable, false);
>  		break;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 06ed7e5..f4f515e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -26,6 +26,7 @@
>  #include <linux/resource_ext.h>
>  #include <linux/device.h>
>  #include <linux/property.h>
> +#include <linux/irqdomain.h>
> 
>  #ifndef _LINUX
>  #define _LINUX
> @@ -294,6 +295,11 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 
> *gsi);
>  void acpi_set_irq_model(enum acpi_irq_model_id model,
>  			struct fwnode_handle *fwnode);
> 
> +int acpi_irq_domain_register_irq(struct acpi_resource_source *source,
> u32 rcirq,
> +		      int trigger, int polarity);
> +int acpi_irq_domain_unregister_irq(struct acpi_resource_source 
> *source,
> +				   u32 rcirq);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  extern int acpi_get_override_irq(u32 gsi, int *trigger, int 
> *polarity);
>  #else
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
> Forum,
> a Linux Foundation Collaborative Project.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project.
