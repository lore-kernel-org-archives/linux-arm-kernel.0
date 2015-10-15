From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Thu, 15 Oct 2015 09:03:36 -0500
Subject: [PATCH V2 6/6] gicv2m: acpi: Introducing GICv2m ACPI support
In-Reply-To: <561F449E.2050803@semihalf.com>
References: <1444865156-9870-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1444865156-9870-7-git-send-email-Suravee.Suthikulpanit@amd.com>
 <561F449E.2050803@semihalf.com>
Message-ID: <561FB238.10509@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Thanks for the feedback.

On 10/15/2015 1:15 AM, Tomasz Nowicki wrote:
>> [..]
>> @@ -138,6 +140,11 @@ static int gicv2m_irq_gic_domain_alloc(struct
>> irq_domain *domain,
>>           fwspec.param[0] = 0;
>>           fwspec.param[1] = hwirq - 32;
>>           fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
>> +    } else if (is_fwnode_irqchip(domain->parent->fwnode)) {
>> +        fwspec.fwnode = domain->parent->fwnode;
>> +        fwspec.param_count = 2;
>> +        fwspec.param[0] = hwirq;
>> +        fwspec.param[1] = IRQ_TYPE_EDGE_RISING & IRQ_TYPE_SENSE_MASK;
> How about just:
> fwspec.param[1] = IRQ_TYPE_EDGE_RISING;

Right.

>
>>       } else {
>>           return -EINVAL;
>>       }
>> @@ -255,6 +262,8 @@ static void gicv2m_teardown(void)
>>           kfree(v2m->bm);
>>           iounmap(v2m->base);
>>           of_node_put(to_of_node(v2m->fwnode));
>> +        if (is_fwnode_irqchip(v2m->fwnode))
>> +            irq_domain_free_fwnode(v2m->fwnode);
>>           kfree(v2m);
>>       }
>>   }
>> @@ -359,6 +368,8 @@ static int __init gicv2m_init_one(struct
>> fwnode_handle *fwnode,
>>
>>       if (to_of_node(fwnode))
>>           name = to_of_node(fwnode)->name;
>> +    else
>> +        name = irq_domain_get_irqchip_fwnode_name(fwnode);
>>
>>       pr_info("Frame %s: range[%#lx:%#lx], SPI[%d:%d]\n", name,
>>           (unsigned long)res->start, (unsigned long)res->end,
>> @@ -415,3 +426,86 @@ int __init gicv2m_of_init(struct device_node
>> *node, struct irq_domain *parent)
>>           gicv2m_teardown();
>>       return ret;
>>   }
>> +
>> +#ifdef CONFIG_ACPI
>> +static int acpi_num_msi;
>> +
>> +static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
>> +{
>> +    struct v2m_data *data;
>> +
>> +    if (WARN_ON(acpi_num_msi <= 0))
>> +        return NULL;
>> +
>> +    /* We only return the fwnode of the first MSI frame. */
>> +    data = list_first_entry_or_null(&v2m_nodes,
>> +                    struct v2m_data, entry);
> This can be one line and still fits within 80 characters.

Ok.

>> +    if (!data)
>> +        return NULL;
>> +
>> +    return data->fwnode;
>> +}
>> +
>> +static int __init
>> +acpi_parse_madt_msi(struct acpi_subtable_header *header,
>> +            const unsigned long end)
>> +{
>> +    int ret;
>> +    struct resource res;
>> +    u32 spi_start = 0, nr_spis = 0;
>> +    struct acpi_madt_generic_msi_frame *m;
>> +    struct fwnode_handle *fwnode = NULL;
>> +
>> +    m = (struct acpi_madt_generic_msi_frame *)header;
>> +    if (BAD_MADT_ENTRY(m, end))
>> +        return -EINVAL;
>> +
>> +    res.start = m->base_address;
>> +    res.end = m->base_address + 0x1000;
>> +
>> +    if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
>> +        spi_start = m->spi_base;
>> +        nr_spis = m->spi_count;
>> +
>> +        pr_info("ACPI overriding V2M MSI_TYPER (base:%u, num:%u)\n",
>> +            spi_start, nr_spis);
>> +    }
>> +
>> +    fwnode = irq_domain_alloc_fwnode((void *)m->base_address);
>> +    if (!fwnode) {
>> +        pr_err("Unable to allocate GICv2m domain token\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
> I case of error, we should call here:
> irq_domain_free_fwnode(fwnode);

This should have already been handled when returning from the 
acpi_parse_madt_msi() in gicv2m_teardown() since we would need to 
iterate through all existing MSI frame to clean up.

>> +
>> +    return ret;
>> +}
>> +
>> +int __init gicv2m_acpi_init(struct irq_domain *parent)
>> +{
>> +    int ret;
>> +
>> +    if (acpi_num_msi > 0)
>> +        return 0;
>> +
>> +    acpi_num_msi =
>> acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_MSI_FRAME,
>> +                      acpi_parse_madt_msi, 0);
>> +
>> +    if (acpi_num_msi <= 0)
>> +        goto err_out;
> If acpi_table_parse_madt return 0, then we don't need to call
> gicv2m_teardown(). Instead we can simply return, optionally add some
> pr_info. Well, gicv2m_teardown would do nothing, so this is just
> cosmetic and up to you.

I'd be hesitate to add pr_info here since V2m is optional, we already 
print information for each frame found. I think I would just leave this 
one the way it is.

>> [..]
>> diff --git a/include/linux/irqchip/arm-gic.h
>> b/include/linux/irqchip/arm-gic.h
>> index bae69e5..7398538 100644
>> --- a/include/linux/irqchip/arm-gic.h
>> +++ b/include/linux/irqchip/arm-gic.h
>> @@ -108,6 +108,12 @@ void gic_init(unsigned int nr, int start,
>>
>>   int gicv2m_of_init(struct device_node *node, struct irq_domain
>> *parent);
>>
>> +#ifdef CONFIG_ACPI
>> +#include <linux/acpi.h>
> I think, we don't need this include here. You already added it to itq-gic.c

Right.

Thanks,
Suravee
