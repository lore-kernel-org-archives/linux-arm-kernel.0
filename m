From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 15 Aug 2013 15:27:24 +0100
Subject: [PATCH] ARM: ARMv7-M: implement restart routine common to all
 v7-M machines
In-Reply-To: <20130814180133.GE30496@pengutronix.de>
References: <1376494625-25496-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <520BB3D1.1050205@arm.com> <20130814180133.GE30496@pengutronix.de>
Message-ID: <520CE54C.4000004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 19:01, Uwe Kleine-K?nig wrote:
> On Wed, Aug 14, 2013 at 05:44:01PM +0100, Jonathan Austin wrote:
>> On 14/08/13 16:37, Uwe Kleine-K?nig wrote:
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Do we get a commit message? ;)
> You did see the Subject line? I guess you did and it's not enough to
> understand it. The new function is used as .restart member of
> {DT_,}MACHINE_START.
>

Yea, I saw it but think it is always useful to have the commit message!

>>
>>> ---
>>>   arch/arm/include/asm/v7m.h   | 12 ++++++++++++
>>>   arch/arm/kernel/Makefile     |  2 +-
>>>   arch/arm/kernel/common-v7m.c | 19 +++++++++++++++++++
>>>   3 files changed, 32 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/arm/kernel/common-v7m.c
>>>
>>> diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
>>> index fa88d09..615781c 100644
>>> --- a/arch/arm/include/asm/v7m.h
>>> +++ b/arch/arm/include/asm/v7m.h
>>> @@ -15,6 +15,10 @@
>>>
>>>   #define V7M_SCB_VTOR			0x08
>>>
>>> +#define V7M_SCB_AIRCR			0x0c
>>> +#define V7M_SCB_AIRCR_VECTKEY			(0x05fa << 16)
>>> +#define V7M_SCB_AIRCR_SYSRESETREQ		(1 << 2)
>>> +
>>
>> These all look good, happy with the names too.
>>>   #define V7M_SCB_SCR			0x10
>>>   #define V7M_SCB_SCR_SLEEPDEEP			(1 << 2)
>>>
>>> @@ -42,3 +46,11 @@
>>>    */
>>>   #define EXC_RET_STACK_MASK			0x00000004
>>>   #define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
>>> +
>>> +#ifndef __ASSEMBLY__
>>> +
>>> +enum reboot_mode;
>>
>> Certainly worth introducing what the plans for this are in the long
>> run - but I suspect the commit message might have contained that
>> info?
>>
>>> +
>>> +void armv7m_restart(enum reboot_mode mode, const char *cmd);
>>> +
>>> +#endif /* __ASSEMBLY__ */
>>> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
>>> index 86d10dd..688b8be 100644
>>> --- a/arch/arm/kernel/Makefile
>>> +++ b/arch/arm/kernel/Makefile
>>> @@ -24,7 +24,7 @@ obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
>>>   obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
>>>
>>>   ifeq ($(CONFIG_CPU_V7M),y)
>>> -obj-y		+= entry-v7m.o
>>> +obj-y		+= entry-v7m.o common-v7m.o
>>>   else
>>>   obj-y		+= entry-armv.o
>>>   endif
>>> diff --git a/arch/arm/kernel/common-v7m.c b/arch/arm/kernel/common-v7m.c
>>> new file mode 100644
>>> index 0000000..4d2cba9
>>> --- /dev/null
>>> +++ b/arch/arm/kernel/common-v7m.c
>>
>> Is this really the right place for such a function? My immediate
>> thought is that such a thing belongs in proc-v7m.S
>>
>> Is this fitting in to a an existing framework or pattern that I'm missing?
> proc-v7m.S doesn't work as my function is coded in C :-)

Well, what you have at the moment is in C, but it certainly could be 
asm, might even be easier to read as asm ;)

That said, everyone else uses C, so there should be a place for it to go...

>
> Here are some other restart functions with the file they are defined in:
>
> davinci_restart   | arch/arm/mach-davinci/devices.c
> exynos4_restart   | arch/arm/mach-exynos/common.c
> highbank_restart  | arch/arm/mach-highbank/system.c
> mxc_restart       | arch/arm/mach-imx/system.c
> omap3xxx_restart  | arch/arm/mach-omap2/omap3-restart.c
> pxa_restart       | arch/arm/mach-pxa/reset.c
> versatile_restart | arch/arm/mach-versatile/core.c
>
> at91 doesn't seem to have a restart function.
>
> Hmm, I'm still happy with arch/arm/kernel/common-v7m.c.

What else might go in that file in time? It certainly breaks the pattern 
we see above - but then this is architectural not machine defined in V7M 
so that also makes sense...

How about arch/arm/kernel/v7m.c instead?


>
>>> @@ -0,0 +1,19 @@
>>> +/*
>>> + * Copyright (C) 2013 Uwe Kleine-Koenig for Pengutronix
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it under
>>> + * the terms of the GNU General Public License version 2 as published by the
>>> + * Free Software Foundation.
>>> + */
>>> +#include <linux/io.h>
>>> +#include <linux/reboot.h>
>>> +#include <asm/barrier.h>
>>> +#include <asm/v7m.h>
>>> +
>>> +void armv7m_restart(enum reboot_mode mode, const char *cmd)
>>> +{
>>> +	dsb();
>>> +	__raw_writel(V7M_SCB_AIRCR_VECTKEY | V7M_SCB_AIRCR_SYSRESETREQ,
>>> +			BASEADDR_V7M_SCB + V7M_SCB_AIRCR);

Are we definitely okay to ignore that reboot_mode value? I'm not sure 
what I would expect REBOOT_GPIO to mean in this case? or even the 
difference between REBOOT_SOFT? I think it looks like we can (certainly 
other people do!)

Jonny
