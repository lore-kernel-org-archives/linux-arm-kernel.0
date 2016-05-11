From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 11 May 2016 09:39:34 +0200
Subject: [PATCH V7 05/11] acpi, pci: Support IO resources when parsing PCI
 host bridge resources.
In-Reply-To: <CAJZ5v0j-jiGmMWoyd-ab4qiKGAScbxMskqUThBQxkOxPR8unMA@mail.gmail.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-6-git-send-email-tn@semihalf.com>
 <CAJZ5v0j-jiGmMWoyd-ab4qiKGAScbxMskqUThBQxkOxPR8unMA@mail.gmail.com>
Message-ID: <5732E1B6.1000709@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.05.2016 20:20, Rafael J. Wysocki wrote:
> On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> Platforms that have memory mapped IO port (such as ARM64) need special
>> handling for PCI I/O resources. For host bridge's resource probing case
>> these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.
>>
>> The same I/O resources need to be released after hotplug
>> removal so that it can be re-added back by the pci_remap_iospace
>> function during insertion. As a consequence we unmap I/O resources
>> with pci_unmap_iospace when we release host bridge resources.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/acpi/pci_root.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index ae3fe4e..cb3071d 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -719,6 +719,34 @@ next:
>>                          resource_list_add_tail(entry, resources);
>>          }
>>   }
>> +static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
>> +{
>> +#ifdef PCI_IOBASE
>
> Same comment about the #ifdefs as in the other patch.

OK

>
>> +       struct resource *res = entry->res;
>> +       resource_size_t cpu_addr = res->start;
>> +       resource_size_t pci_addr = cpu_addr - entry->offset;
>> +       resource_size_t length = resource_size(res);
>> +       unsigned long port;
>> +
>> +       if (pci_register_io_range(cpu_addr, length))
>> +               goto err;
>> +
>> +       port = pci_address_to_pio(cpu_addr);
>> +       if (port == (unsigned long)-1)
>> +               goto err;
>> +
>> +       res->start = port;
>> +       res->end = port + length - 1;
>> +       entry->offset = port - pci_addr;
>> +
>> +       if (pci_remap_iospace(res, cpu_addr) < 0)
>> +               goto err;
>
> An empty line here?

yes, empty line would be nice here.

Tomasz
