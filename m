From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Oct 2009 13:36:00 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <1256299512.6564.74.camel@pc1117.cambridge.arm.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
Message-ID: <20091023123600.GB22853@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 01:05:12PM +0100, Catalin Marinas wrote:
> On Fri, 2009-10-23 at 12:30 +0100, Russell King - ARM Linux wrote:
> > I don't think you understand the problem.  /dev/mem can map *both* memory
> > and devices.  Fixing the mapping type for one doesn't solve the problem.
> > The only real way to fix it "properly" is to make /dev/mem lookup in a
> > table to find the proper mapping type for a specific physical address,
> > and get platforms to register these physical regions...
> 
> Something like below defined under arch/arm (if it's not RAM, we
> probably don't want Normal cached memory anyway, so no check for
> O_SYNC):
> 
> #if __LINUX_ARM_ARCH__ >= 6
> pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> 			      unsigned long size, pgprot_t vma_prot)
> {
> 	if (!pfn_valid(pfn))
> 		return pgprot_device(vma_prot);
> 	else if (file->f_flags & O_SYNC)
> 		return pgprot_noncached(vma_prot);
> 	return vma_prot;
> }
> EXPORT_SYMBOL(phys_mem_access_prot);
> #endif

This WILL NOT WORK, as I've tried to explain.

For example, what about framebuffers which aren't part of system RAM?
With the above, you end up mapping them as device, but the kernel will
map them as normal memory.  So you still end up with the same physical
address mapped using two different types.

It is not as simple as you seem to think, which is the point I've been
*painfully* trying to get across to you, and apparantly keeps being
ignored.

> > That's a pipedream.  Changing the memory type of dma_alloc_coherent()
> > is going to produce random failures by itself, since device drivers
> > as currently written for ARM assume that writes to this memory are
> > strongly ordered.
> > 
> > The only way to avoid this is to audit all the ARM drivers first,
> > before changing this.  
> 
> Yes, I don't say that's not needed (together with testing). If you want,
> we can restrict this requirement to ARMv7 onwards only (that's where it
> actually matters most) and there aren't many platforms around. The
> driver fix is simple enough - adding mb() before starting DMA transfers
> (I don't think this contradicts Documentation/memory-barriers.txt). I
> can see some well written drivers already use wmb() in functions like
> start_xmit().

Indeed, and as I say this is what needs to happen first.  But there is no
option (as you seem to want) to do this without causing instability.
One way or another, we're going to get unstable systems - the choice
is whether we get them *now* by changing the memory returned by
dma_alloc_coherent() or *later* when we actually have platforms which
suffer a problem.

> Alternatively, we can place a DMB in readl/writel but I'm not sure about
> the performance impact.

If you do that, you might as well use strongly ordered memory for device
mappings - since you'll be causing the CPU to stall after each access.

> Of course, you can use a more complicated workaround and ensure that
> coherent mappings first unmap the pages from the linear kernel mapping
> but we end up using pages instead of sections.

Please put some thought into your statements before you make them.
This is impossible without getting rid of the section mappings for
the kernel's direct-mapped pages, and converting them to 4K page
mappings.  That means a lot of additional TLB pressure which we
_already_ know people will not be happy with.

There is no way in hell that this would be a sane solution.

> > I don't think you read what I said.  What I was implying is that on
> > v6 and v7, there is (and can be) no difference between
> > dma_alloc_coherent() and dma_alloc_writecombine() - see what I said
> > in parens where I detail the type of memory _writecombine() provides
> > you with, which is precisely what you're proposing the _coherent()
> > interface returns.
> 
> I agree, with my patch there is no difference between coherent and
> writecombine. Why does it need to be one?

Because writecombine is unsafe for older architectures to use for
coherent DMA - it isn't coherent.  Especially when you realise that
older architecture write buffers are buggy as hell by allowing writes
to buffered memory to be randomly reordered, in spite of documentation
to the contary.

If you have a shared ownership ring buffer, you need the writes for
updating the DMA pointers to hit it before the write to change the
ownership of the descriptor to device.  Reverse those two writes and
you end up transmitting junk.
