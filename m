From: alchark@gmail.com (Alexey Charkov)
Date: Wed, 18 Jul 2012 14:52:26 +0200
Subject: [PATCHv2 1/1] ARM:vt8500: Convert to use .restart and remove
 arch_reset()
In-Reply-To: <1342615030.5079.YahooMailNeo@web140804.mail.bf1.yahoo.com>
References: <1342615030.5079.YahooMailNeo@web140804.mail.bf1.yahoo.com>
Message-ID: <CABjd4Yxnot=qWNXVKkS4KOj8bg3p3EjWRwLfPn6Q1PBdTs5kqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/18 Tony Prisk <sentientnz@yahoo.co.nz>:
> Changed the existing board files to use .restart in there machine

Looks like a typo here :)

> descriptions.
> Removed system.h as it only contained an inline for arch_reset()
>
> Added device tree support for the restart controller.
> Device tree support for vt8500 is still a work-in-progress.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/mach-vt8500/Makefile               |    2 +-
>  arch/arm/mach-vt8500/bv07.c                 |    3 +
>  arch/arm/mach-vt8500/include/mach/restart.h |   17 +++++++
>  arch/arm/mach-vt8500/include/mach/system.h  |   13 -----
>  arch/arm/mach-vt8500/restart.c              |   64 +++++++++++++++++++++++++++
>  arch/arm/mach-vt8500/wm8505_7in.c           |    4 +-
>  6 files changed, 88 insertions(+), 15 deletions(-)
>  create mode 100644 arch/arm/mach-vt8500/include/mach/restart.h
>  delete mode 100644 arch/arm/mach-vt8500/include/mach/system.h
>  create mode 100644 arch/arm/mach-vt8500/restart.c
>
> diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
> index 81aedb7..54e6997 100644
> --- a/arch/arm/mach-vt8500/Makefile
> +++ b/arch/arm/mach-vt8500/Makefile
> @@ -1,4 +1,4 @@
> -obj-y += devices.o gpio.o irq.o timer.o
> +obj-y += devices.o gpio.o irq.o timer.o restart.o
>
>  obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o
>  obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o
> diff --git a/arch/arm/mach-vt8500/bv07.c b/arch/arm/mach-vt8500/bv07.c
> index a464c75..f9fbeb2 100644
> --- a/arch/arm/mach-vt8500/bv07.c
> +++ b/arch/arm/mach-vt8500/bv07.c
> @@ -23,6 +23,7 @@
>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> +#include <mach/restart.h>
>
>  #include "devices.h"
>
> @@ -62,6 +63,7 @@ void __init bv07_init(void)
>      else
>          printk(KERN_ERR "PMC Hibernation register could not be remapped, not enabling power off!\n");
>
> +    wmt_setup_restart();
>      vt8500_set_resources();
>      platform_add_devices(devices, ARRAY_SIZE(devices));
>      vt8500_gpio_init();
> @@ -69,6 +71,7 @@ void __init bv07_init(void)
>
>  MACHINE_START(BV07, "Benign BV07 Mini Netbook")
>      .atag_offset    = 0x100,
> +    .restart    = wmt_restart,
>      .reserve    = vt8500_reserve_mem,
>      .map_io        = vt8500_map_io,
>      .init_irq    = vt8500_init_irq,
> diff --git a/arch/arm/mach-vt8500/include/mach/restart.h b/arch/arm/mach-vt8500/include/mach/restart.h
> new file mode 100644
> index 0000000..89f9b78
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/restart.h
> @@ -0,0 +1,17 @@
> +/* linux/arch/arm/mach-vt8500/restart.h
> + *
> + * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +void wmt_setup_restart(void);
> +void wmt_restart(char mode, const char *cmd);
> diff --git a/arch/arm/mach-vt8500/include/mach/system.h b/arch/arm/mach-vt8500/include/mach/system.h
> deleted file mode 100644
> index 58fa801..0000000
> --- a/arch/arm/mach-vt8500/include/mach/system.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/*
> - * arch/arm/mach-vt8500/include/mach/system.h
> - *
> - */
> -#include <asm/io.h>
> -
> -/* PM Software Reset request register */
> -#define VT8500_PMSR_VIRT    0xf8130060
> -
> -static inline void arch_reset(char mode, const char *cmd)
> -{
> -    writel(1, VT8500_PMSR_VIRT);
> -}
> diff --git a/arch/arm/mach-vt8500/restart.c b/arch/arm/mach-vt8500/restart.c
> new file mode 100644
> index 0000000..9134aea
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/restart.c
> @@ -0,0 +1,64 @@
> +/* linux/arch/arm/mach-vt8500/restart.c
> + *
> + * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <asm/io.h>
> +#include <linux/ioport.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +/* PM Software Reset request register */
> +#define LEGACY_PMSR_REG        0xD8130060
> +#define WMT_PRIZM_PMSR_REG    0x60
> +
> +static void __iomem *wmt_restart_reg;
> +
> +void wmt_setup_restart(void)
> +{
> +    struct device_node *np;
> +    void __iomem *pmc_base;
> +
> +    /*
> +     * Check if Power Mgmt Controller node is present in device tree. If no
> +     * device tree node, use the legacy PMSR value (valid for all current
> +     * SoCs).
> +     */
> +    np = of_find_compatible_node(NULL, NULL, "wmt,prizm-pmc");
> +    if (np) {
> +        pmc_base = of_iomap(np, 0);
> +
> +        if (!pmc_base)
> +            pr_err("%s:of_iomap(pmc) failed\n", __func__);
> +
> +        of_node_put(np);
> +
> +        wmt_restart_reg = (void *)((u32)(pmc_base) + WMT_PRIZM_PMSR_REG);

GCC allows pointer arithmetics on void * directly, and that's relied
upon heavily throughout the kernel code, so you don't need to cast it
here.

> +    } else {
> +        if (!request_mem_region(LEGACY_PMSR_REG, 4, NULL)) {

Is this required? I believe we could drop it just as well.

Thanks,
Alexey
