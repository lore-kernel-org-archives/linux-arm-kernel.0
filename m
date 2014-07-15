From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Jul 2014 12:11:49 -0400 (EDT)
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
 <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407151154450.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jul 2014, Rob Herring wrote:

> Adding Nico for cluster PM code.

Thanks.

This really ought to be split into smaller patches.

[...]

> > index 0000000..86d223f
> > --- /dev/null
> > +++ b/arch/arm/mach-mb86s7x/mcpm.c
> > @@ -0,0 +1,293 @@
> > +/*
> > + * arch/arm/mach-mb86s7x/mcpm.c
> > + *
> > + * "Inspired" by tc_pm.c
> > + * Copyright:  (C) 2013-2014  Fujitsu Semiconductor Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/pm.h>
> > +#include <linux/delay.h>
> > +#include <linux/kernel.h>
> > +#include <linux/reboot.h>
> > +#include <linux/arm-cci.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/irqchip/arm-gic.h>
> > +#include <linux/platform_data/mb86s7x_mbox.h>
> > +
> > +#include <asm/mcpm.h>
> > +#include <asm/cp15.h>
> > +#include <asm/cputype.h>
> > +#include <asm/system_misc.h>
> > +
> > +#include "iomap.h"
> > +
> > +static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> 
> You should not be using arch_spinlock_t directly.

Depends.  See comment from line 48 in arch/arm/mach-vexpress/tc2_pm.c.

> > +static int mb86s7x_pm_use_count[2][2];
> > +
> > +#define MB86S7X_WFICOLOR_VIRT (MB86S7X_ISRAM_VIRT + WFI_COLOR_REG_OFFSET)
> > +
> > +static void mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr)
> > +{
> > +       u8 val;
> > +
> > +       if (clr & ~AT_WFI_COLOR_MASK)
> > +               return;
> > +
> > +       val = readb_relaxed(MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
> > +       val &= ~AT_WFI_COLOR_MASK;
> > +       val |= clr;
> > +       writeb_relaxed(val, MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
> > +}
> > +
> > +static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
> > +{
> > +       struct completion got_rsp;
> > +       int ret = 0;
> > +
> > +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> > +
> > +       arch_spin_lock(&mb86s7x_pm_lock);

This is called in a preemptible context so local_irq_disable() has to be 
used before arch_spin_lock().  There is no combined operator for it.

> > +       mb86s7x_pm_use_count[cpu][cluster]++;
> > +
> > +       if (mb86s7x_pm_use_count[cpu][cluster] == 1) {
> > +               struct mb86s7x_cpu_gate cmd;
> > +
> > +               arch_spin_unlock(&mb86s7x_pm_lock);
> 
> Can't you use atomic operations here (i.e. atomic_inc_return) instead of a lock?

There is more than the count that has to be atomic.

> In any case, Nicolas should review the cluster PM code if he hasn't
> already. As Arnd pointed out, this patch should be split up into
> multiple patches. I'd suggest splitting into DT bindings, DTS files,
> base support, mailbox, MCPM, and PM domains.

Agreed.


Nicolas
