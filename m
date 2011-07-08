From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 07 Jul 2011 18:14:58 -0700
Subject: [PATCH 02/17] ARM: Add cpu power management notifiers
In-Reply-To: <1310053830-23779-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4E165A12.5080600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> From: Colin Cross<ccross@android.com>
>
> During some CPU power modes entered during idle, hotplug and
> suspend, peripherals located in the CPU power domain, such as
> the GIC and VFP, may be powered down.  Add a notifier chain
> that allows drivers for those peripherals to be notified
> before and after they may be reset.
>
> Signed-off-by: Colin Cross<ccross@android.com>
> Tested-by: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/Kconfig              |    7 ++
>   arch/arm/include/asm/cpu_pm.h |   54 ++++++++++++
>   arch/arm/kernel/Makefile      |    1 +
>   arch/arm/kernel/cpu_pm.c      |  181 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 243 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/include/asm/cpu_pm.h
>   create mode 100644 arch/arm/kernel/cpu_pm.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..356f266 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -183,6 +183,13 @@ config FIQ
>   config ARCH_MTD_XIP
>   	bool
>
> +config ARCH_USES_CPU_PM
> +       bool
> +
> +config CPU_PM
> +       def_bool y
> +       depends on ARCH_USES_CPU_PM&&  (PM || CPU_IDLE)
> +
>   config VECTORS_BASE
>   	hex
>   	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
> diff --git a/arch/arm/include/asm/cpu_pm.h b/arch/arm/include/asm/cpu_pm.h
> new file mode 100644
> index 0000000..b4bb715
> --- /dev/null
> +++ b/arch/arm/include/asm/cpu_pm.h
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (C) 2011 Google, Inc.
> + *
> + * Author:
> + *	Colin Cross<ccross@android.com>
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
> +#ifndef _ASMARM_CPU_PM_H
> +#define _ASMARM_CPU_PM_H
> +
> +#include<linux/kernel.h>
> +#include<linux/notifier.h>
> +
> +/* Event codes passed as unsigned long val to notifier calls */
> +enum cpu_pm_event {
> +	/* A single cpu is entering a low power state */
> +	CPU_PM_ENTER,
> +
> +	/* A single cpu failed to enter a low power state */
> +	CPU_PM_ENTER_FAILED,
> +
> +	/* A single cpu is exiting a low power state */
> +	CPU_PM_EXIT,
> +
> +	/* A cpu power domain is entering a low power state */
> +	CPU_COMPLEX_PM_ENTER,
> +
> +	/* A cpu power domain failed to enter a low power state */
> +	CPU_COMPLEX_PM_ENTER_FAILED,
> +
> +	/* A cpu power domain is exiting a low power state */
> +	CPU_COMPLEX_PM_EXIT,
> +};
> +
> +int cpu_pm_register_notifier(struct notifier_block *nb);
> +int cpu_pm_unregister_notifier(struct notifier_block *nb);
> +
> +int cpu_pm_enter(void);
> +int cpu_pm_exit(void);
> +
> +int cpu_complex_pm_enter(void);
> +int cpu_complex_pm_exit(void);
> +
Can "cpu_complex_pm*" renamed to "cpu_cluster_pm*" as discussed
earlier on the list.

Regards
Santosh
