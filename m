From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 14 Dec 2014 17:49:34 +0200
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141210150853.GH23639@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAF6AEGs6dZauq1QxY_OqBPUs0xHYjjGTi+H7Vm-mNvJtmTAHRA@mail.gmail.com>
 <20141210150853.GH23639@arm.com>
Message-ID: <6860089.2Ca399bIPK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wednesday 10 December 2014 15:08:53 Will Deacon wrote:
> On Wed, Dec 10, 2014 at 02:52:56PM +0000, Rob Clark wrote:
> > On Mon, Dec 1, 2014 at 11:57 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > This patch extends of_dma_configure so that it sets up the IOMMU for a
> > > device, as well as the coherent/non-coherent DMA mapping ops.
> > > 
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > > 
> > >  arch/arm/include/asm/dma-mapping.h |  4 +++-
> > >  drivers/of/platform.c              | 21 ++++++++++++++-------
> > >  include/linux/dma-mapping.h        |  8 +++++++-
> > >  3 files changed, 24 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/arch/arm/include/asm/dma-mapping.h
> > > b/arch/arm/include/asm/dma-mapping.h index dc3420e77758..f3c0d953f6a2
> > > 100644
> > > --- a/arch/arm/include/asm/dma-mapping.h
> > > +++ b/arch/arm/include/asm/dma-mapping.h
> > > @@ -121,7 +121,9 @@ static inline unsigned long dma_max_pfn(struct
> > > device *dev)> > 
> > >  }
> > >  #define dma_max_pfn(dev) dma_max_pfn(dev)
> > > 
> > > -static inline void arch_setup_dma_ops(struct device *dev, bool
> > > coherent)
> > > +static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
> > > +                                     u64 size, struct iommu_ops *iommu,
> > > +                                     bool coherent)
> > >  {
> > >         if (coherent)
> > >                 set_dma_ops(dev, &arm_coherent_dma_ops);
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index ff1f4e9afccb..b89caf8c7586 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/of_iommu.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/of_platform.h>
> > >  #include <linux/platform_device.h>
> > > @@ -166,6 +167,7 @@ static void of_dma_configure(struct device *dev)
> > >         int ret;
> > >         bool coherent;
> > >         unsigned long offset;
> > > +       struct iommu_ops *iommu;
> > > 
> > >         /*
> > >          * Set default dma-mask to 32 bit. Drivers are expected to setup
> > > @@ -194,7 +196,16 @@ static void of_dma_configure(struct device *dev)
> > >         dev_dbg(dev, "device is%sdma coherent\n",
> > >                 coherent ? " " : " not ");
> > > 
> > > -       arch_setup_dma_ops(dev, coherent);
> > > +       iommu = of_iommu_configure(dev);
> > > +       dev_dbg(dev, "device is%sbehind an iommu\n",
> > > +               iommu ? " " : " not ");
> > > +
> > > +       arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> > 
> > so, what is the way for a driver that explicitly wants to manage it's
> > own device virtual address space to opt out of this?  I suspect that
> > won't be the common case, but for a gpu, if dma layer all of a sudden
> > thinks it is in control of the gpu's virtual address space, things are
> > going to end in tears..
> 
> I think you'll need to detach from the DMA domain, then have the driver
> manage everything itself. As you say, it's not the common case, so you
> may need to add some hooks for detaching from the default domain and
> swizzling your DMA ops.

I'm wondering if it's such an exotic case after all. I can see two reasons not 
to use the default domain. In addition to special requirements coming from the 
bus master side, the IOMMU itself might not support one domain per bus master 
(I'm of course raising the issue from a very selfish Renesas IPMMU point of 
view).

In that case the IOMMU driver can still detach the device from the default 
domain in the .of_xlate() callback and attach it to its private domain. I'm 
however wondering whether this case isn't common enough to avoid creating 
default domains in common code in the first place. IOMMU drivers that support 
one domain per master would then create device domain in their .of_xlate() 
callback.

-- 
Regards,

Laurent Pinchart
