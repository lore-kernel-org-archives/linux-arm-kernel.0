From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jul 2015 16:31:48 +0100
Subject: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <55B630CE.4050803@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
 <55B630CE.4050803@arm.com>
Message-ID: <20150727153148.GJ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 02:23:26PM +0100, Robin Murphy wrote:
> On 16/07/15 10:04, Yong Wu wrote:
> >This patch adds support for mediatek m4u (MultiMedia Memory Management
> >Unit).
> >
> >Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [...]
> >+static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> >+{
> >+       struct mtk_iommu_domain *domain = cookie;
> >+       unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
> >+
> >+       dma_map_page(domain->data->dev, virt_to_page(ptr), offset,
> >+                    size, DMA_TO_DEVICE);
> 
> Nit: this looks like it may as well be dma_map_single.
> 
> It would probably be worth following it with a matching unmap too, just to
> avoid any possible leakage bugs (especially if this M4U ever appears in a
> SoC supporting RAM above the 32-bit boundary).

Why not do the job properly?  Take a look at how I implemented the
streaming DMA API on Tegra SMMU (patch set recently sent out earlier
today).

There's no need for hacks like dma_map_page() (and discarding it's
return value) or dma_map_page() followed by dma_unmap_page().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
