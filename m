From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 Aug 2014 16:21:15 +0200
Subject: [PATCH 4/7] ARM: meson: add basic support for MesonX SoCs
In-Reply-To: <1408272594-10814-5-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-5-git-send-email-carlo@caione.org>
Message-ID: <20140817142115.GB15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Sun, Aug 17, 2014 at 12:49:51PM +0200, Carlo Caione wrote:
> Signed-off-by: Carlo Caione <carlo@caione.org>

A commit log would be nice

> ---
>  arch/arm/Kconfig             |  2 ++
>  arch/arm/Makefile            |  1 +
>  arch/arm/mach-meson/Kconfig  | 13 +++++++++++++
>  arch/arm/mach-meson/Makefile |  1 +
>  arch/arm/mach-meson/meson.c  | 36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/mach-meson/Kconfig
>  create mode 100644 arch/arm/mach-meson/Makefile
>  create mode 100644 arch/arm/mach-meson/meson.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c49a775..cc52a8f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -888,6 +888,8 @@ source "arch/arm/mach-keystone/Kconfig"
>  
>  source "arch/arm/mach-ks8695/Kconfig"
>  
> +source "arch/arm/mach-meson/Kconfig"
> +
>  source "arch/arm/mach-msm/Kconfig"
>  
>  source "arch/arm/mach-moxart/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0ce9d0f..320aa57 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -168,6 +168,7 @@ machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
>  machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
>  machine-$(CONFIG_ARCH_KS8695)		+= ks8695
>  machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
> +machine-$(CONFIG_ARCH_MESON)		+= meson
>  machine-$(CONFIG_ARCH_MMP)		+= mmp
>  machine-$(CONFIG_ARCH_MOXART)		+= moxart
>  machine-$(CONFIG_ARCH_MSM)		+= msm
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> new file mode 100644
> index 0000000..2c1154e
> --- /dev/null
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -0,0 +1,13 @@
> +menuconfig ARCH_MESON
> +	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
> +	select GENERIC_IRQ_CHIP
> +	select ARM_GIC
> +
> +if ARCH_MESON
> +
> +config MACH_MESON6
> +	bool "Amlogic Meson6 (8726MX) SoCs support"
> +	default ARCH_MESON
> +	select MESON6_TIMER
> +
> +endif
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> new file mode 100644
> index 0000000..9d7380e
> --- /dev/null
> +++ b/arch/arm/mach-meson/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARCH_MESON) += meson.o
> diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
> new file mode 100644
> index 0000000..4528312
> --- /dev/null
> +++ b/arch/arm/mach-meson/meson.c
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + */
> +
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +
> +static __init void meson_init_machine_devicetree(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

This is the default, you can just remove it

> +
> +static const char * const m6_common_board_compat[] = {
> +	"amlogic,8726_mx",
> +	"amlogic,8726_mxs",
> +	"amlogic,8726_mxl",
> +	"amlogic,meson6",

Why are all those compatibles needed? Usually, you add a single one
per SoC (which would be the last in your case I guess.

> +	NULL,
> +};
> +
> +DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> +	.init_machine	= meson_init_machine_devicetree,

And since you don't need the init machine, you can just use the
generic machine support. I'm not sure what's been decided on this,
should we remove such empty machines?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140817/211de77b/attachment.sig>
