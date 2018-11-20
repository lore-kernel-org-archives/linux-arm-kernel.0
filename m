From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:42:45 +0100
Subject: [RFC PATCH v2 03/14] ARM: sunxi: add Allwinner ARMv5 SoCs
In-Reply-To: <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120084245.bnjdaf647e6tdlku@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 05:17:02PM +0300, Mesih Kilinc wrote:
> Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
> used for many new F-series products, including F1C100A, F1C100s, F1C200s,
> F1C500, F1C600).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig    | 14 +++++++++++++-
>  arch/arm/mach-sunxi/Makefile   |  1 +
>  arch/arm/mach-sunxi/sunxi_v5.c | 22 ++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 5db17ec..066644c 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig ARCH_SUNXI
>  	bool "Allwinner SoCs"
> -	depends on ARCH_MULTI_V7
> +	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
> @@ -64,4 +64,16 @@ config ARCH_SUNXI_MC_SMP
>  
>  endif
>  
> +if ARCH_MULTI_V5
> +
> +config ARCH_SUNXI_V5
> +	bool
> +	select SUN4I_TIMER

If SUN4I_TIMER is needed both by the armv5 and armv7 cores, why did we
need to move it out of ARCH_SUNXI?

> +config MACH_SUNIV
> +	bool "Allwinner new F-series (suniv) SoCs support"

I would drop the "new" here.

> +++ b/arch/arm/mach-sunxi/sunxi_v5.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree support for Allwinner F series SoCs
> + *
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + * Copyright (C) 2018 Mesih Kilinc <mesihkilinc@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <asm/mach/arch.h>
> +
> +static const char * const suniv_board_dt_compat[] = {
> +	"allwinner,suniv-f1c100s",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUNXI_DT, "Allwinner suniv Family")
> +	.dt_compat	= suniv_board_dt_compat,
> +MACHINE_END

Do we really need a separate file for that?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/8fce95a1/attachment-0001.sig>
