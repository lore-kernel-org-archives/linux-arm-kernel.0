From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 24 Jul 2015 18:32:34 +0100
Subject: [PATCH v2 5/7] acpi: gsi: Add acpi_set_irq_model to initialize
 the GSI layer
In-Reply-To: <1437656713-9677-6-git-send-email-marc.zyngier@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
 <1437656713-9677-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150724173234.GD8207@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 02:05:11PM +0100, Marc Zyngier wrote:
> In order to start embrassing irqdomains at the GSI level, introduce

s/embrassing/embracing

[...]

> +
> +/**
> + * acpi_set_irq_model - Setup the GSI irqdomain information
> + * @model: the value assigned to acpi_irq_model
> + * @domain_token: the irq_domain identifier for mapping and looking up
> + *                GSI interrupts
> + * @populate: provided by the interrupt controller, populating a
> + *            struct acpi_gsi_descriptor based on a GSI and
> + *            the interrupt trigger information
> + */
> +void acpi_set_irq_model(enum acpi_irq_model_id model,

You can make it __init

> +			unsigned long domain_token,
> +			int (*populate)(struct acpi_gsi_descriptor *,
> +					u32, unsigned int))
> +{
> +	acpi_irq_model = model;
> +	acpi_gsi_domain_token = (void *)domain_token;
> +	acpi_gsi_descriptor_populate = populate;


> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2f23ab0..0820cb1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -214,6 +214,11 @@ struct acpi_gsi_descriptor {
>  unsigned int irq_create_acpi_mapping(struct irq_domain *d,
>  				     struct acpi_gsi_descriptor *irq_data);
>  
> +void acpi_set_irq_model(enum acpi_irq_model_id model,
> +			unsigned long domain_token,
> +			int (*populate)(struct acpi_gsi_descriptor *,
> +					u32, unsigned int));
> +
>  #ifdef CONFIG_X86_IO_APIC
>  extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
>  #else
> 

It makes sense and it removes GIC specific mapping from generic code:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
