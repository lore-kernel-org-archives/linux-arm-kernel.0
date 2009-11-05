From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Nov 2009 19:15:01 +0100
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
References: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091105181501.GA7221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Thu, Nov 05, 2009 at 12:35:12PM +0000, Catalin Marinas wrote:
> This patch allows an earlyprintk console if CONFIG_DEBUG_LL is enabled,
> using the printch asm function.
> 
> The patch is based on the original work by Sascha Hauer.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> The first variant of this patch was posted earlier this year -
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/52478 - and there
> were a few comments but no follow-up patch. I implemented those
> comments and I think we should merge this (it's much easier to pass
> earlyprintk on the kernel command line than hacking the printk code to
> do a printascii).
Great that you pick that up!
 
>  arch/arm/Kconfig.debug         |    8 ++++++
>  arch/arm/kernel/Makefile       |    1 +
>  arch/arm/kernel/early_printk.c |   57 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/kernel/early_printk.c
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 1a6f70e..feb7b11 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -71,6 +71,14 @@ config DEBUG_LL
>  	  in the kernel.  This is helpful if you are debugging code that
>  	  executes before the console is initialized.
>  
> +config EARLY_PRINTK
> +	bool "Early printk"
> +	depends on DEBUG_LL
> +	help
> +	  Say Y here if you want to have an early console using the
> +	  kernel low-level debugging functions. Add earlyprintk to your
> +	  kernel parameters to enable this console.
> +
>  config DEBUG_ICEDCC
>  	bool "Kernel low-level debugging via EmbeddedICE DCC channel"
>  	depends on DEBUG_LL
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 79087dd..d0e40b7 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -52,5 +52,6 @@ endif
>  
>  head-y			:= head$(MMUEXT).o
>  obj-$(CONFIG_DEBUG_LL)	+= debug.o
> +obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
>  extra-y := $(head-y) init_task.o vmlinux.lds
> diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> new file mode 100644
> index 0000000..85aa2b2
> --- /dev/null
> +++ b/arch/arm/kernel/early_printk.c
> @@ -0,0 +1,57 @@
> +/*
> + *  linux/arch/arm/kernel/early_printk.c
> + *
> + *  Copyright (C) 2009 Sascha Hauer <s.hauer@pengutronix.de>
<nitpick>
remove one space before "linux" and "Copyright"
</nitpick>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/console.h>
> +#include <linux/init.h>
> +
> +extern void printch(int);
> +
> +static void early_write(const char *s, unsigned n)
> +{
> +	while (n-- > 0) {
> +		if (*s == '\n')
> +			printch('\r');
> +		printch(*s);
> +		s++;
> +	}
> +}
Can you better use uart_console_write here?  (If yes, don't forget to
select CONFIG_SERIAL_CORE.)

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
