From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 03 Apr 2011 22:49:47 -0400 (EDT)
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <1301869097.2549.36.camel@pasglop>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<8ya39m2mv65.fsf@huya.qualcomm.com> <20110401074519.GC7594@elte.hu>
	<201104011554.07924.arnd@arndb.de> <4D95E112.4020400@vollmann.ch>
	<1301869097.2549.36.camel@pasglop>
Message-ID: <alpine.LFD.2.00.1104032225170.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Apr 2011, Benjamin Herrenschmidt wrote:

> On Fri, 2011-04-01 at 16:28 +0200, Detlef Vollmann wrote:
> > >   * No board files
> > Where do you put code that needs to run very early (e.g. pinging the
> > watchdog)? 
> 
> Even on powerpc I keep board files :-)
> 
> The main thing is:
> 
> - The generic -> board linkage must not be hard (ie, no
> platform_restart, but a board_ops.restart() etc....)

We have that on ARM already.  See for example the struct machine_desc 
definition in arch/arm/include/asm/mach/arch.h.

> - An average board file is a few hundreds line long, that's it, mostly
> it hooks up to generically provided functions, tho it gets the choice of
> _which_ ones to hookup.

Again that's largely the same situation on ARM.  Taking Kirkwood for 
example (wc -l arch/arm/mach-kirkwood/*-setup.c) the average for board 
file tends to be more towards 200 lines though.  Here DT could make a 
difference by moving the statically defined board resources elsewhere.

> - It can still quirk/fixup a thing or two if needed, I thinkt it's
> useful to keep that around, as long as such "quirks" remain small and
> few. At the end of the day, if dealing with one board special case gives
> you the choice between changing a ton of infrastructure/core to
> introduce a new abstraction to deal with -that- special case vs. having
> a one liner fixup in the platform code, the later is the most sensible
> option. The hard part of course is to have sensible maintainers to make
> sure this doesn't grow back to the old mess.

Totally agreed.  I think that's the core of the issue on ARM: we simply 
aren't factoring out the duplication aggressively enough in order to 
keep the board code to the absolute minimum.  The fact that different 
SoCs are totally alien to each other never encouraged that.


Nicolas
