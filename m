From: ian.campbell@citrix.com (Ian Campbell)
Date: Thu, 1 Oct 2015 09:47:11 +0100
Subject: "clk: sunxi: Add a simple gates driver" breaks kernel with older DTB
Message-ID: <1443689231.16718.225.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting a recent kernel with the DTB supplied with Debian Jessie (3.16
based) breaks on Cubietruck because that DTB lacks the clock-indices nodes
which the new driver from the commit below adds (replacing the hardcoding
which used to be in clk-sunxi.c).

It is panicing in drivers/clocksource/timer-sun5i.c with:

[    0.015413] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.025049] Kernel panic - not syncing: Can't get timer clock
[    0.030794] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-rc2-arm-native+ #6
[    0.038002] Hardware name: Allwinner sun7i (A20) Family
[    0.043253] [<c0219794>] (unwind_backtrace) from [<c0214e44>] (show_stack+0x10/0x14)
[    0.050992] [<c0214e44>] (show_stack) from [<c048159c>] (dump_stack+0x88/0x98)
[    0.058213] [<c048159c>] (dump_stack) from [<c02caa98>] (panic+0xa4/0x22c)
[    0.065090] [<c02caa98>] (panic) from [<c0d7c518>] (sun5i_timer_init+0x80/0x384)
[    0.072482] [<c0d7c518>] (sun5i_timer_init) from [<c0d7aad0>] (clocksource_of_init+0x4c/0x8c)
[    0.081001] [<c0d7aad0>] (clocksource_of_init) from [<c0d39b48>] (start_kernel+0x28c/0x3c4)
[    0.089343] [<c0d39b48>] (start_kernel) from [<4020807c>] (0x4020807c)
[    0.095866] ---[ end Kernel panic - not syncing: Can't get timer clock

Reverting ee38b2698ae2 fixes this specific issue for me (it boots further,
but there seems to be other problems later when earlycon hands over to
proper console, which I've not yet looked into).

Is this considered acceptable linkage between the kernel and the dtbs?

I suspect that even if anyone does care this is going to be an uphill
struggle for that minority so I'm going to adjust our test infrastructure
to pickup the dtbs from the kernel it is trying to test rather then reusing
the one from the OS install.

Ian.

commit ee38b2698ae234c03f65ccafa1811d4dda3c316d
Author: Maxime Ripard <maxime.ripard@free-electrons.com>
Date:   Fri Jul 31 19:46:22 2015 +0200

    clk: sunxi: Add a simple gates driver
    
    The gates were handled with a common piece of framework that was
    registering all gates array, that was not using the CLK_OF_DECLARE logic,
    and was not using clock-indices but some private masks that were pretty
    much equivalent.
    
    Move this code in a new driver that handles all the gates array and solves
    both these issues.
    
    Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
    Signed-off-by: Michael Turquette <mturquette@baylibre.com>
    [sboyd at codeaurora.org: Include clk.h for consumer API usage]
    Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
