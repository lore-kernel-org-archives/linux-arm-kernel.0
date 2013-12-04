From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 22:58:19 +0800
Subject: [RFC part2 PATCH 9/9] ACPI / GIC: Initialize GIC using the
 information in MADT
In-Reply-To: <CAL_Jsq+XWn5ns850mV6Jvm0W4+TPh8c0aWANZPAqSPmmsDMWoQ@mail.gmail.com>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-10-git-send-email-hanjun.guo@linaro.org>
 <CAL_Jsq+XWn5ns850mV6Jvm0W4+TPh8c0aWANZPAqSPmmsDMWoQ@mail.gmail.com>
Message-ID: <529F430B.10609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 01:09, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 10:39 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> In MADT table, there are GIC cpu interface base address and
>> GIC distributor base address, use them to convert GIC to ACPI.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/irq.c      |    5 ++++
>>   drivers/acpi/plat/arm-core.c |   66 ++++++++++++++++++++++++++++++++++++------
>>   include/linux/acpi.h         |    6 ++++
>>   3 files changed, 68 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index 473e5db..a9e68bf 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/irq.h>
>>   #include <linux/smp.h>
>>   #include <linux/init.h>
>> +#include <linux/acpi.h>
>>   #include <linux/irqchip.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/ratelimit.h>
>> @@ -78,6 +79,10 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>>   void __init init_IRQ(void)
>>   {
>>          irqchip_init();
>> +
>> +       if (!handle_arch_irq)
>> +               acpi_gic_init();
>> +
>>          if (!handle_arch_irq)
>>                  panic("No interrupt controller found.");
>>   }
>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
>> index 17c99e1..509b847 100644
>> --- a/drivers/acpi/plat/arm-core.c
>> +++ b/drivers/acpi/plat/arm-core.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/module.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/irqchip/arm-gic.h>
>>   #include <linux/slab.h>
>>   #include <linux/bootmem.h>
>>   #include <linux/ioport.h>
>> @@ -211,11 +212,21 @@ acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_ARM_GIC
> Perhaps this should go in the GIC code? This is more of a general
> question of where init/probing code goes. For DT, this as been with
> the driver code.

I'm ok with your suggestion, how about move the code to
drivers/irqchip/irq-gic.c ? is this make sense to you?

>> +/*
>> + * Hard code here, we can not get memory size from MADT (but FDT does),
>> + * this size is described in ARMv8 foudation model's User Guide
>> + */
>> +#define GIC_DISTRIBUTOR_MEMORY_SIZE (SZ_8K)
>> +#define GIC_CPU_INTERFACE_MEMORY_SIZE (SZ_4K)
> You have the sizes swapped. The cpu interface has the DIR register at 0x1000.

I will figure out the right size in next version.

>> +
>>   static int __init
>>   acpi_parse_gic_distributor(struct acpi_subtable_header *header,
>>                                  const unsigned long end)
>>   {
>>          struct acpi_madt_generic_distributor *distributor = NULL;
>> +       void __iomem *dist_base = NULL;
>> +       void __iomem *cpu_base = NULL;
> Initialization here is unnecessary.

ok, will update in next version.

>>          distributor = (struct acpi_madt_generic_distributor *)header;
>>
>> @@ -224,8 +235,43 @@ acpi_parse_gic_distributor(struct acpi_subtable_header *header,
>>
>>          acpi_table_print_madt_entry(header);
>>
>> +       /* GIC is initialised after page_init(), no need for early_ioremap */
>> +       dist_base = ioremap(distributor->base_address,
>> +                               GIC_CPU_INTERFACE_MEMORY_SIZE);
> Should be GIC_DISTRIBUTOR_MEMORY_SIZE.

Good catch

>> +       if (!dist_base) {
>> +               pr_warn(PREFIX "unable to map gic dist registers\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       /*
>> +        * acpi_lapic_addr is stored in acpi_parse_madt(),
>> +        * so we can use it here for GIC init
>> +        */
>> +       if (acpi_lapic_addr) {
> Checking this first would be cleaner.

Agreed, thank you for the advice, will update it in next version.

>> +               iounmap(dist_base);
>> +               pr_warn(PREFIX "Invalid GIC cpu interface base address\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       cpu_base = ioremap(acpi_lapic_addr, GIC_CPU_INTERFACE_MEMORY_SIZE);
> How are gic's with different cpu address per core going to be handled?

do you mean some GIC without banked registers?
if yes, ACPI can handle that, in the GIC (GIC cpu interface) structure, there is
"Physical Base Address" per core, we can use it to handle gic's with different
cpu address per core.

This part of code is not implemented yet, if needed, will send out in next version.


>> +       if (!cpu_base) {
>> +               iounmap(dist_base);
>> +               pr_warn(PREFIX "unable to map gic cpu registers\n");
> All the printks are a bit verbose for my tastes. I think a single
> error print would suffice.

do you mean if meet some error, then got to a single error printk?

>> +               return -ENOMEM;
>> +       }
>> +
>> +       gic_init(distributor->gic_id, -1, dist_base, cpu_base);
>> +
>>          return 0;
>>   }
>> +#else
>> +static int __init
>> +acpi_parse_gic_distributor(struct acpi_subtable_header *header,
>> +                               const unsigned long end)
>> +{
>> +       return -ENODEV;
>> +}
>> +#endif /* CONFIG_ARM_GIC */
> A "if (!IS_ENABLED(CONFIG_ARM_GIC)) return;" in the above function
> would eliminate this ifdef.

Thanks for the suggestion, will do it

>>   /*
>>    * Parse GIC cpu interface related entries in MADT
>> @@ -234,7 +280,7 @@ acpi_parse_gic_distributor(struct acpi_subtable_header *header,
>>   static int __init acpi_parse_madt_gic_entries(void)
>>   {
>>          int count;
>> -
>> +
> Unnecessary whitespace change.

will update it :)

Thanks
Hanjun
