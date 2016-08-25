From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 25 Aug 2016 15:08:38 +0800
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <1472055231-28434-1-git-send-email-Anson.Huang@nxp.com>
References: <1472055231-28434-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAL411-rVg6HHj=MoZ32tK6QoioehPKjbu71mHr1c4QCoD8mXCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/cpuidle-imx6sx.c | 10 ++++++++++
>  arch/arm/mach-imx/mach-imx6ul.c    |  3 +++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
> index 41cdce6..b4fcc8ae 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -9,14 +9,21 @@
>  #include <linux/cpuidle.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <asm/cacheflush.h>
>  #include <asm/cpuidle.h>
>  #include <asm/suspend.h>
>
>  #include "common.h"
>  #include "cpuidle.h"
>
> +static bool pl310_available;
> +


>  static int imx6sx_idle_finish(unsigned long val)
>  {
> +       /* check if need to flush internal L2 cache */
> +       if (!pl310_available)

Just wondering why you need an extra variable here?
Calling of_find_compatible_node takes long time at that time?

Peter

> +               flush_cache_all();
>         cpu_do_idle();
>
>         return 0;
> @@ -101,5 +108,8 @@ int __init imx6sx_cpuidle_init(void)
>         imx_gpc_set_arm_power_up_timing(2, 1);
>         imx_gpc_set_arm_power_down_timing(1, 1);
>
> +       if (of_find_compatible_node(NULL, NULL, "arm,pl310-cache"))
> +               pl310_available = true;
> +
>         return cpuidle_register(&imx6sx_cpuidle_driver, NULL);
>  }
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> index c2cd61c..9c5e8f3 100644
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -16,6 +16,7 @@
>  #include <asm/mach/map.h>
>
>  #include "common.h"
> +#include "cpuidle.h"
>
>  static void __init imx6ul_enet_clk_init(void)
>  {
> @@ -80,6 +81,8 @@ static void __init imx6ul_init_irq(void)
>
>  static void __init imx6ul_init_late(void)
>  {
> +       imx6sx_cpuidle_init();
> +
>         if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
>                 imx6_pm_opp_init();
>                 platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
