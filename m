From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 13 May 2015 13:38:37 +0800
Subject: [RFC v2 6/7] x86/PCI/ACPI: Use common interface to support PCI
 host bridge
In-Reply-To: <5551EFC1.2010704@linaro.org>
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com>
 <1430793970-11159-7-git-send-email-jiang.liu@linux.intel.com>
 <5551EFC1.2010704@linaro.org>
Message-ID: <5552E35D.8030501@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/12 20:19, Hanjun Guo wrote:
> [...]
>>   struct pci_root_info {
>> -    struct acpi_device *bridge;
>> -    char name[16];
>> -    struct pci_controller sd;
>> +    struct acpi_pci_root_info_common common;
>>   #ifdef    CONFIG_PCI_MMCONFIG
>>       bool mcfg_added;
>>       u16 segment;
>> @@ -165,14 +164,17 @@ static int check_segment(u16 seg, struct device
>> *dev, char *estr)
>>       return 0;
>>   }
>>
>> -static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
>> -              u8 end, phys_addr_t addr)
>> +static int setup_mcfg_map(struct acpi_pci_root_info_common *ci)
>>   {
>>       int result;
>> -    struct device *dev = &info->bridge->dev;
>> +    struct pci_root_info *info;
>> +    struct acpi_pci_root *root = ci->root;
>> +    struct device *dev = &ci->bridge->dev;
>> +    int seg = ci->controller.segment;
> 
> ...
> 
>>
>> -    info->start_bus = start;
>> -    info->end_bus = end;
>> +    info = container_of(ci, struct pci_root_info, common);
>> +    info->start_bus = (u8)root->secondary.start;
>> +    info->end_bus = (u8)root->secondary.end;
>>       info->mcfg_added = false;
> 
> info->segment is not initialized here
> 
>>
>>       /* return success if MMCFG is not in use */
>> @@ -182,7 +184,8 @@ static int setup_mcfg_map(struct pci_root_info
>> *info, u16 seg, u8 start,
>>       if (!(pci_probe & PCI_PROBE_MMCONF))
>>           return check_segment(seg, dev, "MMCONFIG is disabled,");
>>
>> -    result = pci_mmconfig_insert(dev, seg, start, end, addr);
>> +    result = pci_mmconfig_insert(dev, seg, info->start_bus,
>> info->end_bus,
>> +                     root->mcfg_addr);
>>       if (result == 0) {
>>           /* enable MMCFG if it hasn't been enabled yet */
>>           if (raw_pci_ext_ops == NULL)
>> @@ -195,8 +198,11 @@ static int setup_mcfg_map(struct pci_root_info
>> *info, u16 seg, u8 start,
>>       return 0;
>>   }
>>
>> -static void teardown_mcfg_map(struct pci_root_info *info)
>> +static void teardown_mcfg_map(struct acpi_pci_root_info_common *ci)
>>   {
>> +    struct pci_root_info *info;
>> +
>> +    info = container_of(ci, struct pci_root_info, common);
>>       if (info->mcfg_added) {
>>           pci_mmconfig_delete(info->segment, info->start_bus,
> 
> But the segment is used here to delete mmconfig entry, it seems that
> the domain is 0 so there will be no problem, did I miss something?

Good catch, we should use ci->controller.segment and kill info->segment.

> 
> Thanks
> Hanjun
