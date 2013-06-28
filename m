From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 28 Jun 2013 14:07:24 -0700
Subject: [PATCH 1/2] ARM: bcm281xx: Board specific reboot code
In-Reply-To: <1372453018-5830-2-git-send-email-markus.mayer@linaro.org>
References: <1372453018-5830-1-git-send-email-markus.mayer@linaro.org>
 <1372453018-5830-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <CAPdLdqmnbt0ApMeupabh8qDD1Juf_8aOymayNhvG-OzGW+5Cyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Christian who got dropped from the Cc list.

-Markus

On 28 June 2013 13:56, Markus Mayer <markus.mayer@linaro.org> wrote:
> This patch adds the code needed to trigger a reboot on the bcm281xx
> family.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Acked-by: Christian Daudt <csd@broadcom.com>
> ---
>  arch/arm/mach-bcm/Makefile    |    4 +--
>  arch/arm/mach-bcm/board_bcm.c |   20 ++++++++++++---
>  arch/arm/mach-bcm/kona.c      |   54 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-bcm/kona.h      |   15 ++++++++++++
>  4 files changed, 88 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-bcm/kona.c
>  create mode 100644 arch/arm/mach-bcm/kona.h
>
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 6adb6aec..7e5ca0a 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -1,5 +1,5 @@
>  #
> -# Copyright (C) 2012 Broadcom Corporation
> +# Copyright (C) 2012-2013 Broadcom Corporation
>  #
>  # This program is free software; you can redistribute it and/or
>  # modify it under the terms of the GNU General Public License as
> @@ -10,6 +10,6 @@
>  # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  # GNU General Public License for more details.
>
> -obj-$(CONFIG_ARCH_BCM)         := board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
> +obj-$(CONFIG_ARCH_BCM) := board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_bcm_kona_smc_asm.o      :=-Wa,-march=armv7-a$(plus_sec)
> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
> index 22e8421..2dc9f95 100644
> --- a/arch/arm/mach-bcm/board_bcm.c
> +++ b/arch/arm/mach-bcm/board_bcm.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 Broadcom Corporation
> + * Copyright (C) 2012-2013 Broadcom Corporation
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> @@ -22,8 +22,8 @@
>  #include <asm/mach/time.h>
>  #include <asm/hardware/cache-l2x0.h>
>
> -
>  #include "bcm_kona_smc.h"
> +#include "kona.h"
>
>  static int __init kona_l2_cache_init(void)
>  {
> @@ -41,13 +41,26 @@ static int __init kona_l2_cache_init(void)
>         return 0;
>  }
>
> +static void bcm_board_setup_restart(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "bcm,bcm11351");
> +       if (np) {
> +               if (of_device_is_available(np))
> +                       bcm_kona_setup_restart();
> +               of_node_put(np);
> +       }
> +       /* Restart setup for other boards goes here */
> +}
> +
>  static void __init board_init(void)
>  {
>         of_platform_populate(NULL, of_default_bus_match_table, NULL,
>                 &platform_bus);
>
>         bcm_kona_smc_init();
> -
> +       bcm_board_setup_restart();
>         kona_l2_cache_init();
>  }
>
> @@ -57,5 +70,6 @@ DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
>         .init_irq = irqchip_init,
>         .init_time = clocksource_of_init,
>         .init_machine = board_init,
> +       .restart = bcm_kona_restart,
>         .dt_compat = bcm11351_dt_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-bcm/kona.c b/arch/arm/mach-bcm/kona.c
> new file mode 100644
> index 0000000..4492b9f
> --- /dev/null
> +++ b/arch/arm/mach-bcm/kona.c
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (C) 2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/of_address.h>
> +#include <asm/io.h>
> +
> +#include "kona.h"
> +
> +static void __iomem *watchdog_base;
> +
> +void bcm_kona_setup_restart(void)
> +{
> +       struct device_node *np_wdog;
> +
> +       np_wdog = of_find_compatible_node(NULL, NULL, "bcm,kona-wdt");
> +       watchdog_base = of_iomap(np_wdog, 0);
> +       WARN(!watchdog_base, "failed to map watchdog base");
> +       of_node_put(np_wdog);
> +}
> +
> +#define GICDIST_ENABLE_OFFSET          0x00000000
> +#define SECWDOG_OFFSET                 0x00000000
> +#define SECWDOG_RESERVED_MASK          0xE2000000
> +#define SECWDOG_WD_LOAD_FLAG_MASK      0x10000000
> +#define SECWDOG_EN_MASK                        0x08000000
> +#define SECWDOG_SRSTEN_MASK            0x04000000
> +#define SECWDOG_CLKS_SHIFT             20
> +#define SECWDOG_LOCK_SHIFT             0
> +
> +void bcm_kona_restart(char mode, const char *cmd)
> +{
> +       uint32_t val;
> +
> +       /* Enable watchdog 2 with very short timeout. */
> +       val = readl(watchdog_base + SECWDOG_OFFSET);
> +       val &= SECWDOG_RESERVED_MASK | SECWDOG_WD_LOAD_FLAG_MASK;
> +       val |= SECWDOG_EN_MASK | SECWDOG_SRSTEN_MASK |
> +               (0x8 << SECWDOG_CLKS_SHIFT) |
> +               (0x8 << SECWDOG_LOCK_SHIFT);
> +       writel(val, watchdog_base + SECWDOG_OFFSET);
> +
> +       while (1)
> +               ;
> +}
> diff --git a/arch/arm/mach-bcm/kona.h b/arch/arm/mach-bcm/kona.h
> new file mode 100644
> index 0000000..ecb417e
> --- /dev/null
> +++ b/arch/arm/mach-bcm/kona.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (C) 2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +void bcm_kona_setup_restart(void);
> +void bcm_kona_restart(char mode, const char *cmd);
> --
> 1.7.9.5
>
>
