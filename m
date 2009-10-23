From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Oct 2009 13:05:12 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023113001.GA22853@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
Message-ID: <1256299512.6564.74.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-23 at 12:30 +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2009 at 11:59:51AM +0100, Catalin Marinas wrote:
> > On Fri, 2009-10-23 at 11:34 +0100, Russell King - ARM Linux wrote:
> > > On Fri, Oct 23, 2009 at 11:22:54AM +0100, Catalin Marinas wrote:
> > > > On Fri, 2009-10-23 at 11:06 +0100, Russell King - ARM Linux wrote:
> > > > > On Fri, Oct 23, 2009 at 10:41:21AM +0100, Catalin Marinas wrote:
> > > > > > The patch modifies the pgprot_noncached() for ARMv6+ architecture
> > > > > > versions to generate Normal uncached memory attributes rather than
> > > > > > Strongly Ordered. The patch also modifies the mandatory barriers to use
> > > > > > dmb() rather than being simple compiler barriers.
> > > > > 
> > > > > It's not this simple - pgprot_noncached() is used for /dev/mem O_SYNC
> > > > > mappings, which are used for device mappings.  This means you still
> > > > > end up with the unpredictable issue.
> > > > 
> > > > If it is used for accessing device memory, why not create a
> > > > pgprot_device() and use this instead (maybe after checking for pfn_valid
> > > > to make sure we don't map the RAM as device memory)? Of course, it needs
> > > > some modifications to the mem.c driver which may be ARM specific, though
> > > > some other architecture might benefit as well.
> > > 
> > > People keep fiddling with /dev/mem, and it keeps having these problems.
> > > I suggest we leave that area well alone - we can not properly solve the
> > > /dev/mem problems.  Fixing it to use "memory" mappings will break attempts
> > > to use it to access devices, and fixing it for "device" mappings will break
> > > attempts to access memory.
> > > 
> > > No amount of fiddling with uncached_access() can fix that.
> > 
> > You can also fix phys_mem_access_prot() to differentiate between
> > standard and device memory. You can simply define
> > __HAVE_PHYS_MEM_ACCESS_PROT and implement an ARM-specific function (we
> > probably don't even need to modify uncached_access()).
> 
> I don't think you understand the problem.  /dev/mem can map *both* memory
> and devices.  Fixing the mapping type for one doesn't solve the problem.
> The only real way to fix it "properly" is to make /dev/mem lookup in a
> table to find the proper mapping type for a specific physical address,
> and get platforms to register these physical regions...

Something like below defined under arch/arm (if it's not RAM, we
probably don't want Normal cached memory anyway, so no check for
O_SYNC):

#if __LINUX_ARM_ARCH__ >= 6
pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
			      unsigned long size, pgprot_t vma_prot)
{
	if (!pfn_valid(pfn))
		return pgprot_device(vma_prot);
	else if (file->f_flags & O_SYNC)
		return pgprot_noncached(vma_prot);
	return vma_prot;
}
EXPORT_SYMBOL(phys_mem_access_prot);
#endif

> > We really need to sort out this issue before we start to see people
> > complaining of random failures as a result aliased memory (no specific
> > case yet but I don't think it would be long).
> 
> That's a pipedream.  Changing the memory type of dma_alloc_coherent()
> is going to produce random failures by itself, since device drivers
> as currently written for ARM assume that writes to this memory are
> strongly ordered.
> 
> The only way to avoid this is to audit all the ARM drivers first,
> before changing this.  

Yes, I don't say that's not needed (together with testing). If you want,
we can restrict this requirement to ARMv7 onwards only (that's where it
actually matters most) and there aren't many platforms around. The
driver fix is simple enough - adding mb() before starting DMA transfers
(I don't think this contradicts Documentation/memory-barriers.txt). I
can see some well written drivers already use wmb() in functions like
start_xmit().

Alternatively, we can place a DMB in readl/writel but I'm not sure about
the performance impact.

Of course, you can use a more complicated workaround and ensure that
coherent mappings first unmap the pages from the linear kernel mapping
but we end up using pages instead of sections.

> Not doing this will be a recipe for an unstable
> system - which could be really difficult to debug - eg, if DMA ends
> up scribbling over some random part of the kernel because the DMA
> address hasn't been written to the descriptor.

The current configuration will lead to unstable systems in the future
anyway (especially with processors doing aggressive prefetching via the
cached alias). That would be even more difficult to debug.

> > > When it comes to the writecombine and DMA coherent mappings, these are
> > > architecture private stuff.  I guess on ARMv6 and v7, there is no
> > > difference between these two (since writecombine is already uncacheable
> > > normal memory).
> > 
> > Yes, the writecombine is fine.
> 
> I don't think you read what I said.  What I was implying is that on
> v6 and v7, there is (and can be) no difference between
> dma_alloc_coherent() and dma_alloc_writecombine() - see what I said
> in parens where I detail the type of memory _writecombine() provides
> you with, which is precisely what you're proposing the _coherent()
> interface returns.

I agree, with my patch there is no difference between coherent and
writecombine. Why does it need to be one?

-- 
Catalin
