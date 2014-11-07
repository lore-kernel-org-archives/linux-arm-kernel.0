From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Nov 2014 16:03:06 +0000
Subject: [PATCH v7 6/8] xen/arm/arm64: merge xen/mm32.c into xen/mm.c
In-Reply-To: <alpine.DEB.2.02.1411071523170.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
 <1414422568-19103-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <20141107142205.GD29148@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411071523170.22875@kaball.uk.xensource.com>
Message-ID: <20141107160306.GF29148@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 03:28:38PM +0000, Stefano Stabellini wrote:
> On Fri, 7 Nov 2014, Catalin Marinas wrote:
> > On Mon, Oct 27, 2014 at 03:09:26PM +0000, Stefano Stabellini wrote:
> > > Merge xen/mm32.c into xen/mm.c.
> > > As a consequence the code gets compiled on arm64 too: introduce a few
> > > compat functions to actually be able to compile it.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Acked-by: Ian Campbell <ian.campbell@citrix.com>
> > 
> > Since I missed the commit introducing mm32.c (340720be32d4 xen/arm:
> > reimplement xen_dma_unmap_page & friends), I'll add a retrospective NAK ;).
> > 
> > The main reason is the asymmetry between dma map and unmap. With host
> > swiotlb somehow getting !dma_capable(dev), you even risk leaking dom0
> > swiotlb bounce buffers (on arm64).
> > 
> > > --- a/arch/arm/xen/mm.c
> > > +++ b/arch/arm/xen/mm.c
> > [...]
> > > +/* functions called by SWIOTLB */
> > > +
> > > +static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
> > > +       size_t size, enum dma_data_direction dir,
> > > +       void (*op)(const void *, size_t, int))
> > > +{
> > > +       unsigned long pfn;
> > > +       size_t left = size;
> > > +
> > > +       pfn = (handle >> PAGE_SHIFT) + offset / PAGE_SIZE;
> > > +       offset %= PAGE_SIZE;
> > > +
> > > +       do {
> > > +               size_t len = left;
> > > +               void *vaddr;
> > > +
> > > +               if (!pfn_valid(pfn))
> > 
> > Is this the pfn or the mfn? As you said in the previous email, there is
> > no mfn_to_pfn() conversion, so that's actually in another address space
> > where dom0 pfn_valid() would not make sense.
> 
> That is actually the mfn. The check works because dom0 is mapped 1:1, so
> if the mfn is a valid pfn, then it means that it is a local page.

So the Xen DMA ops would never be called on anything other than dom0? If
that's correct, the pfn_valid() check would work. But add some big
comments as it's not clear at all to someone not familiar with Xen.

-- 
Catalin
