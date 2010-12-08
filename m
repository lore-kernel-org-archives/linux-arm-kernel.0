From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 8 Dec 2010 11:33:58 +0530
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
References: <007401cb962d$d53d2500$7fb76f00$@deacon@arm.com><20101207171810.GA25839@n2100.arm.linux.org.uk>
	<007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
Message-ID: <a23df178794882d81bc1068d8240dfc8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Will Deacon
> Sent: Tuesday, December 07, 2010 11:17 PM
> To: 'Russell King - ARM Linux'
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: [RFC] Fixing CPU Hotplug for RealView Platforms
>
> Hi Russell,
>
> > On Tue, Dec 07, 2010 at 04:43:10PM -0000, Will Deacon wrote:
> > > Hello,
> > >
> > > Currently, CPU hotplug is broken for RealView platforms. I posted
some
> > > patches previously to try and address this, but they didn't solve
the
> > > problems fully:
> > >
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-
> September/026157.html
> > >
> > > I'm now revisiting the code and it looks like the main problem is
when
> > > we wish to *leave* the lowpower state. The enter/leave routines look
> > > like this:
> > >
> > ...
> > >
> > > The problem is that by turning off coherency, the contents of the D-
> cache
> > > becomes stale. If data is prefetched into L1 between the
> flush_cache_all
> > > invocation and disabling the D-cache then this data will still be
> present
> > > when we come out of lowpower. Without coherency, we *must not* use
> this
> > > data and so a D-cache invalidation to the PoC is required in
> > > cpu_leave_lowpower().
> >
> > What if we fixed the cpu_reset functions for v6 and v7, and when a CPU
> > is taken offline, we actually go through a proper shutdown of that CPU
> > and call the reset vector, re-entering the boot loader?
>
> This will certainly solve our problem, but people might complain that
it's
> too heavyweight :) That said, for v7 this may be the only solution as
the
> platform can require an IMPLEMENTATION DEFINED initialisation routine to
> be
> executed before enabling the D-cache out of reset. This should be
> something
> that the bootloader does for us.
>
> > We can only do this for CPUs other than the original boot CPU, because
> > the boot loader should be checking which are the secondary CPUs and
> > putting those into this simple WFI loop with the GIC appropriately
> > programmed.
> >
> > This means when we re-activate the CPU, we'll be waking it up in
> > exactly the same way as we do when the kernel boots - and we have all
> > that code around just waiting to be used.
>
One more simpler thing which could work is disable "C' bit before flushing
the L1 cache. That way prefetch would be avoided and cache also will
be in clean state while restarting the core.

Regards,
Santosh
