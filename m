From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Sat, 7 Aug 2010 10:46:08 +0900
Subject: [PATCH v4] ARM: S5PV310: Add Samsung UNIVERSAL_C210 support
In-Reply-To: <1281096865-27885-1-git-send-email-kgene.kim@samsung.com>
References: <1281096865-27885-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikqvxyBQcYshY+P7ERDhQEb_uJqOjp6wS4MCkvz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 6, 2010 at 9:14 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> This patch adds Samsung Mobile S5PC210 Reference Board, UNIVERSAL_C210 board
> support.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> [kgene.kim at samsung.com: changed machine name]
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Kyungmin,
> Maybe as you know, should be changed all universal_ functions when adding
> other universal board for avoiding confusing later. And need this so that
> we can support single kernel image in future. Thanks.

Keep in mind. but as you see other universal patches. it's almost
static variables do don't make a problem when other universal board
comes.
Yes. some time later it needs to change the name, but current samsung
socs has each SoCs directory so it also don't make a problem.

Thank you,
Kyungmin Park
>
> NOTE:
> Changes since v3:
> - Changed only machine name not functions based on v1 patch
>
> Changes since v2:
> - Changed machine name from 'UNIVERSAL' to 'UNIVERSAL_C210'
>
> Changes since v1:
> - Changed default UFCON tx/rx trigger level
>
> ?arch/arm/mach-s5pv310/Kconfig ? ? ? ? ? ? ? | ? ?9 +++
> ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-s5pv310/mach-universal_c210.c | ? 86 +++++++++++++++++++++++++++
> ?3 files changed, 96 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-s5pv310/mach-universal_c210.c
>
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index f9b1892..331b5bd 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -33,4 +33,13 @@ config MACH_SMDKV310
> ? ? ? ?select ARCH_SPARSEMEM_ENABLE
> ? ? ? ?help
> ? ? ? ? ?Machine support for Samsung SMDKV310
> +
> +config MACH_UNIVERSAL_C210
> + ? ? ? bool "Mobile UNIVERSAL_C210 Board"
> + ? ? ? select CPU_S5PV310
> + ? ? ? select ARCH_SPARSEMEM_ENABLE
> + ? ? ? help
> + ? ? ? ? Machine support for Samsung Mobile Universal S5PC210 Reference
> + ? ? ? ? Board. S5PC210(MCP) is one of package option of S5PV310
> +
> ?endif
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index 967e2c8..d5b51c7 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_HOTPLUG_CPU) ? ? += hotplug.o
> ?# machine support
>
> ?obj-$(CONFIG_MACH_SMDKV310) ? ?+= mach-smdkv310.o
> +obj-$(CONFIG_MACH_UNIVERSAL_C210) ? ? ?+= mach-universal_c210.o
>
> ?# device support
>
> diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-s5pv310/mach-universal_c210.c
> new file mode 100644
> index 0000000..2388cb9
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
> @@ -0,0 +1,86 @@
> +/* linux/arch/arm/mach-s5pv310/mach-universal_c210.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/serial_core.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach-types.h>
> +#include <asm/hardware/cache-l2x0.h>
> +
> +#include <plat/regs-serial.h>
> +#include <plat/s5pv310.h>
> +#include <plat/cpu.h>
> +
> +#include <mach/map.h>
> +
> +/* Following are default values for UCON, ULCON and UFCON UART registers */
> +#define UNIVERSAL_UCON_DEFAULT (S3C2410_UCON_TXILEVEL | ? ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_RXILEVEL | ? ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_TXIRQMODE | ? ? ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_RXIRQMODE | ? ? ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2410_UCON_RXFIFO_TOI | ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S3C2443_UCON_RXERR_IRQEN)
> +
> +#define UNIVERSAL_ULCON_DEFAULT ? ? ? ?S3C2410_LCON_CS8
> +
> +#define UNIVERSAL_UFCON_DEFAULT ? ? ? ?(S3C2410_UFCON_FIFOMODE | ? ? ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_TXTRIG256 | ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_RXTRIG256)
> +
> +static struct s3c2410_uartcfg universal_uartcfgs[] __initdata = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 0,
> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = UNIVERSAL_UCON_DEFAULT,
> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= UNIVERSAL_ULCON_DEFAULT,
> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= UNIVERSAL_UFCON_DEFAULT,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 1,
> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = UNIVERSAL_UCON_DEFAULT,
> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= UNIVERSAL_ULCON_DEFAULT,
> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= UNIVERSAL_UFCON_DEFAULT,
> + ? ? ? },
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 2,
> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = UNIVERSAL_UCON_DEFAULT,
> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= UNIVERSAL_ULCON_DEFAULT,
> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= UNIVERSAL_UFCON_DEFAULT,
> + ? ? ? },
> + ? ? ? [3] = {
> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 3,
> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = UNIVERSAL_UCON_DEFAULT,
> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= UNIVERSAL_ULCON_DEFAULT,
> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= UNIVERSAL_UFCON_DEFAULT,
> + ? ? ? },
> +};
> +
> +static void __init universal_map_io(void)
> +{
> + ? ? ? s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> + ? ? ? s3c24xx_init_clocks(24000000);
> + ? ? ? s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
> +}
> +
> +static void __init universal_machine_init(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> + ? ? ? l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
> +#endif
> +}
> +
> +MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
> + ? ? ? /* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
> + ? ? ? .phys_io ? ? ? ?= S3C_PA_UART & 0xfff00000,
> + ? ? ? .io_pg_offst ? ?= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
> + ? ? ? .boot_params ? ?= S5P_PA_SDRAM + 0x100,
> + ? ? ? .init_irq ? ? ? = s5pv310_init_irq,
> + ? ? ? .map_io ? ? ? ? = universal_map_io,
> + ? ? ? .init_machine ? = universal_machine_init,
> + ? ? ? .timer ? ? ? ? ?= &s5pv310_timer,
> +MACHINE_END
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
