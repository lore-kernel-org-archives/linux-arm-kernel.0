From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 7 Jun 2016 18:07:31 +0200
Subject: [PATCH V5 5/7] irqchip, gicv3, its: Probe ITS in the ACPI way.
In-Reply-To: <20160604125534.228e6a55@arm.com>
References: <1464693584-22343-1-git-send-email-tn@semihalf.com>
 <1464693584-22343-6-git-send-email-tn@semihalf.com>
 <20160604125534.228e6a55@arm.com>
Message-ID: <5756F143.9050801@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2016 13:55, Marc Zyngier wrote:
> On Tue, 31 May 2016 13:19:42 +0200
> Tomasz Nowicki <tn@semihalf.com> wrote:
>
>> ITS is prepared for being initialized different than DT,
>> therefore we can initialize it in ACPI way. We collect register base
>> address from MADT table and pass mandatory info to firmware-agnostic
>> ITS init call.
>>
>> Note that we are using here IORT lib to register ITS domain which
>> then can be found and used on to build another PCI MSI domain
>> in hierarchical stack domain.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

[...]

>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +
>> +#define ACPI_GICV3_ITS_MEM_SIZE (2 * SZ_64K)
>
> SZ_128k?
>
>> +
>> +static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>> +					  const unsigned long end)
>> +{
>> +	struct acpi_madt_generic_translator *its_entry;
>> +	struct fwnode_handle *dom_handle;
>> +	struct resource res;
>> +	int err;
>> +
>> +	its_entry = (struct acpi_madt_generic_translator *)header;
>> +	res.start = its_entry->base_address;
>> +	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
>> +
>> +	dom_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
>> +	if (!dom_handle) {
>> +		pr_err("ITS@%pa: Unable to allocate GICv3 ITS domain token\n",
>> +		       &res.start);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
>> +	if (err) {
>> +		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
>> +		       &res.start, its_entry->translation_id);
>> +		goto dom_err;
>> +	}
>> +
>> +	err = its_probe_one(&res, dom_handle);
>> +	if (!err)
>> +		return 0;
>> +
>> +	iort_deregister_domain_token(its_entry->translation_id);
>> +dom_err:
>> +	irq_domain_free_fwnode(dom_handle);
>> +	return err;
>> +}
>> +
>> +void __init its_acpi_probe(void)
>
> Should be static.
>
>> +{
>> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
>> +				  gic_acpi_parse_madt_its, 0) <= 0)
>> +		pr_info("No valid GIC ITS entries exist\n");
>
> We already have a message further down, no need to shout twice.
>
>> +}
>> +#else
>> +static inline void __init its_acpi_probe(struct irq_domain *parent_domain) { }
>
> Drop the inline, the compiler can figure out that by itself.
>

I will address all above comments in next series.

Tomasz
