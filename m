From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 16 May 2015 14:59:41 +0800
Subject: [PATCH v4 1/7] ARM: zx: add basic support for ZTE ZX296702
In-Reply-To: <2493762.Sr0FmX9rRB@wuerfel>
References: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
 <1430212691-16009-2-git-send-email-jun.nie@linaro.org>
 <2493762.Sr0FmX9rRB@wuerfel>
Message-ID: <CABymUCONPiQqcu3d7-zJYWKLq9tc5kW1s-Nn+OEadhnwLLoo0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B.R.
Jun


2015-05-16 3:57 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 28 April 2015 17:18:05 Jun Nie wrote:
>> Add basic code for ZTE ZX296702 platform.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>
> Hi Jun,
>
> I've applied patches 1, 2, 3 and 6 to the next/soc branch now, but
> ended up modifying the first patch slightly, see the new version
> version below. Let's find a way to get the cache controller settings
> right without the override please.
>
>         Arnd
>
Thanks for help modifying. I test below patch and the cache change works well.

Jun

> commit acede515b3a5997becc5736657e11f4f410a8235
> Author: Jun Nie <jun.nie@linaro.org>
> Date:   Tue Apr 28 17:18:05 2015 +0800
>
>     ARM: zx: add basic support for ZTE ZX296702
>
>     Add basic code for ZTE ZX296702 platform.
>
>     [arnd: removed unused zx296702_init_machine function, and changed
>            l2c aux val to default]
>
>     Signed-off-by: Jun Nie <jun.nie@linaro.org>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 16b47afb60f1..80a2a14df604 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -989,6 +989,8 @@ source "arch/arm/mach-vt8500/Kconfig"
>
>  source "arch/arm/mach-w90x900/Kconfig"
>
> +source "arch/arm/mach-zx/Kconfig"
> +
>  source "arch/arm/mach-zynq/Kconfig"
>
>  # Definitions to make life easier
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 16bfd585585c..2a4fae7e9c44 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -207,6 +207,7 @@ machine-$(CONFIG_ARCH_VERSATILE)    += versatile
>  machine-$(CONFIG_ARCH_VEXPRESS)                += vexpress
>  machine-$(CONFIG_ARCH_VT8500)          += vt8500
>  machine-$(CONFIG_ARCH_W90X900)         += w90x900
> +machine-$(CONFIG_ARCH_ZX)              += zx
>  machine-$(CONFIG_ARCH_ZYNQ)            += zynq
>  machine-$(CONFIG_PLAT_SPEAR)           += spear
>
> diff --git a/arch/arm/mach-zx/Kconfig b/arch/arm/mach-zx/Kconfig
> new file mode 100644
> index 000000000000..2a910dc0d15e
> --- /dev/null
> +++ b/arch/arm/mach-zx/Kconfig
> @@ -0,0 +1,18 @@
> +menuconfig ARCH_ZX
> +       bool "ZTE ZX family" if ARCH_MULTI_V7
> +       help
> +         Support for ZTE ZX-based family of processors. TV
> +         set-top-box processor is supported. More will be
> +         added soon.
> +
> +if ARCH_ZX
> +
> +config SOC_ZX296702
> +       def_bool y
> +       select ARM_GIC
> +       select ARM_GLOBAL_TIMER
> +       select HAVE_ARM_SCU if SMP
> +       select HAVE_ARM_TWD if SMP
> +       help
> +         Support for ZTE ZX296702 SoC which is a dual core CortexA9MP
> +endif
> diff --git a/arch/arm/mach-zx/Makefile b/arch/arm/mach-zx/Makefile
> new file mode 100644
> index 000000000000..7a541c78f695
> --- /dev/null
> +++ b/arch/arm/mach-zx/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_SOC_ZX296702) += zx296702.o
> diff --git a/arch/arm/mach-zx/zx296702.c b/arch/arm/mach-zx/zx296702.c
> new file mode 100644
> index 000000000000..60bb1a8e1bf1
> --- /dev/null
> +++ b/arch/arm/mach-zx/zx296702.c
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright 2014 Linaro Ltd.
> + * Copyright (C) 2014 ZTE Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +static const char *zx296702_dt_compat[] __initconst = {
> +       "zte,zx296702",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(ZX, "ZTE ZX296702 (Device Tree)")
> +       .dt_compat      = zx296702_dt_compat,
> +       .l2c_aux_val    = 0,
> +       .l2c_aux_mask   = ~0,
> +MACHINE_END
>
