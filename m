From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Jul 2017 12:12:30 +0200
Subject: [PATCH 1/2] ARM: shmobile: Add CA7 arch_timer initialization for
 secondary CPUs
In-Reply-To: <af12382f-4953-44fd-8f61-0aad2c309476@arm.com>
References: <1499187733-1430-1-git-send-email-geert+renesas@glider.be>
 <1499187733-1430-2-git-send-email-geert+renesas@glider.be>
 <2f7ef764-c511-9598-c136-13966f810c95@arm.com>
 <CAMuHMdXFAZ2Gvgk7oJhkQo7ygCKE_MPqtypccwqj9NTW30q57A@mail.gmail.com>
 <af12382f-4953-44fd-8f61-0aad2c309476@arm.com>
Message-ID: <CAMuHMdU7RCd=xK4ttTem0Ev-TfaN=ynDdt6dNikSb4dvW=UTDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Jul 5, 2017 at 12:07 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 04/07/17 19:20, Geert Uytterhoeven wrote:
>> On Tue, Jul 4, 2017 at 7:32 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 04/07/17 18:02, Geert Uytterhoeven wrote:
>>>> On Cortex-A7, the arch timer CNTVOFF register is uninitialized.
>>>> Hence when enabling SMP on r8a7794, the kernel log is spammed with:
>>>>
>>>>     WARNING: Underflow in clocksource 'arch_sys_counter' observed, time update ignored.
>>>>            Please report this, consider using a different clocksource, if possible.
>>>>            Your kernel is probably still fine.
>>>>
>>>> To fix this, wrap the standard secondary_startup routine inside a
>>>> routine which initializes CNTVOFF when running on a Cortex-A7.
>>>> As the only possibilities are Cortex-A7 or Cortex-A15, checking the low
>>>> nibble of the Primary Part Number is sufficient.
>>>>
>>>> The initialization is identical to what is already done for the boot CPU
>>>> since commit 9ce3fa6816c2fb59 ("ARM: shmobile: rcar-gen2: Add CA7
>>>> arch_timer initialization for r8a7794").
>>>
>>> Humfff... Pretty horrible. Comments below.
>>
>> I know.  I suppose this should be done by the firmware/boot loader?
>
> That's what is normally expected.
>
>> But we have to live with firmware/boot loaders in the wild...
>
> Yeah, I can tell. It is a shame that firmware people didn't realize that
> just because the old firmware seems to work on a new revision of the
> architecture, it doesn't mean it does everything right for that
> particular revision... Oh well.
>
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-shmobile/headsmp-apmu.S
>>>> @@ -0,0 +1,38 @@
>>>> +/*
>>>> + * SMP support for APMU based systems
>>>> + *
>>>> + * Copyright (C) 2014  Renesas Electronics Corporation
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <linux/linkage.h>
>>>> +
>>>> +ENTRY(shmobile_boot_apmu)
>>>> +     mrc     p15, 0, r0, c0, c0, 0           /* Get Main ID */
>>>> +     ubfx    r1, r0, #4, #4                  /* r1=Lo 4bit of Primary Part */
>>>> +     cmp     r1, #0x7                        /* 0x7 = CA7, 0xf = CA15 */
>>>> +     bne     1f
>>>
>>> Why don't you deal with the A15 parts as well? And TBH, you'd be better
>>> off checking ID_PFR1 for both Generic Timers and Virtualization Extensions.
>>
>> Do we have to deal with the A15 parts here?
>> We're not having issues with the A15 parts, so that's why I left it out.
>
> Well, A15 has the exact same features as A7 when it comes to the timer,
> and CNTVOFF definitely resets as UNKNOWN.

IC.

>> I'm trying to understand what's different between A15 and A7, and why A7
>> needs this code, while A15 apparently doesn't.
>> I'm not seeing any obvious differences in the U-Boot sources handling
>> e.g. r8a7791/koelsch (dual A15) vs. r8a7794/alt (dual A7).
>
> The UNKNOWN above might well be 0 on A15, but I wouldn't bet on it. If
> nothing sets CNTVOFF on these systems, consider yourself lucky!

OK.  That means I can just drop the Primary Part check, as this code path
is exercised only on systems with Cortex-A15 and/or A7 CPU cores.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
