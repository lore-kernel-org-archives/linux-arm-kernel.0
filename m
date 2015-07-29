From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 29 Jul 2015 13:41:31 +0800
Subject: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <55B6530A.9050903@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
 <55B630CE.4050803@arm.com> <20150727153148.GJ7557@n2100.arm.linux.org.uk>
 <55B6530A.9050903@arm.com>
Message-ID: <1438148491.25925.89.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-27 at 16:49 +0100, Robin Murphy wrote:
> On 27/07/15 16:31, Russell King - ARM Linux wrote:
> > On Mon, Jul 27, 2015 at 02:23:26PM +0100, Robin Murphy wrote:
> >> On 16/07/15 10:04, Yong Wu wrote:
> >>> This patch adds support for mediatek m4u (MultiMedia Memory Management
> >>> Unit).
> >>>
> >>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >> [...]
> >>> +static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> >>> +{
> >>> +       struct mtk_iommu_domain *domain = cookie;
> >>> +       unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
> >>> +
> >>> +       dma_map_page(domain->data->dev, virt_to_page(ptr), offset,
> >>> +                    size, DMA_TO_DEVICE);
> >>
> >> Nit: this looks like it may as well be dma_map_single.
> >>
> >> It would probably be worth following it with a matching unmap too, just to
> >> avoid any possible leakage bugs (especially if this M4U ever appears in a
> >> SoC supporting RAM above the 32-bit boundary).
> >
> > Why not do the job properly?  Take a look at how I implemented the
> > streaming DMA API on Tegra SMMU (patch set recently sent out earlier
> > today).
> >
> > There's no need for hacks like dma_map_page() (and discarding it's
> > return value) or dma_map_page() followed by dma_unmap_page().
> 
> Indeed, as it happens I do have a branch where I prototyped that for the 
> long-descriptor io-pgtable-arm code a while ago; this discussion has 
> prompted me to dig it up again. Stay tuned, folks...

Hi Russell, Robin,

     From I see in arm-smmu-v3.c in v4.2-rc1, 
     
     The flush_pgtable seems like this:
//==========
	dma_addr_t dma_addr;

	dma_addr = dma_map_page(dev, ptr, size, DMA_TO_DEVICE);

	if (dma_mapping_error(dev, dma_addr))
		dev_err(dev, "failed to flush pgtable at %p\n", ptr);
	else
		dma_unmap_page(dev, dma_addr, size, DMA_TO_DEVICE);
//==========
       I will change map like this and use dma_map_single instead.

       Is this also seems to be not proper?

       Then how to do it?  add this before unmap? :
       dma_sync_single_for_device(dev, dma_addr, size, DMA_TO_DEVICE);

> 
> Robin.
> 
