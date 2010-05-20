From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 20 May 2010 10:10:33 +0900
Subject: [PATCH] ARM: S5PV210: Add GONI board support
In-Reply-To: <20100520004856.GK4720@trinity.fluff.org>
References: <4BF3F284.5090505@samsung.com>
	<20100520004856.GK4720@trinity.fluff.org>
Message-ID: <AANLkTikKmNSqLwvpvj3DQVEoKgE6gvt0eBLxiwRswx09@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 9:48 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, May 19, 2010 at 11:15:32PM +0900, Joonyoung Shim wrote:
>> This is for samsung GONI board using s5pc110.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> I'll think about adding this, however it is very late in the development
> cycle, and the only thing saving it from immediate stalling until the next
> round is the fact that it is so simple.

Hi,

In the previous time, Marek sent the s5pv210 patch including the
aquila board support.
But in this merge cycle, it doesn't included. of course all s5pv210 patches too,
Please find the patch subject "ARM: S5PV210: add Aquila board" and
check it again.

Thank you,
Kyungmin Park
>
>> ---
>> ?arch/arm/mach-s5pv210/Kconfig ? ? | ? ?8 +++
>> ?arch/arm/mach-s5pv210/Makefile ? ?| ? ?1 +
>> ?arch/arm/mach-s5pv210/mach-goni.c | ? 98 +++++++++++++++++++++++++++++++++++++
>> ?3 files changed, 107 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-s5pv210/mach-goni.c
>>
>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
>> index 7601c28..83b15b2 100644
>> --- a/arch/arm/mach-s5pv210/Kconfig
>> +++ b/arch/arm/mach-s5pv210/Kconfig
>> @@ -36,6 +36,14 @@ config MACH_SMDKC110
>> ? ? ? ? Machine support for Samsung SMDKC110
>> ? ? ? ? S5PC110(MCP) is one of package option of S5PV210
>>
>> +config MACH_GONI
>> + ? ? bool "GONI"
>> + ? ? select CPU_S5PV210
>> + ? ? select ARCH_SPARSEMEM_ENABLE
>> + ? ? help
>> + ? ? ? Machine support for Samsung GONI board
>> + ? ? ? S5PC110(MCP) is one of package option of S5PV210
>> +
>> ?endchoice
>>
>> ?endif
>> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
>> index 9982781..5135577 100644
>> --- a/arch/arm/mach-s5pv210/Makefile
>> +++ b/arch/arm/mach-s5pv210/Makefile
>> @@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_S5PV210) ? += setup-i2c0.o
>>
>> ?obj-$(CONFIG_MACH_SMDKV210) ?+= mach-smdkv210.o
>> ?obj-$(CONFIG_MACH_SMDKC110) ?+= mach-smdkc110.o
>> +obj-$(CONFIG_MACH_GONI) ? ? ? ? ? ? ?+= mach-goni.o
>>
>> ?# device support
>>
>> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
>> new file mode 100644
>> index 0000000..4863b13
>> --- /dev/null
>> +++ b/arch/arm/mach-s5pv210/mach-goni.c
>> @@ -0,0 +1,98 @@
>> +/* linux/arch/arm/mach-s5pv210/mach-goni.c
>> + *
>> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
>> + * ? ? ? ? ? http://www.samsung.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/init.h>
>> +#include <linux/serial_core.h>
>> +
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/map.h>
>> +#include <asm/setup.h>
>> +#include <asm/mach-types.h>
>> +
>> +#include <mach/map.h>
>> +#include <mach/regs-clock.h>
>> +
>> +#include <plat/regs-serial.h>
>> +#include <plat/s5pv210.h>
>> +#include <plat/devs.h>
>> +#include <plat/cpu.h>
>> +
>> +/* Following are default values for UCON, ULCON and UFCON UART registers */
>> +#define S5PV210_UCON_DEFAULT (S3C2410_UCON_TXILEVEL | ? ? ? ?\
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_RXILEVEL | ? ? ? ?\
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_TXIRQMODE | ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_RXIRQMODE | ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_RXFIFO_TOI | ? ? ?\
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2443_UCON_RXERR_IRQEN)
>> +
>> +#define S5PV210_ULCON_DEFAULT ? ? ? ?S3C2410_LCON_CS8
>> +
>> +#define S5PV210_UFCON_DEFAULT ? ? ? ?(S3C2410_UFCON_FIFOMODE | ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_TXTRIG4 | ? ? ? ?\
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_RXTRIG4)
>> +
>> +static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
>> + ? ? [0] = {
>> + ? ? ? ? ? ? .hwport ? ? ? ? = 0,
>> + ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>> + ? ? ? ? ? ? .ucon ? ? ? ? ? = S5PV210_UCON_DEFAULT,
>> + ? ? ? ? ? ? .ulcon ? ? ? ? ?= S5PV210_ULCON_DEFAULT,
>> + ? ? ? ? ? ? .ufcon ? ? ? ? ?= S5PV210_UFCON_DEFAULT,
>> + ? ? },
>> + ? ? [1] = {
>> + ? ? ? ? ? ? .hwport ? ? ? ? = 1,
>> + ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>> + ? ? ? ? ? ? .ucon ? ? ? ? ? = S5PV210_UCON_DEFAULT,
>> + ? ? ? ? ? ? .ulcon ? ? ? ? ?= S5PV210_ULCON_DEFAULT,
>> + ? ? ? ? ? ? .ufcon ? ? ? ? ?= S5PV210_UFCON_DEFAULT,
>> + ? ? },
>> + ? ? [2] = {
>> + ? ? ? ? ? ? .hwport ? ? ? ? = 2,
>> + ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>> + ? ? ? ? ? ? .ucon ? ? ? ? ? = S5PV210_UCON_DEFAULT,
>> + ? ? ? ? ? ? .ulcon ? ? ? ? ?= S5PV210_ULCON_DEFAULT,
>> + ? ? ? ? ? ? .ufcon ? ? ? ? ?= S5PV210_UFCON_DEFAULT,
>> + ? ? },
>> + ? ? [3] = {
>> + ? ? ? ? ? ? .hwport ? ? ? ? = 3,
>> + ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
>> + ? ? ? ? ? ? .ucon ? ? ? ? ? = S5PV210_UCON_DEFAULT,
>> + ? ? ? ? ? ? .ulcon ? ? ? ? ?= S5PV210_ULCON_DEFAULT,
>> + ? ? ? ? ? ? .ufcon ? ? ? ? ?= S5PV210_UFCON_DEFAULT,
>> + ? ? },
>> +};
>> +
>> +static struct platform_device *goni_devices[] __initdata = {
>> +};
>
> If you promise to actually populate this, then it can stay.
>
>> +static void __init goni_map_io(void)
>> +{
>> + ? ? s5p_init_io(NULL, 0, S5P_VA_CHIPID);
>> + ? ? s3c24xx_init_clocks(24000000);
>> + ? ? s3c24xx_init_uarts(goni_uartcfgs, ARRAY_SIZE(goni_uartcfgs));
>> +}
>> +
>> +static void __init goni_machine_init(void)
>> +{
>> + ? ? platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
>> +}
>> +
>> +MACHINE_START(GONI, "GONI")
>> + ? ? /* Maintainers: Kyungmin Park <kyungmin.park@samsung.com> */
>> + ? ? .phys_io ? ? ? ?= S3C_PA_UART & 0xfff00000,
>> + ? ? .io_pg_offst ? ?= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
>> + ? ? .boot_params ? ?= S5P_PA_SDRAM + 0x100,
>> + ? ? .init_irq ? ? ? = s5pv210_init_irq,
>> + ? ? .map_io ? ? ? ? = goni_map_io,
>> + ? ? .init_machine ? = goni_machine_init,
>> + ? ? .timer ? ? ? ? ?= &s3c24xx_timer,
>> +MACHINE_END
>
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
