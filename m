From: imre.deak@nokia.com (Imre Deak)
Date: Tue, 29 Sep 2009 12:10:01 +0300
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928193528.GA32339@shareable.org>
References: <20090928092919.GA30271@localhost>
	<200909281610.32674.laurent.pinchart@ideasonboard.com>
	<20090928141510.GG19778@shareable.org>
	<200909281622.28404.laurent.pinchart@ideasonboard.com>
	<20090928145028.GA23745@shareable.org>
	<20090928162826.GA21914@localhost>
	<20090928193528.GA32339@shareable.org>
Message-ID: <20090929091001.GB9536@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 09:35:29PM +0200, ext Jamie Lokier wrote:
> Imre Deak wrote:
> > > > Jamie Lokier wrote:
> > > > > I hate to spell out the obvious, but a fine solution is to _not_ DMA
> > > > > directly to userspace, but to kmalloc() a large buffer in your own
> > > > > driver, DMA into the buffer (it's kernel memory so that's ok), and
> > > > > _then_ mmap() that buffer into userspace after the DMA.  Going the
> > > > > other way, mmap(), write from userspace, munmap(), then do the DMA to
> > > > > the device.
> > 
> > One case where I don't see how this would work is when you want to pass
> > on the read data to another device using DMA as well. For example when
> > the raw captured data is written to flash storage. Unless you have some
> > way of letting know the target device that the area is kmalloc'd, but
> > that seems to be not so standard again.
> 
> An understandable desire.
> 
> But if you want to do that, DMA to userspace and then from userspace is
> not a particularly efficient way to do it anyway - because both DMAs
> would have to walk the page tables in get_user_pages.
> I believe someone posted an architecture/RFC/patches (I forget) for
> passing memory blocks between devices for camera/video type
> applications a few months ago.

True, that would be the most ideal, you would even save the cache flush.
It assumes also that the data can be passed as-is, but perhaps that's a
fair assumption.

Another example where mmap would be inflexible is when the buffer is
shared between processes, or you are provided by a framework - like
gstreamer - with a ready buffer to transfer.

> I was advocating transfering to/from userspace, and the person
> providing that framework said it was too slow to go via userspace.
> 
> > > > > That's trivial to implement, and the developer's we're talking about
> > > > > should have no difficulty writing a simple driver like that.  They
> > > > > have a driver already, it's just a matter of adding the mmap method.
> > > > > 
> > > > > Russell, is there any reason why the above would not work?
> > 
> > The need for large physically contiguous allocations at run time.
> > Preallocation is not so nice if you have a bunch of multimedia
> > peripherals in your device.
> 
> The kmalloc+mmap approach does not require any large contiguous
> allocations, unless that's a property of your hardware, in which case
> nothing will avoid it.

No, I didn't mean the hardware, but was just wondering what the
benefit would be over get_user_pages. As I see you can either do:

a. kmalloc the whole buffer which will be physically contiguous. If
   this is mapped to user space so that it won't create aliases with
   the kernel direct mapping, dma_map_single can be used which will
   do proper cache sync'ing.

b. kmalloc in chunks (practically pages) and pass it to dma_map_sg,
   which will only flush cache lines for the kernel direct mapping.
   Thus in addition for each page you'll have to flush cache lines
   for the user mapping. For me this doesn't provide much benefit
   over using get_user_pages.

--Imre
