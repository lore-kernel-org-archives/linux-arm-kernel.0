From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:21:43 +0100
Subject: [PATCH v7 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142143.GG20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:05PM +0100, Lorenzo Pieralisi wrote:
> This patch implements a generic CPU idle driver for ARM64 machines.
> 
> It relies on the DT idle states infrastructure to initialize idle
> states count and respective parameters. Current code assumes the driver
> is managing idle states on all possible CPUs but can be easily
> generalized to support heterogenous systems and build cpumasks at
> runtime using MIDRs or DT cpu nodes compatible properties.
> 
> The driver relies on the arm64 CPU operations to call the idle
> initialization hook used to parse and save suspend back-end specific
> idle states information upon probing.
> 
> Idle state index 0 is always initialized as a simple wfi state, ie always
> considered present and functional on all ARM64 platforms.
> 
> Idle state indices higher than 0 trigger idle state entry by calling
> the cpu_suspend function, that triggers the suspend operation through
> the CPU operations suspend back-end hook. cpu_suspend passes the idle
> state index as a parameter so that the CPU operations suspend back-end
> can retrieve the required idle state data by using the idle state
> index to execute a look-up on its internal data structures.
> 
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig         |   5 ++
>  drivers/cpuidle/Kconfig.arm64   |  14 +++++
>  drivers/cpuidle/Makefile        |   4 ++
>  drivers/cpuidle/cpuidle-arm64.c | 131 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 drivers/cpuidle/Kconfig.arm64
>  create mode 100644 drivers/cpuidle/cpuidle-arm64.c
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 8deb934..c5029c1 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -33,6 +33,11 @@ depends on ARM
>  source "drivers/cpuidle/Kconfig.arm"
>  endmenu
>  
> +menu "ARM64 CPU Idle Drivers"
> +depends on ARM64
> +source "drivers/cpuidle/Kconfig.arm64"
> +endmenu
> +
>  menu "MIPS CPU Idle Drivers"
>  depends on MIPS
>  source "drivers/cpuidle/Kconfig.mips"
> diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
> new file mode 100644
> index 0000000..d0a08ed
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.arm64
> @@ -0,0 +1,14 @@
> +#
> +# ARM64 CPU Idle drivers
> +#
> +
> +config ARM64_CPUIDLE
> +	bool "Generic ARM64 CPU idle Driver"
> +	select ARM64_CPU_SUSPEND
> +	select DT_IDLE_STATES
> +	help
> +	  Select this to enable generic cpuidle driver for ARM64.
> +	  It provides a generic idle driver whose idle states are configured
> +	  at run-time through DT nodes. The CPUidle suspend backend is
> +	  initialized by calling the CPU operations init idle hook
> +	  provided by architecture code.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 002b653..4d177b9 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -23,6 +23,10 @@ obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>  obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
>  
>  ###############################################################################
> +# ARM64 drivers
> +obj-$(CONFIG_ARM64_CPUIDLE)		+= cpuidle-arm64.o
> +
> +###############################################################################
>  # POWERPC drivers
>  obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
>  obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> new file mode 100644
> index 0000000..25ec622
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -0,0 +1,131 @@
> +/*
> + * ARM64 generic CPU idle driver.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "CPUidle arm64: " fmt
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cpuidle.h>
> +#include <asm/suspend.h>
> +
> +#include "dt_idle_states.h"
> +
> +/*
> + * arm_enter_idle_state - Programs CPU to enter the specified state
> + *
> + * dev: cpuidle device
> + * drv: cpuidle driver
> + * idx: state index
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified target state selected by the governor.
> + */
> +static int arm_enter_idle_state(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int idx)

Nitpick: for consistency, I would either prefix it arm64 or drop the
prefix entirely (it's a static function anyway).

> +struct cpuidle_driver arm64_idle_driver = {

Should this be static?

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
