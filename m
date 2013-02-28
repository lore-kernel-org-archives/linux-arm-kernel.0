From: monstr@monstr.eu (Michal Simek)
Date: Thu, 28 Feb 2013 13:46:08 -0800
Subject: [PATCH 3/7] ARM: hs: add board support with device tree
In-Reply-To: <1362035966-17628-3-git-send-email-haojian.zhuang@linaro.org>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
 <1362035966-17628-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAHTX3dLO6Waf7bT0Lo6AqmDQSKbt14pwjZzYzP5De8RR3btY9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/27 Haojian Zhuang <haojian.zhuang@linaro.org>:
> Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig          |    2 ++
>  arch/arm/Makefile         |    1 +
>  arch/arm/mach-hs/Kconfig  |   23 +++++++++++++
>  arch/arm/mach-hs/Makefile |    5 +++
>  arch/arm/mach-hs/hs-dt.c  |   83 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 114 insertions(+)
>  create mode 100644 arch/arm/mach-hs/Kconfig
>  create mode 100644 arch/arm/mach-hs/Makefile
>  create mode 100644 arch/arm/mach-hs/hs-dt.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dedf02b..dfe70aa 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1055,6 +1055,8 @@ source "arch/arm/mach-h720x/Kconfig"
>
>  source "arch/arm/mach-highbank/Kconfig"
>
> +source "arch/arm/mach-hs/Kconfig"
> +
>  source "arch/arm/mach-integrator/Kconfig"
>
>  source "arch/arm/mach-iop32x/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index ee4605f..08a913b 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -149,6 +149,7 @@ machine-$(CONFIG_ARCH_EP93XX)               += ep93xx
>  machine-$(CONFIG_ARCH_GEMINI)          += gemini
>  machine-$(CONFIG_ARCH_H720X)           += h720x
>  machine-$(CONFIG_ARCH_HIGHBANK)                += highbank
> +machine-$(CONFIG_ARCH_HS)              += hs
>  machine-$(CONFIG_ARCH_INTEGRATOR)      += integrator
>  machine-$(CONFIG_ARCH_IOP13XX)         += iop13xx
>  machine-$(CONFIG_ARCH_IOP32X)          += iop32x
> diff --git a/arch/arm/mach-hs/Kconfig b/arch/arm/mach-hs/Kconfig
> new file mode 100644
> index 0000000..491c6da
> --- /dev/null
> +++ b/arch/arm/mach-hs/Kconfig
> @@ -0,0 +1,23 @@
> +config ARCH_HS
> +       bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
> +       select ARM_AMBA
> +       select ARM_GIC
> +       select CACHE_L2X0
> +       select CACHE_PL310
> +       select PINCTRL
> +       select PINCTRL_SINGLE
> +       select SERIAL_AMBA_PL011
> +       select SERIAL_AMBA_PL011_CONSOLE
> +       help
> +         Support for Hisilicon Hi36xx/Hi37xx processor family
> +
> +if ARCH_HS
> +
> +config MACH_HS_DT
> +       bool "Hisilicon Development Board"
> +       default y
> +       help
> +         Say 'Y' here if you want to support the Hisilicon Development
> +         Board.
> +
> +endif
> diff --git a/arch/arm/mach-hs/Makefile b/arch/arm/mach-hs/Makefile
> new file mode 100644
> index 0000000..d79ecb5
> --- /dev/null
> +++ b/arch/arm/mach-hs/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for Hisilicon Hi36xx/Hi37xx processors line
> +#
> +
> +obj-$(CONFIG_MACH_HS_DT)       += hs-dt.o
> diff --git a/arch/arm/mach-hs/hs-dt.c b/arch/arm/mach-hs/hs-dt.c
> new file mode 100644
> index 0000000..813ebb0
> --- /dev/null
> +++ b/arch/arm/mach-hs/hs-dt.c
> @@ -0,0 +1,83 @@
> +/*
> + * (Hisilicon's Hi36xx/Hi37xx SoC based) flattened device tree enabled machine
> + *
> + * Copyright (c) 2012-2013 Hisilicon Ltd.
> + * Copyright (c) 2012-2013 Linaro Ltd.
> + *
> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/hardware/arm_timer.h>
> +#include <asm/hardware/timer-sp.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/time.h>
> +
> +static struct of_device_id hs_timer_match[] __initdata = {
> +       { .compatible = "arm,sp804", },
> +       {}
> +};
> +
> +static struct clk_lookup sp804_lookup = {
> +       .dev_id = "sp804",
> +       .clk    = NULL,
> +};
> +
> +extern void __init hs_init_clocks(void);

this shouldn't be in this file. Run checkpatch.pl on it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
