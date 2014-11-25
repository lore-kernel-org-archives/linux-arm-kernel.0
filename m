From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Nov 2014 19:21:38 +0000
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <alpine.LFD.2.11.1411251357230.11690@knanqh.ubzr>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <alpine.LFD.2.11.1411251205500.11690@knanqh.ubzr>
 <20141125184609.GA29425@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1411251357230.11690@knanqh.ubzr>
Message-ID: <5474D6C2.7060904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/14 18:59, Nicolas Pitre wrote:
> On Tue, 25 Nov 2014, Lorenzo Pieralisi wrote:
>
>> On Tue, Nov 25, 2014 at 05:42:32PM +0000, Nicolas Pitre wrote:
>>> On Thu, 20 Nov 2014, Vincent Yang wrote:
>>>
>>>> The remote firmware(SCB) owns the SMP control. This MCPM driver gets
>>>> CPU/CLUSTER power up/down done by SCB over mailbox.
>>>>
>>>> Signed-off-by: Andy Green <andy.green@linaro.org>
>>>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>>>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>>>> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>>>> ---
>>>>   arch/arm/mach-mb86s7x/Makefile |   2 +-
>>>>   arch/arm/mach-mb86s7x/mcpm.c   | 360 +++++++++++++++++++++++++++++++++++++++++
>>>>   arch/arm/mach-mb86s7x/smc.S    |  27 ++++
>>>>   3 files changed, 388 insertions(+), 1 deletion(-)
>>>>   create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
>>>>   create mode 100644 arch/arm/mach-mb86s7x/smc.S
>>>>
>>>> diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
>>>> index 97640b6..b0fa34b 100644
>>>> --- a/arch/arm/mach-mb86s7x/Makefile
>>>> +++ b/arch/arm/mach-mb86s7x/Makefile
>>>> @@ -1 +1 @@
>>>> -obj-$(CONFIG_ARCH_MB86S7X)   += board.o
>>>> +obj-$(CONFIG_ARCH_MB86S7X)   += board.o mcpm.o smc.o
>>>> diff --git a/arch/arm/mach-mb86s7x/mcpm.c b/arch/arm/mach-mb86s7x/mcpm.c
>>>> new file mode 100644
>>>> index 0000000..bf1b50a
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-mb86s7x/mcpm.c
>>>> @@ -0,0 +1,360 @@
>>>> +/*
>>>> + * arch/arm/mach-mb86s7x/mcpm.c
>>>> + * Copyright:        (C) 2013-2014 Fujitsu Semiconductor Limited
>>>> + * Copyright:        (C) 2014 Linaro Ltd.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <linux/io.h>
>>>> +#include <linux/pm.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/cpu_pm.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/arm-cci.h>
>>>> +#include <linux/spinlock.h>
>>>> +#include <linux/suspend.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/irqchip/arm-gic.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#include <soc/mb86s7x/scb_mhu.h>
>>>> +
>>>> +#include <asm/mcpm.h>
>>>> +#include <asm/cp15.h>
>>>> +#include <asm/cputype.h>
>>>> +#include <asm/suspend.h>
>>>> +#include <asm/idmap.h>
>>>> +
>>>> +#define S7X_MAX_CLUSTER      2
>>>> +#define S7X_MAX_CPU  2
>>>> +
>>>> +#define MHU_SHM_OFFSET               0x3800
>>>> +#define WFI_COLOR_OFFSET     0x3f00
>>>> +#define TRAMPOLINE_OFFSET    0x3c00
>>>> +#define RESET_OFFSET         (TRAMPOLINE_OFFSET + 0x3fc)
>>>> +
>>>> +static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
>>>> +static int mb86s7x_pm_use_count[S7X_MAX_CLUSTER][S7X_MAX_CPU];
>>>> +extern void __iomem *mb86s7x_shm_base;
>>>> +
>>>> +#define AT_WFI_DO_NOTHING    0x0
>>>> +#define AT_WFI_DO_SUSPEND    0x1
>>>> +#define AT_WFI_DO_POWEROFF   0x2
>>>> +#define AT_WFI_COLOR_MASK    0x3
>>>> +
>>>> +struct mb86s7x_cpu_gate {
>>>> +     u32 payload_size;
>>>> +     u32 cluster_class;
>>>> +     u32 cluster_id;
>>>> +     u32 cpu_id;
>>>> +#define SCB_CPU_STATE_OFF    0x0
>>>> +#define SCB_CPU_STATE_ON     0x1
>>>> +#define SCB_CPU_STATE_SUSP   0x2
>>>> +     u32 cpu_state;
>>>> +};
>>>> +
>>>> +asmlinkage void mb86s70evb_outer_flush_all(void)
>>>> +{
>>>> +     outer_flush_all();
>>>> +}
>>>> +
>>>> +#define mb86s70evb_exit_coherency_flush(level) { \
>>>> +     asm volatile( \
>>>> +     "stmfd  sp!, {fp, ip}\n\t" \
>>>> +     "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
>>>> +     "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
>>>> +     "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
>>>> +     "isb\n\t" \
>>>> +     "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
>>>> +     "bl     mb86s70evb_outer_flush_all\n\t" \
>>>
>>> This is wrong.  As mentioned already, this unconditionally flushes L2 in
>>> all cases which shouldn't be necessary in the "louis" case.
>>
>> Is this a bL system with unified and architected L2s ? I think so, so
>> what's the outercache for ?
>>
>>> Furthermore, the safety of this macro is ensured by not having any
>>> memory writes in the middle of the whole sequence.  By calling
>>> mb86s70evb_outer_flush_all() there could be the return address pushed
>>> onto the stack before calling outer_flush_all() if some tail call
>>> optimization is not applied.  And this is without saying what
>>> outer_flush_all() actually does.
>>>
>>> Why can't you simply do this instead:
>>>
>>>          v7_exit_coherency_flush(all);
>>>          outer_flush_all();
>>>
>>> Of course you'll have to audit everything in the outer_flush_all() path
>>> to make sure no atomic instructions such as LDREX/STREX are invoked.
>>> Those have undefined behavior after CR_C is cleared.
>>
>> What you are saying is correct but first of all I would like to
>> understand what outercache we are talking about here.
>>
>> Code snippet above is fragile, as you said, and I'd rather disable
>> the outercache before executing the power down sequence (which implies
>> cache is cleaned/invalidated and quiescent before we clear the C bit)
>> if there is an outercache to be managed.
>
> Good question.  That opens the potential for an even simpler fix!  ;-)
>
Ah right, sorry my bad somehow I assumed this is system cache at higher
level apart from the intra-cluster unified and architected L2 cache.
Now checking the DT again I don't see any outer cache controller, so
it's better to get that info.

Regards,
Sudeep
