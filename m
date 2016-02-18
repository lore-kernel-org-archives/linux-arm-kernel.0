From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Thu, 18 Feb 2016 19:33:19 +0000
Subject: RFC: extend IOMMU attributes
In-Reply-To: <20160218162145.GB16883@arm.com>
References: <HE1PR04MB1641F22E38710B68F4ED891F8DAF0@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <20160218162145.GB16883@arm.com>
Message-ID: <HE1PR04MB16418B721EF4A95F6860542B8DAF0@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Thursday, February 18, 2016 10:22 AM
> To: Stuart Yoder <stuart.yoder@nxp.com>
> Cc: joro at 8bytes.org; robin.murphy at arm.com; iommu at lists.linux-foundation.org; linux-arm-
> kernel at lists.infradead.org; Varun Sethi <V.Sethi@nxp.com>; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>; Peter Newton
> <peter.newton@nxp.com>
> Subject: Re: RFC: extend IOMMU attributes
> 
> Hi Stuart,
> 
> On Thu, Feb 18, 2016 at 04:16:26PM +0000, Stuart Yoder wrote:
> > We are implementing support for some specialized NXP SoC network
> > devices and have the desire to extend the mapping attributes beyond
> > those currently in iommu.h. (I see there is a recent proposal to
> > add an IOMMU_MMIO flag)
> >
> > What we have right now in Linux is a least-common-denominator set of
> > attributes, while for the ARM SMMU there is a much richer set of
> > attributes that seem useful to support. Specifically, we have one
> > SoC device we're dealing with right now that is the target of DMA
> > that functionally requires a "cacheable, non-shareable" attribute
> > in its SMMU mapping.
> >
> > In addition, there are many other attributes such as r/w allocate
> > hints, transient hints, write-back/write-thru, etc in the SMMU.
> >
> > We wanted to see what your thinking is with respect to the
> > direction the Linux IOMMU layer will head over the longer term with
> > respect to attributes.
> >
> > Is there anything problematic with continuing to grow the
> > attributes in iommu.h?...e.g.:
> >
> >  #define IOMMU_READ            (1 << 0)
> >  #define IOMMU_WRITE           (1 << 1)
> > -#define IOMMU_CACHE           (1 << 2) /* DMA cache coherency */
> > +#define IOMMU_CACHE_COHERENT  (1 << 2) /* cacheable and coherent */
> >  #define IOMMU_NOEXEC          (1 << 3)
> >  #define IOMMU_MMIO            (1 << 4) /* e.g. things like MSI doorbells */
> > +#define IOMMU_CACHEABLE       (1 << 5) /* cacheable, not coherent */
> 
> What does that even mean?

It means allocate in the cache, but don't propagate coherency.
In our case we have a device using an A57 cluster ACP port
to do stashing.  

             cluster
       +------------------+
       |   A57     A57    |                +----+
       |           ......ACP..<............|SMMU|<...device
       |  +--------.--+   |  non-coherent  +----+
       |  |    L2  v  |   | write w/allocate
       |  +--------.--+   |
       +-----------.------+
                   .
       +-----------v------+
       |     CCN-504      |
       +-------------.----+
                     .
              +------v------+
              |    device   |
              | (descriptor |
              |    rings)   | 
              +-------------+

The device in question is doing a cacheable write targeting some
device descriptor rings.  The purpose of this transaction is to stash
the descriptor ring data in the L2 cache so the driver on the
A57s can get@it with low latency.  It has to be non-coherent
because of stuff related to how things are hooked up to CCN-504
(can take more details offline if you want).  Because it is non
coherent, the driver obviously has to be affined to the cluster.
It's a lot of hoops to jump through, but the performance benefit
is worth it.

> > +#define IOMMU_CACHE_ALLOCATE  (1 << 6) /* hint to allocate in the cache */
> >
> > Also, are we willing to let somewhat architecture specific flags
> > onto that list?  For, example the ARM 'transient' hint.
> 
> If we're going to support fine-grained attribute control, I think it needs
> to be done in a page-table specific manner. That is, io-pgtable-arm could
> provide those attribute controls which feature in the ARMv8 architecture...

So there would be some new API for users like vfio?

> ...but that brings me onto my next question: Who on Earth is actually
> going to provide these attributes to the IOMMU API?
> 
> There seems to be a missing piece.

Currently it would be vfio, because the driver is in user space.
There are some details to be worked out regarding how vfio would
determine and provide the attributes.  This is a device on the
fsl-mc bus (see drivers/staging/fsl-mc/README.txt) and the
vfio-fsl-mc bus layer should be able to determine what attributes
to use.

Once the kernel dma map API is hooked up to the SMMU, I think there
could be similar requirements down the road for kernel drivers.
If a driver is  intelligent enough to use some of the fine grained
attributes, how can that be supported?

Thanks,
Stuart
