From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Sun, 9 Aug 2015 15:02:33 +0700
Subject: [PATCH v4 08/10] ACPI: GIC: Add ACPI helper functions to query
 irq-domain tokens for for GIC MSI and ITS
In-Reply-To: <55C0C5DD.6090607@arm.com>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-9-git-send-email-hanjun.guo@linaro.org>
 <55C0C5DD.6090607@arm.com>
Message-ID: <55C70919.2050805@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Sorry for late reply. Please see my comments below.

On 8/4/15 21:02, Marc Zyngier wrote:
> On 29/07/15 11:08, Hanjun Guo wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> This patch introduces acpi_gic_get_msi_token(), which returns irq-domain
>> token that can be used to look up MSI doamin of a device.
>> In both GIC MSI and ITS cases, the base_address specified in the GIC MSI
>> or GIC ITS structure is used as a token for MSI domain.
>>
>> In addition, this patch also provides low-level helper functions to parse
>> and query GIC MSI structure and GIC ITS from MADT. Once parsed, it keeps
>> a copy of the structure for use in subsequent queries to avoid having
>> to map and parse MADT multiple times.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/Makefile   |   1 +
>>   drivers/acpi/acpi_gic.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/acpi/acpi_gic.h |  23 +++++
>>   include/linux/acpi.h    |   1 +
>>   4 files changed, 259 insertions(+)
>>   create mode 100644 drivers/acpi/acpi_gic.c
>>   create mode 100644 include/acpi/acpi_gic.h
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 8321430..def54b9 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -54,6 +54,7 @@ acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>>   acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>>   acpi-y				+= acpi_lpat.o
>>   acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
>> +acpi-$(CONFIG_ARM_GIC_ACPI)	+= acpi_gic.o
>>
>>   # These are (potentially) separate modules
>>
>> diff --git a/drivers/acpi/acpi_gic.c b/drivers/acpi/acpi_gic.c
>> new file mode 100644
>> index 0000000..11ee4eb
>> --- /dev/null
>> +++ b/drivers/acpi/acpi_gic.c
>
> I think this is starting badly. If this is GIC specific, it lives in
> drivers/irqchip. Nothing in drivers/acpi should be interrupt-controller
> specific at all. If there are things you need to expose through the ACPI
> layer, add some indirections.

OK, originally, I intended for this to be an intermediate layer b/w ACPI 
and irqchip, but I guess that's still not what you are looking for. I'll 
rework this again.

[....]
>> +
>> +#endif /*__ACPI_GIC_H__*/
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 04dd0bb..5d58b61 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -44,6 +44,7 @@
>>
>>   #include <acpi/acpi_bus.h>
>>   #include <acpi/acpi_drivers.h>
>> +#include <acpi/acpi_gic.h>
>
> Ah! No.
>
>>   #include <acpi/acpi_numa.h>
>>   #include <acpi/acpi_io.h>
>>   #include <asm/acpi.h>
>>
>
> Right. Very little of what is above belongs to the ACPI layer. What
> would belong here is a generic acpi_get_msi_domain_token(dev) that would
> call into a controller-specific function to parse the various tables and
> find out which GICv2m frame (or which ITS) is serving the given device.
> This would include parsing of the IORT structures if they are available.

The problem here is we would need to figure out the hook into *a 
controller-specific function* from a generic layer (ACPI in this case).

> For GICv2m, it should be simplistic: just return the domain_token of the
> v2m widget. For the ITS, it is slightly more complex, and there should
> be some specific backend for that. There is no ACPI support for the ITS
> yet, so that shouldn't be your concern at this point in time.
>
> Overall, drivers/acpi should be hardware agnostic (or at least aim for
> it), just like drivers/of is.

I think I understand how you don't like the current approach. Lemme try 
a different approach and send out another revision.

Thanks,
Suravee
