From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 19:28:26 +0300
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928145028.GA23745@shareable.org>
References: <20090928092919.GA30271@localhost>
	<200909281610.32674.laurent.pinchart@ideasonboard.com>
	<20090928141510.GG19778@shareable.org>
	<200909281622.28404.laurent.pinchart@ideasonboard.com>
	<20090928145028.GA23745@shareable.org>
Message-ID: <20090928162826.GA21914@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 04:50:28PM +0200, ext Jamie Lokier wrote:
> Laurent Pinchart wrote:
> > On Monday 28 September 2009 16:15:10 Jamie Lokier wrote:
> > > Laurent Pinchart wrote:
> > > > > I'd much rather just say "no, userspace DMA is *never* going to ever
> > > > > be supported" and call it a day, but I suspect no one's going to like
> > > > > that either.
> > > >
> > > > In that case developers will all create their own incompatible solutions
> > > > and the situation will likely get worse. Do you think it would be
> > > > possible to create a clean DMA-to-userspace API specific to the ARM
> > > > architecture ?
> > > 
> > > I hate to spell out the obvious, but a fine solution is to _not_ DMA
> > > directly to userspace, but to kmalloc() a large buffer in your own
> > > driver, DMA into the buffer (it's kernel memory so that's ok), and
> > > _then_ mmap() that buffer into userspace after the DMA.  Going the
> > > other way, mmap(), write from userspace, munmap(), then do the DMA to
> > > the device.

One case where I don't see how this would work is when you want to pass
on the read data to another device using DMA as well. For example when
the raw captured data is written to flash storage. Unless you have some
way of letting know the target device that the area is kmalloc'd, but
that seems to be not so standard again.

> > > That's trivial to implement, and the developer's we're talking about
> > > should have no difficulty writing a simple driver like that.  They
> > > have a driver already, it's just a matter of adding the mmap method.
> > > 
> > > Russell, is there any reason why the above would not work?

The need for large physically contiguous allocations at run time.
Preallocation is not so nice if you have a bunch of multimedia
peripherals in your device.

--Imre
