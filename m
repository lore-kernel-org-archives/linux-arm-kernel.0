From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Oct 2009 15:08:16 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023123600.GB22853@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
Message-ID: <1256306896.6564.128.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-23 at 13:36 +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2009 at 01:05:12PM +0100, Catalin Marinas wrote:
> > Something like below defined under arch/arm (if it's not RAM, we
> > probably don't want Normal cached memory anyway, so no check for
> > O_SYNC):
> > 
> > #if __LINUX_ARM_ARCH__ >= 6
> > pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> > 			      unsigned long size, pgprot_t vma_prot)
> > {
> > 	if (!pfn_valid(pfn))
> > 		return pgprot_device(vma_prot);
> > 	else if (file->f_flags & O_SYNC)
> > 		return pgprot_noncached(vma_prot);
> > 	return vma_prot;
> > }
> > EXPORT_SYMBOL(phys_mem_access_prot);
> > #endif
> 
> This WILL NOT WORK, as I've tried to explain.
> 
> For example, what about framebuffers which aren't part of system RAM?
> With the above, you end up mapping them as device, but the kernel will
> map them as normal memory.  So you still end up with the same physical
> address mapped using two different types.

In this case we would need other ways of checking whether a page is RAM,
maybe having a per-platform phys_mem_access_prot function (similar to
what powerpc seems to do) which is aware of other RAM-like areas and
what drivers are used.

It's not simple but IMHO not impossible either.

> > Alternatively, we can place a DMB in readl/writel but I'm not sure about
> > the performance impact.
> 
> If you do that, you might as well use strongly ordered memory for device
> mappings - since you'll be causing the CPU to stall after each access.

I'm not sure that's guaranteed. The ARM ARM doesn't state any ordering
requirements between normal memory (cached or uncached) and strongly
ordered memory.

> > Of course, you can use a more complicated workaround and ensure that
> > coherent mappings first unmap the pages from the linear kernel mapping
> > but we end up using pages instead of sections.
> 
> Please put some thought into your statements before you make them.
> This is impossible without getting rid of the section mappings for
> the kernel's direct-mapped pages, and converting them to 4K page
> mappings.  That means a lot of additional TLB pressure which we
> _already_ know people will not be happy with.

I'm aware of this and I don't think its a viable solution. An
alternative is to allocate already unmapped pages (highmem) in
dma_alloc_coherent but I haven't explored this variant.

-- 
Catalin
