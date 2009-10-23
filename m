From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Oct 2009 12:30:01 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <1256295591.6564.42.camel@pc1117.cambridge.arm.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
Message-ID: <20091023113001.GA22853@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 11:59:51AM +0100, Catalin Marinas wrote:
> On Fri, 2009-10-23 at 11:34 +0100, Russell King - ARM Linux wrote:
> > On Fri, Oct 23, 2009 at 11:22:54AM +0100, Catalin Marinas wrote:
> > > On Fri, 2009-10-23 at 11:06 +0100, Russell King - ARM Linux wrote:
> > > > On Fri, Oct 23, 2009 at 10:41:21AM +0100, Catalin Marinas wrote:
> > > > > The patch modifies the pgprot_noncached() for ARMv6+ architecture
> > > > > versions to generate Normal uncached memory attributes rather than
> > > > > Strongly Ordered. The patch also modifies the mandatory barriers to use
> > > > > dmb() rather than being simple compiler barriers.
> > > > 
> > > > It's not this simple - pgprot_noncached() is used for /dev/mem O_SYNC
> > > > mappings, which are used for device mappings.  This means you still
> > > > end up with the unpredictable issue.
> > > 
> > > If it is used for accessing device memory, why not create a
> > > pgprot_device() and use this instead (maybe after checking for pfn_valid
> > > to make sure we don't map the RAM as device memory)? Of course, it needs
> > > some modifications to the mem.c driver which may be ARM specific, though
> > > some other architecture might benefit as well.
> > 
> > People keep fiddling with /dev/mem, and it keeps having these problems.
> > I suggest we leave that area well alone - we can not properly solve the
> > /dev/mem problems.  Fixing it to use "memory" mappings will break attempts
> > to use it to access devices, and fixing it for "device" mappings will break
> > attempts to access memory.
> > 
> > No amount of fiddling with uncached_access() can fix that.
> 
> You can also fix phys_mem_access_prot() to differentiate between
> standard and device memory. You can simply define
> __HAVE_PHYS_MEM_ACCESS_PROT and implement an ARM-specific function (we
> probably don't even need to modify uncached_access()).

I don't think you understand the problem.  /dev/mem can map *both* memory
and devices.  Fixing the mapping type for one doesn't solve the problem.
The only real way to fix it "properly" is to make /dev/mem lookup in a
table to find the proper mapping type for a specific physical address,
and get platforms to register these physical regions...

That said, /dev/mem is more or less legacy when it comes to frame buffers
(which are supposed to use the frame buffer stuff - but iirc X11 stuff
either took ages or just doesn't use the frame buffer stuff, especially
with PCI cards.)

> We really need to sort out this issue before we start to see people
> complaining of random failures as a result aliased memory (no specific
> case yet but I don't think it would be long).

That's a pipedream.  Changing the memory type of dma_alloc_coherent()
is going to produce random failures by itself, since device drivers
as currently written for ARM assume that writes to this memory are
strongly ordered.

The only way to avoid this is to audit all the ARM drivers first,
before changing this.  Not doing this will be a recipe for an unstable
system - which could be really difficult to debug - eg, if DMA ends
up scribbling over some random part of the kernel because the DMA
address hasn't been written to the descriptor.

> > When it comes to the writecombine and DMA coherent mappings, these are
> > architecture private stuff.  I guess on ARMv6 and v7, there is no
> > difference between these two (since writecombine is already uncacheable
> > normal memory).
> 
> Yes, the writecombine is fine.

I don't think you read what I said.  What I was implying is that on
v6 and v7, there is (and can be) no difference between
dma_alloc_coherent() and dma_alloc_writecombine() - see what I said
in parens where I detail the type of memory _writecombine() provides
you with, which is precisely what you're proposing the _coherent()
interface returns.

> But my patch is intended for dma_alloc_coherent which uses
> pgprot_noncached(). There are also several drivers that make use of
> pgprot_noncached(), especially framebuffer drivers which are not
> ARM-specific.

These other drivers are a separate problem, and need auditing to see
what type of mapping is actually required.  pgprot_noncached() has
been used both for things like frame buffers and for things like
device mappings.  To change it to suit one case is likely to break
the other case.
