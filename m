From: muddogxp@gmail.com (Xinyu Chen)
Date: Fri, 26 Nov 2010 22:16:47 +0800
Subject: [PATCH 03/15] ARM: mxs: Add reset routines
In-Reply-To: <19695.36407.793411.550458@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
	<19695.32386.279224.624305@ipc1.ka-ro>
	<20101126095733.GA27637@pengutronix.de>
	<19695.36407.793411.550458@ipc1.ka-ro>
Message-ID: <AANLkTik-di9Kkwv9sPHvUumyQRufL4r_TsyQuksyPPqF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar

2010/11/26 Lothar Wa?mann <LW@karo-electronics.de>:
> Hi,
>
> Uwe Kleine-K?nig writes:
>> On Fri, Nov 26, 2010 at 10:31:46AM +0100, Lothar Wa?mann wrote:
>> > Shawn Guo writes:
>> > [...]
>> > > diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
>> > > new file mode 100644
>> > > index 0000000..de33c66
>> > > --- /dev/null
>> > > +++ b/arch/arm/mach-mxs/system.c
>> > > @@ -0,0 +1,152 @@
>> > > +/*
>> > > + * Copyright (C) 1999 ARM Limited
>> > > + * Copyright (C) 2000 Deep Blue Solutions Ltd
>> > > + * Copyright 2006-2007,2010 Freescale Semiconductor, Inc. All Rights Reserved.
>> > > + * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
>> > > + * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok at emcraft.com
>> > > + *
>> > > + * This program is free software; you can redistribute it and/or modify
>> > > + * it under the terms of the GNU General Public License as published by
>> > > + * the Free Software Foundation; either version 2 of the License, or
>> > > + * (at your option) any later version.
>> > > + *
>> > > + * This program is distributed in the hope that it will be useful,
>> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> > > + * GNU General Public License for more details.
>> > > + */
>> > > +
>> > > +#include <linux/kernel.h>
>> > > +#include <linux/clk.h>
>> > > +#include <linux/io.h>
>> > > +#include <linux/err.h>
>> > > +#include <linux/delay.h>
>> > > +
>> > > +#include <asm/proc-fns.h>
>> > > +#include <asm/system.h>
>> > > +
>> > > +#include <mach/hardware.h>
>> > > +#include <mach/common.h>
>> > > +
>> > > +#define MXS_RTC_WATCHDOG 0x50
>> > > +#define MXS_WATCHDOG_EN ? ? ? ? ?(1 << 4)
>> > > +
>> > > +#define MXS_MODULE_CLKGATE ? ? ? (1 << 30)
>> > > +#define MXS_MODULE_SFTRST ? ? ? ?(1 << 31)
>> > > +
>> > > +static void __iomem *wdog_base;
>> > > +
>> > > +/*
>> > > + * Reset the system. It is called by machine_restart().
>> > > + */
>> > > +void arch_reset(char mode, const char *cmd)
>> > > +{
>> > > + struct clk *clk;
>> > > +
>> > > + clk = clk_get_sys("rtc", NULL);
>> > > + if (!IS_ERR(clk))
>> > > + ? ? ? ? clk_enable(clk);
>> > > +
>> > >
>> > Since arch_reset() may be called from interrupt context (e.g. due to
>> > SYSRQ-B) it must not call any functions that may sleep like clk_get*()
>> > or clk_enable(). The clock should be acquired and enabled in the init
>> > routine.
>> This is a problem that also exist in arch/arm/plat-mxc/system.c's
>> arch_reset.
>>
>> Did you already verify that this is indeed a problem? ?I guess there are
>> more architectures that use clk_get in arch_reset, aren't there?
>>
> If you consider this a problem:
> BUG: sleeping function called from invalid context at /usr/local/src/arm-linux/kernel/mutex.c:
> 280
> in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper
> 2 locks held by swapper/0:
> ?#0: ?(&port_lock_key){-.-...}, at: [<c01aed10>] imx_rxint+0x24/0x20c
> ?#1: ?(sysrq_key_table_lock){-.....}, at: [<c01a8e14>] __handle_sysrq+0x20/0x170
> irq event stamp: 130658
> hardirqs last ?enabled at (130657): [<c0027f80>] default_idle+0x2c/0x3c
> hardirqs last disabled at (130658): [<c0026a74>] __irq_svc+0x34/0xa8
> softirqs last ?enabled at (130648): [<c004bc1c>] __do_softirq+0x144/0x164
> softirqs last disabled at (130637): [<c004bc9c>] irq_exit+0x60/0xb4
> Backtrace:
> [<c002aee0>] (dump_backtrace+0x0/0x114) from [<c0260240>] (dump_stack+0x18/0x1c)
> ?r7:00000000 r6:c0326000 r5:00000000 r4:c0326000
> [<c0260228>] (dump_stack+0x0/0x1c) from [<c0041930>] (__might_sleep+0x11c/0x13c)
> [<c0041814>] (__might_sleep+0x0/0x13c) from [<c026181c>] (mutex_lock_nested+0x34/0x31c)
> ?r4:c032afd4
> [<c02617e8>] (mutex_lock_nested+0x0/0x31c) from [<c003097c>] (clk_get_sys+0x30/0xe8)
> [<c003094c>] (clk_get_sys+0x0/0xe8) from [<c00338c8>] (arch_reset+0x18/0x8c)
> [<c00338b0>] (arch_reset+0x0/0x8c) from [<c0028564>] (arm_machine_restart+0x2c/0x5c)
> ?r5:00000000 r4:00000068
> [<c0028538>] (arm_machine_restart+0x0/0x5c) from [<c0027f3c>] (machine_restart+0x20/0x28)
> ?r5:d186b9c0 r4:00000062
> [<c0027f1c>] (machine_restart+0x0/0x28) from [<c0056db8>] (emergency_restart+0x14/0x18)
> [<c0056da4>] (emergency_restart+0x0/0x18) from [<c01a9220>] (sysrq_handle_reboot+0x24/0x28)
> [<c01a91fc>] (sysrq_handle_reboot+0x0/0x28) from [<c01a8eb4>] (__handle_sysrq+0xc0/0x170)
> [<c01a8df4>] (__handle_sysrq+0x0/0x170) from [<c01a8fd4>] (handle_sysrq+0x34/0x40)
> [<c01a8fa0>] (handle_sysrq+0x0/0x40) from [<c01aedd8>] (imx_rxint+0xec/0x20c)
> [<c01aecec>] (imx_rxint+0x0/0x20c) from [<c01aef20>] (imx_int+0x28/0x68)
> [<c01aeef8>] (imx_int+0x0/0x68) from [<c007a794>] (handle_IRQ_event+0x2c/0x100)
> ?r7:0000002d r6:00000000 r5:00000000 r4:d1eab800
> [<c007a768>] (handle_IRQ_event+0x0/0x100) from [<c007c4fc>] (handle_level_irq+0xbc/0x120)
> ?r7:d1eab800 r6:c03340b8 r5:0000002d r4:c033407c
> [<c007c440>] (handle_level_irq+0x0/0x120) from [<c0026070>] (_text+0x70/0x8c)
> ?r7:00000002 r6:002d0000 r5:00000000 r4:0000002d
> [<c0026000>] (_text+0x0/0x8c) from [<c0026a94>] (__irq_svc+0x54/0xa8)
> Exception stack(0xc0327f48 to 0xc0327f90)
> 7f40: ? ? ? ? ? ? ? ? ? 00000001 0016e240 20000093 20000013 c0326000 c032aaa8
> 7f60: c03541e4 c032aaa0 8001ecc4 41069264 8001ec90 c0327f9c c0327f68 c0327f90
> 7f80: c006c620 c0027f8c 20000013 ffffffff
> ?r5:fc400000 r4:0000001f
> [<c0027f54>] (default_idle+0x0/0x3c) from [<c00284dc>] (cpu_idle+0x70/0xcc)
> [<c002846c>] (cpu_idle+0x0/0xcc) from [<c025d338>] (rest_init+0x70/0x84)
> ?r7:c032aaa0 r6:c0020e14 r5:c0020e18 r4:c0853ad8
> [<c025d2c8>] (rest_init+0x0/0x84) from [<c00089a4>] (start_kernel+0x280/0x2d8)
> [<c0008724>] (start_kernel+0x0/0x2d8) from [<80008034>] (0x80008034)
> ?r5:c0354284 r4:00053175
> ------------[ cut here ]------------
> WARNING: at /usr/local/src/arm-linux/kernel/mutex.c:207 mutex_lock_nested+0xb4/0x31c()
> Modules linked in:
> Backtrace:
> [<c002aee0>] (dump_backtrace+0x0/0x114) from [<c0260240>] (dump_stack+0x18/0x1c)
> ?r7:c02e09d3 r6:000000cf r5:c026189c r4:00000000
> [<c0260228>] (dump_stack+0x0/0x1c) from [<c004682c>] (warn_slowpath_common+0x50/0x68)
> [<c00467dc>] (warn_slowpath_common+0x0/0x68) from [<c004685c>] (warn_slowpath_null+0x18/0x1c)
> ?r7:00000000 r6:c0326000 r5:c0329868 r4:c032afd4
> [<c0046844>] (warn_slowpath_null+0x0/0x1c) from [<c026189c>] (mutex_lock_nested+0xb4/0x31c)
> [<c02617e8>] (mutex_lock_nested+0x0/0x31c) from [<c003097c>] (clk_get_sys+0x30/0xe8)
> [<c003094c>] (clk_get_sys+0x0/0xe8) from [<c00338c8>] (arch_reset+0x18/0x8c)
> [<c00338b0>] (arch_reset+0x0/0x8c) from [<c0028564>] (arm_machine_restart+0x2c/0x5c)
> ?r5:00000000 r4:00000068
> [<c0028538>] (arm_machine_restart+0x0/0x5c) from [<c0027f3c>] (machine_restart+0x20/0x28)
> ?r5:d186b9c0 r4:00000062
> [<c0027f1c>] (machine_restart+0x0/0x28) from [<c0056db8>] (emergency_restart+0x14/0x18)
> [<c0056da4>] (emergency_restart+0x0/0x18) from [<c01a9220>] (sysrq_handle_reboot+0x24/0x28)
> [<c01a91fc>] (sysrq_handle_reboot+0x0/0x28) from [<c01a8eb4>] (__handle_sysrq+0xc0/0x170)
> [<c01a8df4>] (__handle_sysrq+0x0/0x170) from [<c01a8fd4>] (handle_sysrq+0x34/0x40)
> [<c01a8fa0>] (handle_sysrq+0x0/0x40) from [<c01aedd8>] (imx_rxint+0xec/0x20c)
> [<c01aecec>] (imx_rxint+0x0/0x20c) from [<c01aef20>] (imx_int+0x28/0x68)
> [<c01aeef8>] (imx_int+0x0/0x68) from [<c007a794>] (handle_IRQ_event+0x2c/0x100)
> ?r7:0000002d r6:00000000 r5:00000000 r4:d1eab800
> [<c007a768>] (handle_IRQ_event+0x0/0x100) from [<c007c4fc>] (handle_level_irq+0xbc/0x120)
> ?r7:d1eab800 r6:c03340b8 r5:0000002d r4:c033407c
> [<c007c440>] (handle_level_irq+0x0/0x120) from [<c0026070>] (_text+0x70/0x8c)
> ?r7:00000002 r6:002d0000 r5:00000000 r4:0000002d
> [<c0026000>] (_text+0x0/0x8c) from [<c0026a94>] (__irq_svc+0x54/0xa8)
> Exception stack(0xc0327f48 to 0xc0327f90)
> 7f40: ? ? ? ? ? ? ? ? ? 00000001 0016e240 20000093 20000013 c0326000 c032aaa8
> 7f60: c03541e4 c032aaa0 8001ecc4 41069264 8001ec90 c0327f9c c0327f68 c0327f90
> 7f80: c006c620 c0027f8c 20000013 ffffffff
> ?r5:fc400000 r4:0000001f
> [<c0027f54>] (default_idle+0x0/0x3c) from [<c00284dc>] (cpu_idle+0x70/0xcc)
> [<c002846c>] (cpu_idle+0x0/0xcc) from [<c025d338>] (rest_init+0x70/0x84)
> ?r7:c032aaa0 r6:c0020e14 r5:c0020e18 r4:c0853ad8
> [<c025d2c8>] (rest_init+0x0/0x84) from [<c00089a4>] (start_kernel+0x280/0x2d8)
> [<c0008724>] (start_kernel+0x0/0x2d8) from [<80008034>] (0x80008034)
> ?r5:c0354284 r4:00053175
> ---[ end trace b484fc13651ee6f1 ]---

could we use spin_lock but not mutex_lock in the clk_enable/disable?
I'm considering there may have drivers call clk enable/disable in the
irq context to done feature or save power.


-- 
Best Regards
Xinyu Chen
Freescale Semiconductor, MAD Linux
