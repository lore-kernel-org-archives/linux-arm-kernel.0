From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jul 2015 13:22:05 +0100
Subject: [PATCH v2 3/7] genirq: irqdomain: Add irq_create_acpi_mapping
In-Reply-To: <55B201E4.7060704@linaro.org>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
 <1437656713-9677-4-git-send-email-marc.zyngier@arm.com>
 <55B201E4.7060704@linaro.org>
Message-ID: <55B22DED.1000505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/15 10:14, Hanjun Guo wrote:
> On 07/23/2015 09:05 PM, Marc Zyngier wrote:
>> In order to help ACPI on arm64 to make use of most of the irqdomain
>> goodies, add a new entry point (irq_create_acpi_mapping) which
>> mimics irq_create_of_mapping, except that it takes a new
>> struct acpi_gsi_descriptor, which is the pendent of of_phandle_args
>> in the OF world.
>>
>> We assume that the way the acpi_gsi_descriptor is populated matches
>> that of of_phandle_args, as the latter is still the building block
>> for interrupt descriptor in the whole kernel.
>>
>> Eventually, these two representations should be merged in a single
>> structure, but that's probably for another day.
> 
> ...
> 
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   include/linux/acpi.h   |  9 +++++++++
>>   kernel/irq/irqdomain.c | 18 ++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index d2445fa..2f23ab0 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -205,6 +205,15 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
>>   int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>>   int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>>
>> +#define MAX_GSI_DESC_PARAMS 16
>> +struct acpi_gsi_descriptor {
>> +	int param_count;
>> +	u32 param[MAX_GSI_DESC_PARAMS];
>> +};
>> +
>> +unsigned int irq_create_acpi_mapping(struct irq_domain *d,
>> +				     struct acpi_gsi_descriptor *irq_data);
>> +
>>   #ifdef CONFIG_X86_IO_APIC
>>   extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
>>   #else
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 27f4ec7..542cda3 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -1,5 +1,6 @@
>>   #define pr_fmt(fmt)  "irq: " fmt
>>
>> +#include <linux/acpi.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/hardirq.h>
>>   #include <linux/interrupt.h>
>> @@ -557,6 +558,23 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>>   }
>>   EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>>
>> +#ifdef CONFIG_ACPI
>> +unsigned int irq_create_acpi_mapping(struct irq_domain *d,
>> +				     struct acpi_gsi_descriptor *irq_data)
>> +{
>> +	struct of_phandle_args args;
>> +	int i;
>> +
>> +	for (i = 0; i < min(irq_data->param_count, MAX_PHANDLE_ARGS); i++)
>> +		args.args[i] = irq_data->param[i];
>> +
>> +	args.np = d ? d->domain_token : NULL;
>> +	args.args_count = i;
>> +
>> +	return irq_create_of_mapping(&args);
>> +}
> 
> A little bit of hack to me :) , but I agree it's the first step to
> merge them in a single structure,

If you have a more elegant solution that doesn't end up duplicating most
of the kernel infrastructure, I'm really all ears.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
