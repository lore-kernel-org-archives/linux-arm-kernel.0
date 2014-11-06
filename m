From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 06 Nov 2014 21:04:21 +0100
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
In-Reply-To: <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Thu, 6 Nov 2014 12:45:02
 +0400")
References: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
 <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
Message-ID: <87lhnoxfi2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Hello,
>
> Tested in qemu (pxa25x target).
Excellent.

>
> 0) Had to revert 23c4a3a5212701ad34bd30591fa33d7bacef9c5f to get kernel
> to build for pxa25x + pxa27x.
Yes, good move.

> 1) I got the following backtrace early in the boot:
>
> Division by zero in kernel.
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc2-00011-g7805b78 #97
> [<c000e028>] (unwind_backtrace) from [<c000c0b4>] (show_stack+0x10/0x14)
> [<c000c0b4>] (show_stack) from [<c01a3af0>] (Ldiv0+0x8/0x10)
> [<c01a3af0>] (Ldiv0) from [<c029bb9c>] (clk_pxa25x_memory_get_rate+0x28/0x30)
> [<c029bb9c>] (clk_pxa25x_memory_get_rate) from [<c029b114>]
> (clk_composite_recalc_rate+0x20/0x24)
> [<c029b114>] (clk_composite_recalc_rate) from [<c0299888>]
> (__clk_init+0x1d0/0x4e8)
> [<c0299888>] (__clk_init) from [<c0299d24>] (clk_register+0x100/0x1c4)
> [<c0299d24>] (clk_register) from [<c029b518>]
> (clk_register_composite+0x17c/0x250)
> [<c029b518>] (clk_register_composite) from [<c04cecd4>]
> (pxa25x_clocks_init+0x194/0x240)
> [<c04cecd4>] (pxa25x_clocks_init) from [<c04c048c>] (pxa_timer_init+0x18/0x64)
> [<c04c048c>] (pxa_timer_init) from [<c04bde88>] (time_init+0x1c/0x2c)
> [<c04bde88>] (time_init) from [<c04bbb14>] (start_kernel+0x268/0x3e8)
> [<c04bbb14>] (start_kernel) from [<a0008040>] (0xa0008040)
>
> It might be due to something being not emulated properly, but I'd
> suggest to add a check
> anyway.
You're right about that part. According to the specification, the "M" multiplier
in CCCR can only be 1, 2, or 3. 0 is a reserved value which should never happen,
and if it happens, hardware is already lost.
I don't want to be that defensive in this code unless it blocks something for
good.

> 2) sa1100-rtc could not find a clock and thus failed to be probed.
Ha I'll check that, thanks.

> 3) Had to patch tc6393xb driver to call
> clk_prepare_enable/clk_disable_unprepare -
>   will submit a patch shortly.
Good catch.

> 4) Got an issue with IrDA driver - it gets -ENODEV for UARTCLK clock
I'll check that too. It's probable I either forgot a clock or mispelled a
clock.

Thanks for the test Dmitry.

Cheers.

-- 
Robert
