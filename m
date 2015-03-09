From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 9 Mar 2015 22:46:29 +0800
Subject: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <CAAFQd5AhTe=d9tXN8kaRah_GiZYYxG0cD0up=cbHkSfbBnXmvQ@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5AhTe=d9tXN8kaRah_GiZYYxG0cD0up=cbHkSfbBnXmvQ@mail.gmail.com>
Message-ID: <1425912389.4871.19.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-09 at 20:11 +0900, Tomasz Figa wrote:
<...>
> > +/*
> > + * pimudev is a global var for dma_alloc_coherent.
> > + * It is not accepatable, we will delete it if "domain_alloc" is enabled
> > + */
> > +static struct device *pimudev;
> 
> This is indeed not acceptable. Could you replace dma_alloc_coherent()
> with something that doesn't require device pointer, e.g.
> alloc_pages()? (Although that would require you to handle cache
> maintenance in the driver, due to cached memory allocated.) I need to
> think about a better solution for this.

Hi,

For 2nd level page table, we use cached memory now. Currently we are
using __dma_flush_range to flush the cache, which is also unacceptable.

For proper cache management, we'll need to use dma_map_single or
dma_sync_*, which still need a deivce*.

Joe.C
