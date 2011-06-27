From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Jun 2011 16:29:26 +0200
Subject: [PATCH 2/8] ARM: dma-mapping: implement dma_map_single on top of
	dma_map_page
In-Reply-To: <201106241724.21113.arnd@arndb.de>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<20110620143911.GD26089@n2100.arm.linux.org.uk>
	<000101cc2f5c$ec21da40$c4658ec0$%szyprowski@samsung.com>
	<201106241724.21113.arnd@arndb.de>
Message-ID: <000a01cc34d6$9e4576e0$dad064a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 24, 2011 5:24 PM Arnd Bergmann wrote:

> On Monday 20 June 2011, Marek Szyprowski wrote:
> > > This also breaks dmabounce when used with a highmem-enabled system -
> > > dmabounce refuses the dma_map_page() API but allows the
> dma_map_single()
> > > API.
> >
> > I really not sure how this change will break dma bounce code.
> >
> > Does it mean that it is allowed to call dma_map_single() on kmapped
> > HIGH_MEM page?
> 
> dma_map_single on a kmapped page already doesn't work, the argument needs
> to be inside of the linear mapping in order for virt_to_page to work.

Then I got really confused.

Documentation/DMA-mapping.txt says that dma_map_single() can be used only
with kernel linear mapping, while dma_map_page() can be also called on 
HIGHMEM pages.

Now, lets go to arch/arm/common/dmabounce.c code:

dma_addr_t __dma_map_page(struct device *dev, struct page *page,
                unsigned long offset, size_t size, enum dma_data_direction dir)
{
        dev_dbg(dev, "%s(page=%p,off=%#lx,size=%zx,dir=%x)\n",
                __func__, page, offset, size, dir);

        BUG_ON(!valid_dma_direction(dir));

        if (PageHighMem(page)) {
                dev_err(dev, "DMA buffer bouncing of HIGHMEM pages "
                             "is not supported\n");
                return ~0;
        }

        return map_single(dev, page_address(page) + offset, size, dir);
}
EXPORT_SYMBOL(__dma_map_page);

Am I right that there is something mixed here? I really don't get why there is
high mem check in dma_map_page implementation. dma_map_single doesn't perform
such check and works with kmapped highmem pages...

Russell also pointed that my patch broke dma bounch with high mem enabled.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
