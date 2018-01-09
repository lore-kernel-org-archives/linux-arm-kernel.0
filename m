From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 9 Jan 2018 13:37:40 +0100
Subject: [RFC PATCH 4/9] soc: samsung: Add generic power-management driver
 for Exynos
In-Reply-To: <1515484746-10656-5-git-send-email-cw00.choi@samsung.com>
References: <CGME20180109075905epcas1p40431a90ecc3530f2200ade028bf54594@epcas1p4.samsung.com>
 <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <1515484746-10656-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAJKOXPd5nZApbx-v2dZhuUy5ociUwNGHa_wAoz1b-XKbJy1nmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 8:59 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> To enter suspend, Exynos SoC requires the some machine dependent procedures.
> This patch introduces the generic power-management driver to support
> those requirements and generic interface for power state management.
>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h         |   1 -
>  arch/arm/mach-exynos/exynos.c         |  23 +----
>  drivers/soc/samsung/Makefile          |   2 +-
>  drivers/soc/samsung/exynos-pm.c       | 176 ++++++++++++++++++++++++++++++++++
>  include/linux/soc/samsung/exynos-pm.h |  21 ++++
>  5 files changed, 199 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/soc/samsung/exynos-pm.c
>  create mode 100644 include/linux/soc/samsung/exynos-pm.h
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index afbc143a3d5d..ad482c0fc131 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -119,7 +119,6 @@ enum {
>   * Magic values for bootloader indicating chosen low power mode.
>   * See also Documentation/arm/Samsung/Bootloader-interface.txt
>   */
> -#define EXYNOS_SLEEP_MAGIC     0x00000bad
>  #define EXYNOS_AFTR_MAGIC      0xfcba0d10
>
>  void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index fbd108ce8745..0d5265d175c4 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_fdt.h>

of_address.h might be not needed anymore.

>  #include <linux/platform_device.h>
>  #include <linux/irqchip.h>
> +#include <linux/soc/samsung/exynos-pm.h>
>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>
>  #include <asm/cacheflush.h>
> @@ -41,28 +42,6 @@
>         .id                = -1,
>  };
>
> -void __iomem *sysram_base_addr __ro_after_init;
> -void __iomem *sysram_ns_base_addr __ro_after_init;
> -
> -void __init exynos_sysram_init(void)
> -{
> -       struct device_node *node;
> -
> -       for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
> -               if (!of_device_is_available(node))
> -                       continue;
> -               sysram_base_addr = of_iomap(node, 0);
> -               break;
> -       }
> -
> -       for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram-ns") {
> -               if (!of_device_is_available(node))
> -                       continue;
> -               sysram_ns_base_addr = of_iomap(node, 0);
> -               break;
> -       }
> -}
> -
>  static void __init exynos_init_late(void)
>  {
>         if (of_machine_is_compatible("samsung,exynos5440"))
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index d2e637339a45..58ca5bdabf1f 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
> +obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o exynos-pm.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
>                                         exynos5250-pmu.o exynos5420-pmu.o \
> diff --git a/drivers/soc/samsung/exynos-pm.c b/drivers/soc/samsung/exynos-pm.c
> new file mode 100644
> index 000000000000..45d84bbe5e61
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-pm.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// based on arch/arm/mach-exynos/suspend.c
> +// Copyright (c) 2018 Samsung Electronics Co., Ltd.
> +//
> +// Exynos Power Management support driver
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_fdt.h>
> +#include <linux/kernel.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/suspend.h>
> +
> +#include <asm/cpuidle.h>
> +#include <asm/io.h>
> +#include <asm/suspend.h>
> +
> +#include <linux/soc/samsung/exynos-pm.h>
> +#include <linux/soc/samsung/exynos-pmu.h>
> +
> +/*
> + * The struct exynos_pm_data contains the callbacks of
> + * both struct platform_suspend_ops and syscore_ops.
> + * This structure is listed according to the call order,
> + * because the callback call order for the two structures is mixed.
> + */
> +struct exynos_pm_data {
> +       int (*prepare)(void);                   /* for platform_suspend_ops */
> +       int (*suspend)(void);                   /* for syscore_ops */
> +       int (*enter)(suspend_state_t state);    /* for platform_suspend_ops */
> +       void (*resume)(void);                   /* for syscore_ops */
> +       void (*finish)(void);                   /* for platform_suspend_ops */
> +};
> +
> +static struct platform_suspend_ops exynos_pm_suspend_ops;
> +static struct syscore_ops exynos_pm_syscore_ops;
> +static const struct exynos_pm_data *pm_data  __ro_after_init;

It is already const, so __initconst?

> +
> +void __iomem *sysram_base_addr __ro_after_init;
> +void __iomem *sysram_ns_base_addr __ro_after_init;
> +
> +static int exynos_pm_prepare(void)
> +{
> +       int ret;
> +
> +       /*
> +        * REVISIT: It would be better if struct platform_suspend_ops
> +        * .prepare handler get the suspend_state_t as a parameter to
> +        * avoid hard-coding the suspend to mem state. It's safe to do
> +        * it now only because the suspend_valid_only_mem function is
> +        * used as the .valid callback used to check if a given state
> +        * is supported by the platform anyways.
> +        */
> +       ret = regulator_suspend_prepare(PM_SUSPEND_MEM);
> +       if (ret) {
> +               pr_err("Failed to prepare regulators for suspend (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       if (pm_data->prepare) {
> +               ret = pm_data->prepare();
> +               if (ret) {
> +                       pr_err("Failed to prepare for suspend (%d)\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int exynos_pm_suspend(void)
> +{
> +       if (pm_data->suspend)
> +               return pm_data->suspend();
> +
> +       return 0;
> +}
> +
> +static int exynos_pm_enter(suspend_state_t state)
> +{
> +       int ret;
> +
> +       exynos_sys_powerdown_conf(SYS_SLEEP);
> +
> +       ret = pm_data->enter(state);
> +       if (ret) {
> +               pr_err("Failed to enter sleep\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void exynos_pm_resume(void)
> +{
> +       exynos_sys_powerup_conf(SYS_SLEEP);
> +
> +       if (pm_data->resume)
> +               pm_data->resume();
> +}
> +
> +static void exynos_pm_finish(void)
> +{
> +       int ret;
> +
> +       ret = regulator_suspend_finish();
> +       if (ret)
> +               pr_warn("Failed to resume regulators from suspend (%d)\n", ret);
> +
> +       if (pm_data->finish)
> +               pm_data->finish();
> +}
> +
> +/*
> + * Split the data between ARM architectures because it is relatively big
> + * and useless on other arch.
> + */
> +#ifdef CONFIG_EXYNOS_PMU_ARM_DRIVERS
> +#define exynos_pm_data_arm_ptr(data)   (&data)
> +#else
> +#define exynos_pm_data_arm_ptr(data)   NULL
> +#endif
> +
> +static const struct of_device_id exynos_pm_of_device_ids[] = {
> +       { /*sentinel*/ },
> +};
> +
> +void __init exynos_sysram_init(void)
> +{
> +       struct device_node *np;
> +
> +       for_each_compatible_node(np, NULL, "samsung,exynos4210-sysram") {
> +               if (!of_device_is_available(np))
> +                       continue;
> +               sysram_base_addr = of_iomap(np, 0);
> +               break;
> +       }
> +
> +       for_each_compatible_node(np, NULL, "samsung,exynos4210-sysram-ns") {
> +               if (!of_device_is_available(np))
> +                       continue;
> +               sysram_ns_base_addr = of_iomap(np, 0);
> +               break;
> +       }
> +}
> +
> +static int __init exynos_pm_init(void)
> +{
> +       const struct of_device_id *match;
> +       struct device_node *np;
> +
> +       np = of_find_matching_node_and_match(NULL,
> +                                       exynos_pm_of_device_ids, &match);
> +       if (!np) {
> +               pr_err("Failed to find PMU node for Exynos Power-Management\n");
> +               return -ENODEV;
> +       }
> +       pm_data = (const struct exynos_pm_data *) match->data;
> +
> +       exynos_sysram_init();
> +
> +       exynos_pm_suspend_ops.valid     = suspend_valid_only_mem;
> +       exynos_pm_suspend_ops.prepare   = exynos_pm_prepare;
> +       exynos_pm_syscore_ops.suspend   = exynos_pm_suspend;
> +       exynos_pm_suspend_ops.enter     = exynos_pm_enter;
> +       exynos_pm_syscore_ops.resume    = exynos_pm_resume;
> +       exynos_pm_suspend_ops.finish    = exynos_pm_finish;
> +
> +       register_syscore_ops(&exynos_pm_syscore_ops);
> +       suspend_set_ops(&exynos_pm_suspend_ops);
> +
> +       return 0;
> +}
> +postcore_initcall(exynos_pm_init);

As I mentioned in cover letter, please move here first ARMv7 code. Now
it looks like duplicating the existing code.

> diff --git a/include/linux/soc/samsung/exynos-pm.h b/include/linux/soc/samsung/exynos-pm.h
> new file mode 100644
> index 000000000000..b1afe95ed10c
> --- /dev/null
> +++ b/include/linux/soc/samsung/exynos-pm.h
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 Samsung Electronics Co., Ltd.
> +//
> +// Header for Exynos Power-Management support driver

Use header-style SPDX and comment.

Best regards,
Krzysztof

> +
> +#ifndef __LINUX_SOC_EXYNOS_PM_H
> +#define __LINUX_SOC_EXYNOS_PM_H
> +
> +/*
> + * Magic values for bootloader indicating chosen low power mode.
> + * See also Documentation/arm/Samsung/Bootloader-interface.txt
> + */
> +#define EXYNOS_SLEEP_MAGIC     0x00000bad
> +
> +extern void __iomem *sysram_base_addr;
> +extern void __iomem *sysram_ns_base_addr;

Since these are now global symbols, they need nice exynos prefix.
Also, probably they should not be globally modifiable. Only
exynos_sysram_init() should write there. Instead export a global
accessor (get()) and rest should use that one.

Best regards,
Krzysztof

> +
> +extern void exynos_sysram_init(void);
> +
> +#endif /* __LINUX_SOC_EXYNOS_PMU_H */
> --
> 1.9.1
>
