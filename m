From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jul 2015 18:00:56 +0800
Subject: [PATCH v2 5/7] acpi: gsi: Add acpi_set_irq_model to initialize
 the GSI layer
In-Reply-To: <1437656713-9677-6-git-send-email-marc.zyngier@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
 <1437656713-9677-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <55B20CD8.60309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 09:05 PM, Marc Zyngier wrote:
> In order to start embrassing irqdomains at the GSI level, introduce
> a new initializer:
>
> void acpi_set_irq_model(enum acpi_irq_model_id model,
> 			unsigned long domain_token,
> 			int (*populate)(struct acpi_gsi_descriptor *,
> 					u32, unsigned int));
>
> where:
> - model is the value assigned to acpi_irq_model
> - domain_token is the identifier for the irqdomain mapping
>    GSI interrupts
> - populate is a function provided by the interrupt controller,
>    populating a struct acpi_gsi_descriptor based on a GSI and
>    the interrupt trigger information
>
> As nobody calls this code yet, the current code is left in place.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/acpi/gsi.c   | 32 ++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 +++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index a745880..e6f4a0c 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -16,6 +16,9 @@ enum acpi_irq_model_id acpi_irq_model;
>
>   static void *acpi_gsi_domain_token;
>
> +static int (*acpi_gsi_descriptor_populate)(struct acpi_gsi_descriptor *data,
> +					   u32 gsi, unsigned int irq_type);
> +
>   static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>   {
>   	switch (polarity) {
> @@ -71,10 +74,20 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>   int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>   		      int polarity)
>   {
> +	int err;
>   	unsigned int irq;
>   	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
>   	struct irq_domain *d = irq_find_host(acpi_gsi_domain_token);
>
> +	if (acpi_gsi_descriptor_populate) {
> +		struct acpi_gsi_descriptor data;
> +		err = acpi_gsi_descriptor_populate(&data, gsi, irq_type);
> +		if (err)
> +			return err;
> +
> +		return irq_create_acpi_mapping(d, &data);
> +	}
> +
>   	irq = irq_create_mapping(d, gsi);
>   	if (!irq)
>   		return -EINVAL;
> @@ -99,3 +112,22 @@ void acpi_unregister_gsi(u32 gsi)
>   	irq_dispose_mapping(irq);
>   }
>   EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
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
> +			unsigned long domain_token,
> +			int (*populate)(struct acpi_gsi_descriptor *,
> +					u32, unsigned int))
> +{
> +	acpi_irq_model = model;
> +	acpi_gsi_domain_token = (void *)domain_token;

This will work perfectly fine with ARM as it has single GICD and
one irq domain, I'm not sure x86 is ok with it because x86 has
multi ioapics and each ioapic has a irqdomain if I understand
correctly, but x86 don't use functions in this file at all for now,
I think I'm over worried :)

Thanks
Hanjun
