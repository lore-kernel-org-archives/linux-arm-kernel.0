From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 23 Sep 2014 15:30:57 +0200
Subject: [PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on
 wake-up
In-Reply-To: <20140917121820.GR12361@n2100.arm.linux.org.uk>
References: <1410955036-1956-1-git-send-email-geert+renesas@glider.be>
 <20140917121820.GR12361@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdU+ztui5N-2p5Va7b7Tp-JRNVtGfNZ6=GPweR2ig_H5wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Sep 17, 2014 at 2:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 17, 2014 at 01:57:16PM +0200, Geert Uytterhoeven wrote:
>> If power area D4, which contains the Coresight-ETM hardware block, is
>> powered down on R-Mobile A1 (r8a7740), the kernel crashes when
>> suspending from s2ram with:
>>
>>     Internal error: Oops - undefined instruction: 0 [#1] ARM
>>
>> This happens because dbg_cpu_pm_notify() calls reset_ctrl_regs(), which
>> can't access the debug registers as the debug module is powered down.
>>
>> Protect the call to reset_ctrl_regs() by an undefined instruction hook,
>> like was done in commit 0d352e3d006c9589 ("ARM: hw_breakpoint: trap
>> undef instruction exceptions in reset_ctrl_regs") for another caller.
>
> I'd prefer a better solution to this (such as tracking whether the ETM
> block is powered down).  This feels very much like a hack than a good
> solution.

That seems to be something to fit into "[PATCH 00/11 v6] Coresight framework
and drivers" (https://lkml.org/lkml/2014/9/11/733)?

However, if I'm not mistaken, while that series introduces extensive handling
based on the presence of Coresight device nodes in DT, it looks like it doesn't
affect the current direct accesses to the debug registers in hw_breakpoint.c?

For now, do you consider it acceptable to introduce a global bool (defaulting
to true) to track whether accessing the debug registers is allowed?

> Also, the undefined instruction hook was not supposed to be used in this
> way - certainly *not* dynamically like this.  While the lookup of the
> undef handler is done in a safe atomic way, calling the resulting
> function is outside of the locks.

Right, that's definitely not optimal.
I guess this also applies to the existing (ab)users of debug_reg_hook?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
