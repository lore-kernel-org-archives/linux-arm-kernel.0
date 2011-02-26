From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 26 Feb 2011 15:50:28 +0800
Subject: [PATCH] ARM: mxs: Initial support for Ka-Ro TX28
In-Reply-To: <1298581480-15585-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110224210353.GA22310@pengutronix.de>
	<1298581480-15585-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110226075027.GA2506@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 10:04:40PM +0100, Uwe Kleine-K?nig wrote:
> From: Lothar Wa?mann <LW@KARO-electronics.de>
> 
> Based on code created by Lothar Wa?mann, Sascha Hauer, Wolfram Sang and
> me.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mxs/Kconfig                   |   12 ++
>  arch/arm/mach-mxs/Makefile                  |    2 +
>  arch/arm/mach-mxs/include/mach/mxs.h        |    9 +-
>  arch/arm/mach-mxs/include/mach/uncompress.h |    1 +
>  arch/arm/mach-mxs/mach-tx28.c               |  175 +++++++++++++++++++++++++++
>  arch/arm/mach-mxs/module-tx28.c             |  131 ++++++++++++++++++++
>  arch/arm/mach-mxs/module-tx28.h             |    9 ++
>  7 files changed, 337 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/mach-tx28.c
>  create mode 100644 arch/arm/mach-mxs/module-tx28.c
>  create mode 100644 arch/arm/mach-mxs/module-tx28.h
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 836cc81..895d066 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -39,4 +39,16 @@ config MACH_MX28EVK
>  	  Include support for MX28EVK platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MODULE_TX28
> +	bool
> +	select SOC_IMX28
> +	select MXS_HAVE_AMBA_DUART
> +	select MXS_HAVE_PLATFORM_AUART
> +	select MXS_HAVE_PLATFORM_FEC
> +	select MXS_HAVE_PLATFORM_MXS_PWM
> +
> +config MACH_TX28
> +	bool "Ka-Ro TX28 module"
> +	select MODULE_TX28
> +
>  endif
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index 6b26f02..2f1f614 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -9,5 +9,7 @@ obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
>  
>  obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
>  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> +obj-$(CONFIG_MODULE_TX28) += module-tx28.o
> +obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
>  
>  obj-y += devices/
> diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
> index f186c08..35a89dd 100644
> --- a/arch/arm/mach-mxs/include/mach/mxs.h
> +++ b/arch/arm/mach-mxs/include/mach/mxs.h
> @@ -28,8 +28,13 @@
>  /*
>   * MXS CPU types
>   */
> -#define cpu_is_mx23()		(machine_is_mx23evk())
> -#define cpu_is_mx28()		(machine_is_mx28evk())
> +#define cpu_is_mx23()		(					\
> +		machine_is_mx23evk() ||					\
> +		0)
> +#define cpu_is_mx28()		(					\
> +		machine_is_mx28evk() ||					\
> +		machine_is_tx28() ||					\
> +		0)
>  
>  /*
>   * IO addresses common to MXS-based
> diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
> index a005e76..f12a173 100644
> --- a/arch/arm/mach-mxs/include/mach/uncompress.h
> +++ b/arch/arm/mach-mxs/include/mach/uncompress.h
> @@ -63,6 +63,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		mxs_duart_base = MX23_DUART_BASE_ADDR;
>  		break;
>  	case MACH_TYPE_MX28EVK:
> +	case MACH_TYPE_TX28:
>  		mxs_duart_base = MX28_DUART_BASE_ADDR;
>  		break;
>  	default:
> diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
> new file mode 100644
> index 0000000..540d6ea
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mach-tx28.c
> @@ -0,0 +1,175 @@
> +/*
> + * Copyright (C) 2010 <LW@KARO-electronics.de>
> + *
> + * based on: mach-mx28_evk.c

mach-mx28evk.c?

> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation
> + */

-- 
Regards,
Shawn
