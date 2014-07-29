From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Jul 2014 21:08:40 +0800
Subject: [PATCH 01/19] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <53D69678.20002@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-2-git-send-email-hanjun.guo@linaro.org>
 <53D69678.20002@arm.com>
Message-ID: <53D79CD8.9050709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-29 2:29, Sudeep Holla wrote:
[...]
>> +
>> +/*
>> + * We never plan to use RSDT on arm/arm64 as its deprecated in spec but this
>> + * variable is still required by the ACPI core
>> + */
>> +u32 acpi_rsdt_forced;
> 
> This looks like yet another stray variable not used anywhere including
> core ACPI

It will be used by ACPICA to get the RSDP in acpi_tb_parse_root_table()
in tbutils.c.

> 
>> +
>> +int acpi_noirq;                        /* skip ACPI IRQ initialization */
>> +int acpi_strict;
>> +int acpi_disabled;
>> +EXPORT_SYMBOL(acpi_disabled);
>> +
>> +int acpi_pci_disabled;         /* skip ACPI PCI scan and IRQ initialization */
>> +EXPORT_SYMBOL(acpi_pci_disabled);
>> +
>> +/*
>> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
>> + * or early_memremap() should be called here to for ACPI table mapping.
>> + */
>> +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
>> +{
>> +       if (!phys || !size)
>> +               return NULL;
>> +
>> +       return early_memremap(phys, size);
>> +}
>> +
>> +void __init __acpi_unmap_table(char *map, unsigned long size)
>> +{
>> +       if (!map || !size)
>> +               return;
>> +
>> +       early_iounmap(map, size);
> 
> Why not early_memunmap for consistency ?

ok.

> Also now there's generic implementation of early mappings does it make
> sense to move this also to acpi core ?

Good point, how about clean it up after this patch set is merged?

Thanks
Hanjun
