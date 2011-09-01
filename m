From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 1 Sep 2011 20:22:40 +0800
Subject: [PATCH v2 7/7] ARM: highbank: add suspend support
In-Reply-To: <1314841446-11006-8-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
	<1314841446-11006-8-git-send-email-robherring2@gmail.com>
Message-ID: <20110901122239.GA5147@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 08:44:06PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add the platform suspend ops for highbank.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> Changes in v2:
>  - s/a9_base_addr/scu_base_addr/
>  - use sysregs helper functions
>  - add __init to highbank_pm_init
> 
>  arch/arm/mach-highbank/Makefile |    1 +
>  arch/arm/mach-highbank/pm.c     |   55 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-highbank/pm.c
> 
> diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
> index df30b0d..daeb3d8 100644
> --- a/arch/arm/mach-highbank/Makefile
> +++ b/arch/arm/mach-highbank/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_DEBUG_LL)			+= lluart.o
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> +obj-$(CONFIG_PM_SLEEP)			+= pm.o
> diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
> new file mode 100644
> index 0000000..33b3beb
> --- /dev/null
> +++ b/arch/arm/mach-highbank/pm.c
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2011 Calxeda, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/suspend.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/smp_scu.h>
> +#include <asm/suspend.h>
> +
> +#include "core.h"
> +#include "sysregs.h"
> +
> +static int highbank_suspend_finish(unsigned long val)
> +{
> +	cpu_do_idle();
> +	return 0;
> +}
> +
> +static int highbank_pm_enter(suspend_state_t state)
> +{
> +	hignbank_set_pwr_suspend();
> +	highbank_set_cpu_jump(0, cpu_resume);
> +
> +	scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
> +	cpu_suspend(0, highbank_suspend_finish);
> +
Rob,

Just out of curiosity, how can you resume back without taking care of
GIC, L2 and SCU which will lose power during suspend?

Regards,
Shawn

> +	return 0;
> +}
> +
> +static const struct platform_suspend_ops highbank_pm_ops = {
> +	.enter = highbank_pm_enter,
> +	.valid = suspend_valid_only_mem,
> +};
> +
> +static int __init highbank_pm_init(void)
> +{
> +	suspend_set_ops(&highbank_pm_ops);
> +	return 0;
> +}
> +module_init(highbank_pm_init);
> -- 
> 1.7.4.1
> 
> 
