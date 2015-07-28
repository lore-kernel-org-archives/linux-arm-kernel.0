From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jul 2015 12:20:57 +0100
Subject: [PATCH] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <20150727051025.GA5310@localhost.localdomain>
References: <1437717263-11979-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <20150724144103.GC12569@arm.com>
 <20150727051025.GA5310@localhost.localdomain>
Message-ID: <20150728112057.GI29209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 06:10:29AM +0100, Jerin Jacob wrote:
> On Fri, Jul 24, 2015 at 03:41:03PM +0100, Will Deacon wrote:
> > On Fri, Jul 24, 2015 at 06:54:23AM +0100, Jerin Jacob wrote:
> > > +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> > > +		enum pci_mmap_state mmap_state, int write_combine)
> > > +{
> > > +	/*
> > > +	* I/O space can be accessed via normal processor loads and stores on
> > > +	* this platform but for now we elect not to do this and portable
> > > +	* drivers should not do this anyway.
> > > +	*/
> > > +	if (mmap_state == pci_mmap_io)
> > > +		return -EINVAL;
> > > +
> > > +	if (write_combine)
> > > +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > > +	else
> > > +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > +
> > > +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> > > +	       vma->vm_end - vma->vm_start, vma->vm_page_prot);
> > > +}
> > 
> > So pci_iomap_range chooses the memory attributes based on the BAR flags
> > (and even then it looks weird -- CACHEABLE => ioremap, else ioremap_nocache,
> > which is just the same as ioremap on arm64).
> > 
> > It would be good to understand (a) why this is different and (b) what
> 
> AFAIU, pci_iomap_range is the generic implementation and chooses to
> use only minimal attributes that works on all the architectures.
> The primary consumer of pci_iomap_range is virtio_pci driver,Which
> doesn't care about HW PCI memory attributes like Prefetchable.

pci_iomap calls pci_iomap_range.

> > the consistent set of attributes should be.
> 
> PCI perspective, memory attributes are Prefetchable and non-Prefetchable
> for a given BAR.
> 
> Former one does have read side-effects or supports write
> merging(typically used
> by graphics memory) and latter one has read side effects and does not
> support write merging(typically used by register files)
> 
> IMO, In armv8 nomenclature, MT_NORMAL_NC and MT_DEVICE_nGnRnE map
> correctly to above PCI memory attribute definitions.

I agree with your choice of memory types (well, almost. We probably don't
need the nE), I'm just after some consistency within the kernel, because
pci_iomap_range looks wrong to me. Another different example is
pci_ioremap_bar, which always uses ioremap_nocache.

Will
