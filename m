From: eddie.cai.kernel@gmail.com (Eddie Cai)
Date: Fri, 11 Sep 2015 10:01:43 +0800
Subject: [PATCH v2] ARM: rockchip: add reboot notifier
In-Reply-To: <1441883089-26567-1-git-send-email-andy.yan@rock-chips.com>
References: <1441883089-26567-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CANCyOWb4ih1Dt8MoAKZD-eYtH-xuhgo1b6o7-oh3eCsfZnncRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy

2015-09-10 19:04 GMT+08:00 Andy Yan <andy.yan@rock-chips.com>:
> rockchip platform have a protocol to pass the kernel reboot
> mode to bootloader by some special registers when system reboot.
> By this way the bootloader can take different action according
> to the different kernel reboot mode, for example, command
> "reboot loader" will reboot the board to rockusb mode, this is
> a very convenient way to get the board enter download mode.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>
> Changes in v2:
>   - check cpu dt node
>   - remove a unnecessary of_put_node in function rockchip_get_pmu_regmap
>   - fix a align issue
>   - use reboot_notifier instead of restart_handler
>
>  arch/arm/mach-rockchip/Makefile |   2 +-
>  arch/arm/mach-rockchip/loader.h |  22 ++++++++
>  arch/arm/mach-rockchip/reboot.c | 111 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-rockchip/loader.h
>  create mode 100644 arch/arm/mach-rockchip/reboot.c
>
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 5c3a9b2..cd291e3 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -1,5 +1,5 @@
>  CFLAGS_platsmp.o := -march=armv7-a
>
> -obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip.o
> +obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip.o reboot.o
>  obj-$(CONFIG_PM_SLEEP) += pm.o sleep.o
>  obj-$(CONFIG_SMP) += headsmp.o platsmp.o
> diff --git a/arch/arm/mach-rockchip/loader.h b/arch/arm/mach-rockchip/loader.h
> new file mode 100644
> index 0000000..bf51baa
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/loader.h
> @@ -0,0 +1,22 @@
> +#ifndef __MACH_ROCKCHIP_LOADER_H
> +#define __MACH_ROCKCHIP_LOADER_H
> +
> +/*high 24 bits is tag, low 8 bits is type*/
> +#define SYS_LOADER_REBOOT_FLAG   0x5242C300
> +
> +enum {
> +       BOOT_NORMAL = 0, /* normal boot */
> +       BOOT_LOADER,     /* enter loader rockusb mode */
> +       BOOT_MASKROM,    /* enter maskrom rockusb mode (not support now) */
> +       BOOT_RECOVER,    /* enter recover */
> +       BOOT_NORECOVER,  /* do not enter recover */
> +       BOOT_SECONDOS,   /* boot second OS (not support now)*/
> +       BOOT_WIPEDATA,   /* enter recover and wipe data. */
> +       BOOT_WIPEALL,    /* enter recover and wipe all data. */
> +       BOOT_CHECKIMG,   /* check firmware img with backup part*/
> +       BOOT_FASTBOOT,   /* enter fast boot mode */
> +       BOOT_SECUREBOOT_DISABLE,
> +       BOOT_CHARGING,   /* enter charge mode */
> +       BOOT_MAX         /* MAX VALID BOOT TYPE.*/
> +};
> +#endif
> diff --git a/arch/arm/mach-rockchip/reboot.c b/arch/arm/mach-rockchip/reboot.c
> new file mode 100644
> index 0000000..c29f031e
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/reboot.c
> @@ -0,0 +1,111 @@
> +/*
> + * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include "loader.h"
> +
> +#define RK3188_PMU_SYS_REG0             0x40
> +#define RK3288_PMU_SYS_REG0             0x94

I think RK3066 and RK3368 also supported in upstream kernel. And the
protocol is the same. So it would be better to support it here.
> +
> +struct regmap *regmap;
> +int flag_reg;
> +
> +static int rockchip_get_pmu_regmap(void)
> +{
> +       struct device_node *node;
> +
> +       node = of_find_node_by_path("/cpus");
> +       if (!node)
> +               return -ENODEV;
> +
> +       regmap = syscon_regmap_lookup_by_phandle(node, "rockchip,pmu");
> +       of_node_put(node);
> +       if (!IS_ERR(regmap))
> +               return 0;
> +
> +       regmap = syscon_regmap_lookup_by_compatible("rockchip,rk3066-pmu");
> +       if (!IS_ERR(regmap))
> +               return 0;
> +
> +       return -ENODEV;
> +}
> +
> +static int rockchip_get_reboot_flag_regmap(void)
> +{
> +       int ret = rockchip_get_pmu_regmap();
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       if (of_machine_is_compatible("rockchip,rk3288")) {
> +               flag_reg = RK3288_PMU_SYS_REG0;
> +               return 0;
> +       } else if (of_machine_is_compatible("rockchip,rk3066a") ||
> +                  of_machine_is_compatible("rockchip,rk3066b") ||
> +                  of_machine_is_compatible("rockchip,rk3188")) {
> +               flag_reg = RK3188_PMU_SYS_REG0;
> +               return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static void rockchip_get_reboot_flag(const char *cmd, u32 *flag)
> +{
> +       *flag = SYS_LOADER_REBOOT_FLAG + BOOT_NORMAL;
> +
> +       if (cmd) {
> +               if (!strcmp(cmd, "loader") || !strcmp(cmd, "bootloader"))
> +                       *flag = SYS_LOADER_REBOOT_FLAG + BOOT_LOADER;
> +               else if (!strcmp(cmd, "recovery"))
> +                       *flag = SYS_LOADER_REBOOT_FLAG + BOOT_RECOVER;
> +               else if (!strcmp(cmd, "charge"))
> +                       *flag = SYS_LOADER_REBOOT_FLAG + BOOT_CHARGING;
> +       }
> +}
> +
> +static int rockchip_reboot_notify(struct notifier_block *this,
> +                                 unsigned long mode, void *cmd)
> +{
> +       u32 flag;
> +
> +       rockchip_get_reboot_flag(cmd, &flag);
> +       regmap_write(regmap, flag_reg, flag);
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rockchip_reboot_handler = {
> +       .notifier_call = rockchip_reboot_notify,
> +};
> +
> +static int __init rockchip_reboot_init(void)
> +{
> +       int ret = 0;
> +
> +       if (!rockchip_get_reboot_flag_regmap()) {
> +               ret = register_reboot_notifier(&rockchip_reboot_handler);
> +               if (ret)
> +                       pr_err("%s: cannot register reboot handler, %d\n",
> +                              __func__, ret);
> +       }
> +
> +       return ret;
> +}
> +
> +module_init(rockchip_reboot_init);
> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
> +MODULE_DESCRIPTION("Rockchip platform reboot notifier driver");
> +MODULE_LICENSE("GPL");
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
