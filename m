From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 13 Dec 2016 10:03:30 -0500
Subject: [PATCH V8 1/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <20161208110552.GA17398@red-moon>
References: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
 <1480460259-8585-2-git-send-email-agustinv@codeaurora.org>
 <20161208110552.GA17398@red-moon>
Message-ID: <51796560d4bc70bcca1afab3e2a5f8d1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2016-12-08 06:05, Lorenzo Pieralisi wrote:
> Hi Agustin,
> 
> please CC me for next version.
> 
> On Tue, Nov 29, 2016 at 05:57:37PM -0500, Agustin Vega-Frias wrote:
>> When an Extended IRQ Resource contains a valid ResourceSource
>> use it to map the IRQ on the domain associated with the ACPI
>> device referenced.
>> 
>> With this in place an irqchip driver can create its domain using
>> irq_domain_create_linear and pass the device fwnode to create
>> the domain mapping. When dependent devices are probed these
>> changes allow the ACPI core find the domain and map the IRQ.
>> 
>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>> ---
>>  drivers/acpi/Makefile         |  2 +-
>>  drivers/acpi/{gsi.c => irq.c} | 99 
>> +++++++++++++++++++++++++++++++++++++------
> 
> [...]
> 
>> -static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>> +static void acpi_dev_get_irqresource(struct resource *res, u32 hwirq,
>> +				     struct fwnode_handle *source,
>>  				     u8 triggering, u8 polarity, u8 shareable,
>>  				     bool legacy)
>>  {
>>  	int irq, p, t;
>> 
>> -	if (!valid_IRQ(gsi)) {
>> -		acpi_dev_irqresource_disabled(res, gsi);
>> +	if (!source && !valid_IRQ(hwirq)) {
> 
> If you make source a struct acpi_resource_source pointer it could be:
> 
> if (source || !valid_IRQ(hwirq))
> 
> Actually we would not even need to pass the pointer, if we detect
> an acpi_resource_source dependency we can just disable the resource
> (without even looking-up the fwnode_handle, see below), it is a design
> choice we have to make.
> 
>> +		acpi_dev_irqresource_disabled(res, hwirq);
>>  		return;
>>  	}
>> 
>> @@ -402,25 +403,25 @@ static void acpi_dev_get_irqresource(struct 
>> resource *res, u32 gsi,
>>  	 * using extended IRQ descriptors we take the IRQ configuration
>>  	 * from _CRS directly.
>>  	 */
>> -	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
>> +	if (legacy && !acpi_get_override_irq(hwirq, &t, &p)) {
>>  		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>>  		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> 
>>  		if (triggering != trig || polarity != pol) {
>> -			pr_warning("ACPI: IRQ %d override to %s, %s\n", gsi,
>> -				   t ? "level" : "edge", p ? "low" : "high");
>> +			pr_warn("ACPI: IRQ %d override to %s, %s\n", hwirq,
>> +				t ? "level" : "edge", p ? "low" : "high");
>>  			triggering = trig;
>>  			polarity = pol;
>>  		}
>>  	}
>> 
>>  	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
>> -	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
>> +	irq = acpi_register_irq(source, hwirq, triggering, polarity);
>>  	if (irq >= 0) {
>>  		res->start = irq;
>>  		res->end = irq;
>>  	} else {
>> -		acpi_dev_irqresource_disabled(res, gsi);
>> +		acpi_dev_irqresource_disabled(res, hwirq);
>>  	}
>>  }
>> 
>> @@ -448,6 +449,7 @@ bool acpi_dev_resource_interrupt(struct 
>> acpi_resource *ares, int index,
>>  {
>>  	struct acpi_resource_irq *irq;
>>  	struct acpi_resource_extended_irq *ext_irq;
>> +	struct fwnode_handle *src;
>> 
>>  	switch (ares->type) {
>>  	case ACPI_RESOURCE_TYPE_IRQ:
>> @@ -460,7 +462,7 @@ bool acpi_dev_resource_interrupt(struct 
>> acpi_resource *ares, int index,
>>  			acpi_dev_irqresource_disabled(res, 0);
>>  			return false;
>>  		}
>> -		acpi_dev_get_irqresource(res, irq->interrupts[index],
>> +		acpi_dev_get_irqresource(res, irq->interrupts[index], NULL,
>>  					 irq->triggering, irq->polarity,
>>  					 irq->sharable, true);
>>  		break;
>> @@ -470,7 +472,8 @@ bool acpi_dev_resource_interrupt(struct 
>> acpi_resource *ares, int index,
>>  			acpi_dev_irqresource_disabled(res, 0);
>>  			return false;
>>  		}
>> -		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>> +		src = acpi_get_irq_source_fwhandle(&ext_irq->resource_source);
> 
> I think the only pending question on my side for this series is whether
> we still carry out the domain look-up here (as you are doing now), or,
> if we detect a resource_source dependency, we just disable the resource
> and leave the deferred probing mechanism to deal with it, this will
> completely decouple the current resource parsing from the deferred 
> probe
> mechanism that you are introducing; basically this is equivalent to
> saying "if the IRQ resource has a dependency let's resolve it at
> acpi_irq_get() time, not now".
> 

I'm also torn about this so I am going to leave most of this code as it
was originally and just ensure we don't attempt the mapping when we have
a resource source.

I other words bus scan only maps GSIs and other IRQs are mapped via
acpi_irq_get().

Thanks,
Agustin

> I am fine either way, I just think that leaving the domain look-up
> in the middle of the IRQ resource parsing is not really clean-cut.
> 
> Thanks,
> Lorenzo
> 
>> +		acpi_dev_get_irqresource(res, ext_irq->interrupts[index], src,
>>  					 ext_irq->triggering, ext_irq->polarity,
>>  					 ext_irq->sharable, false);
>>  		break;
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 61a3d90..154e576 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -321,6 +321,25 @@ void acpi_set_irq_model(enum acpi_irq_model_id 
>> model,
>>   */
>>  void acpi_unregister_gsi (u32 gsi);
>> 
>> +#ifdef CONFIG_ACPI_GENERIC_GSI
>> +struct fwnode_handle *
>> +acpi_get_irq_source_fwhandle(const struct acpi_resource_source 
>> *source);
>> +int acpi_register_irq(struct fwnode_handle *source, u32 hwirq, int 
>> trigger,
>> +		      int polarity);
>> +void acpi_unregister_irq(struct fwnode_handle *source, u32 hwirq);
>> +#else
>> +#define acpi_get_irq_source_fwhandle(source) (NULL)
>> +static inline int acpi_register_irq(struct fwnode_handle *source, u32 
>> hwirq,
>> +				    int trigger, int polarity)
>> +{
>> +	return acpi_register_gsi(NULL, hwirq, trigger, polarity);
>> +}
>> +static inline void acpi_unregister_irq(struct fwnode_handle *source, 
>> u32 hwirq)
>> +{
>> +	acpi_unregister_gsi(hwirq);
>> +}
>> +#endif
>> +
>>  struct pci_dev;
>> 
>>  int acpi_pci_irq_enable (struct pci_dev *dev);
>> --
>> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
>> Technologies, Inc.
>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
>> in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
