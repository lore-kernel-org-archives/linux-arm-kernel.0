From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 10 Mar 2015 11:41:47 +0800
Subject: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <CAAFQd5DpXxyoNiTGC4YYnpXeKo43XXrC+my6KWOV1pGq1jw6Aw@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5AhTe=d9tXN8kaRah_GiZYYxG0cD0up=cbHkSfbBnXmvQ@mail.gmail.com>
 <1425912389.4871.19.camel@mtksdaap41>
 <CAAFQd5DpXxyoNiTGC4YYnpXeKo43XXrC+my6KWOV1pGq1jw6Aw@mail.gmail.com>
Message-ID: <1425958907.4871.102.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-03-10 at 02:00 +0900, Tomasz Figa wrote:
> On Mon, Mar 9, 2015 at 11:46 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> > On Mon, 2015-03-09 at 20:11 +0900, Tomasz Figa wrote:
> > <...>
> >> > +/*
> >> > + * pimudev is a global var for dma_alloc_coherent.
> >> > + * It is not accepatable, we will delete it if "domain_alloc" is enabled
> >> > + */
> >> > +static struct device *pimudev;
> >>
> >> This is indeed not acceptable. Could you replace dma_alloc_coherent()
> >> with something that doesn't require device pointer, e.g.
> >> alloc_pages()? (Although that would require you to handle cache
> >> maintenance in the driver, due to cached memory allocated.) I need to
> >> think about a better solution for this.
> >
> > Hi,
> >
> > For 2nd level page table, we use cached memory now. Currently we are
> > using __dma_flush_range to flush the cache, which is also unacceptable.
> >
> > For proper cache management, we'll need to use dma_map_single or
> > dma_sync_*, which still need a deivce*.
> 
> Looking at how already mainlined drivers do this, they either use
> dmac_flush_range()
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/msm_iommu.c?id=refs/tags/v4.0-rc3#n80)
> or directly __cpuc_flush_dcache_area() and outer_flush_range()
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/rockchip-iommu.c?id=refs/tags/v4.0-rc3#n93).

Hi,

These only exist in arch/arm, not arm64. I think we should avoid using
API start with __ in drivers. This driver might be used in both
arm/arm64, I think the only option for us is DMA APIs.

Actually, I'm thinking that we should change to use coherent memory for
2nd level page table as well and totally skip the cache flush. It seems
dma_pool_create is suitable to replace kmem_cache we are using right
now. However it still need a device*, which we have to fix anyway.

Joe.C
