From: davidsin@ti.com (Sin, David)
Date: Mon, 2 Aug 2010 09:49:54 -0500
Subject: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
	implementation
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C641D580@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
	<1279927348-21750-2-git-send-email-davidsin@ti.com>
	<1279927348-21750-3-git-send-email-davidsin@ti.com>
	<1279927348-21750-4-git-send-email-davidsin@ti.com>
	<1279927348-21750-5-git-send-email-davidsin@ti.com>
	<20100724080118.GB15064@n2100.arm.linux.org.uk>
	<513FF747EED39B4AADBB4D6C9D9F9F7903D654A3FE@dlee02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C641D580@dbde02.ent.ti.com>
Message-ID: <513FF747EED39B4AADBB4D6C9D9F9F7903D654A430@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----Original Message-----
From: Shilimkar, Santosh 
Sent: Monday, August 02, 2010 9:45 AM
To: Sin, David; Russell King - ARM Linux; Woodruff, Richard
Cc: linux-omap at vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; Molnar, Lajos; Voultoury, Pierre; linux-arm-kernel at lists.infradead.org
Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and implementation

> -----Original Message-----
> From: Sin, David
> Sent: Monday, August 02, 2010 8:11 PM
> To: Russell King - ARM Linux; Woodruff, Richard
> Cc: linux-omap at vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-
> Cohen; Hiremath, Vaibhav; Shilimkar, Santosh; Molnar, Lajos; Voultoury,
> Pierre; linux-arm-kernel at lists.infradead.org
> Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, July 24, 2010 3:01 AM
> To: Sin, David
> Cc: linux-arm-kernel at lists.arm.linux.org.uk; linux-omap at vger.kernel.org;
> Tony Lindgren; Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav;
> Shilimkar, Santosh; Molnar, Lajos
> Subject: Re: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
> On Fri, Jul 23, 2010 at 06:22:24PM -0500, David Sin wrote:
> > +/* allocate and flush a page */
> > +static struct mem *alloc_mem(void)
> > +{
> > +	struct mem *m = kzalloc(sizeof(*m), GFP_KERNEL);
> > +	if (!m)
> > +		return NULL;
> > +
> > +	m->pg = alloc_page(GFP_KERNEL | GFP_DMA);
> > +	if (!m->pg) {
> > +		kfree(m);
> > +		return NULL;
> > +	}
> > +
> > +	m->pa = page_to_phys(m->pg);
> > +
> > +	/* flush the cache entry for each page we allocate. */
> > +	dmac_flush_range(page_address(m->pg),
> > +				page_address(m->pg) + PAGE_SIZE);
> > +	outer_flush_range(m->pa, m->pa + PAGE_SIZE);
> 
> NAK.  This is an abuse of these interfaces, and is buggy in any case.
> 
> ARMv6 and ARMv7 CPUs speculatively prefetch memory, which means that
> there's no guarantee that if you flush the caches for a particular
> range of virtual space, that it will stay flushed until you decide
> to read it.  So flushing the caches in some memory allocator can't
> guarantee that when you eventually get around to using the page that
> there won't be cache lines associated with it.
> 
> [dhs] Russell, thanks for reviewing this code.  Do you have any interface
> suggestions that you can share that would make this proper?  Ideally, I
> would like to get physical pages without associated virtual address, or
> ones that are non-cached/non-bufferable.

There is nothing called 'non-bufferable' any more David on ARMv6 and ARMv7. 
You can get non-cached memory using "dma_alloc_coherent"

[dhs] Thanks, Santosh, for the clarification.  I believe dma_alloc_coherent is quite limited, right?  We need to be able to cover potentially 128MB of physical memory for the TILER.  BTW, does GFP_DMA indicate that I don't want cached memory?

Regards,
Santosh
