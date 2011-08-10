From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 10 Aug 2011 15:08:09 +0200
Subject: [PATCH] ARM: fix perf build with uclibc toolchains
In-Reply-To: <20110810122648.GG10121@e102144-lin.cambridge.arm.com>
References: <201108091324.17750.florian@openwrt.org>
	<201108101256.01010.florian@openwrt.org>
	<20110810122648.GG10121@e102144-lin.cambridge.arm.com>
Message-ID: <201108101508.09963.florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011 14:26:48 Will Deacon wrote:
> On Wed, Aug 10, 2011 at 11:56:00AM +0100, Florian Fainelli wrote:
> > On Wednesday 10 August 2011 12:21:55 Will Deacon wrote:
> > > On Tue, Aug 09, 2011 at 09:08:53PM +0100, Will Deacon wrote:
> > > > On Tue, Aug 09, 2011 at 12:24:17PM +0100, Florian Fainelli wrote:
> > > > > libio.h is not provided by uClibc, in order to be able to test the
> > > > > definition of __UCLIBC__ we need to include stdlib.h, which also
> > > > > includes stddef.h, providing the definition of 'NULL'.
> > > > > 
> > > > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > > > ---
> > > > > diff --git a/tools/perf/arch/arm/util/dwarf-regs.c
> > > > > b/tools/perf/arch/arm/util/dwarf-regs.c index fff6450..e8d5c55
> > > > > 100644 --- a/tools/perf/arch/arm/util/dwarf-regs.c
> > > > > +++ b/tools/perf/arch/arm/util/dwarf-regs.c
> > > > > @@ -8,7 +8,10 @@
> > > > > 
> > > > >   * published by the Free Software Foundation.
> > > > >   */
> > > > > 
> > > > > +#include <stdlib.h>
> > > > > +#ifndef __UCLIBC__
> > > > > 
> > > > >  #include <libio.h>
> > > > > 
> > > > > +#endif
> > > > > 
> > > > >  #include <dwarf-regs.h>
> > > > >  
> > > > >  struct pt_regs_dwarfnum {
> > > > 
> > > > Nice to see somebody trying to get this going with uclinux! I'll give
> > > > this a quick compile-check on my boards and then I'll include it in
> > > > my perf-fixes branch for 3.1.
> > > 
> > > Seems happy enough on my MMU boards. Since you're using this on noMMU
> > > platforms, does that mean that you can build a static perf binary out
> > > of the box or do you need further patches for this?
> > 
> > uClibc is not only for noMMU boards, I just built an uclibc toolchain for
> > arm targetting realview and run-tested this with qemu. This was the only
> > patch required to cross-compile perf for me. I also tested this with
> > eglibc.
> 
> Ok, great. Cross-compiling perf usually just causes endless pain for me.
> 
> > By the way, perf top reports no even being generated for realview under
> > qemu, is that normal?
> 
> My guess is that qemu isn't emulating the cycle counter, which is required
> to generate interrupts for use by perf. You could try disabling
> HW_PERF_EVENTS which will force perf to fall back to a CPU tick instead.

That did it, thanks a lot Will.
--
Florian
