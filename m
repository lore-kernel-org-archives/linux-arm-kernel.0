From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Apr 2018 14:14:09 +0200
Subject: [PATCH v2 3/5] ARM: dma-mapping: Implement
 arch_iommu_detach_device()
In-Reply-To: <20180425152049.GD16075@infradead.org>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-3-thierry.reding@gmail.com>
 <20180425152049.GD16075@infradead.org>
Message-ID: <20180426121409.GE11985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 08:20:49AM -0700, Christoph Hellwig wrote:
> > +void arch_iommu_detach_device(struct device *dev)
> > +{
> > +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> > +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> > +	const struct dma_map_ops *dma_ops;
> > +
> > +	if (!mapping)
> > +		return;
> > +
> > +	arm_iommu_release_mapping(mapping);
> > +	arm_iommu_detach_device(dev);
> > +
> > +	dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
> > +	set_dma_ops(dev, dma_ops);
> 
> Why not simply:
> 
> 	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));

I had that initially, but it looked cluttered to me, so I split it up.
I don't care much either way, so I can revert to that if you prefer.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/c380f505/attachment.sig>
