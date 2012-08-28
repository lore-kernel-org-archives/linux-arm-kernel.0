From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 28 Aug 2012 17:39:39 +0900
Subject: [PATCH v5 2/2] ARM: EXYNOS: SMC instruction (aka firmware) support
In-Reply-To: <20120827221030.GC7431@lumpy>
References: <20120824083357.GA25384@july>
	<20120827221030.GC7431@lumpy>
Message-ID: <CAH9JG2V5Xt1H5siBKT=LBr76YdSBRqyM92pTNFVo9K4WRWxcyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/12, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> See below.
>
> On Fri, Aug 24, 2012 at 05:33:57PM +0900, Kyungmin Park wrote:
>
>> diff --git a/arch/arm/mach-exynos/Makefile
>> b/arch/arm/mach-exynos/Makefile
>> index 9b58024..8ee779c 100644
>> --- a/arch/arm/mach-exynos/Makefile
>> +++ b/arch/arm/mach-exynos/Makefile
>> @@ -30,6 +30,11 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
>>
>>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
>>
>> +obj-$(CONFIG_ARM_FIRMWARE)	+= exynos-smc.o firmware.o
>> +
>> +plus_sec := $(call as-instr,.arch_extension sec,+sec)
>> +AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
>
> Again, no need for a config option here.
checked, I just did as others, omap3, highbank.
BTW, does it be required for older toolchain?
>
>> diff --git a/arch/arm/mach-exynos/firmware.c
>> b/arch/arm/mach-exynos/firmware.c
>> new file mode 100644
>> index 0000000..a144593
>> --- /dev/null
>> +++ b/arch/arm/mach-exynos/firmware.c
>> @@ -0,0 +1,37 @@
>> +/*
>> + *  Copyright (C) 2012 Samsung Electronics.
>> + *  Kyungmin Park <kyungmin.park@samsung.com>
>> + *
>> + * This program is free software,you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +
>> +#include <asm/firmware.h>
>> +
>> +#include "smc.h"
>> +
>> +static int exynos_do_idle(void)
>> +{
>> +        exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
>> +        return 0;
>> +}
>> +
>> +static void exynos_cpu_boot(int cpu)
>> +{
>> +	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
>> +}
>> +
>> +static struct firmware_ops exynos_firmware_ops __initdata = {
>> +	.do_idle	= exynos_do_idle,
>> +	.cpu_boot	= exynos_cpu_boot,
>> +};
>> +
>> +int __init exynos_firmware_init(void)
>> +{
>> +	firmware_ops = exynos_firmware_ops;
>> +	return 0;
>> +}
>
> If you add a check for SMC presence/execution mode here, then you can
> make this a runtime instead of boot time option, thus making it possible
> to build a kernel that boots and runs both with and without SMC support.
In the previous time, it's hard to detect at runtime, so I add this function.
I think it's board specfic instead of SOC one.
Can you check it again, does it possbiel to know smc firmware is
support at this board?

Thank you,
Kyungmin Park
