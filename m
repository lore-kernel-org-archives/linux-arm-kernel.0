From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 15 Jan 2014 10:15:57 +0100
Subject: v3.12 regression from "ARM: kirkwood: convert to DT irqchip and
 clocksource" on non-DT kirkwood platforms
In-Reply-To: <1389775235.10695.51.camel@dagon.hellion.org.uk>
References: <1389775235.10695.51.camel@dagon.hellion.org.uk>
Message-ID: <52D651CD.5020307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/14 09:40, Ian Campbell wrote:
> Debian kernel's have been suffering a hang on boot on kirkwood platforms
> since 3.12, http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=735172.
>
> The issue has been seen on various QNAP TS platforms, mine is a TS-419
> but TS-119 and TS-212's have also been seen to fail. In all cases this
> is using the legacy board file based support not the DT support (which
> is only for TS-219 so far in any case AFAIK, I am not using Andrew
> Lunn's DT patches for TS-41x).

Ian,

thanks for the detailed report below. I quickly checked your .config and
saw you have CONFIG_ARCH_KIRKWOOD_DT=y although I understand you are not
booting DT here.

There may be some interference with both non-DT/DT compiled in, I'll
check that later.

> The bootlogs are below or in the bug. It stops after "Console: colour
> dummy device 80x30", I think next would normally be the
> BogoMIPS/calibrate_delay output.

That would indicate the timer (clocksource) or irq (irqchip) is not
running correctly. Again, that could be non-DT and DT fighting for it.
I'll investigate that.

In the meantime, can you recompile your kernel and set
CONFIG_ARCH_KIRKWOOD_DT=n ?

Sebastian

> I bisected it down to:
>          commit 2326f04321a9aec591c1d159b3a9d12c2bf89438
>          Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>          Date:   Tue Jul 2 15:15:07 2013 +0200
>
>              ARM: kirkwood: convert to DT irqchip and clocksource
>
>              With recent support for true irqchip and clocksource drivers for Orion
>              SoCs, now make use of it on DT enabled Kirkwood boards.
>
>              This also introduces a new Kconfig option for legacy (non-DT) Kirkwood
>              where old code is moved out to and polishes DT board file a little bit.
>
>              Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>              Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>
> and reverting this on top of v3.12 allows the platform to boot
> successfully. I've also reproduced with v3.13-rc8 and the revert was not
> so trivial there, but I think I've done it right and it corrects the
> problem.
