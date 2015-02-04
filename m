From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Feb 2015 10:29:53 +0000
Subject: [PATCH v2 1/2] drm/exynos: fix DMA_ATTR_NO_KERNEL_MAPPING usage
In-Reply-To: <54D1F263.4000006@samsung.com>
References: <1423041800-27859-1-git-send-email-carlo@caione.org>
 <1423041800-27859-2-git-send-email-carlo@caione.org>
 <54D1F263.4000006@samsung.com>
Message-ID: <20150204102953.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 11:20:19AM +0100, Marek Szyprowski wrote:
> >diff --git a/drivers/gpu/drm/exynos/exynos_drm_buf.c b/drivers/gpu/drm/exynos/exynos_drm_buf.c
> >index 9c80884..24994ba 100644
> >--- a/drivers/gpu/drm/exynos/exynos_drm_buf.c
> >+++ b/drivers/gpu/drm/exynos/exynos_drm_buf.c
> >@@ -63,11 +63,11 @@ static int lowlevel_buffer_allocate(struct drm_device *dev,
> >  			return -ENOMEM;
> >  		}
> >-		buf->kvaddr = (void __iomem *)dma_alloc_attrs(dev->dev,
> >+		buf->cookie = dma_alloc_attrs(dev->dev,
> >  					buf->size,
> >  					&buf->dma_addr, GFP_KERNEL,
> >  					&buf->dma_attrs);
> >-		if (!buf->kvaddr) {
> >+		if (!buf->cookie) {
> >  			DRM_ERROR("failed to allocate buffer.\n");
> >  			ret = -ENOMEM;
> >  			goto err_free;

I wonder whether anyone has looked at what exynos is doing with this.

                start_addr = buf->dma_addr;
                while (i < nr_pages) {
                        buf->pages[i] = phys_to_page(start_addr);
                        start_addr += PAGE_SIZE;
                        i++;
                }

There is no guarantee that DMA addresses are the same as physical addresses
in the kernel, so this is a layering violation.  If you want to do this,
then a better way to do this on ARM would be:

			buf->pages[i] = pfn_to_page(dma_to_pfn(dev, start_addr));

The difference here is that dma_to_pfn() knows how to convert a dma_addr_t
to a PFN which can then be converted to a struct page (provided it is
backed by kernel managed system memory.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
