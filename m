From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 15 Jun 2016 10:07:24 -0500
Subject: [PATCH 3/8] arm64: pmu: Add support for probing with ACPI
In-Reply-To: <20160615113333.GI24029@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-4-git-send-email-jeremy.linton@arm.com>
 <20160615113333.GI24029@arm.com>
Message-ID: <57616F2C.4020901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 06:33 AM, Will Deacon wrote:
> On Thu, Jun 09, 2016 at 05:23:28PM -0500, Jeremy Linton wrote:
>> From: Mark Salter <msalter@redhat.com>
>>
>> In the case of ACPI, the PMU IRQ information is contained in the
>> MADT table. Also, since the PMU does not exist as a device in the
>> ACPI DSDT table, it is necessary to create a platform device so
>> that the appropriate driver probing is triggered.
>>
>> Signed-off-by: Mark Salter <msalter@redhat.com>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>
>>   NOTE: Much of the code in pmu_acpi_init() is replaced in a later version
>>         of this patch. The later version of the patch cleans up some of the
>>         possible style/error handling issues that have been pointed out with
>>         this version.
>>
>>   arch/arm64/kernel/smp.c      |  5 +++
>>   drivers/perf/Kconfig         |  4 ++
>>   drivers/perf/Makefile        |  1 +
>>   drivers/perf/arm_pmu_acpi.c  | 97 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/perf/arm_pmu.h |  7 ++++
>>   5 files changed, 114 insertions(+)
>>   create mode 100644 drivers/perf/arm_pmu_acpi.c
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 678e084..5c96d23 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -37,6 +37,7 @@
>>   #include <linux/completion.h>
>>   #include <linux/of.h>
>>   #include <linux/irq_work.h>
>> +#include <linux/perf/arm_pmu.h>
>>
>>   #include <asm/alternative.h>
>>   #include <asm/atomic.h>
>> @@ -540,6 +541,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>>   			return;
>>   		}
>>   		bootcpu_valid = true;
>> +		arm_pmu_parse_acpi(0, processor);
>>   		return;
>>   	}
>>
>> @@ -560,6 +562,9 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>>   	 */
>>   	acpi_set_mailbox_entry(cpu_count, processor);
>>
>> +	/* get PMU irq info */
>> +	arm_pmu_parse_acpi(cpu_count, processor);
>> +
>
> Nit: the outer functions are now misnomers, since this has nothing to do
> with the GIC. It feels like acpi_parse_gic_cpu_interface could use some
> slight restructuring so that the MADT parsing looks less confused.


Ok, I will clean up the naming a bit.


>
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index acd2397..fd8090d 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -1 +1,2 @@
>>   obj-$(CONFIG_ARM_PMU) += arm_pmu.o
>> +obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> new file mode 100644
>> index 0000000..98c452d
>> --- /dev/null
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * PMU support
>> + *
>> + * Copyright (C) 2015 Red Hat Inc.
>> + * Author: Mark Salter <msalter@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.  See
>> + * the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include <linux/perf/arm_pmu.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdesc.h>
>> +
>> +#define PMU_PDEV_NAME "armv8-pmu"
>
> Stick this in include/linux/perf/arm_pmu.h where we can use it in the driver
> code too?

Sure..

>
>> +
>> +struct pmu_irq {
>> +	int gsi;
>> +	int trigger;
>> +};
>> +
>> +static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
>> +
>> +void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>> +{
>> +	pmu_irqs[cpu].gsi = gic->performance_interrupt;
>> +	if (gic->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
>> +		pmu_irqs[cpu].trigger = ACPI_EDGE_SENSITIVE;
>> +	else
>> +		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
>> +}
>> +
>> +static int __init pmu_acpi_init(void)
>> +{
>> +	struct platform_device *pdev;
>> +	struct pmu_irq *pirq = pmu_irqs;
>> +	struct resource	*res, *r;
>> +	int err = -ENOMEM;
>> +	int i, count, irq;
>> +
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	/* Must have irq for boot boot cpu, at least */
>
> boot boot
>
>> +	if (pirq->gsi == 0)
>> +		return -EINVAL;
>> +
>> +	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
>> +				ACPI_ACTIVE_HIGH);
>
> This is quite tricky to read, thanks to the aliasing of pirq and
> pmu_irqs[0]. Why is it necessary to register the first gsi separately,
> rather than just register it later in the loop with all the other
> interrupts?

	Short answer, no particular reason. If you notice patch 6, 
arm_pmu_acpi_gsi_res() reworks this to register all the irqs for a 
particular PMU at the same time.
