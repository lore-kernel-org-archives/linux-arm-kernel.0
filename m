From: yinghai@kernel.org (Yinghai Lu)
Date: Mon, 29 Sep 2014 12:06:10 -0700
Subject: [PATCH v13 10/12] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
In-Reply-To: <CAE9FiQXEUZvkuzwOrK+2zGVj0ywFaQsiWH7SHufZk9BRWnwddQ@mail.gmail.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
 <1412000971-9242-11-git-send-email-Liviu.Dudau@arm.com>
 <CAE9FiQXEUZvkuzwOrK+2zGVj0ywFaQsiWH7SHufZk9BRWnwddQ@mail.gmail.com>
Message-ID: <CAE9FiQUkcPRMUEn01VJMyXz8aYvk6C5MBNZi5NCV2m3qkNabeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 11:25 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 29, 2014 at 7:29 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> If the firmware has not assigned all the bus resources and we are not just
>> probing the PCI buses, it makes sense to assign the unassigned resources
>> in pci_scan_root_bus().
>>
>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> ---
>>  drivers/pci/probe.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 636d1c9..d2ebd49 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1951,6 +1951,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>>         if (!found)
>>                 pci_bus_update_busn_res_end(b, max);
>>
>> +       if (!pci_has_flag(PCI_PROBE_ONLY))
>> +               pci_assign_unassigned_bus_resources(b);
>> +
>>         pci_bus_add_devices(b);
>>         return b;
>>  }
>
> No, you can not do it that early.
>
> On x86, we need to call
> pcibios_resource_survey_bus at first.

on x86:
pcibios_init
pcibios_resource_survey()
pcibios_assign_resources() via fs_initcall
