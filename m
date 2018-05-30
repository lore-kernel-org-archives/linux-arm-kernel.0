From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 May 2018 14:54:46 +0200
Subject: [PATCH v3 1/2] ARM: dma-mapping: Implement
 arm_dma_iommu_detach_device()
In-Reply-To: <eee02391-aa25-da84-f98a-b5fed6c69599@arm.com>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
 <20180530080345.2353-2-thierry.reding@gmail.com>
 <eee02391-aa25-da84-f98a-b5fed6c69599@arm.com>
Message-ID: <20180530125446.GA1595@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 10:59:30AM +0100, Robin Murphy wrote:
> On 30/05/18 09:03, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Implement this function to enable drivers from detaching from any IOMMU
> > domains that architecture code might have attached them to so that they
> > can take exclusive control of the IOMMU via the IOMMU API.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v3:
> > - make API 32-bit ARM specific
> > - avoid extra local variable
> > 
> > Changes in v2:
> > - fix compilation
> > 
> >   arch/arm/include/asm/dma-mapping.h |  3 +++
> >   arch/arm/mm/dma-mapping-nommu.c    |  4 ++++
> >   arch/arm/mm/dma-mapping.c          | 16 ++++++++++++++++
> >   3 files changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > index 8436f6ade57d..5960e9f3a9d0 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -103,6 +103,9 @@ extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >   #define arch_teardown_dma_ops arch_teardown_dma_ops
> >   extern void arch_teardown_dma_ops(struct device *dev);
> > +#define arm_dma_iommu_detach_device arm_dma_iommu_detach_device
> > +extern void arm_dma_iommu_detach_device(struct device *dev);
> > +
> >   /* do not use this function in a driver */
> >   static inline bool is_device_dma_coherent(struct device *dev)
> >   {
> > diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> > index f448a0663b10..eb781369377b 100644
> > --- a/arch/arm/mm/dma-mapping-nommu.c
> > +++ b/arch/arm/mm/dma-mapping-nommu.c
> > @@ -241,3 +241,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >   void arch_teardown_dma_ops(struct device *dev)
> >   {
> >   }
> > +
> > +void arm_dma_iommu_detach_device(struct device *dev)
> > +{
> > +}
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index af27f1c22d93..6d8af08b3e7d 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2400,3 +2400,19 @@ void arch_teardown_dma_ops(struct device *dev)
> >   	arm_teardown_iommu_dma_ops(dev);
> >   }
> > +
> > +void arm_dma_iommu_detach_device(struct device *dev)
> > +{
> > +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> > +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> > +
> > +	if (!mapping)
> > +		return;
> > +
> > +	arm_iommu_release_mapping(mapping);
> 
> Potentially freeing the mapping before you try to operate on it is never the
> best idea. Plus arm_iommu_detach_device() already releases a reference
> appropriately anyway, so it's a double-free.

But the reference released by arm_iommu_detach_device() is to balance
out the reference acquired by arm_iommu_attach_device(), isn't it? In
the above, the arm_iommu_release_mapping() is supposed to drop the
final reference which was obtained by arm_iommu_create_mapping(). The
mapping shouldn't go away irrespective of the order in which these
will be called.

> > +	arm_iommu_detach_device(dev);
> > +
> > +	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
> > +#endif
> > +}
> > +EXPORT_SYMBOL(arm_dma_iommu_detach_device);
> 
> I really don't see why we need an extra function that essentially just
> duplicates arm_iommu_detach_device(). The only real difference here is that
> here you reset the DMA ops more appropriately, but I think the existing
> function should be fixed to do that anyway, since set_dma_ops(dev, NULL) now
> just behaves as an unconditional fallback to the noncoherent arm_dma_ops,
> which clearly isn't always right.

The idea behind making this an extra function is that we can call it
unconditionally and it will do the right things. Granted, that already
doesn't quite work as elegantly anymore as I had hoped since this is
now an ARM specific function, so we need an #ifdef guard anyway.

I don't care very strongly either way, so if you and Christoph can both
agree that we just want arm_iommu_detach_device() to call the proper
variant of set_dma_ops(), that's fine with me, too.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/38fbec80/attachment-0001.sig>
