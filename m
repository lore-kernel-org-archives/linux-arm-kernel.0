From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jan 2016 16:16:03 +0000
Subject: [PATCH V2 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
In-Reply-To: <56951645.6070704@linaro.org>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-4-git-send-email-tn@semihalf.com>
 <5694EB92.9030109@arm.com> <56951645.6070704@linaro.org>
Message-ID: <569526C3.1090701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/16 15:05, Hanjun Guo wrote:
> On 01/12/2016 08:03 PM, Marc Zyngier wrote:
>> On 17/12/15 11:52, Tomasz Nowicki wrote:
>>> On systems supporting GICv3 and above, in MADT GICC structures, the
>>> field of GICR Base Address holds the 64-bit physical address of the
>>> associated Redistributor if the GIC Redistributors are not in the
>>> always-on power domain, so instead of init GICR regions via GIC
>>> redistributor structure(s), init it with GICR base address in GICC
>>> structures in that case.
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>> ---
>>>   drivers/irqchip/irq-gic-v3.c | 98 ++++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 89 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index c4b929c..0528e82 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -39,6 +39,7 @@
>>>   struct redist_region {
>>>   	void __iomem		*redist_base;
>>>   	phys_addr_t		phys_base;
>>> +	bool			single_redist;
>>>   };
>>>
>>>   struct gic_chip_data {
>>> @@ -435,6 +436,9 @@ static int gic_populate_rdist(void)
>>>   				return 0;
>>>   			}
>>>
>>> +			if (gic_data.redist_regions[i].single_redist)
>>> +				break;
>>> +
>>>   			if (gic_data.redist_stride) {
>>>   				ptr += gic_data.redist_stride;
>>>   			} else {
>>> @@ -965,6 +969,7 @@ IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
>>>   #ifdef CONFIG_ACPI
>>>   static struct redist_region *redist_regs __initdata;
>>>   static u32 nr_redist_regions __initdata;
>>> +static bool single_redist;
>>>
>>>   static int __init
>>>   gic_acpi_register_redist(phys_addr_t phys_base, u64 size)
>>> @@ -979,7 +984,8 @@ gic_acpi_register_redist(phys_addr_t phys_base, u64 size)
>>>   	}
>>>
>>>   	redist_regs[count].phys_base = phys_base;
>>> -	redist_regs[count++].redist_base = redist_base;
>>> +	redist_regs[count].redist_base = redist_base;
>>
>> nit: move the count++ out of the access in the previous patch, this will
>> make this series a bit easier to follow.
> 
> OK.
> 
>>
>>> +	redist_regs[count++].single_redist = single_redist;
>>
>> What is that single_redist for? Is that because you can't rely on
>> GICR_TYPER.Last?
> 
> Yes, there is no GICR_TYPER.Last bit for some redistributors,
> as it's valid for redistributor regions.
> 
>>
>>>   	return 0;
>>>   }
>>>
>>> @@ -993,6 +999,48 @@ gic_acpi_parse_madt_redist(struct acpi_subtable_header *header,
>>>   	return gic_acpi_register_redist(redist->base_address, redist->length);
>>>   }
>>>
>>> +static int __init
>>> +gic_acpi_parse_madt_gicc(struct acpi_subtable_header *header,
>>> +			 const unsigned long end)
>>> +{
>>> +	struct acpi_madt_generic_interrupt *gicc;
>>> +	void __iomem *redist_base;
>>> +	u64 typer;
>>> +	u32 size;
>>> +
>>> +	gicc = (struct acpi_madt_generic_interrupt *)header;
>>> +	redist_base = ioremap(gicc->gicr_base_address, SZ_64K * 2);
>>> +	if (!redist_base)
>>> +		return -ENOMEM;
>>> +
>>> +	typer = readq_relaxed(redist_base + GICR_TYPER);
>>> +	/* don't map reserved page as it's buggy to access it */
>>> +	size = (typer & GICR_TYPER_VLPIS) ? SZ_64K * 3 : SZ_64K * 2;
>>> +	iounmap(redist_base);
>>
>> What a mess. If you discover a !VLPIS redistributor, why do you have to
>> unmap it to remap it again? Also, please map the whole region for the
> 
> I think I missed something here, I didn't know it's GICv3 or v4, I need
> to check the GICR_TYPER first, then decide map 2 or 4 SZ_64K pages.

But if you find out it is a v3, you already have it mapped, so why unmap
and then remap in this case?

> 
>> redistributor as we have on the DT side (4 64kB pages for VLPIS capable
>> redistributors).
>>
>> Also, the spec says:
>>
>> "On systems supporting GICv3 and above, this field holds the 64-bit
>> physical address of the associated Redistributor. If all of the GIC
>> Redistributors are in the always-on power domain, GICR structures should
>> be used to describe the Redistributors instead, and this field must be
>> set to 0."
>>
>> which triggers two questions:
>> - Can you access always the GICR_TYPER register without waking the
>> redistributor up?
> 
> I missed this part, can you suggest how can we do that? accessing some
> register before access to redistributor?

This redistributor may be in a power-domain that is off. Are you
guaranteed that you can access GICR_TYPER even when it is off?

> 
>> - How do you cope with situations where some redistributors are in the
>> always-on domain, and some are not?
> 
> I'm not sure if there is such hardware, if yes, do we need to fix
> the spec first?

It is something that should definitely be clarified. Can we end-up in a
situation where some redistributors are described via the GICR
structure, and some via the GICC structure? The spec is a bit ambiguous.

>>
>>> +	return gic_acpi_register_redist(gicc->gicr_base_address, size);
>>> +}
>>> +
>>> +static int __init gic_acpi_collect_gicr_base(void)
>>> +{
>>> +	acpi_tbl_entry_handler redist_parser;
>>> +	enum acpi_madt_type type;
>>> +
>>> +	if (single_redist) {
>>> +		type = ACPI_MADT_TYPE_GENERIC_INTERRUPT;
>>> +		redist_parser = gic_acpi_parse_madt_gicc;
>>> +	} else {
>>> +		type = ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR;
>>> +		redist_parser = gic_acpi_parse_madt_redist;
>>> +	}
>>> +
>>> +	/* Collect redistributor base addresses in GICR entries */
>>> +	if (acpi_table_parse_madt(type, redist_parser, 0) > 0)
>>> +		return 0;
>>> +
>>> +	pr_info("No valid GICR entries exist\n");
>>> +	return -ENODEV;
>>> +}
>>> +
>>>   static int __init gic_acpi_match_gicr(struct acpi_subtable_header *header,
>>>   				  const unsigned long end)
>>>   {
>>> @@ -1000,6 +1048,42 @@ static int __init gic_acpi_match_gicr(struct acpi_subtable_header *header,
>>>   	return 0;
>>>   }
>>>
>>> +static int __init gic_acpi_match_gicc(struct acpi_subtable_header *header,
>>> +				      const unsigned long end)
>>> +{
>>> +	struct acpi_madt_generic_interrupt *gicc =
>>> +				(struct acpi_madt_generic_interrupt *)header;
>>> +
>>> +	/*
>>> +	 * If GICC is enabled and has valid gicr base address, then it means
>>> +	 * GICR base is presented via GICC
>>> +	 */
>>> +	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
>>> +		return 0;
>>> +
>>> +	return -ENODEV;
>>> +}
>>> +
>>> +static int __init gic_acpi_count_gicr_regions(void)
>>> +{
>>> +	int count;
>>> +
>>> +	/* Count how many redistributor regions we have */
>>> +	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
>>> +				      gic_acpi_match_gicr, 0);
>>> +	if (count > 0) {
>>> +		single_redist = false;
>>> +		return count;
>>> +	}
>>> +
>>> +	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
>>> +				      gic_acpi_match_gicc, 0);
>>> +	if (count > 0)
>>> +		single_redist = true;
>>> +
>>> +	return count;
>>> +}
>>> +
>>
>> Here, you seem to consider GICR and GICC tables to be mutually
>> exclusive. I don't think the spec says so.
> 
> Good question, I will ask Charles first about it.

I just did, and he agreed that the spec is ambiguous - but that your
interpretation is probably the correct one. It would be good fix it though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
