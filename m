From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 18:46:00 +0100
Subject: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <4252161.sBJZLIS2WH@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-6-git-send-email-will.deacon@arm.com>
 <4252161.sBJZLIS2WH@avalon>
Message-ID: <20140922174600.GJ7936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 12:17:33PM +0100, Laurent Pinchart wrote:
> Hi Will,

Hello again,

> On Friday 12 September 2014 17:34:53 Will Deacon wrote:
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

Indeed, I've not done anything to the ARM dma-mapping ops other than plug-in
the existing code, which doesn't use these new features. I think Marek was
going to look at that.

> By the way, now that I think about it, I find struct iommu_dma_mapping and 
> struct dma_iommu_mapping very confusing.

Yup; I'd like to see some generic code that uses the per-IOMMU-instance
domain and allocator which is passed to arch_setup_dma_ops. Then we could
simply move arch/arm/ (and arm64) over to that, which would get rid of
dma_iommu_mapping entirely.

Will
