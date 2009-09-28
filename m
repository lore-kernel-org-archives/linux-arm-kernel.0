From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 28 Sep 2009 15:50:28 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <200909281622.28404.laurent.pinchart@ideasonboard.com>
References: <20090928092919.GA30271@localhost>
	<200909281610.32674.laurent.pinchart@ideasonboard.com>
	<20090928141510.GG19778@shareable.org>
	<200909281622.28404.laurent.pinchart@ideasonboard.com>
Message-ID: <20090928145028.GA23745@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent Pinchart wrote:
> On Monday 28 September 2009 16:15:10 Jamie Lokier wrote:
> > Laurent Pinchart wrote:
> > > > I'd much rather just say "no, userspace DMA is *never* going to ever
> > > > be supported" and call it a day, but I suspect no one's going to like
> > > > that either.
> > >
> > > In that case developers will all create their own incompatible solutions
> > > and the situation will likely get worse. Do you think it would be
> > > possible to create a clean DMA-to-userspace API specific to the ARM
> > > architecture ?
> > 
> > I hate to spell out the obvious, but a fine solution is to _not_ DMA
> > directly to userspace, but to kmalloc() a large buffer in your own
> > driver, DMA into the buffer (it's kernel memory so that's ok), and
> > _then_ mmap() that buffer into userspace after the DMA.  Going the
> > other way, mmap(), write from userspace, munmap(), then do the DMA to
> > the device.
> > 
> > That's trivial to implement, and the developer's we're talking about
> > should have no difficulty writing a simple driver like that.  They
> > have a driver already, it's just a matter of adding the mmap method.
> > 
> > Russell, is there any reason why the above would not work?
> 
> Performance reasons mostly. Think about transferring uncompressed 1080p at 
> 30fps for instance.

Did you confuse the mail you quoted with a different one?  What part
of using mmap+munmap 30 times per second has any impact at all on your
DMA performance?

-- Jamie
