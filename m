From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 12 Nov 2010 13:43:55 -0500 (EST)
Subject: [PATCH 11/11] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <1289546260-6208-11-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-6-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-7-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-8-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-9-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-10-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-11-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <alpine.LFD.2.00.1011121257540.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Nov 2010, Haojian Zhuang wrote:

> iwmmxt is used in XScale, XScale3, Mohawk and PJ4 core. But the instructions
> of accessing CP0 and CP1 is changed in PJ4. Append more files to support
> iwmmxt in PJ4 core.
> 
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Comments below.

>  delete mode 100644 arch/arm/kernel/iwmmxt.S
>  create mode 100644 arch/arm/kernel/pj4-iwmmxt.S
>  create mode 100644 arch/arm/kernel/xscale-iwmmxt.S

According to your previous patch, the changes needed to iwmmxt.S were 
minimal.  Please don't duplicate the whole file just for this.

In retrospective I think I still prefer the #ifdef's for this file.  
Eventually we could use some dynamic kernel patching (we're getting 
good at it) when we'll want to support XScale and PJ4 with the same 
kernel binary.

So what you could do to make the code cleaner in iwmmxt.S is:

[...]
#if defined(CONFIG_CPU_PJ4)
#define PJ4(code...) code
#define XSC(code...)
#else
#define PJ4(code...)
#define XSC(code...) code
#endif

[...]

ENTRY(iwmmxt_task_switch)

   XSC(	mrc	p15, 0, r1, c15, c1, 0	)
   PJ4(	mrc	p15, 0, r1, c1, c0, 2	)
	@ CP0 and CP1 accessible?
   XSC(	tst	r1, #0x3		)
   PJ4(	tst	r1, #0xf		)	
        bne     1f                              @ yes: block them for next task
[...]

This way the code is pretty readable, and that paves the way for a 
future dynamic patching capability.

> --- /dev/null
> +++ b/arch/arm/kernel/pj4-cp0.c
> @@ -0,0 +1,180 @@
> +/*
> + * linux/arch/arm/kernel/pj4-cp0.c
> + *
> + * XScale DSP and iWMMXt coprocessor context switching and handling
> + *
> + * Copyright (c) 2010 Marvell International Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <asm/thread_notify.h>
> +
> +static inline void dsp_save_state(u32 *state)
> +{

Do you really need this?  The "dsp" stuff was to support early XScale 
versions which had only an accumulator and not the full iwmmx support.  
Therefore you should only keep the appropriate iwmmxt notifier block and 
get 
rid of the "dsp" one.

[...]
> +/*
> + * Detect whether we have a MAC coprocessor (40 bit register) or an
> + * iWMMXt coprocessor (64 bit registers) by loading 00000100:00000000
> + * into a coprocessor register and reading it back, and checking
> + * whether the upper word survived intact.
> + */
> +static int __init cpu_has_iwmmxt(void)
> +{

And obviously you don't need this anymore either.

> +/*
> + * If we detect that the CPU has iWMMXt (and CONFIG_IWMMXT=y), we
> + * disable CP0/CP1 on boot, and let call_fpe() and the iWMMXt lazy
> + * switch code handle iWMMXt context switching.  If on the other
> + * hand the CPU has a DSP coprocessor, we keep access to CP0 enabled
> + * all the time, and save/restore acc0 on context switch in non-lazy
> + * fashion.
> + */
> +static int __init pj4_cp0_init(void)
> +{

The first case described in the comment above should be unconditional 
with a 
PJ4, obviously.  Therefore this code and comment need to be reworked as 
well.


Nicolas
