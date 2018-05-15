From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 15 May 2018 16:42:32 -0500
Subject: [PATCH v9 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
In-Reply-To: <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-6-jeremy.linton@arm.com>
 <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com>
Message-ID: <7cefb087-f41a-0a73-ef77-b560d338be4b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/12/2018 05:09 AM, Rafael J. Wysocki wrote:
> On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> ACPI 6.2 adds a new table, which describes how processing units
>> are related to each other in tree like fashion. Caches are
>> also sprinkled throughout the tree and describe the properties
>> of the caches in relation to other caches and processing units.
>>
>> Add the code to parse the cache hierarchy and report the total
>> number of levels of cache for a given core using
>> acpi_find_last_cache_level() as well as fill out the individual
>> cores cache information with cache_setup_acpi() once the
>> cpu_cacheinfo structure has been populated by the arch specific
>> code.
>>
>> An additional patch later in the set adds the ability to report
>> peers in the topology using find_acpi_cpu_topology()
>> to report a unique ID for each processing unit at a given level
>> in the tree. These unique id's can then be used to match related
>> processing units which exist as threads, within a given
>> package, etc.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
>> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>   drivers/acpi/pptt.c  | 655 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h |   4 +
>>   2 files changed, 659 insertions(+)
>>   create mode 100644 drivers/acpi/pptt.c
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> new file mode 100644
>> index 000000000000..e5ea1974d1e3
>> --- /dev/null
>> +++ b/drivers/acpi/pptt.c
>> @@ -0,0 +1,655 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pptt.c - parsing of Processor Properties Topology Table (PPTT)
>> + *
>> + * Copyright (C) 2018, ARM
>> + *
>> + * This file implements parsing of the Processor Properties Topology Table
>> + * which is optionally used to describe the processor and cache topology.
>> + * Due to the relative pointers used throughout the table, this doesn't
>> + * leverage the existing subtable parsing in the kernel.
>> + *
>> + * The PPTT structure is an inverted tree, with each node potentially
>> + * holding one or two inverted tree data structures describing
>> + * the caches available at that level. Each cache structure optionally
>> + * contains properties describing the cache at a given level which can be
>> + * used to override hardware probed values.
>> + */
>> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cacheinfo.h>
>> +#include <acpi/processor.h>
>> +
>> +static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>> +                                                       u32 pptt_ref)
>> +{
>> +       struct acpi_subtable_header *entry;
>> +
>> +       /* there isn't a subtable at reference 0 */
>> +       if (pptt_ref < sizeof(struct acpi_subtable_header))
>> +               return NULL;
>> +
>> +       if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
>> +               return NULL;
>> +
>> +       entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
>> +
>> +       if (entry->length == 0)
>> +               return NULL;
>> +
>> +       if (pptt_ref + entry->length > table_hdr->length)
>> +               return NULL;
>> +
>> +       return entry;
>> +}
>> +
>> +static struct acpi_pptt_processor *fetch_pptt_node(struct acpi_table_header *table_hdr,
>> +                                                  u32 pptt_ref)
>> +{
>> +       return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr, pptt_ref);
>> +}
>> +
>> +static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_hdr,
>> +                                               u32 pptt_ref)
>> +{
>> +       return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
> 
> I don't think you really need the explicit type cast here and above,
> but that's very minor.
> 
>> +}
> 
> Please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patch and route it through the arch tree as needed.

Thanks for looking at this (and the ack of course)!

As an FYI, the in my build without the type cast, the 
-Werror=incompatible-pointer-types (sourced from the root Makefile) 
triggers an error.



thanks again.
