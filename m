From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jan 2015 18:00:45 +0100
Subject: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
 arm_iommu_attach_device()
In-Reply-To: <2416515.WUUq1g4kPD@avalon>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <10179212.ryUUVC9zEx@wuerfel> <2416515.WUUq1g4kPD@avalon>
Message-ID: <2036088.T8IpDXjCxc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 January 2015 17:55:25 Laurent Pinchart wrote:
> 
> On Friday 23 January 2015 16:27:24 Arnd Bergmann wrote:
> > On Friday 23 January 2015 16:21:49 Laurent Pinchart wrote:
> > > +/**
> > > + * arm_iommu_detach_device
> > > + * @dev: valid struct device pointer
> > > + *
> > > + * Detaches the provided device from a previously attached map.
> > > + * This voids the dma operations (dma_map_ops pointer)
> > > + */
> > > +void arm_iommu_detach_device(struct device *dev)
> > > +{
> > > +       __arm_iommu_detach_device(dev);
> > > +       set_dma_ops(dev, NULL);
> > > +}
> > > 
> > >  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> > 
> > Would this introduce a regression in the case where the device is
> > cache coherent and needs arm_coherent_dma_ops set?
> 
> I think we need to handle that case (as well as the coherent IOMMU case in 
> arm_iommu_attach_device), but this patch only tries to restore the previous 
> behaviour to fix the bug detailed in the commit message. Would you prefer 
> fixing both issues in one go ?
> 

No, I was specifically trying to find out whether the new behavior would
be worse than what we had in 3.18. If it's a preexisting bug that nobody
has run into, there is no hurry.

It's quite likely that to date, all IOMMU users on ARM32 are not
cache coherent.

	Arnd
