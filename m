From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 14 Apr 2015 14:50:09 +0800
Subject: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <550C71B3.1080708@arm.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
 <1426677749.22581.38.camel@mhfsdcap03> <550C71B3.1080708@arm.com>
Message-ID: <1428994209.13552.29.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
      Thanks very much for your confirm.
      About the v3 of the DMA-mapping, I have some question below.

On Fri, 2015-03-20 at 19:14 +0000, Robin Murphy wrote:
> On 18/03/15 11:22, Yong Wu wrote:
> > Hi Tomasz,
> >     Thanks very much for your review. please help check below.
> > The others I will fix in the next version.
> >
> > Hi Robin,
> >     There are some place I would like you can have a look and give me
> > some suggestion.
> >
> > On Wed, 2015-03-11 at 19:53 +0900, Tomasz Figa wrote:
> >> Hi,
> >>
> >> Please find next part of my comments inline.
> >>
> >>> +/*
> >>> + * pimudev is a global var for dma_alloc_coherent.
> >>> + * It is not accepatable, we will delete it if "domain_alloc" is enabled
> >>
> >> It looks like we indeed need to use dma_alloc_coherent() and we don't
> >> have a good way to pass the device pointer to domain_init callback.
> >>
> >> If you don't expect SoCs in the nearest future to have multiple M4U
> >> blocks, then I guess this global variable could stay, after changing
> >> the comment into an explanation why it's correct. Also it should be
> >> moved to the top of the file, below #include directives, as this is
> >> where usually global variables are located.
> > @Robin,
> >       We have merged this patch[0] in order to delete the global var, But
> > it seems that your patch of "arm64:IOMMU" isn't based on it right row.
> > it will build fail.
> 
> Yeah, I've not yet managed to try pulling in that series (much as I 
> approve of it), partly as I know doing so is going to lean towards a 
> not-insignificant rework and I'd rather avoid picking up more unmerged 
> dependencies to block getting _something_ in for arm64 (which we can 
> then improve).
> 
> >
> > [0]:http://lists.linuxfoundation.org/pipermail/iommu/2015-January/011939.html
> >
[snip]
> 
> Calling arch_setup_dma_ops() from the driver looks plain wrong, 
> especially given that you apparently attach the IOMMU to itself - if you 
> want your own domain you should use iommu_dma_create_domain(). I admit 
> that still leaves you having to dance around a bit in order to tear down 
> the automatic domains for now, but hopefully we'll get the core code 
> sorted out sooner rather than later.
> >>> +
> >>> +                       mtk_iommu_config_port(piommu, portid);
> >>> +
> >>> +                       if (i == 0)
> >>> +                               dev->archdata.dma_ops =
> >>> +                                       piommu->dev->archdata.dma_ops;
> >>
> >> Shouldn't this be set automatically by IOMMU or DMA mapping core?
> > @Robin,
> >       In the original "arm_iommu_attach_device" of arm/mm, it will call
> > set_dma_ops to add iommu_ops for each iommu device.
> > But iommu_dma_attach_device don't help this, so I have to add it here.
> > Could this be improved?
> 
> If you implemented a simple of_xlate callback so that the core code 
> handles the dma_ops as intended, I think the simplest cheat would be to 
> check the client device's domain, either on attachment or when they 
> start mapping/unmapping, and move them to your own domain if necessary. 
> I'm putting together a v3 of the DMA mapping series, so I'll have a look 
> to see if I can squeeze in a way to make that a bit less painful until 
> we solve it properly.
> 
> 
> Robin.
> 
      I have implemented a simple of_xlate, but I can?t get the standard
struct dma_map_ops ?iommu_dma_ops? to assigned it to the client device.
So the v3 of dma mapping will improve this issue?  

      And Is the v3 of the DMA-mapping based on 4.0-rc1? because we
expect it could contain will?s io-pagetable.

      And when the v3 will be ready?
> >>
> >>> +               }
> >>> +               i++;
> >>> +       }
> >>> +
> >>> +       spin_unlock_irqrestore(&priv->portlock, flags);
> >>> +
> >>> +imudev:
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +static void mtk_iommu_detach_device(struct iommu_domain *domain,
> >>> +                                   struct device *dev)
> >>> +{
> >>
> >> No hardware (de)configuration or clean-up necessary?
> > I will add it. Actually we design like this:If a device have attached to
> > iommu domain, it won't detach from it.
> >>
> >>> +}
> >>> +
> > [snip]
