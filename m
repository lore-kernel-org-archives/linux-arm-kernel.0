From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jul 2015 08:46:04 +0100
Subject: [PATCH 4/5] acpi: gsi: Use acpi_gsi_descriptor to allocate
 interrupts
In-Reply-To: <20150721181646.GC32187@red-moon>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-5-git-send-email-marc.zyngier@arm.com>
 <20150721181646.GC32187@red-moon>
Message-ID: <55AF4A3C.1010608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/15 19:16, Lorenzo Pieralisi wrote:
> On Tue, Jul 21, 2015 at 11:07:59AM +0100, Marc Zyngier wrote:
>> Now that the irqdomain layer is a bit more ACPI friendly, add the
>> mapping code that allows irq_create_acpi_mapping to be called.
>>
>> As we only support the GIC so far, support is pretty limited.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/acpi/gsi.c | 54 ++++++++++++++++++++++++++++++++++++------------------
>>  1 file changed, 36 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
>> index 38208f2..005d843 100644
>> --- a/drivers/acpi/gsi.c
>> +++ b/drivers/acpi/gsi.c
>> @@ -33,6 +33,12 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>>  	}
>>  }
>>  
>> +static struct irq_domain *irq_find_acpi_domain(enum acpi_irq_model_id id,
>> +					       enum irq_domain_bus_token bus_token)
>> +{
>> +	return irq_find_matching_host((void *)id, bus_token);
>> +}
>> +
>>  /**
>>   * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>>   * @gsi: GSI IRQ number to map
>> @@ -45,12 +51,10 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>>   */
>>  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>  {
>> -	/*
>> -	 * Only default domain is supported at present, always find
>> -	 * the mapping corresponding to default domain by passing NULL
>> -	 * as irq_domain parameter
>> -	 */
>> -	*irq = irq_find_mapping(NULL, gsi);
>> +	struct irq_domain *d = irq_find_acpi_domain(acpi_irq_model,
>> +						    DOMAIN_BUS_ANY);
>> +
>> +	*irq = irq_find_mapping(d, gsi);
>>  	/*
>>  	 * *irq == 0 means no mapping, that should
>>  	 * be reported as a failure
>> @@ -72,23 +76,35 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>  int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>>  		      int polarity)
>>  {
>> -	unsigned int irq;
>> +	struct acpi_gsi_descriptor data;
>>  	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
>> +	struct irq_domain *d = irq_find_acpi_domain(acpi_irq_model,
>> +						    DOMAIN_BUS_ANY);
>>  
>>  	/*
>> -	 * There is no way at present to look-up the IRQ domain on ACPI,
>> -	 * hence always create mapping referring to the default domain
>> -	 * by passing NULL as irq_domain parameter
>> +	 * Populate the GSI descriptor in a way that matches the way
>> +	 * the driver expects its of_phandle_args.
>>  	 */
>> -	irq = irq_create_mapping(NULL, gsi);
>> -	if (!irq)
>> +	switch (acpi_irq_model) {
>> +	case ACPI_IRQ_MODEL_GIC:
>> +		if (gsi >= 32) {
>> +			data.param[0] = 0;
>> +			data.param[1] = gsi - 32;
>> +			data.param[2] = irq_type;
>> +		} else {
>> +			data.param[0] = 1;
>> +			data.param[1] = gsi - 16;
>> +			data.param[2] = 0xff << 4 | irq_type;
>> +		}
>> +
>> +		data.param_count = 3;
>> +		break;
>> +	default:
>> +		pr_warn("Unknown acpi_irq_model = %d\n", acpi_irq_model);
>>  		return -EINVAL;
>> +	}
> 
> Nit: you could move the switch in a function (in this file) so that
> code that is irq model specific is self-contained and in a function
> on its own, if we ever have to add other irq models later I think it
> is easier to parse.

Yup, makes sense.

Actually, having given it a bit more thoughts, there is not reason why
this translation function should be located in this file. The interrupt
controller driver, instead of doing a

acpi_irq_model = ACPI_IRQ_MODEL_BLAH;

could as well be doing

acpi_set_irq_model(ACPI_IRQ_MODEL_BLAH, blah_acpi_gsi_desc_populate);

making the whole thing completely interrupt-controller agnostic.

Thanks,

	M.

> 
> Lorenzo
> 
>>  
>> -	/* Set irq type if specified and different than the current one */
>> -	if (irq_type != IRQ_TYPE_NONE &&
>> -		irq_type != irq_get_trigger_type(irq))
>> -		irq_set_irq_type(irq, irq_type);
>> -	return irq;
>> +	return irq_create_acpi_mapping(d, &data);
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_register_gsi);
>>  
>> @@ -98,7 +114,9 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
>>   */
>>  void acpi_unregister_gsi(u32 gsi)
>>  {
>> -	int irq = irq_find_mapping(NULL, gsi);
>> +	struct irq_domain *d = irq_find_acpi_domain(acpi_irq_model,
>> +						    DOMAIN_BUS_ANY);
>> +	int irq = irq_find_mapping(d, gsi);
>>  
>>  	irq_dispose_mapping(irq);
>>  }
>> -- 
>> 2.1.4
>>
> 


-- 
Jazz is not dead. It just smells funny...
