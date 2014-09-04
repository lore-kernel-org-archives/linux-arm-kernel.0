From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Thu, 04 Sep 2014 12:10:28 +0200
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <2893693.4bZJXXENof@wuerfel>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
 <2893693.4bZJXXENof@wuerfel>
Message-ID: <54083A94.2040105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.09.2014 20:42, Arnd Bergmann wrote:
> On Monday 01 September 2014 22:57:51 Hanjun Guo wrote:
>> +       /* Collect CPU base addresses */
>> +       count = acpi_parse_entries(sizeof(struct acpi_table_madt),
>> +                                  gic_acpi_parse_madt_cpu, table,
>> +                                  ACPI_MADT_TYPE_GENERIC_INTERRUPT,
>> +                                  ACPI_MAX_GIC_CPU_INTERFACE_ENTRIES);
>> +       if (count < 0) {
>> +               pr_err("Error during GICC entries parsing\n");
>> +               return -EFAULT;
>> +       } else if (!count) {
>> +               /* No GICC entries provided, use address from MADT header */
>> +               struct acpi_table_madt *madt = (struct acpi_table_madt *)table;
>> +
>> +               if (!madt->address)
>> +                       return -EFAULT;
>> +
>> +               cpu_phy_base = (u64)madt->address;
>> +       }
>
> After I read through ACPI-5.1 section 5.2.12.14, I wonder if this is the
> best way to treat a missing ACPI_MADT_TYPE_GENERIC_INTERRUPT table.
>
> Do we expect to see those in practice? It seems like using the x86 local
> APIC address as a fallback for the GIC address is not something we
> should do unless we absolutely have to support a system that doesn't
> have the GIC table.

No, we do not expect and hopefully there will be no such :)

But, we are trying to be as much as possible inline with 5.1 spec, 
5.2.12.14 says:
[...]
If provided here (CPU physical base address), the "Local Interrupt 
Controller Address" field in the MADT must be ignored by the OSPM.
[...]

Regards,
Tomasz
