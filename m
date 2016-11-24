From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 24 Nov 2016 16:15:48 +0000
Subject: [PATCH V7 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <1479074375-2629-3-git-send-email-agustinv@codeaurora.org>
References: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
 <1479074375-2629-3-git-send-email-agustinv@codeaurora.org>
Message-ID: <20161124161548.GA11766@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

On Sun, Nov 13, 2016 at 04:59:34PM -0500, Agustin Vega-Frias wrote:
> When an Extended IRQ Resource contains a valid ResourceSource
> use it to map the IRQ on the domain associated with the ACPI
> device referenced.
> 
> With this in place an irqchip driver can create its domain using
> irq_domain_create_linear and pass the device fwnode to create
> the domain mapping. When dependent devices are probed these
> changes allow the ACPI core find the domain and map the IRQ.
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/Makefile         |  2 +-
>  drivers/acpi/{gsi.c => irq.c} | 98 +++++++++++++++++++++++++++++++++++++------
>  drivers/acpi/resource.c       | 29 +++++++------
>  include/linux/acpi.h          | 19 +++++++++
>  4 files changed, 121 insertions(+), 27 deletions(-)
>  rename drivers/acpi/{gsi.c => irq.c} (53%)

It looks to me the direction is the right one but I have a question
for you and others below.

> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 9ed0878..a391bbc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -55,7 +55,7 @@ acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y				+= acpi_lpat.o
> -acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
> +acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
>  acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
>  
>  # These are (potentially) separate modules
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/irq.c
> similarity index 53%
> rename from drivers/acpi/gsi.c
> rename to drivers/acpi/irq.c
> index ee9e0f2..c6ecaab 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/irq.c
> @@ -18,6 +18,45 @@
>  static struct fwnode_handle *acpi_gsi_domain_id;
>  
>  /**
> + * acpi_get_irq_source_fwhandle() - Retrieve the fwhandle of the given
> + *                                  acpi_resource_source which is used
> + *                                  to be used as an IRQ domain id
> + * @source: acpi_resource_source to use for the lookup
> + *
> + * Returns: The appropriate IRQ fwhandle domain id
> + *          NULL on failure
> + */
> +struct fwnode_handle *
> +acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
> +{
> +	struct fwnode_handle *result;
> +	struct acpi_device *device;
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	if (!source->string_length)
> +		return acpi_gsi_domain_id;
> +
> +	status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +	if (ACPI_FAILURE(status)) {
> +		pr_warn("Could not find handle for %s\n", source->string_ptr);
> +		return NULL;
> +	}
> +
> +	device = acpi_bus_get_acpi_device(handle);
> +	if (!device) {
> +		pr_warn("Could not get device for %s\n", source->string_ptr);
> +		return NULL;
> +	}
> +
> +	result = &device->fwnode;
> +	acpi_bus_put_acpi_device(device);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_irq_source_fwhandle);
> +
> +/**
>   * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>   * @gsi: GSI IRQ number to map
>   * @irq: pointer where linux IRQ number is stored
> @@ -42,6 +81,50 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>  
>  /**
> + * acpi_register_irq() - Map a hardware to a linux IRQ number
> + * @source: IRQ source
> + * @hwirq: Hardware IRQ number
> + * @trigger: trigger type of the IRQ number to be mapped
> + * @polarity: polarity of the IRQ to be mapped
> + *
> + * Returns: a valid linux IRQ number on success
> + *          -EINVAL on failure

Nit: You need to update the return values list.

> + */
> +int acpi_register_irq(struct fwnode_handle *source, u32 hwirq, int trigger,
> +		      int polarity)
> +{
> +	struct irq_fwspec fwspec;
> +
> +	if (!source)
> +		return -EINVAL;
> +
> +	if (irq_find_matching_fwnode(source, DOMAIN_BUS_ANY) == NULL)
> +		return -EPROBE_DEFER;
> +
> +	fwspec.fwnode = source;
> +	fwspec.param[0] = hwirq;
> +	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> +	fwspec.param_count = 2;
> +
> +	return irq_create_fwspec_mapping(&fwspec);
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_irq);
> +
> +/**
> + * acpi_unregister_irq() - Free a Hardware IRQ<->linux IRQ number mapping
> + * @hwirq: Hardware IRQ number
> + */
> +void acpi_unregister_irq(struct fwnode_handle *source, u32 hwirq)
> +{
> +	struct irq_domain *d = irq_find_matching_fwnode(source,
> +							DOMAIN_BUS_ANY);
> +	int irq = irq_find_mapping(d, hwirq);
> +
> +	irq_dispose_mapping(irq);
> +}
> +EXPORT_SYMBOL_GPL(acpi_unregister_irq);
> +
> +/**
>   * acpi_register_gsi() - Map a GSI to a linux IRQ number
>   * @dev: device for which IRQ has to be mapped
>   * @gsi: GSI IRQ number
> @@ -54,19 +137,12 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>  int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>  		      int polarity)
>  {
> -	struct irq_fwspec fwspec;
> -
>  	if (WARN_ON(!acpi_gsi_domain_id)) {
>  		pr_warn("GSI: No registered irqchip, giving up\n");
>  		return -EINVAL;
>  	}
>  
> -	fwspec.fwnode = acpi_gsi_domain_id;
> -	fwspec.param[0] = gsi;
> -	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> -	fwspec.param_count = 2;
> -
> -	return irq_create_fwspec_mapping(&fwspec);
> +	return acpi_register_irq(acpi_gsi_domain_id, gsi, trigger, polarity);
>  }
>  EXPORT_SYMBOL_GPL(acpi_register_gsi);
>  
> @@ -76,11 +152,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>   */
>  void acpi_unregister_gsi(u32 gsi)
>  {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> -	int irq = irq_find_mapping(d, gsi);
> -
> -	irq_dispose_mapping(irq);
> +	acpi_unregister_irq(acpi_gsi_domain_id, gsi);
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>  
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 4beda15..83cff00 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -374,21 +374,22 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>  
> -static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
> +static void acpi_dev_irqresource_disabled(struct resource *res, u32 hwirq)
>  {
> -	res->start = gsi;
> -	res->end = gsi;
> +	res->start = hwirq;
> +	res->end = hwirq;
>  	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>  }
>  
> -static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
> +static void acpi_dev_get_irqresource(struct resource *res, u32 hwirq,
> +				     struct fwnode_handle *source,
>  				     u8 triggering, u8 polarity, u8 shareable,
>  				     bool legacy)
>  {
>  	int irq, p, t;
>  
> -	if (!valid_IRQ(gsi)) {
> -		acpi_dev_irqresource_disabled(res, gsi);
> +	if (!source && !valid_IRQ(hwirq)) {
> +		acpi_dev_irqresource_disabled(res, hwirq);
>  		return;
>  	}
>  
> @@ -402,25 +403,25 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>  	 * using extended IRQ descriptors we take the IRQ configuration
>  	 * from _CRS directly.
>  	 */
> -	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
> +	if (legacy && !acpi_get_override_irq(hwirq, &t, &p)) {
>  		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>  		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>  
>  		if (triggering != trig || polarity != pol) {
> -			pr_warning("ACPI: IRQ %d override to %s, %s\n", gsi,
> -				   t ? "level" : "edge", p ? "low" : "high");
> +			pr_warn("ACPI: IRQ %d override to %s, %s\n", hwirq,
> +				t ? "level" : "edge", p ? "low" : "high");
>  			triggering = trig;
>  			polarity = pol;
>  		}
>  	}
>  
>  	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> -	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
> +	irq = acpi_register_irq(source, hwirq, triggering, polarity);
>  	if (irq >= 0) {
>  		res->start = irq;
>  		res->end = irq;
>  	} else {
> -		acpi_dev_irqresource_disabled(res, gsi);
> +		acpi_dev_irqresource_disabled(res, hwirq);
>  	}
>  }
>  
> @@ -448,6 +449,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  {
>  	struct acpi_resource_irq *irq;
>  	struct acpi_resource_extended_irq *ext_irq;
> +	struct fwnode_handle *src;
>  
>  	switch (ares->type) {
>  	case ACPI_RESOURCE_TYPE_IRQ:
> @@ -460,7 +462,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, irq->interrupts[index],
> +		acpi_dev_get_irqresource(res, irq->interrupts[index], NULL,
>  					 irq->triggering, irq->polarity,
>  					 irq->sharable, true);
>  		break;
> @@ -470,7 +472,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> +		src = acpi_get_irq_source_fwhandle(&ext_irq->resource_source);

Is there a reason why we need to do the domain look-up here ?

I would like to understand if, by reshuffling the code (and by returning
the resource_source to the calling code - somehow), it would be possible
to just mirror what the OF code does in of_irq_get(), namely:

(1) parse the irq entry -> of_irq_parse_one()
(2) look the domain up -> irq_find_host()
(3) create the mapping -> irq_create_of_mapping()

You wrote the code already, I think it is just a matter of shuffling
it around (well, minus returning the resource_source to the caller
which is phandle equivalent in DT).

You abstracted away (2) and (3) behind acpi_register_irq(), that
on anything than does not use ACPI_GENERIC_GSI is just glue code
to acpi_register_gsi().

Also, it is not a question on this patch but I ask it here because it
is related. On ACPI you are doing the reverse of what is done in
DT in platform_get_irq():

- get the resources already parsed -> platform_get_resource()
- if they are disabled -> acpi_irq_get()

and I think the ordering is tied to my question above because
you carry out the domain look up in acpi_dev_resource_interrupt()
so that if for any reason it fails the corresponding resource
is disabled so that we try to get it again through acpi_irq_get().

I suspect you did it this way to make sure:

a) keep the current ACPI IRQ parsing interface changes to a mininum
b) avoid changing the behaviour on x86/ia64; in particular, calling
   acpi_register_gsi() for the _same_ mapping (an IRQ that was already
   registered at device creation resource parsing) multiple times can
   trigger issues on x86/ia64

I think that's a reasonable approach but I wanted to get these
clarifications, I do not think you are far from getting this
done but since it is a significant change I think it is worth
discussing the points I raised above because I think the DT code
sequence in of_irq_get() (1-2-3 above) is cleaner from an IRQ
layer perspective (instead of having the domain look-up buried
inside the ACPI IRQ resource parsing API).

Thanks !
Lorenzo

> +		acpi_dev_get_irqresource(res, ext_irq->interrupts[index], src,
>  					 ext_irq->triggering, ext_irq->polarity,
>  					 ext_irq->sharable, false);
>  		break;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 325bdb9..1099b51 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -321,6 +321,25 @@ void acpi_set_irq_model(enum acpi_irq_model_id model,
>   */
>  void acpi_unregister_gsi (u32 gsi);
>  
> +#ifdef CONFIG_ACPI_GENERIC_GSI
> +struct fwnode_handle *
> +acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source);
> +int acpi_register_irq(struct fwnode_handle *source, u32 hwirq, int trigger,
> +		      int polarity);
> +void acpi_unregister_irq(struct fwnode_handle *source, u32 hwirq);
> +#else
> +#define acpi_get_irq_source_fwhandle(source) (NULL)
> +static inline int acpi_register_irq(struct fwnode_handle *source, u32 hwirq,
> +				    int trigger, int polarity)
> +{
> +	return acpi_register_gsi(NULL, hwirq, trigger, polarity);
> +}
> +static inline void acpi_unregister_irq(struct fwnode_handle *source, u32 hwirq)
> +{
> +	acpi_unregister_gsi(hwirq);
> +}
> +#endif
> +
>  struct pci_dev;
>  
>  int acpi_pci_irq_enable (struct pci_dev *dev);
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
