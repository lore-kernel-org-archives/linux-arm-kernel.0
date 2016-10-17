From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 17 Oct 2016 16:17:25 -0500
Subject: [PATCH V4 1/2] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <1476738177-24979-2-git-send-email-agustinv@codeaurora.org>
References: <1476738177-24979-1-git-send-email-agustinv@codeaurora.org>
 <1476738177-24979-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <58053FE5.3020208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a few nits:

Agustin Vega-Frias wrote:
> +int acpi_irq_domain_register_irq(struct acpi_resource_source *source, u32 hwirq,
> +				 int trigger, int polarity)
> +{
> +	struct irq_fwspec fwspec;
> +	struct acpi_device *device;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int ret;
> +
> +	if (source->string_length == 0)

Would (!source->string_length) be more meaningful?

> +		return acpi_register_gsi(NULL, hwirq, trigger, polarity);
> +
> +	status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	device = acpi_bus_get_acpi_device(handle);
> +	if (!device)
> +		return -ENODEV;
> +
> +	if (acpi_irq_domain_ensure_probed(device))
> +		return -ENODEV;
> +
> +	fwspec.fwnode = &device->fwnode;
> +	fwspec.param[0] = hwirq;
> +	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> +	fwspec.param_count = 2;
> +
> +	ret = irq_create_fwspec_mapping(&fwspec);
> +	acpi_bus_put_acpi_device(device);
> +	return ret;

Blank line before 'return'.

> -static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
> +static void acpi_dev_get_irqresource(struct resource *res, u32 hwirq,
> +				     struct acpi_resource_source *source,

This should probably be a 'const', because ...

> @@ -448,6 +449,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>   {
>   	struct acpi_resource_irq *irq;
>   	struct acpi_resource_extended_irq *ext_irq;
> +	struct acpi_resource_source dummy = { 0, 0, NULL };

... then you can make this a static const, which will reduce code size 
and improve performance.

> @@ -1024,6 +1030,43 @@ struct acpi_probe_entry {
>   					  (&ACPI_PROBE_TABLE_END(t) -	\
>   					   &ACPI_PROBE_TABLE(t)));	\
>   	})
> +
> +#define ACPI_HID_LEN 9

Please add a comment for this.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
