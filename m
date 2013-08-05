From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 04 Aug 2013 21:19:53 -0400 (EDT)
Subject: [GIT PULL] MCPM backends update
In-Reply-To: <20130804200201.GH10876@quad.lixom.net>
References: <alpine.LFD.2.03.1307221521200.15022@syhkavp.arg>
 <20130804200201.GH10876@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1308042058280.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Aug 2013, Olof Johansson wrote:

> On Mon, Jul 22, 2013 at 04:02:45PM -0400, Nicolas Pitre wrote:
> > Hello gents,
> 
> Hi, sorry for the delayed reply to this.
> 
> > Would you please pull the following into ARM-SOC:
> > 
> > 	git://git.linaro.org/people/nico/linux mcpm+tc2
> > 
> > This contains
> > 
> > - Fixes to the existing Vexpress DCSCB backend.
> > 
> > - Lorenzo's minimal SPC driver required by the TC2 MCPM backend.
> >   As discussed on the list, this is not considered to be a MFD driver.
> >   This hardly qualify as a bus driver either.  Conceptually, this is
> >   a very platform specific register multiplex driver allowing subsystem
> >   drivers to hook into.  I therefore moved it to 
> >   drivers/platform/vexpress/ which seems to please everyone.
> > 
> > - The MCPM backend enabling SMP secondary boot and CPU hotplug
> >   on the VExpress TC2 big.LITTLE platform.
> > 
> > - MCPM suspend method to the TC2 backend allowing basic CPU 
> >   idle/suspend.  The cpuidle driver that hooks into this will be 
> >   submitted separately.
> > 
> > This is based on v3.11-rc2.  The diffstat follows:
> > 
> >  .../devicetree/bindings/arm/vexpress-spc.txt       |  36 +++
> >  arch/arm/mach-vexpress/Kconfig                     |   9 +
> >  arch/arm/mach-vexpress/Makefile                    |   1 +
> >  arch/arm/mach-vexpress/dcscb.c                     |  58 ++--
> >  arch/arm/mach-vexpress/tc2_pm.c                    | 304 +++++++++++++++++++++
> >  drivers/platform/Kconfig                           |   4 +-
> >  drivers/platform/Makefile                          |   1 +
> >  drivers/platform/vexpress/Kconfig                  |   9 +
> >  drivers/platform/vexpress/Makefile                 |   1 +
> >  drivers/platform/vexpress/spc.c                    | 253 +++++++++++++++++
> >  include/linux/vexpress.h                           |  17 ++
> >  11 files changed, 671 insertions(+), 22 deletions(-)
> 
> 
> The vexpress code continues to be uncooperative in fitting into any of
> the existing conventions of how drivers and platform code is organized
> in the kernel, which makes it hard to find a good home for it.

No kidding.

> I sort of see the appeal of having a generic driver for this, but the code is
> already TC2-specific.

I'm expecting the next b.L platform from ARM to be Cortex A57+A53 based 
which is 64 bits.

> Also, most drivers under drivers/platform are more or less glue code
> that sets up other drivers.

But that's exactly what's happening here.

> I don't think we want to have a calling
> dependency from mach-vexpress into drivers/platform like this.

The cpufreq driver (currently used by TC2 but I'd expect more vexpress 
flavors in the future) is also calling into this.  And that one doesn't 
live under mach-vexpress.

> If it wasn't for that tight coupling then I think drivers/platform/arm
> could be a good location for it.

This is actually more "Versatile Express" related than "ARM" which IMHO 
is a bit too generic.  Hence "platform: vexpress".

And aren't we simply starting to bikeshed here?

> I'm sure there'll come a time when a similar driver is needed for
> something arm64-based on vexpress. Until then I think we're best off
> just moving the code under mach-vexpress.

That time is going to be sooner than you think.

> Nico, would you mind moving it once again and this time to
> mach-vexpress? I know you already brought it out of drivers/mfd.

You know what?  This code did start in mach-vexpress originally.  But 
that was considered unsuitable a location.

So could we stop fooling around please?

I'd strongly plea for you to just pull this stuff as it is now.  We've 
wasted way too much time on the issue of a proper location for this code 
and other drivers are being gated on this. I think that 
drivers/platform/vexpress is Innocent enough to cause no harm.  So 
_please_ let's just use that and move it _if_ we find a more optimal 
location in the future.

Please ?


Nicolas
