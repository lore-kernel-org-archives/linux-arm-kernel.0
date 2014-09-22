From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Sep 2014 11:29:10 +0200
Subject: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <4252161.sBJZLIS2WH@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-6-git-send-email-will.deacon@arm.com>
 <4252161.sBJZLIS2WH@avalon>
Message-ID: <20140922092909.GJ1470@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 02:17:33PM +0300, Laurent Pinchart wrote:
> Hi Will,
> 
> Thank you for the patch.
> 
> On Friday 12 September 2014 17:34:53 Will Deacon wrote:
> > This patch extends of_dma_configure so that it sets up the IOMMU for a
> > device, as well as the coherent/non-coherent DMA mapping ops.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/dma-mapping.h |  4 +++-
> >  drivers/of/platform.c              | 24 +++++++++++++++++-------
> >  include/linux/dma-mapping.h        |  8 +++++++-
> >  3 files changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/dma-mapping.h
> > b/arch/arm/include/asm/dma-mapping.h index 7e9ac4f604c3..a8bb0c494bb3
> > 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -121,7 +121,9 @@ static inline unsigned long dma_max_pfn(struct device
> > *dev) }
> >  #define dma_max_pfn(dev) dma_max_pfn(dev)
> > 
> > -static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
> > +static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
> > +				      u64 size, struct iommu_dma_mapping *iommu,
> > +				      bool coherent)
> >  {
> >  	if (coherent)
> >  		set_dma_ops(dev, &arm_coherent_dma_ops);
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 946dd7ae0394..95ebd38db545 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_iommu.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > @@ -166,6 +167,7 @@ static void of_dma_configure(struct platform_device
> > *pdev) int ret;
> >  	bool coherent;
> >  	unsigned long offset;
> > +	struct iommu_dma_mapping *iommu;
> >  	struct device *dev = &pdev->dev;
> > 
> >  	/*
> > @@ -195,7 +197,19 @@ static void of_dma_configure(struct platform_device
> > *pdev) dev_dbg(dev, "device is%sdma coherent\n",
> >  		coherent ? " " : " not ");
> > 
> > -	arch_setup_dma_ops(dev, coherent);
> > +	iommu = of_iommu_configure(dev);
> > +	dev_dbg(dev, "device is%sbehind an iommu\n",
> > +		iommu ? " " : " not ");
> > +
> > +	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> > +
> > +	if (iommu)
> > +		kref_put(&iommu->kref, of_iommu_deconfigure);
> 
> What's the expected life cycle of the iommu_dma_mapping structure ? It gets 
> created by of_iommu_configure() and the initial reference gets dropped here. I 
> suppose you expect arch code to need to keep a reference to the structure, but 
> your implementation in patch 7/7 doesn't. As far as I can see, you don't even 
> use the contents of the structure in the ARM arch_setup_dma_ops() 
> implementation. Do you expect that to change later, or other architectures to 
> need it ?
> 
> By the way, now that I think about it, I find struct iommu_dma_mapping and 
> struct dma_iommu_mapping very confusing.

Agreed. I wonder how useful it is to know the set of IOMMU instances
that each device can master through. Wouldn't it be more useful to keep
a list of master interfaces for each device? The set of IOMMU instances
can trivially be derived from that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/12e75db0/attachment.sig>
