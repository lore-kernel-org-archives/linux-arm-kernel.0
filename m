From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 12 Sep 2014 17:42:30 +0800
Subject: [PATCH v3 11/17] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
In-Reply-To: <20140911110846.D152DC408F0@trevor.secretlab.ca>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-12-git-send-email-hanjun.guo@linaro.org>
 <20140911110846.D152DC408F0@trevor.secretlab.ca>
Message-ID: <5412C006.6060207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?09?11? 19:08, Grant Likely wrote:
> On Mon,  1 Sep 2014 22:57:49 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
>> used, and then register device's gsi with the core IRQ subsystem.
>>
>> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
>> since gsi is unique in the system, so use hwirq number directly
>> for the mapping.
>>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/kernel/acpi.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/bus.c       |    3 ++
>>  include/linux/acpi.h     |    1 +
>>  3 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index 35dff11..354b912 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -37,6 +37,12 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>>  static int enabled_cpus;	/* Processors (GICC) with enabled flag in MADT */
>>  
>>  /*
>> + * Since we're on ARM, the default interrupt routing model
>> + * clearly has to be GIC.
>> + */
>> +enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
>> +
>> +/*
>>   * __acpi_map_table() will be called before page_init(), so early_ioremap()
>>   * or early_memremap() should be called here to for ACPI table mapping.
>>   */
>> @@ -194,6 +200,73 @@ void __init acpi_smp_init_cpus(void)
>>  	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
>>  }
>>  
>> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>> +{
>> +	*irq = irq_find_mapping(NULL, gsi);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> Why is this exported? x86 exports it, but ia64 does not. There aren't
> very many callers, and none of them can be built as a module AFAICS.

It will be called by Generic Hardware Error Source driver which
can be built as module, and it provides a way to report platform
hardware errors (such as that from chipset) which can also used
by ARM platform, so I think we can keep it as exported.

Thanks
Hanjun
