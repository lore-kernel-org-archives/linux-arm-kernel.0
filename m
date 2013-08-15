From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 15 Aug 2013 16:50:09 +0100
Subject: [PATCH v2] ARM: ARMv7-M: implement restart routine common to
 all v7-M machines
In-Reply-To: <1376581536-14742-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1376581536-14742-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <520CF8B1.20609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/13 16:45, Uwe Kleine-K?nig wrote:
> The newly introduced function is to be used as .restart callback for
> ARMv7-M machines. The used register is architecturally defined, so it
> should work for all M-class machines.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>
> Changes since v1, sent with Message-Id:
> 1376494625-25496-1-git-send-email-u.kleine-koenig at pengutronix.de:
>
>   - add a more verbose change log
>   - rename arch/arm/kernel/common-v7m.c to arch/arm/kernel/v7m.c
>

Thanks Uwe, this looks good now - assuming Russell's happy with
arch/arm/kernel/v7m.c :)

FWIW,
Acked-by: Jonathan Austin <jonathan.austin@arm.com>

>   arch/arm/include/asm/v7m.h | 12 ++++++++++++
>   arch/arm/kernel/Makefile   |  2 +-
>   arch/arm/kernel/v7m.c      | 19 +++++++++++++++++++
>   3 files changed, 32 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/kernel/v7m.c
>
> diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
> index fa88d09..615781c 100644
> --- a/arch/arm/include/asm/v7m.h
> +++ b/arch/arm/include/asm/v7m.h
> @@ -15,6 +15,10 @@
>
>   #define V7M_SCB_VTOR			0x08
>
> +#define V7M_SCB_AIRCR			0x0c
> +#define V7M_SCB_AIRCR_VECTKEY			(0x05fa << 16)
> +#define V7M_SCB_AIRCR_SYSRESETREQ		(1 << 2)
> +
>   #define V7M_SCB_SCR			0x10
>   #define V7M_SCB_SCR_SLEEPDEEP			(1 << 2)
>
> @@ -42,3 +46,11 @@
>    */
>   #define EXC_RET_STACK_MASK			0x00000004
>   #define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
> +
> +#ifndef __ASSEMBLY__
> +
> +enum reboot_mode;
> +
> +void armv7m_restart(enum reboot_mode mode, const char *cmd);
> +
> +#endif /* __ASSEMBLY__ */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 86d10dd..5140df5f 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -24,7 +24,7 @@ obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
>   obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
>
>   ifeq ($(CONFIG_CPU_V7M),y)
> -obj-y		+= entry-v7m.o
> +obj-y		+= entry-v7m.o v7m.o
>   else
>   obj-y		+= entry-armv.o
>   endif
> diff --git a/arch/arm/kernel/v7m.c b/arch/arm/kernel/v7m.c
> new file mode 100644
> index 0000000..4d2cba9
> --- /dev/null
> +++ b/arch/arm/kernel/v7m.c
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (C) 2013 Uwe Kleine-Koenig for Pengutronix
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <linux/io.h>
> +#include <linux/reboot.h>
> +#include <asm/barrier.h>
> +#include <asm/v7m.h>
> +
> +void armv7m_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	dsb();
> +	__raw_writel(V7M_SCB_AIRCR_VECTKEY | V7M_SCB_AIRCR_SYSRESETREQ,
> +			BASEADDR_V7M_SCB + V7M_SCB_AIRCR);
> +	dsb();
> +}
>
