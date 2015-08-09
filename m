From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Sun, 9 Aug 2015 15:04:31 +0700
Subject: [PATCH v4 10/10] irqchip / gicv2m: Introducing gicv2m_acpi_init()
In-Reply-To: <55C0CAC4.3010202@arm.com>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-11-git-send-email-hanjun.guo@linaro.org>
 <55C0CAC4.3010202@arm.com>
Message-ID: <55C7098F.5010303@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 8/4/15 21:23, Marc Zyngier wrote:
> On 29/07/15 11:08, Hanjun Guo wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> This patch introduces gicv2m_acpi_init(), which uses information
>> in MADT GIC MSI frames structure to initialize GICv2m driver.
>> It also refactors gicv2m_init_one() to handle both DT and ACPI
>> initialization path.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-v2m.c   | 111 +++++++++++++++++++++++++++++++---------
>>   drivers/irqchip/irq-gic.c       |   3 ++
>>   include/linux/irqchip/arm-gic.h |   7 +++
>>   3 files changed, 98 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
>> index d0fcbf8..c491a08 100644
>> --- a/drivers/irqchip/irq-gic-v2m.c
>> +++ b/drivers/irqchip/irq-gic-v2m.c
>> @@ -15,6 +15,7 @@
>>
>>   #define pr_fmt(fmt) "GICv2m: " fmt
>>
>> +#include <linux/acpi.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqdomain.h>
>>   #include <linux/kernel.h>
>> @@ -211,6 +212,10 @@ static bool is_msi_spi_valid(u32 base, u32 num)
>>   	return true;
>>   }
>>
>> +char gicv2m_domain_name[] = "GICV2M";
>> +char gicv2m_pci_msi_domain_name[] = "GICV2M-PCI-MSI";
>> +char gicv2m_plat_msi_domain_name[] = "GICV2M-PLAT-MSI";
>> +
>
> Can't these be static? Why do we need them?

Of course, this is not needed. I figured it was useful when I was 
debugging the irq domain hierarchy stuff. I'll remove it then.

[...]
>> @@ -329,15 +330,79 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
>>
>>   	for (child = of_find_matching_node(node, gicv2m_device_id); child;
>>   	     child = of_find_matching_node(child, gicv2m_device_id)) {
>> +		u32 spi_start = 0, nr_spis = 0;
>> +		struct resource res;
>> +
>>   		if (!of_find_property(child, "msi-controller", NULL))
>>   			continue;
>>
>> -		ret = gicv2m_init_one(child, parent);
>> +		ret = of_address_to_resource(child, 0, &res);
>> +		if (ret) {
>> +			pr_err("Failed to allocate v2m resource.\n");
>> +			break;
>> +		}
>> +
>> +		if (!of_property_read_u32(child, "arm,msi-base-spi", &spi_start) &&
>> +		    !of_property_read_u32(child, "arm,msi-num-spis", &nr_spis))
>> +			pr_info("Overriding V2M MSI_TYPER (base:%u, num:%u)\n",
>> +				spi_start, nr_spis);
>> +
>> +		ret = gicv2m_init_one(parent, &spi_start, &nr_spis, &res,
>
> If these spi_start and nr_spis pointers passed to gicv2m_init_one are
> only for the benefit of printing the message below, just move the
> message inside the function...
>

Ok.

>> +				      child);
>>   		if (ret) {
>>   			of_node_put(node);
>>   			break;
>>   		}
>> +
>> +		pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", child->name,
>> +			(unsigned long)res.start, (unsigned long)res.end,
>> +			spi_start, (spi_start + nr_spis));
>>   	}
>>
>>   	return ret;
>>   }
>> +
>> +#ifdef CONFIG_ACPI
>> +int __init gicv2m_acpi_init(struct acpi_table_header *table,
>> +			    struct irq_domain *parent)
>> +{
>> +	int i, ret;
>> +
>> +	ret = acpi_gic_msi_init(table);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < acpi_gic_get_num_msi_frame(); i++) {
>> +		struct resource res;
>> +		u32 spi_start = 0, nr_spis = 0;
>> +		struct acpi_madt_generic_msi_frame *m;
>> +
>> +		ret = acpi_gic_get_msi_frame(i, &m);
>> +		if (ret)
>> +			return ret;
>> +
>
> All of that should be moved here. And we don't need to build an
> intermediate representation. Just build the v2m_data structures as you go.

I'll rework the ACPI MADT parsing, and move it into this file, and get 
rid of the structure.

>> +		res.start = m->base_address;
>> +		res.end = m->base_address + 0x1000;
>> +
>> +		if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
>> +			spi_start = m->spi_base;
>> +			nr_spis = m->spi_count;
>> +
>> +			pr_info("ACPI overriding V2M MSI_TYPER (base:%u, num:%u)\n",
>> +				spi_start, nr_spis);
>> +		}
>> +
>> +		ret = gicv2m_init_one(parent, &spi_start, &nr_spis, &res,
>> +				      (void *)(m->base_address));
>> +		if (ret)
>> +			break;
>> +
>> +		pr_info("MSI frame ID %u: range[%#lx:%#lx], SPI[%d:%d]\n",
>> +			m->msi_frame_id,
>> +			(unsigned long)res.start, (unsigned long)res.end,
>> +			spi_start, (spi_start + nr_spis));
>> +	}
>> +	return ret;
>> +}
>> +
>> +#endif /* CONFIG_ACPI */
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index bec6b00..531ebbc 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -1159,6 +1159,9 @@ gic_v2_acpi_init(struct acpi_table_header *table)
>>   	 */
>>   	gic_init_bases(0, -1, dist_base, cpu_base, 0, (void *)ACPI_IRQ_MODEL_GIC);
>>
>> +	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
>> +		gicv2m_acpi_init(table, gic_data[0].domain);
>> +
>>   	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, ACPI_IRQ_MODEL_GIC,
>>   			   gic_acpi_gsi_desc_populate);
>>   	return 0;
>> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
>> index 97799b7..27d8196 100644
>> --- a/include/linux/irqchip/arm-gic.h
>> +++ b/include/linux/irqchip/arm-gic.h
>> @@ -109,6 +109,13 @@ static inline void gic_init(unsigned int nr, int start,
>>
>>   int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
>>
>> +#ifdef CONFIG_ACPI
>> +struct acpi_table_header;
>> +
>> +int gicv2m_acpi_init(struct acpi_table_header *table,
>> +		     struct irq_domain *parent);
>> +#endif
>> +
>>   void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
>>   int gic_get_cpu_id(unsigned int cpu);
>>   void gic_migrate_target(unsigned int new_cpu_id);
>>
>
> This needs rework to do the parsing of the tables in this driver. Just
> expose the domain_token through a function that you register with the
> ACPI layer.

Ok. I'll investigate and rework this to only expose the domain_token.

Basically, I would need a way to pass down a device from ACPI layer into 
irqchips (e.g. GICv2m and GICv3-ITS), so that it can verify the device 
with the MSI domains and return the appropriate domain token (or some 
sort of domain reference).

Thanks,
Suravee
