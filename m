From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Thu, 20 Oct 2016 17:23:58 -0400
Subject: [PATCH V5 1/2] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <4506c0f4-165a-e84b-73e2-d3cca9c8b9d7@arm.com>
References: <1476812509-2760-1-git-send-email-agustinv@codeaurora.org>
 <1476812509-2760-2-git-send-email-agustinv@codeaurora.org>
 <20161020164812.GD8731@red-moon>
 <4506c0f4-165a-e84b-73e2-d3cca9c8b9d7@arm.com>
Message-ID: <356eaad5e0c546d22f6dca2d6a4530ea@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Marc,

On 2016-10-20 13:51, Marc Zyngier wrote:
> On 20/10/16 17:48, Lorenzo Pieralisi wrote:
>> Hi Agustin,
>> 
>> On Tue, Oct 18, 2016 at 01:41:48PM -0400, Agustin Vega-Frias wrote:
>>> This allows irqchip drivers to associate an ACPI DSDT device to
>>> an IRQ domain and provides support for using the ResourceSource
>>> in Extended IRQ Resources to find the domain and map the IRQs
>>> specified on that domain.
>>> 
>>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>>> ---
>>>  drivers/acpi/Makefile             |   1 +
>>>  drivers/acpi/irqdomain.c          | 141 
>>> ++++++++++++++++++++++++++++++++++++++
>>>  drivers/acpi/resource.c           |  21 +++---
>>>  include/asm-generic/vmlinux.lds.h |   1 +
>>>  include/linux/acpi.h              |  71 +++++++++++++++++++
>>>  include/linux/irqchip.h           |  17 ++++-
>>>  6 files changed, 240 insertions(+), 12 deletions(-)
>>>  create mode 100644 drivers/acpi/irqdomain.c
>>> 
>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>> index 9ed0878..880401b 100644
>>> --- a/drivers/acpi/Makefile
>>> +++ b/drivers/acpi/Makefile
>>> @@ -57,6 +57,7 @@ acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>>>  acpi-y				+= acpi_lpat.o
>>>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
>>>  acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
>>> +acpi-$(CONFIG_IRQ_DOMAIN)	+= irqdomain.o
>>> 
>>>  # These are (potentially) separate modules
>>> 
>>> diff --git a/drivers/acpi/irqdomain.c b/drivers/acpi/irqdomain.c
>>> new file mode 100644
>>> index 0000000..c53b9f4
>>> --- /dev/null
>>> +++ b/drivers/acpi/irqdomain.c
>>> @@ -0,0 +1,141 @@
>>> +/*
>>> + * ACPI ResourceSource/IRQ domain mapping support
>>> + *
>>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or 
>>> modify
>>> + * it under the terms of the GNU General Public License version 2 
>>> and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +#include <linux/acpi.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/irqdomain.h>
>>> +
>>> +/**
>>> + * acpi_irq_domain_ensure_probed() - Check if the device has 
>>> registered
>>> + *                                   an IRQ domain and probe as 
>>> necessary
>>> + *
>>> + * @device: Device to check and probe
>>> + *
>>> + * Returns: 0 on success, -ENODEV otherwise
>> 
>> This is not correct (ie it depends on what
>> 
>> struct acpi_dsdt_probe_entry.probe
>> 
>> returns) and I would like to take this nit as an opportunity
>> to take a step back and ask you a question below.
>> 
>>> + */
>>> +static int acpi_irq_domain_ensure_probed(struct acpi_device *device)
>>> +{
>>> +	struct acpi_dsdt_probe_entry *entry;
>>> +
>>> +	if (irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY) != 0)
>>> +		return 0;
>>> +
>>> +	for (entry = &__dsdt_acpi_probe_table;
>>> +	     entry < &__dsdt_acpi_probe_table_end; entry++)
>>> +		if (strcmp(entry->_hid, acpi_device_hid(device)) == 0)
>>> +			return entry->probe(device);
>> 
>> Through this approch we are forcing an irqchip (that by the way it
>> has a physical node ACPI companion by being a DSDT device object so it
>> could be managed by a platform driver) to be probed. The question is: 
>> is
>> there a reason (apart from the current ACPI resource parsing API) why
>> this can't be implemented through deferred probing and the device
>> dependencies framework Rafael is working on:
>> 
>> http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1246897.html
>> 
>> The DT layer, through the of_irq_get() API, supports probe deferral
>> and what I am asking you is if there is any blocking point (again,
>> apart from the current ACPI API) to implement the same mechanism.
>> 
>> I have not reviewed the previous versions so I am certainly missing
>> some of the bits and pieces already discussed, apologies for that.
> 
> Also, this function scares me to no end: lack of locking and recursion
> are the main things that worry me. My vote would be to implement
> something based on Rafael's approach (which conveniently solves all 
> kind
> of other issues).

I'll review Rafael's latest patchset and comment back on whether it 
suits
our needs or if we can build on that.

Thanks

> 
> I'll review this patch series in a more in-depth way soon, but I wanted
> to chime in and add my own weight to Lorenzo's proposal.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
