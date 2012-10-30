From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Oct 2012 22:36:42 +0000
Subject: [PATCH] ARM: zynq: move ttc timer code to drivers/clocksource
In-Reply-To: <508FBBA5.2080707@monstr.eu>
References: <20121029185630.GA26149@beefymiracle.amer.corp.natinst.com>
 <508FBBA5.2080707@monstr.eu>
Message-ID: <201210302236.43473.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 October 2012, Michal Simek wrote:
> On 10/29/2012 07:56 PM, Josh Cartwright wrote:
> > Suggested cleanup by Arnd Bergmann.  Move the ttc timer.c code to
> > drivers/clocksource, and out of the mach-zynq directory.
> >
> > The common.h (which only held the timer declaration) was renamed to
> > xilinx_ttc.h and moved into include/linux.
> >
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   arch/arm/mach-zynq/Makefile      |   2 +-
> >   arch/arm/mach-zynq/common.c      |   2 +-
> >   arch/arm/mach-zynq/common.h      |  24 ----
> >   arch/arm/mach-zynq/timer.c       | 298 ---------------------------------------
> >   drivers/clocksource/Makefile     |   1 +
> >   drivers/clocksource/xilinx_ttc.c | 297 ++++++++++++++++++++++++++++++++++++++
> >   include/linux/xilinx_ttc.h       |  24 ++++
> >   7 files changed, 324 insertions(+), 324 deletions(-)

When you submit a patch that moves files around, please use the '-M' flag to
git-format-patch so we can see the actual changes instead of a file being
removed and another one added.

> >   delete mode 100644 arch/arm/mach-zynq/common.h
> >   delete mode 100644 arch/arm/mach-zynq/timer.c
> >   create mode 100644 drivers/clocksource/xilinx_ttc.c
> >   create mode 100644 include/linux/xilinx_ttc.h
> 
> Really?
> If yes. shouldn't be there any better naming convention
> especially for headers. linux/clocksource/xilinx_ttc.h.

Moving it is certainly the right direction, but I think we need a better way to
handle those forward declarations. "struct sys_timer" is actually an ARM specific
structure, so we might just want to add all the forward declarations for the 
timers into arch/arm/include/asm/mach/time.h. It's not ideal to do it like that,
but I think it's much better than having a new globally visible header for
each timer that is used on ARM.

Eventually, we might want to do something similar to what we are discussing
for the top-level IRQ controllers at the moment, where we just autodetect them
from DT if possible, so we don't need to have any pointer to the timer from
arch code at all.

	Arnd
