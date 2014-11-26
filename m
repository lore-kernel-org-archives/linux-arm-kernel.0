From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 26 Nov 2014 21:59:50 +0530
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <20141125184609.GA29425@e102568-lin.cambridge.arm.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <alpine.LFD.2.11.1411251205500.11690@knanqh.ubzr>
 <20141125184609.GA29425@e102568-lin.cambridge.arm.com>
Message-ID: <CAJe_ZheX5KwraFMmuA+uMq95BprJVxaPSWjKd7gOjeEKLDXSdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2014 at 00:16, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Nov 25, 2014 at 05:42:32PM +0000, Nicolas Pitre wrote:
>> On Thu, 20 Nov 2014, Vincent Yang wrote:
>>
>> > The remote firmware(SCB) owns the SMP control. This MCPM driver gets
>> > CPU/CLUSTER power up/down done by SCB over mailbox.
>> >
>> > Signed-off-by: Andy Green <andy.green@linaro.org>
>> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> > Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> > Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>> > ---
>> >  arch/arm/mach-mb86s7x/Makefile |   2 +-
>> >  arch/arm/mach-mb86s7x/mcpm.c   | 360 +++++++++++++++++++++++++++++++++++++++++
>> >  arch/arm/mach-mb86s7x/smc.S    |  27 ++++
>> >  3 files changed, 388 insertions(+), 1 deletion(-)
>> >  create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
>> >  create mode 100644 arch/arm/mach-mb86s7x/smc.S
>> >
>> > diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
>> > index 97640b6..b0fa34b 100644
>> > --- a/arch/arm/mach-mb86s7x/Makefile
>> > +++ b/arch/arm/mach-mb86s7x/Makefile
>> > @@ -1 +1 @@
>> > -obj-$(CONFIG_ARCH_MB86S7X)   += board.o
>> > +obj-$(CONFIG_ARCH_MB86S7X)   += board.o mcpm.o smc.o
>> > diff --git a/arch/arm/mach-mb86s7x/mcpm.c b/arch/arm/mach-mb86s7x/mcpm.c
>> > new file mode 100644
>> > index 0000000..bf1b50a
>> > --- /dev/null
>> > +++ b/arch/arm/mach-mb86s7x/mcpm.c
>> > @@ -0,0 +1,360 @@
>> > +/*
>> > + * arch/arm/mach-mb86s7x/mcpm.c
>> > + * Copyright:        (C) 2013-2014 Fujitsu Semiconductor Limited
>> > + * Copyright:        (C) 2014 Linaro Ltd.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + */
>> > +
>> > +#include <linux/io.h>
>> > +#include <linux/pm.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/cpu_pm.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/module.h>
>> > +#include <linux/arm-cci.h>
>> > +#include <linux/spinlock.h>
>> > +#include <linux/suspend.h>
>> > +#include <linux/of_device.h>
>> > +#include <linux/irqchip/arm-gic.h>
>> > +#include <linux/platform_device.h>
>> > +
>> > +#include <soc/mb86s7x/scb_mhu.h>
>> > +
>> > +#include <asm/mcpm.h>
>> > +#include <asm/cp15.h>
>> > +#include <asm/cputype.h>
>> > +#include <asm/suspend.h>
>> > +#include <asm/idmap.h>
>> > +
>> > +#define S7X_MAX_CLUSTER      2
>> > +#define S7X_MAX_CPU  2
>> > +
>> > +#define MHU_SHM_OFFSET               0x3800
>> > +#define WFI_COLOR_OFFSET     0x3f00
>> > +#define TRAMPOLINE_OFFSET    0x3c00
>> > +#define RESET_OFFSET         (TRAMPOLINE_OFFSET + 0x3fc)
>> > +
>> > +static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
>> > +static int mb86s7x_pm_use_count[S7X_MAX_CLUSTER][S7X_MAX_CPU];
>> > +extern void __iomem *mb86s7x_shm_base;
>> > +
>> > +#define AT_WFI_DO_NOTHING    0x0
>> > +#define AT_WFI_DO_SUSPEND    0x1
>> > +#define AT_WFI_DO_POWEROFF   0x2
>> > +#define AT_WFI_COLOR_MASK    0x3
>> > +
>> > +struct mb86s7x_cpu_gate {
>> > +     u32 payload_size;
>> > +     u32 cluster_class;
>> > +     u32 cluster_id;
>> > +     u32 cpu_id;
>> > +#define SCB_CPU_STATE_OFF    0x0
>> > +#define SCB_CPU_STATE_ON     0x1
>> > +#define SCB_CPU_STATE_SUSP   0x2
>> > +     u32 cpu_state;
>> > +};
>> > +
>> > +asmlinkage void mb86s70evb_outer_flush_all(void)
>> > +{
>> > +     outer_flush_all();
>> > +}
>> > +
>> > +#define mb86s70evb_exit_coherency_flush(level) { \
>> > +     asm volatile( \
>> > +     "stmfd  sp!, {fp, ip}\n\t" \
>> > +     "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
>> > +     "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
>> > +     "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
>> > +     "isb\n\t" \
>> > +     "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
>> > +     "bl     mb86s70evb_outer_flush_all\n\t" \
>>
>> This is wrong.  As mentioned already, this unconditionally flushes L2 in
>> all cases which shouldn't be necessary in the "louis" case.
>
> Is this a bL system with unified and architected L2s ? I think so, so
> what's the outercache for ?
>
Yes, the CA15 has 1MB and CA7 256KB L2 cache, that's it.
This thing sneaked in via a patch from someone desperate to make
Suspend-To-Ram (not yet submitted) work and I failed to spot it. We
should remove the mb86s70evb_outer_flush_all()

Thanks,
Jassi
