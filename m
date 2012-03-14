From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 17:39:41 +0000
Subject: [PATCH v4 09/15] ARM: ux500: convert to twd_local_timer_register()
 interface
In-Reply-To: <CANmRt2gjhg-nznAOxQHA1g7EX+F4uEjp1nW5iT3Rtw4s8y5uGg@mail.gmail.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-10-git-send-email-marc.zyngier@arm.com>
 <CANmRt2gjhg-nznAOxQHA1g7EX+F4uEjp1nW5iT3Rtw4s8y5uGg@mail.gmail.com>
Message-ID: <4F60D7DD.50705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/12 17:12, Lee Jones wrote:
> Add support for the new smp_twd runtime registration interface
> to the ux500 platforms, and remove the old compile-time support.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org
> <mailto:linus.walleij@linaro.org>>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>>
> ---
>  arch/arm/mach-ux500/Makefile     |    1 -
>  arch/arm/mach-ux500/cpu.c        |    1 -
>  arch/arm/mach-ux500/localtimer.c |   29 -----------------------------
>  arch/arm/mach-ux500/timer.c      |   32 +++++++++++++++++++++++++-------
>  4 files changed, 25 insertions(+), 38 deletions(-)
>  delete mode 100644 arch/arm/mach-ux500/localtimer.c
> 
> diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
> index 6bd2f45..35b3894 100644
> --- a/arch/arm/mach-ux500/Makefile
> +++ b/arch/arm/mach-ux500/Makefile
> @@ -15,7 +15,6 @@ obj-$(CONFIG_MACH_U8500)      += board-mop500.o
> board-mop500-sdi.o \
>  obj-$(CONFIG_MACH_U5500)       += board-u5500.o board-u5500-sdi.o
>  obj-$(CONFIG_SMP)              += platsmp.o headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)      += hotplug.o
> -obj-$(CONFIG_LOCAL_TIMERS)     += localtimer.o
>  obj-$(CONFIG_U5500_MODEM_IRQ)  += modem-irq-db5500.o
>  obj-$(CONFIG_U5500_MBOX)       += mbox-db5500.o
> 
> diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> index f418574..851308b 100644
> --- a/arch/arm/mach-ux500/cpu.c
> +++ b/arch/arm/mach-ux500/cpu.c
> @@ -14,7 +14,6 @@
> 
>  #include <asm/hardware/gic.h>
>  #include <asm/mach/map.h>
> -#include <asm/localtimer.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/setup.h>
> diff --git a/arch/arm/mach-ux500/localtimer.c
> b/arch/arm/mach-ux500/localtimer.c
> deleted file mode 100644
> index 5ba1133..0000000
> --- a/arch/arm/mach-ux500/localtimer.c
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * Copyright (C) 2008-2009 ST-Ericsson
> - * Srinidhi Kasagar <srinidhi.kasagar@stericsson.com
> <mailto:srinidhi.kasagar@stericsson.com>>
> - *
> - * This file is heavily based on relaview platform, almost a copy.
> - *
> - * Copyright (C) 2002 ARM Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/init.h>
> -#include <linux/smp.h>
> -#include <linux/clockchips.h>
> -
> -#include <asm/irq.h>
> -#include <asm/smp_twd.h>
> -#include <asm/localtimer.h>
> -
> -/*
> - * Setup the local clock events for a CPU.
> - */
> -int __cpuinit local_timer_setup(struct clock_event_device *evt)
> -{
> -       evt->irq = IRQ_LOCALTIMER;
> -       twd_timer_setup(evt);
> -       return 0;
> -}
> diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
> index aea467d..cadf982 100644
> --- a/arch/arm/mach-ux500/timer.c
> +++ b/arch/arm/mach-ux500/timer.c
> @@ -8,27 +8,44 @@
>  #include <linux/errno.h>
>  #include <linux/clksrc-dbx500-prcmu.h>
> 
> -#include <asm/localtimer.h>
> +#include <asm/smp_twd.h>
> 
>  #include <plat/mtu.h>
> 
>  #include <mach/setup.h>
>  #include <mach/hardware.h>
> 
> +#ifdef CONFIG_HAVE_ARM_TWD
> +static DEFINE_TWD_LOCAL_TIMER(u5500_twd_local_timer,
> +                             U5500_TWD_BASE, IRQ_LOCALTIMER);
> +static DEFINE_TWD_LOCAL_TIMER(u8500_twd_local_timer,
> +                             U8500_TWD_BASE, IRQ_LOCALTIMER);

I think you need to include 'mach/irqs.h' or similar for IRQ_LOCALTIMER.

> +
> +static void __init ux500_twd_init(void)
> +{
> +       struct twd_local_timer *twd_local_timer;
> +       int err;
> +
> +       twd_local_timer = cpu_is_u5500() ? &u5500_twd_local_timer :
> +                                          &u8500_twd_local_timer;
> +
> +       err = twd_local_timer_register(twd_local_timer);
> +       if (err)
> +               pr_err("twd_local_timer_register failed %d\n", err);

Again, this is missing it's declaration from the above includes.

> +}
> +#else
> +#define ux500_twd_init()       do { } while(0)
> +#endif
> +
>  static void __init ux500_timer_init(void)
>  {
>        void __iomem *prcmu_timer_base;
> +       int err;

This appears to be unused.

>        if (cpu_is_u5500()) {
> -#ifdef CONFIG_LOCAL_TIMERS
> -               twd_base = __io_address(U5500_TWD_BASE);
> -#endif
>                mtu_base = __io_address(U5500_MTU0_BASE);
>                prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
>        } else if (cpu_is_u8500()) {
> -#ifdef CONFIG_LOCAL_TIMERS
> -               twd_base = __io_address(U8500_TWD_BASE);
> -#endif
>                mtu_base = __io_address(U8500_MTU0_BASE);
>                prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
>        } else {
> @@ -54,6 +71,7 @@ static void __init ux500_timer_init(void)
> 
>        nmdk_timer_init();
>        clksrc_dbx500_prcmu_init(prcmu_timer_base);
> +       ux500_twd_init();
>  }
> 
>  static void ux500_timer_reset(void)
> --
> 1.7.7.1

NAK: Won't build. :(

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
