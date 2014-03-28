From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Mar 2014 11:13:21 -0700
Subject: [PATCH 07/10] ARM: mvebu: add SMP support for Armada 375 and
 Armada 38x
In-Reply-To: <1396012026-5997-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396012026-5997-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5335BBC1.6090804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/14 06:07, Thomas Petazzoni wrote:
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 8634222..e88d951 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -45,6 +45,8 @@ config MACH_ARMADA_375
>  	select ARMADA_375_CLK
>  	select CPU_V7
>  	select HAVE_ARM_SCU
> +	select HAVE_ARM_TWD

This should have "if SMP" appended to it (same for HAVE_ARM_SCU).

>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 6260cb8..9ded4b9 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -146,6 +146,7 @@ static const char * const armada_375_dt_compat[] = {
>  };
>  
>  DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
> +	.smp		= smp_ops(mvebu_cortex_a9_smp_ops),
>  	.init_time	= mvebu_timer_and_clk_init,
>  	.restart	= mvebu_restart,
>  	.dt_compat	= armada_375_dt_compat,
> @@ -158,6 +159,7 @@ static const char * const armada_38x_dt_compat[] = {
>  };
>  
>  DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
> +	.smp		= smp_ops(mvebu_cortex_a9_smp_ops),
>  	.init_time	= mvebu_timer_and_clk_init,
>  	.restart	= mvebu_restart,
>  	.dt_compat	= armada_38x_dt_compat,

You may want to look into using the enable-method property in devicetree
so that you don't have to set the smp ops here. The patch to support
that is sitting in -next as 6c3ff8b11a16 (ARM: Introduce
CPU_METHOD_OF_DECLARE() for cpu hotplug/smp, 2013-10-30).

> diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
> new file mode 100644
> index 0000000..78e66c9
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/headsmp-a9.S
> @@ -0,0 +1,22 @@
> +/*
> + * SMP support: Entry point for secondary CPUs of Marvell EBU
> + * Cortex-A9 based SOCs (Armada 375 and Armada 38x).
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +	__CPUINIT

__CPUINIT is dead. Don't use it.

> +ENTRY(mvebu_cortex_a9_secondary_startup)
> +	bl      v7_invalidate_l1
> +	b	secondary_startup
> +ENDPROC(mvebu_cortex_a9_secondary_startup)
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
