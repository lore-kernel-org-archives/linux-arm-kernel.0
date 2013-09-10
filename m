From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Sep 2013 12:44:20 +0100
Subject: kmalloc memory slower than malloc
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE016A9EE8@039-SN2MPN1-023.039d.mgd.msft.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <1378807816.4200.6.camel@weser.hi.pengutronix.de>
 <9848F2DB572E5649BA045B288BE08FBE016A9D4A@039-SN2MPN1-023.039d.mgd.msft.net>
 <alpine.DEB.2.02.1309101327340.1305@kelly.ryd.net>
 <9848F2DB572E5649BA045B288BE08FBE016A9EE8@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20130910114420.GC12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 11:36:34AM +0000, Duan Fugang-B38611 wrote:
> From: Thommy Jakobsson [mailto:thommyj at gmail.com] 
> Data: Tuesday, September 10, 2013 7:29 PM
> 
> > To: Duan Fugang-B38611
> > Cc: Lucas Stach; Thommy Jakobsson; linux-arm-kernel at lists.infradead.org
> > Subject: RE: kmalloc memory slower than malloc
> > 
> > 
> > 
> > On Tue, 10 Sep 2013, Duan Fugang-B38611 wrote:
> > 
> > > About the diff:
> > > dma_alloc_coherent in kernel   4.256s (s=0)
> > > dma_alloc_coherent userspace   0.566s (s=0)
> > >
> > > I think it call remap_pfn_range() with page attribute (vma->vm_page_prot)
> > transferred from mmap() maybe cacheable.
> > > So the performance is the same as malloc/kmalloc in userspace.
> > >
> > Thats probably true, or at least that is how I explained it to myself in
> > my head =)
> > 
> > Thanks,
> > Thommy
> 
> Can you add below code to your device_mmap() to test the performance for above two cases:
> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

No, that is not match the page table settings that dma_mmap_coherent
would use.  That gets you strongly ordered memory which will be
(a) a violation of the ARM architecture requirements, being a different
"memory type", and (b) will be a different mapping type compared to
that used by the virtual address returned from dma_alloc_coherent().

The appropriate modification here would be pgprot_dmacoherent().
