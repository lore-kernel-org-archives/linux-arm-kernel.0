From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Dec 2010 13:20:41 -0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <a23df178794882d81bc1068d8240dfc8@mail.gmail.com>
References: <007401cb962d$d53d2500$7fb76f00$@deacon@arm.com><20101207171810.GA25839@n2100.arm.linux.org.uk>
	<007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
	<a23df178794882d81bc1068d8240dfc8@mail.gmail.com>
Message-ID: <007701cb96da$b68dbbd0$23a93370$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

> > > We can only do this for CPUs other than the original boot CPU, because
> > > the boot loader should be checking which are the secondary CPUs and
> > > putting those into this simple WFI loop with the GIC appropriately
> > > programmed.
> > >
> > > This means when we re-activate the CPU, we'll be waking it up in
> > > exactly the same way as we do when the kernel boots - and we have all
> > > that code around just waiting to be used.
> >
> One more simpler thing which could work is disable "C' bit before flushing
> the L1 cache. That way prefetch would be avoided and cache also will
> be in clean state while restarting the core.

I like this idea because it's easy to implement! It does, however, rely
on caches not containing any random dirty lines when leaving the low-power
state. This behaviour is IMPLEMENTATION DEFINED out of reset, so its
something that platform code will need to handle anyway.

On RealView, we only do a WFI to enter lowpower so your approach sounds
feasible. I'll put in a comment describing the potential problems with
random D-cache data out of reset so that if other platforms blindly copy
the code, at least they've been warned.

Will
