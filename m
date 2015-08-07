From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 07 Aug 2015 13:06:40 +0100
Subject: [PATCH v4 09/10] PCI: ACPI: Bind GIC MSI frame to PCI host bridge
In-Reply-To: <55C4826C.80600@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
 <55C4826C.80600@linaro.org>
Message-ID: <55C49F50.1080903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 11:03, Tomasz Nowicki wrote:
> On 29.07.2015 12:08, Hanjun Guo wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> This patch introduces pci_host_bridge_acpi_msi_domain(), which queries
>> a GIC MSI irq-domain token and use it to retrieve an irq_domain with
>> DOMAIN_BUS_PCI_MSI bus type, and bind it to PCI host-bridge.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/pci/pci-acpi.c   | 18 ++++++++++++++++++
>>   drivers/pci/probe.c      |  3 +++
>>   include/linux/pci-acpi.h |  4 ++++
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 314a625..5f11653 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -9,6 +9,7 @@
>>
>>   #include <linux/delay.h>
>>   #include <linux/init.h>
>> +#include <linux/irqdomain.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci_hotplug.h>
>>   #include <linux/module.h>
>> @@ -16,6 +17,7 @@
>>   #include <linux/pci-acpi.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pm_qos.h>
>> +#include <acpi/acpi_gic.h>
>>   #include "pci.h"
>>
>>   /*
>> @@ -681,6 +683,22 @@ static bool pci_acpi_bus_match(struct device *dev)
>>   	return dev_is_pci(dev);
>>   }
>>
>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> +struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
>> +{
>> +	struct irq_domain *d = NULL;
>> +	void *token = acpi_gic_get_msi_token(&bus->dev);
>> +
>> +	if (token)
>> +		d = irq_find_matching_host(token, DOMAIN_BUS_PCI_MSI);
>> +
>> +	if (!d)
>> +		pr_debug("Fail to find domain for MSI\n");
>> +
>> +	return d;
>> +}
>> +#endif /*CONFIG_GENERIC_MSI_IRQ_DOMAIN*/
>> +
>>   static struct acpi_bus_type acpi_pci_bus = {
>>   	.name = "PCI",
>>   	.match = pci_acpi_bus_match,
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index a7afeac..8c1204c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/module.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/pci-aspm.h>
>> +#include <linux/pci-acpi.h>
>>   #include <asm-generic/pci-bridge.h>
>>   #include "pci.h"
>>
>> @@ -670,6 +671,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>>   	 * should be called from here.
>>   	 */
>>   	d = pci_host_bridge_of_msi_domain(bus);
>> +	if (!d)
>> +		d = pci_host_bridge_acpi_msi_domain(bus);
> 
> Please use acpi_disabled here.

No, thanks. pci_host_bridge_acpi_msi_domain() can return NULL if ACPI is
disabled, just like pci_host_bridge_of_msi_domain will return NULL if
there is no domain to be found (or no OF support).

Littering various firmware predicates all over the place hardly seem
like a scalable solution, and I'd expect the ACPI backends to be self
contained.

> BTW. This is another place where we need to know our firmware - DT vs 
> ACPI. I know we can use acpi_disabled but I think more about generic 
> solution. Since we already have:
> struct fwnode_handle	*fwnode;
> we can create macro which identify h/w description style, something like:
> 
> #define FWNODE_TYPE(dev)	dev_fwnode(dev)->type
> 
> and then:
> 
> switch (FWNODE_TYPE(&bus->dev)) {
> case FWNODE_OF:
> ...
> case FWNODE_ACPI:
> ...
> case FWNODE_XXX:
> ...
> }
> 
> Root bus is special case since it has no frimware type but we could 
> factor out pci_set_bus_of_node(). For platform devices we have all we 
> need. Just thinking aloud, let me know your thoughts.

For that to work, we'd need to start converging device_node and
fwnode_handle. Having both feels quite redundant at the moment.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
