From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Sat, 22 Sep 2012 15:01:56 +0900
Subject: [PATCH 2/5] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <20120922055015.GD32245@quad.lixom.net>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-3-git-send-email-t.figa@samsung.com>
 <20120922055015.GD32245@quad.lixom.net>
Message-ID: <CAH9JG2XFVzyZH8rsBogVYRdD4dzWpKjX8JAQw0Sf7qJqgueqAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/22/12, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Sep 13, 2012 at 10:13:35AM +0200, Tomasz Figa wrote:
>> Some boards are running with secure firmware running in TrustZone secure
>> world, which changes the way some things have to be initialized.
>>
>> This patch adds an interface for platforms to specify available firmware
>> operations and call them.
>>
>> A wrapper macro, call_firmware_op(), checks if the operation is provided
>> and calls it if so, otherwise returns 0.
>>
>> By default no operations are provided.
>>
>> This is a follow-up on the patch by Kyungmin Park:
>> [PATCH v5 1/2] ARM: Make a compile firmware conditionally
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/183607/focus=183988
>>
>> Example of use:
>>
>> In code using firmware ops:
>>
>> 	__raw_writel(virt_to_phys(exynos4_secondary_startup),
>> 		CPU1_BOOT_REG);
>>
>> 	/* Call Exynos specific smc call */
>> 	do_firmware_op(cpu_boot, cpu);
>>
>> 	gic_raise_softirq(cpumask_of(cpu), 1);
>>
>> In board-/platform-specific code:
>>
>> 	static int platformX_do_idle(void)
>> 	{
>> 		/* tell platformX firmware to enter idle */
>> 	        return 0;
>> 	}
>>
>> 	static void platformX_cpu_boot(int i)
>> 	{
>> 		/* tell platformX firmware to boot CPU i */
>> 	}
>>
>> 	static const struct firmware_ops platformX_firmware_ops __initdata = {
>> 		.do_idle	= exynos_do_idle,
>> 		.cpu_boot	= exynos_cpu_boot,
>> 		/* cpu_boot_reg not available on platformX */
>> 	};
>>
>> 	static void __init board_init_early(void)
>> 	{
>> 	        register_firmware_ops(&platformX_firmware_ops);
>> 	}
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  arch/arm/common/Makefile        |  2 ++
>>  arch/arm/common/firmware.c      | 18 ++++++++++++++++++
>>  arch/arm/include/asm/firmware.h | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 50 insertions(+)
>>  create mode 100644 arch/arm/common/firmware.c
>>  create mode 100644 arch/arm/include/asm/firmware.h
>>
>> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
>> index e8a4e58..55d4182 100644
>> --- a/arch/arm/common/Makefile
>> +++ b/arch/arm/common/Makefile
>> @@ -2,6 +2,8 @@
>>  # Makefile for the linux kernel.
>>  #
>>
>> +obj-y += firmware.o
>> +
>>  obj-$(CONFIG_ARM_GIC)		+= gic.o
>>  obj-$(CONFIG_ARM_VIC)		+= vic.o
>>  obj-$(CONFIG_ICST)		+= icst.o
>> diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
>> new file mode 100644
>> index 0000000..27ddccb
>> --- /dev/null
>> +++ b/arch/arm/common/firmware.c
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Copyright (C) 2012 Samsung Electronics.
>> + * Kyungmin Park <kyungmin.park@samsung.com>
>> + * Tomasz Figa <t.figa@samsung.com>
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
>> +static const struct firmware_ops default_firmware_ops;
>> +
>> +const struct firmware_ops *firmware_ops = &default_firmware_ops;
>> diff --git a/arch/arm/include/asm/firmware.h
>> b/arch/arm/include/asm/firmware.h
>> new file mode 100644
>> index 0000000..ed51b02
>> --- /dev/null
>> +++ b/arch/arm/include/asm/firmware.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Copyright (C) 2012 Samsung Electronics.
>> + * Kyungmin Park <kyungmin.park@samsung.com>
>> + * Tomasz Figa <t.figa@samsung.com>
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
>> +	int (*do_idle)(void);
>> +	void (*cpu_boot)(int cpu);
>> +	void __iomem *(*cpu_boot_reg)(int cpu);
>> +};
>> +
>> +extern const struct firmware_ops *firmware_ops;
>> +
>> +#define call_firmware_op(op, ...)					\
>> +	((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : 0)
>
> I think this will cause sparse warnings for call_firmware_op(cpu_boot_reg)
> if there are no ops defined, since the '0' isn't annotated as __iomem. And
> you can't annotate it since the other function pointers don't need it.
>
> I think you might be better off with stub functions as fallbacks instead of
> allowing and checking for NULL here.
do you mean like this?

#Ifdef CONFIG_ARM_FIRMWARE
#define call_firmware_op(op, ...) ((firmware_ops->op) ?
firmware_ops->op(__VA_ARGS__) : 0)
#else
#define call_firmware_op(op, ...) do { } while (0)
#endif

No problem to modify it.

Thank you,
Kyungmin Park
>
>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
