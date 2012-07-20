From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 20 Jul 2012 22:28:39 +0900
Subject: [PATCH v3] ARM: Make a compile firmware conditionally
In-Reply-To: <20120720094255.GA2114@linaro.org>
References: <20120720082419.GA9394@july>
	<20120720094255.GA2114@linaro.org>
Message-ID: <CAH9JG2WtRm9PPavsxf0-fkRqACyrkK4FLx6o+kn=2CPpYcKbPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 6:42 PM, Dave Martin <dave.martin@linaro.org> wrote:
> On Fri, Jul 20, 2012 at 05:24:19PM +0900, Kyungmin Park wrote:
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Some boards can use the firmware at trustzone but others can't use this.
>
> Note that this isn't just about TrustZone.  For example, firmware could
> be implemented in a hypervisor.
Okay, I will update the description.
>
>> However we need to build it simultaneously. To address this issue,
>> introduce arm firmware support and use it at each board files.
>>
>> e.g., In boot_secondary at mach-exynos/platsmp.c
>>
>>         __raw_writel(virt_to_phys(exynos4_secondary_startup),
>>                 CPU1_BOOT_REG);
>>
>>         if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) {
>>                 /* Call Exynos specific smc call */
>>                 firmware_ops.cpu_boot(cpu);
>>         }
>>
>>         gic_raise_softirq(cpumask_of(cpu), 1);
>>
>>         if (pen_release == -1)
>>
>> Now smp_ops is not yet merged, now just call the firmware_init at init_early
>>  at board file
>>
>> e.g., exynos4412 based board
>>
>> static void __init board_init_early(void)
>> {
>>         exynos_firmware_init();
>> }
>>
>> TODO
>>         1. DT support.
>>         2. call firmware init by smp_ops.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
>> index 283fa1d..5b097ca 100644
>> --- a/arch/arm/common/Kconfig
>> +++ b/arch/arm/common/Kconfig
>> @@ -21,6 +21,9 @@ config ARM_VIC_NR
>>         The maximum number of VICs available in the system, for
>>         power management.
>>
>> +config ARM_FIRMWARE
>> +     bool
>> +
>>  config ICST
>>       bool
>>
>> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
>> index e8a4e58..4af6568 100644
>> --- a/arch/arm/common/Makefile
>> +++ b/arch/arm/common/Makefile
>> @@ -4,6 +4,7 @@
>>
>>  obj-$(CONFIG_ARM_GIC)                += gic.o
>>  obj-$(CONFIG_ARM_VIC)                += vic.o
>> +obj-$(CONFIG_ARM_FIRMWARE)   += firmware.o
>>  obj-$(CONFIG_ICST)           += icst.o
>>  obj-$(CONFIG_SA1111)         += sa1111.o
>>  obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
>> diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
>> new file mode 100644
>> index 0000000..ffb6822
>> --- /dev/null
>> +++ b/arch/arm/common/firmware.c
>> @@ -0,0 +1,23 @@
>> +/*
>> + *  Copyright (C) 2012 Samsung Electronics.
>> + *  Kyungmin Park <kyungmin.park@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/suspend.h>
>> +
>> +#include <asm/firmware.h>
>> +
>> +static void cpu_boot(int cpu)
>> +{
>> +     /* Do nothing */
>> +}
>> +
>> +struct firmware_ops firmware_ops = {
>> +     .do_idle                = cpu_do_idle,
>> +     .cpu_boot               = cpu_boot,
>> +};
>> diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
>> new file mode 100644
>> index 0000000..c8c28bf
>> --- /dev/null
>> +++ b/arch/arm/include/asm/firmware.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + *  Copyright (C) 2012 Samsung Electronics.
>> + *  Kyungmin Park <kyungmin.park@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __ASM_ARM_FIRMWARE_H
>> +#define __ASM_ARM_FIRMWARE_H
>> +
>> +struct firmware_ops {
>> +     int     (*do_idle)(void);
>> +     void    (*cpu_boot)(int cpu);
>> +};
>> +
>> +extern struct firmware_ops firmware_ops;
>> +
>> +#endif
>
> Do you plan to have a registration interface for this?
>
> I imagine that struct firmware_ops will get extended over time, so
> it might contain many different function pointers.  Each board will
> probably only provide a subset of these, by sparsely populating its
> own struct firmware_ops (similarly to other existing registration
> interfaces).
Not yet, since I only used the real use case at exynos SoC. If you use
other SoC or use case, please add or extend it more.
>
> It may make sense to have a way to define default fallback actions for
> ops not defined by a particular board.  If CONFIG_ARM_FIRMWARE=n, we
> could use the fallbacks for everything.
Yes, I also tested it but interesting things. If it uses the
IS_ENABLED(CONFIG_ARM_FIRMWARE) with firmware_ops, I can't see error
nor warning. Anyway I'll add fackback operation.

Thank you,
Kyungmin Park
