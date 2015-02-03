From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Feb 2015 10:52:31 -0800
Subject: [PATCH v4 1/6] ARM: Alpine: Initial support for Alpine platform
In-Reply-To: <54d0cd1c.JZPcRllcuDW7d5v+%tsahee@annapurnalabs.com>
References: <54d0cd1c.JZPcRllcuDW7d5v+%tsahee@annapurnalabs.com>
Message-ID: <54D118EF.4040605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/15 05:29, Tsahee Zidenberg wrote:
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c1785ee..bcc4113 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -143,6 +143,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
>  
>  # Machine directory name.  This list is sorted alphanumerically
>  # by CONFIG_* macro name.
> +machine-$(CONFIG_ARCH_ALPINE)		+= alpine
>  machine-$(CONFIG_ARCH_AT91)		+= at91
>  machine-$(CONFIG_ARCH_AXXIA)		+= axxia
>  machine-$(CONFIG_ARCH_BCM)		+= bcm
> diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
> new file mode 100644
> index 0000000..4548f32
> --- /dev/null
> +++ b/arch/arm/mach-alpine/Kconfig
> @@ -0,0 +1,8 @@
> +config ARCH_ALPINE
> +        bool "Annapurna Labs Alpine platform" if ARCH_MULTI_V7

s/ */\t/

> +	select ARM_AMBA
> +	select ARM_GIC
> +	select GENERIC_IRQ_CHIP
> +	select HAVE_ARM_ARCH_TIMER
> +	help
> +	  This enables support for the Annapurna Labs Alpine V1 boards.
> diff --git a/arch/arm/mach-alpine/Makefile b/arch/arm/mach-alpine/Makefile
> new file mode 100644
> index 0000000..8ba9e99
> --- /dev/null
> +++ b/arch/arm/mach-alpine/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for the linux kernel.
> +#

Remove comment because this isn't the Makefile for the linux kernel?

> +
> +obj-y				+= alpine_machine.o
> diff --git a/arch/arm/mach-alpine/alpine_machine.c b/arch/arm/mach-alpine/alpine_machine.c
> new file mode 100644
> index 0000000..cf77053
> --- /dev/null
> +++ b/arch/arm/mach-alpine/alpine_machine.c
> @@ -0,0 +1,28 @@
> +/*
> + * Machine declaration for Alpine platforms.
> + *
> + * Copyright (C) 2015 Annapurna Labs Ltd.
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
> + */
> +
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +
> +static const char *al_match[] __initconst = {

static const char * const al_match[] ...

> +	"al,alpine",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(AL_DT, "Annapurna Labs Alpine")
> +	.dt_compat	= al_match,
> +MACHINE_END

Technically we don't even need this file because the default machine
descriptor for DT based platforms will work the same.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
