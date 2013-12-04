From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 23:38:56 +0800
Subject: [RFC part2 PATCH 7/9] irqdomain: Add a new API
 irq_create_acpi_mapping()
In-Reply-To: <CAL_JsqK93mJbFu+GaK_5L14jKnMgctUNdEBqS6K5zKer16Sm3Q@mail.gmail.com>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-8-git-send-email-hanjun.guo@linaro.org>
 <CAL_JsqK93mJbFu+GaK_5L14jKnMgctUNdEBqS6K5zKer16Sm3Q@mail.gmail.com>
Message-ID: <529F4C90.4070402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 01:25, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 10:39 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>
>> This patch introduces a new API for acpi based irq mapping.
>>
>> [hanjun: Rework this patch to delete the reference to
>> gic_irq_domain_xlate() which can simplify the code a lot.]
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   include/linux/acpi.h   |    2 ++
>>   kernel/irq/irqdomain.c |   27 +++++++++++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 1e6a0ac..edd5806 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -141,6 +141,8 @@ int acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu);
>>   int acpi_unmap_lsapic(int cpu);
>>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>>
>> +unsigned int irq_create_acpi_mapping(irq_hw_number_t hwirq,
>> +                                        unsigned int type);
>>   int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base);
>>   int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);
>>   void acpi_irq_stats_init(void);
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index cf68bb3..c661552 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -501,6 +501,33 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>>   }
>>   EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>>
>> +#ifdef CONFIG_ACPI
>> +unsigned int irq_create_acpi_mapping(irq_hw_number_t hwirq,
>> +                                       unsigned int type)
>> +{
>> +       struct irq_domain *domain;
>> +       unsigned int virq;
>> +
>> +       domain = irq_default_domain;
>> +       if (!domain) {
>> +               pr_warn("no irq domain found !\n");
>> +               return 0;
>> +       }
>> +
>> +       /* Create mapping */
>> +       virq = irq_create_mapping(domain, hwirq);
>> +       if (!virq)
>> +               return virq;
>> +
>> +       /* Set type if specified and different than the current one */
>> +       if (type != IRQ_TYPE_NONE &&
>> +           type != irq_get_trigger_type(virq))
>> +               irq_set_irq_type(virq, type);
>> +       return virq;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_create_acpi_mapping);
> There is nothing ACPI specific about this function. This is simply
> irq_create_of_mapping w/o translating of_phandle_args to a hwirq and
> type. So I expect the code to be re-factored here to mirror that.

Sorry for my bad english, do you mean create a OF free function
and call that from the OF function ?

Thanks
Hanjun
