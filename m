From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 14 Aug 2013 17:44:01 +0100
Subject: [PATCH] ARM: ARMv7-M: implement restart routine common to all
 v7-M machines
In-Reply-To: <1376494625-25496-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1376494625-25496-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <520BB3D1.1050205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 16:37, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Do we get a commit message? ;)

> ---
>   arch/arm/include/asm/v7m.h   | 12 ++++++++++++
>   arch/arm/kernel/Makefile     |  2 +-
>   arch/arm/kernel/common-v7m.c | 19 +++++++++++++++++++
>   3 files changed, 32 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/kernel/common-v7m.c
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

These all look good, happy with the names too.
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

Certainly worth introducing what the plans for this are in the long run 
- but I suspect the commit message might have contained that info?

> +
> +void armv7m_restart(enum reboot_mode mode, const char *cmd);
> +
> +#endif /* __ASSEMBLY__ */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 86d10dd..688b8be 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -24,7 +24,7 @@ obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
>   obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
>
>   ifeq ($(CONFIG_CPU_V7M),y)
> -obj-y		+= entry-v7m.o
> +obj-y		+= entry-v7m.o common-v7m.o
>   else
>   obj-y		+= entry-armv.o
>   endif
> diff --git a/arch/arm/kernel/common-v7m.c b/arch/arm/kernel/common-v7m.c
> new file mode 100644
> index 0000000..4d2cba9
> --- /dev/null
> +++ b/arch/arm/kernel/common-v7m.c

Is this really the right place for such a function? My immediate thought 
is that such a thing belongs in proc-v7m.S

Is this fitting in to a an existing framework or pattern that I'm missing?

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
