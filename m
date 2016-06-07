From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 7 Jun 2016 17:25:59 +0100
Subject: [PATCH V5 1/7] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
In-Reply-To: <5756DB5A.4080901@semihalf.com>
References: <1464693584-22343-1-git-send-email-tn@semihalf.com>
 <1464693584-22343-2-git-send-email-tn@semihalf.com>
 <20160604121530.62539dc6@arm.com> <5756DB5A.4080901@semihalf.com>
Message-ID: <5756F597.7060301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 15:34, Tomasz Nowicki wrote:
> On 04.06.2016 13:15, Marc Zyngier wrote:
>> On Tue, 31 May 2016 13:19:38 +0200
>> Tomasz Nowicki <tn@semihalf.com> wrote:
>>
>>> IORT shows representation of IO topology for ARM based systems.
>>> It describes how various components are connected together on
>>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>>>
>>> Initial support allows to:
>>> - register ITS MSI chip along with ITS translation ID and domain token
>>> - deregister ITS MSI chip based on ITS translation ID
>>> - find registered domain token based on ITS translation ID
>>> - map MSI RID based on PCI device and requester ID
>>> - find domain token based on PCI device and requester ID
>>>
>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>> ---
>>>   drivers/acpi/Kconfig  |   3 +
>>>   drivers/acpi/Makefile |   1 +
>>>   drivers/acpi/iort.c   | 344 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/iort.h  |  38 ++++++
>>>   4 files changed, 386 insertions(+)
>>>   create mode 100644 drivers/acpi/iort.c
>>>   create mode 100644 include/linux/iort.h
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index b7e2e77..848471f 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -57,6 +57,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
>>>   config ACPI_CCA_REQUIRED
>>>   	bool
>>>
>>> +config IORT_TABLE
>>> +	bool
>>> +
>>>   config ACPI_DEBUGGER
>>>   	bool "AML debugger interface"
>>>   	select ACPI_DEBUG
>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>> index 251ce85..c7c9b29 100644
>>> --- a/drivers/acpi/Makefile
>>> +++ b/drivers/acpi/Makefile
>>> @@ -82,6 +82,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>>>   obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>>   obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>>> +obj-$(CONFIG_IORT_TABLE) 	+= iort.o
>>>
>>>   # processor has its own "processor." module_param namespace
>>>   processor-y			:= processor_driver.o
>>> diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
>>> new file mode 100644
>>> index 0000000..226eb6d
>>> --- /dev/null
>>> +++ b/drivers/acpi/iort.c
>>> @@ -0,0 +1,344 @@
>>> +/*
>>> + * Copyright (C) 2016, Semihalf
>>> + *	Author: Tomasz Nowicki <tn@semihalf.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms and conditions of the GNU General Public License,
>>> + * version 2, as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope it will be useful, but WITHOUT
>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>> + * more details.
>>> + *
>>> + * This file implements early detection/parsing of I/O mapping
>>> + * reported to OS through firmware via I/O Remapping Table (IORT)
>>> + * IORT document number: ARM DEN 0049A
>>> + */
>>> +
>>> +#define pr_fmt(fmt)	"ACPI: IORT: " fmt
>>> +
>>> +#include <linux/export.h>
>>> +#include <linux/iort.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/pci.h>
>>> +
>>> +struct iort_its_msi_chip {
>>> +	struct list_head	list;
>>> +	struct fwnode_handle	*fw_node;
>>> +	u32			translation_id;
>>> +};
>>> +
>>> +typedef acpi_status (*iort_find_node_callback)
>>> +	(struct acpi_iort_node *node, void *context);
>>> +
>>> +/* Root pointer to the mapped IORT table */
>>> +static struct acpi_table_header *iort_table;
>>> +
>>> +static LIST_HEAD(iort_msi_chip_list);
>>> +
>>> +/**
>>> + * iort_register_domain_token() - register domain token and related ITS ID
>>> + * 				  to the list from where we can get it back
>>> + * 				  later on.
>>> + * @translation_id: ITS ID
>>> + * @token: domain token
>>> + *
>>> + * Returns: 0 on success, -ENOMEM if not memory when allocating list element.
>>> + */
>>> +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
>>> +{
>>> +	struct iort_its_msi_chip *its_msi_chip;
>>> +
>>> +	its_msi_chip = kzalloc(sizeof(*its_msi_chip), GFP_KERNEL);
>>> +	if (!its_msi_chip)
>>> +		return -ENOMEM;
>>> +
>>> +	its_msi_chip->fw_node = fw_node;
>>> +	its_msi_chip->translation_id = trans_id;
>>> +
>>> +	list_add(&its_msi_chip->list, &iort_msi_chip_list);
>>
>> No locking? How do you handle concurrent accesses?
> 
> I wandered if we need locking here but at the end I did not find 
> worst-case scenario.
> 
> 1. Adding elements to list is done in first place here (later on list is 
> not modified):
> start_kernel -> init_IRQ -> [...] - > gic_acpi_parse_madt_its -> 
> iort_register_domain_token
> 
> 2. Then we only retrieving elements form list:
> 
> start_kernel -> rest_init -> kernel_init -> [...] -> do_initcalls -> 
> its_pci_msi_init -> its_pci_acpi_msi_init -> iort_its_find_domain_token
> 
> pci_set_msi_domain -> iort_get_device_domain -> iort_its_find_domain_token
> 
> Do you mean some specific case?

Not right now, but as a matter of principle, shared data structures
should be protected (law of minimal surprise). And that will still work
if someone comes up with a fancy hot-pluggable socket that has an ITS on it.

[...]

>>> +static struct acpi_iort_node *
>>> +iort_dev_map_rid(struct acpi_iort_node *node, u32 rid_in,
>>> +			    u32 *rid_out)
>>
>> Given that there is no "dev" involved in this functions, but only
>> nodes, consider renaming this to iort_node_map_rid.
> 
> +1
> 
>>
>>> +{
>>> +
>>> +	if (!node)
>>> +		goto out;
>>> +
>>> +	/* Go upstream */
>>> +	while (node->type != ACPI_IORT_NODE_ITS_GROUP) {
>>> +		struct acpi_iort_id_mapping *id;
>>> +		int i, found = 0;
>>> +
>>> +		/* Exit when no mapping array */
>>> +		if (!node->mapping_offset || !node->mapping_count)
>>> +			return NULL;
>>> +
>>> +		id = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
>>> +				  node->mapping_offset);
>>> +
>>> +		for (i = 0, found = 0; i < node->mapping_count; i++, id++) {
>>> +			/*
>>> +			 * Single mapping is not translation rule,
>>> +			 * lets move on for this case
>>> +			 */
>>> +			if (id->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>>> +				if (node->type != ACPI_IORT_NODE_SMMU) {
>>> +					rid_in = id->output_base;
>>> +					found = 1;
>>> +					break;
>>> +				}
>>> +
>>> +				pr_warn(FW_BUG "[node %p type %d] SINGLE MAPPING flag not allowed for SMMU node, skipping ID map\n",
>>> +					node, node->type);
>>> +				continue;
>>> +			}
>>> +
>>> +			if (rid_in < id->input_base ||
>>> +			    (rid_in > id->input_base + id->id_count))
>>> +				continue;
>>> +
>>> +			rid_in = id->output_base + (rid_in - id->input_base);
>>> +			found = 1;
>>> +			break;
>>> +		}
>>> +
>>> +		if (!found)
>>> +			return NULL;
>>> +
>>> +		/* Firmware bug! */
>>> +		if (!id->output_reference) {
>>> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
>>> +			       node, node->type);
>>> +			return NULL;
>>> +		}
>>> +
>>> +		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>>> +				    id->output_reference);
>>> +	}
>>
>> Do we always want to resolve an ID from the device down to the last
>> possible transformation? While this works fine for the ITS (which is
>> supposed to be the last user of the RID), this may not work that well
>> for intermediate remapping elements (IOMMU, for example).
>>
>> So I'm wondering if what we actually want is something that would say
>> iort_node_map_rid(from_node, to_node, rid_in, &rid_out)?
> 
> Good point. Actually Lorenzo improved that function in his SMMU ACPI 
> series addressing your comment. So we can make it more generic from day one.

Indeed. He also has a couple of fixes that you could directly include in
the next drop.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
