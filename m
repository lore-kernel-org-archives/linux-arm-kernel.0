From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 11:23:39 +0800
Subject: [PATCH v2 3/3] ARM: imx: Add imx6q cpuidle driver
In-Reply-To: <1335924760-796-4-git-send-email-rob.lee@linaro.org>
References: <1335924760-796-1-git-send-email-rob.lee@linaro.org>
 <1335924760-796-4-git-send-email-rob.lee@linaro.org>
Message-ID: <20120502032336.GU2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 09:12:40PM -0500, Robert Lee wrote:
> Add basic imx6q cpuidle driver.  For now, only basic WFI state is
> supported.  Deeper idle states will be added in the future.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c |   33 +++++++++++++++++++++++++++++++++

So, this file is not needed any more, I guess.

>  arch/arm/mach-imx/mach-imx6q.c    |   18 ++++++++++++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> new file mode 100644
> index 0000000..b74557f
> --- /dev/null
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/cpuidle.h>
> +#include <linux/export.h>
> +#include <asm/cpuidle.h>
> +#include <mach/cpuidle.h>
> +
> +static struct cpuidle_driver imx6q_cpuidle_driver = {
> +	.name			= "imx6q_cpuidle",
> +	.owner			= THIS_MODULE,
> +	.en_core_tk_irqen	= 1,
> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +	.state_count		= 1,
> +};
> +
> +int __init imx6q_cpuidle_init(void)
> +{
> +	imx_cpuidle_set_driver(&imx6q_cpuidle_driver);
> +
> +	return 0;
> +}
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index da6c1d9..21e2051 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -21,6 +21,9 @@
>  #include <linux/of_platform.h>
>  #include <linux/phy.h>
>  #include <linux/micrel_phy.h>
> +#include <linux/export.h>
> +#include <linux/cpuidle.h>
> +#include <asm/cpuidle.h>
>  #include <asm/smp_twd.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/hardware/gic.h>
> @@ -29,6 +32,7 @@
>  #include <asm/system_misc.h>
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> +#include <mach/cpuidle.h>

The headers here are mostly sorted in names, so please ...

Regards,
Shawn

>  
>  void imx6q_restart(char mode, const char *cmd)
>  {
> @@ -86,6 +90,19 @@ static void __init imx6q_init_machine(void)
>  	imx6q_pm_init();
>  }
>  
> +static struct cpuidle_driver imx6q_cpuidle_driver = {
> +	.name			= "imx6q_cpuidle",
> +	.owner			= THIS_MODULE,
> +	.en_core_tk_irqen	= 1,
> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +	.state_count		= 1,
> +};
> +
> +static void __init imx6q_init_late(void)
> +{
> +	imx_cpuidle_init(&imx6q_cpuidle_driver);
> +}
> +
>  static void __init imx6q_map_io(void)
>  {
>  	imx_lluart_map_io();
> @@ -142,6 +159,7 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
>  	.handle_irq	= imx6q_handle_irq,
>  	.timer		= &imx6q_timer,
>  	.init_machine	= imx6q_init_machine,
> +	.init_late      = imx6q_init_late,
>  	.dt_compat	= imx6q_dt_compat,
>  	.restart	= imx6q_restart,
>  MACHINE_END
> -- 
> 1.7.10
> 
