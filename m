From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 9 Oct 2013 18:54:56 +0100
Subject: [PATCH v6 16/19] arm,arm64: do not always merge biovec if we
 are running on Xen
In-Reply-To: <20130930160646.GV3106@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
 <1380298207-29151-16-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130930160646.GV3106@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1310091853540.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Konrad Rzeszutek Wilk wrote:
> On Fri, Sep 27, 2013 at 05:10:04PM +0100, Stefano Stabellini wrote:
> > This is similar to what it is done on X86: biovecs are prevented from merging
> > otherwise every dma requests would be forced to bounce on the swiotlb buffer.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> 
> This also alters the generic (well, was x86, now it is generic) code.
> Perhaps that change should be made in a seperate patch and explain
> what the autotranslate extra check will do for PV, PVH and HVM guests?
> 
> Wait, does that mean we had not been merging requests on HVM guests?
> Is that good or bad?

With the new introduction of a p2m for xen on arm and arm64, I don't
need the change to drivers/xen/biomerge.c anymore.
No more autotranslate extra check.

> > ---
> >  arch/arm/include/asm/io.h   |    8 ++++++++
> >  arch/arm64/include/asm/io.h |    9 +++++++++
> >  drivers/xen/biomerge.c      |    4 +++-
> >  3 files changed, 20 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > index d070741..c45effc 100644
> > --- a/arch/arm/include/asm/io.h
> > +++ b/arch/arm/include/asm/io.h
> > @@ -24,9 +24,11 @@
> >  #ifdef __KERNEL__
> >  
> >  #include <linux/types.h>
> > +#include <linux/blk_types.h>
> >  #include <asm/byteorder.h>
> >  #include <asm/memory.h>
> >  #include <asm-generic/pci_iomap.h>
> > +#include <xen/xen.h>
> >  
> >  /*
> >   * ISA I/O bus memory addresses are 1:1 with the physical address.
> > @@ -372,6 +374,12 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
> >  #define BIOVEC_MERGEABLE(vec1, vec2)	\
> >  	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
> >  
> > +extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
> > +				      const struct bio_vec *vec2);
> > +#define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
> > +	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
> > +	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
> > +
> >  #ifdef CONFIG_MMU
> >  #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
> >  extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index 1d12f89..c163287b 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -22,11 +22,14 @@
> >  #ifdef __KERNEL__
> >  
> >  #include <linux/types.h>
> > +#include <linux/blk_types.h>
> >  
> >  #include <asm/byteorder.h>
> >  #include <asm/barrier.h>
> >  #include <asm/pgtable.h>
> >  
> > +#include <xen/xen.h>
> > +
> >  /*
> >   * Generic IO read/write.  These perform native-endian accesses.
> >   */
> > @@ -263,5 +266,11 @@ extern int devmem_is_allowed(unsigned long pfn);
> >   */
> >  #define xlate_dev_kmem_ptr(p)	p
> >  
> > +extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
> > +				      const struct bio_vec *vec2);
> > +#define BIOVEC_PHYS_MERGEABLE(vec1, vec2)				\
> > +	(__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&				\
> > +	 (!xen_domain() || xen_biovec_phys_mergeable(vec1, vec2)))
> > +
> >  #endif	/* __KERNEL__ */
> >  #endif	/* __ASM_IO_H */
> > diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
> > index 0edb91c..f323a2d 100644
> > --- a/drivers/xen/biomerge.c
> > +++ b/drivers/xen/biomerge.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/io.h>
> >  #include <linux/export.h>
> >  #include <xen/page.h>
> > +#include <xen/features.h>
> >  
> >  bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
> >  			       const struct bio_vec *vec2)
> > @@ -9,7 +10,8 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
> >  	unsigned long mfn1 = pfn_to_mfn(page_to_pfn(vec1->bv_page));
> >  	unsigned long mfn2 = pfn_to_mfn(page_to_pfn(vec2->bv_page));
> >  
> > -	return __BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&
> > +	return !xen_feature(XENFEAT_auto_translated_physmap) &&
> > +		__BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&
> >  		((mfn1 == mfn2) || ((mfn1+1) == mfn2));
> >  }
> >  EXPORT_SYMBOL(xen_biovec_phys_mergeable);
