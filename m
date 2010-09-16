From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 16 Sep 2010 14:37:02 -0400 (EDT)
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <20100916175127.GA27467@n2100.arm.linux.org.uk>
References: <4C8DD588.7040009@endruntechnologies.com>
	<201009131043.48688.marek.vasut@gmail.com>
	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
	<20100913101039.GC2614@kw.sim.vm.gnt>
	<000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
	<1284468849.933.2.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1009141333090.19366@xanadu.home>
	<1284657411.32513.3.camel@e102109-lin.cambridge.arm.com>
	<20100916175127.GA27467@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1009161425200.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Sep 2010, Russell King - ARM Linux wrote:

> On Thu, Sep 16, 2010 at 06:16:51PM +0100, Catalin Marinas wrote:
> > On Tue, 2010-09-14 at 13:37 -0400, Nicolas Pitre wrote:
> > > On Tue, 14 Sep 2010, Catalin Marinas wrote:
> > > 
> > > > I think the Thumb-2 branch goes up to 16MB range. The Thumb-1 may be
> > > > smaller but we don't support this in the kernel. That's why Thumb-2
> > > > modules are within 8MB below PAGE_OFFSET. But this leaves us with
> > > > maximum 8MB of kernel size.
> > > 
> > > Hmmm.  Would be worth moving the pkmap area below modules then.
> > 
> > So currently the pkmap area is at PAGE_OFFSET - 2MB. On a Thumb-2 kernel
> > with highmem enabled we would have 6MB available to modules. Is this big
> > enough? If not, we could move the pkmap area.
> > 
> > BTW, can it be moved in the top part of the memory rather than below
> > PAGE_OFFSET?
> 
> If you move it to the top part of memory, then it'll be about (sizeof
> low memory) bytes - 32K away from the kernel code - which means it'll
> mostly always be outside of the PC relative relocation range.

This is a side discussion where I was talking about a possibly better 
location for the pkmap area, not the modules, given that the module area 
is made smaller with a T2 kernel.  I agree that moving modules at the 
top of memory is not a good idea, and moving the pkmap might not be a 
good idea either.  My suggestion was then to simply move it in the low 
8MB of the module space that is unused with a T2 kernel.

> Indirecting all PC relative branches through trampolines quickly becomes
> expensive, not only on CPUs which don't do branch prediction, but also
> because of the mixed up code and data.

Of course in that case it is best to interleave code and data but 
grouped on separate cache lines.

> What might make sense is to move the init stuff between the kernel code
> and kernel data - but that leads to a penalty of possibly 8 to 16K of
> wasted space in the kernel image (for section alignment.)

But that wasted space in the kernel image would be filled with zeroes 
and that usually compresses very well.  And since the use case would be 
for those people with big initramfs I doubt 16K makes a big difference 
to them.  But unless someone tries it out and provide numbers, I agree 
that this is not a pressing issue.



Nicolas
