From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Dec 2015 08:55:29 +0000
Subject: [PATCH V3 2/6] acpi: pci: Setup MSI domain for ACPI based pci
 devices
In-Reply-To: <56647866.8080802@semihalf.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445453249-32557-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151119120807.07ffd476@arm.com> <5650DFB5.2010809@amd.com>
 <20151122113553.4fd81185@arm.com> <56647866.8080802@semihalf.com>
Message-ID: <56654981.9020301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 06/12/15 18:03, Tomasz Nowicki wrote:
> Hi Marc,
> 
> 
> On 11/22/2015 12:35 PM, Marc Zyngier wrote:
>> On Sat, 21 Nov 2015 15:18:45 -0600
>> Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
>>
>>> Hi Marc,
>>>
>>> On 11/19/15 06:08, Marc Zyngier wrote:
>>>> On Wed, 21 Oct 2015 11:47:25 -0700
>>>> Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
>>>>
>>>> Hi Suravee,
>>>>
>>>> Sorry it took so long to get to this series. Comments below.
>>> No worry.
>>>
>>>>> This patch introduces pci_host_bridge_acpi_msi_domain(), which returns
>>>>> the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
>>>>> bus token. Then, it is assigned to pci device.
>>>>>
>>>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>>> ---
>>>>>    drivers/pci/pci-acpi.c | 13 +++++++++++++
>>>>>    drivers/pci/probe.c    |  2 ++
>>>>>    include/linux/pci.h    |  7 +++++++
>>>>>    3 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>>> index a32ba75..0e21ef4 100644
>>>>> --- a/drivers/pci/pci-acpi.c
>>>>> +++ b/drivers/pci/pci-acpi.c
>>>>> @@ -9,7 +9,9 @@
>>>>>
>>>>>    #include <linux/delay.h>
>>>>>    #include <linux/init.h>
>>>>> +#include <linux/irqdomain.h>
>>>>>    #include <linux/pci.h>
>>>>> +#include <linux/msi.h>
>>>>>    #include <linux/pci_hotplug.h>
>>>>>    #include <linux/module.h>
>>>>>    #include <linux/pci-aspm.h>
>>>>> @@ -689,6 +691,17 @@ static struct acpi_bus_type acpi_pci_bus = {
>>>>>    	.cleanup = pci_acpi_cleanup,
>>>>>    };
>>>>>
>>>>> +struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
>>>>> +{
>>>>> +	struct irq_domain *dom = NULL;
>>>>> +	struct fwnode_handle *fwnode = pci_msi_get_fwnode(&bus->dev);
>>>>> +
>>>>> +	if (fwnode)
>>>>> +		dom = irq_find_matching_fwnode(fwnode,
>>>>> +					       DOMAIN_BUS_PCI_MSI);
>>>>> +	return dom;
>>>>> +}
>>>>> +
>>>> Given this, I really question the need for what you define in patch #1
>>>> to be standalone. It is only used by ACPI (DT has its own private
>>>> helpers), and it is so far unlikely that it will be of any use for
>>>> other firmware interfaces.
>>>>
>>>> My suggestion is to get rid of pci_msi_get_fwnode() and move the
>>>> registration helper into this file. That'd be much simpler.
>>>>
>>>> Thanks,
>>>>
>>>> 	M.
>>>>
>>> Ok, I'll take care of this. I assume the rest of the patches looks ok.
>> I still need to finish going through it (I have minor comments so far
>> on some of the other patches), but I want to get the core ACPI stuff in
>> shape before doing anything else.
> I am trying to do similar thing for GICv3 & ITS, can you please have a look:
> http://lkml.iu.edu/hypermail/linux/kernel/1510.1/06139.html
> 
> Can you please explain what ACPI core changes do you mean?

I mean the code in patches 1 and 2 in Suravee's series. This should form
the basics for being able to assign MSI domains to devices.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
