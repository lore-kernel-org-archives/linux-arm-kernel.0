From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Wed, 3 May 2017 16:00:10 +0000
Subject: [PATCH] ARM64/PCI: Allow userspace to mmap PCI resources
In-Reply-To: <20170503155858.GA11986@red-moon>
References: <1493826538-23785-1-git-send-email-Bharat.Bhushan@nxp.com>
 <20170503155858.GA11986@red-moon>
Message-ID: <AM5PR0401MB25457915BAEEBF8F50BC7C1F9A160@AM5PR0401MB2545.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> Sent: Wednesday, May 03, 2017 9:29 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>
> Cc: catalin.marinas at arm.com; will.deacon at arm.com;
> bhelgaas at google.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH] ARM64/PCI: Allow userspace to mmap PCI resources
> 
> On Wed, May 03, 2017 at 09:18:58PM +0530, Bharat Bhushan wrote:
> > This patch allows user-space to mmap PCI resources. This patch is
> > inline to arm32 bit implementation.
> >
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  arch/arm64/include/asm/pci.h |  4 ++++
> >  arch/arm64/kernel/pci.c      | 19 +++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
> next.git/commit/arch/arm64/include/asm/pci.h?id=f719582435afe9c7985206
> e42d804ea6aa315d33

Oh, I missed this patch series,

Thanks
-Bharat

> 
> >
> > diff --git a/arch/arm64/include/asm/pci.h
> > b/arch/arm64/include/asm/pci.h index b9a7ba9..8a18915 100644
> > --- a/arch/arm64/include/asm/pci.h
> > +++ b/arch/arm64/include/asm/pci.h
> > @@ -31,6 +31,10 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev
> *dev, int channel)
> >  	return -ENODEV;
> >  }
> >
> > +#define HAVE_PCI_MMAP
> > +extern int pci_mmap_page_range(struct pci_dev *dev, struct
> vm_area_struct *vma,
> > +			       enum pci_mmap_state mmap_state,
> > +			       int write_combine);
> >  static inline int pci_proc_domain(struct pci_bus *bus)  {
> >  	return 1;
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c index
> > ce20f4c..2e45a83 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -97,6 +97,25 @@ int pcibios_check_service_irqs(struct pci_dev *dev,
> int *irqs, int mask)
> >  	return count;
> >  }
> >
> > +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct
> *vma,
> > +			enum pci_mmap_state mmap_state, int
> write_combine) {
> > +	if (mmap_state == pci_mmap_io)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Mark this as IO
> > +	 */
> > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +
> > +	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> > +			     vma->vm_end - vma->vm_start,
> > +			     vma->vm_page_prot))
> > +		return -EAGAIN;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * raw_pci_read/write - Platform-specific PCI config space access.
> >   */
> > --
> > 1.9.3
> >
