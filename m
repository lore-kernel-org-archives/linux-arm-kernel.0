From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Sep 2012 08:38:12 -0700
Subject: [PATCH V6] ARM: bcm2835: add stub clock driver
In-Reply-To: <1348026973-18887-1-git-send-email-swarren@wwwdotorg.org>
References: <1348026973-18887-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120919153812.17033.90952@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2012-09-18 20:56:13)
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> This patch adds a minimal stub clock driver for the BCM2835. Its sole
> purpose is to allow the PL011 AMBA clk_get() API calls to provide
> something that looks enough like a clock that the driver probes and
> operates correctly.
> 
> This patch was extracted from git://github.com/lp0/linux.git branch
> rpi-split as of 2012/09/08, and modified as follows:
> 
> * Reworked to call clk_register_fixed_rate(), and clk_register_clkdev()
>   rather than using static data to represent the clocks.
> * Moved implementation to drivers/clk/.
> * Modified .dev_id for UART clocks to match UART DT node names.
> * s/bcm2708/bcm2835/.
> * Modified device tree vendor prefix.
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <dc4@broadcom.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike

> --
> v6:
> * Reworked to call clk_register_fixed_rate(), and clk_register_clkdev()
>   rather than using static data to represent the clocks.
> v5:
> * No change.
> v4:
> * Moved implementation to drivers/clk/.
> * s/bcm2708/bcm2835/.
> * Updated for new device tree vendor prefix.
> v3:
> * New patch.
> 
> clk fixup
> ---
>  arch/arm/mach-bcm2835/bcm2835.c |    3 ++
>  drivers/clk/Makefile            |    1 +
>  drivers/clk/clk-bcm2835.c       |   58 +++++++++++++++++++++++++++++++++++++++
>  include/linux/clk/bcm2835.h     |   24 ++++++++++++++++
>  4 files changed, 86 insertions(+)
>  create mode 100644 drivers/clk/clk-bcm2835.c
>  create mode 100644 include/linux/clk/bcm2835.h
> 
> diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
> index e3f2968..f6fea49 100644
> --- a/arch/arm/mach-bcm2835/bcm2835.c
> +++ b/arch/arm/mach-bcm2835/bcm2835.c
> @@ -16,6 +16,7 @@
>  #include <linux/irqchip/bcm2835.h>
>  #include <linux/of_platform.h>
>  #include <linux/bcm2835_timer.h>
> +#include <linux/clk/bcm2835.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -38,6 +39,8 @@ void __init bcm2835_init(void)
>  {
>         int ret;
>  
> +       bcm2835_init_clocks();
> +
>         ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
>                                    NULL);
>         if (ret) {
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 5869ea3..d5c19d1 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_CLKDEV_LOOKUP)     += clkdev.o
>  obj-$(CONFIG_COMMON_CLK)       += clk.o clk-fixed-rate.o clk-gate.o \
>                                    clk-mux.o clk-divider.o clk-fixed-factor.o
>  # SoCs specific
> +obj-$(CONFIG_ARCH_BCM2835)     += clk-bcm2835.o
>  obj-$(CONFIG_ARCH_NOMADIK)     += clk-nomadik.o
>  obj-$(CONFIG_ARCH_HIGHBANK)    += clk-highbank.o
>  obj-$(CONFIG_ARCH_MXS)         += mxs/
> diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
> new file mode 100644
> index 0000000..ad65f0e
> --- /dev/null
> +++ b/drivers/clk/clk-bcm2835.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2010 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/bcm2835.h>
> +
> +/*
> + * These are fixed clocks. They're probably not all root clocks and it may
> + * be possible to turn them on and off but until this is mapped out better
> + * it's the only way they can be used.
> + */
> +void __init bcm2835_init_clocks(void)
> +{
> +       struct clk *clk;
> +       int ret;
> +
> +       clk = clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT,
> +                                       250000000);
> +       if (!clk)
> +               pr_err("sys_pclk not registered\n");
> +
> +       clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
> +                                       126000000);
> +       if (!clk)
> +               pr_err("apb_pclk not registered\n");
> +
> +       clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, CLK_IS_ROOT,
> +                                       3000000);
> +       if (!clk)
> +               pr_err("uart0_pclk not registered\n");
> +       ret = clk_register_clkdev(clk, NULL, "20201000.uart");
> +       if (ret)
> +               pr_err("uart0_pclk alias not registered\n");
> +
> +       clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, CLK_IS_ROOT,
> +                                       125000000);
> +       if (!clk)
> +               pr_err("uart1_pclk not registered\n");
> +       ret = clk_register_clkdev(clk, NULL, "20215000.uart");
> +       if (ret)
> +               pr_err("uart0_pclk alias not registered\n");
> +}
> diff --git a/include/linux/clk/bcm2835.h b/include/linux/clk/bcm2835.h
> new file mode 100644
> index 0000000..aa937f6
> --- /dev/null
> +++ b/include/linux/clk/bcm2835.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2010 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __LINUX_CLK_BCM2835_H_
> +#define __LINUX_CLK_BCM2835_H_
> +
> +void __init bcm2835_init_clocks(void);
> +
> +#endif
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
