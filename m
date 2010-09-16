From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Sep 2010 18:51:27 +0100
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <1284657411.32513.3.camel@e102109-lin.cambridge.arm.com>
References: <4C8DD588.7040009@endruntechnologies.com>
	<201009131043.48688.marek.vasut@gmail.com>
	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
	<20100913101039.GC2614@kw.sim.vm.gnt>
	<000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
	<1284468849.933.2.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1009141333090.19366@xanadu.home>
	<1284657411.32513.3.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100916175127.GA27467@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 06:16:51PM +0100, Catalin Marinas wrote:
> On Tue, 2010-09-14 at 13:37 -0400, Nicolas Pitre wrote:
> > On Tue, 14 Sep 2010, Catalin Marinas wrote:
> > 
> > > I think the Thumb-2 branch goes up to 16MB range. The Thumb-1 may be
> > > smaller but we don't support this in the kernel. That's why Thumb-2
> > > modules are within 8MB below PAGE_OFFSET. But this leaves us with
> > > maximum 8MB of kernel size.
> > 
> > Hmmm.  Would be worth moving the pkmap area below modules then.
> 
> So currently the pkmap area is at PAGE_OFFSET - 2MB. On a Thumb-2 kernel
> with highmem enabled we would have 6MB available to modules. Is this big
> enough? If not, we could move the pkmap area.
> 
> BTW, can it be moved in the top part of the memory rather than below
> PAGE_OFFSET?

If you move it to the top part of memory, then it'll be about (sizeof
low memory) bytes - 32K away from the kernel code - which means it'll
mostly always be outside of the PC relative relocation range.

Indirecting all PC relative branches through trampolines quickly becomes
expensive, not only on CPUs which don't do branch prediction, but also
because of the mixed up code and data.

What might make sense is to move the init stuff between the kernel code
and kernel data - but that leads to a penalty of possibly 8 to 16K of
wasted space in the kernel image (for section alignment.)

I think we're better of staying as we are - thereby keeping the performance
for the majority use case, and telling those few people who want a massive
kernel binary not to do that.  In the case of a large initramfs, pass it
in as an initrd, possibly using the bootp stuff I've mentioned previously
if you want a single self-contained image.
