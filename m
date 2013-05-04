From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 04 May 2013 21:28:20 +0200
Subject: DMA mapping API abuse in exynos-drm
Message-ID: <2146981.l1bUpBI0CH@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Recently I've been working a bit on a DRM driver for the GPU of Samsung 
S3C6410 SoCs, which required me to familiarize a bit with exynos-drm, as 
it already contains a KMS driver which is compatible with the SoC I'm 
working with, making it a good place to put my driver in.

Reading through exynos_drm_buf.c I stumbled across following (a bit long) 
piece of code:

        dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &buf->dma_attrs);

        nr_pages = buf->size >> PAGE_SHIFT;

        if (!is_drm_iommu_supported(dev)) {
                dma_addr_t start_addr;
                unsigned int i = 0;

                buf->pages = kzalloc(sizeof(struct page) * nr_pages,
                                        GFP_KERNEL);
                if (!buf->pages) {
                        DRM_ERROR("failed to allocate pages.\n");
                        return -ENOMEM;
                }

                buf->kvaddr = dma_alloc_attrs(dev->dev, buf->size,
                                        &buf->dma_addr, GFP_KERNEL,
                                        &buf->dma_attrs);
                if (!buf->kvaddr) {
                        DRM_ERROR("failed to allocate buffer.\n");
                        kfree(buf->pages);
                        return -ENOMEM;
                }

                start_addr = buf->dma_addr;
                while (i < nr_pages) {
                        buf->pages[i] = phys_to_page(start_addr);
                        start_addr += PAGE_SIZE;
                        i++;
                }
        } else {

                buf->pages = dma_alloc_attrs(dev->dev, buf->size,
                                        &buf->dma_addr, GFP_KERNEL,
                                        &buf->dma_attrs);
                if (!buf->pages) {
                        DRM_ERROR("failed to allocate buffer.\n");
                        return -ENOMEM;
                }
        }

        buf->sgt = drm_prime_pages_to_sg(buf->pages, nr_pages);
        if (!buf->sgt) {
                DRM_ERROR("failed to get sg table.\n");
                ret = -ENOMEM;
                goto err_free_attrs;
        }

Notice that the value returned by dma_alloc_attrs() is assumed by this 
code to be either a kernel virtual address (in !is_drm_iommu_supported() 
case) or struct pages ** (in is_drm_iommu_supported() case), which seemed 
a bit worrying to me, making me do a more in depth research on how 
dma_alloc_attrs works.

This, in turn, led me to following excerpt of Documentation/DMA-
attributes.txt :

DMA_ATTR_NO_KERNEL_MAPPING
--------------------------

DMA_ATTR_NO_KERNEL_MAPPING lets the platform to avoid creating a kernel
virtual mapping for the allocated buffer. On some architectures creating
such mapping is non-trivial task and consumes very limited resources
(like kernel virtual address space or dma consistent address space).
Buffers allocated with this attribute can be only passed to user space
by calling dma_mmap_attrs(). By using this API, you are guaranteeing
that you won't dereference the pointer returned by dma_alloc_attr(). You
can threat it as a cookie that must be passed to dma_mmap_attrs() and
dma_free_attrs(). Make sure that both of these also get this attribute
set on each call.

of which the following sentence is the most relevant:

By using this API, you are guaranteeing that you won't dereference the 
pointer returned by dma_alloc_attr().

This statement is obviously ignored by buffer allocation code of exynos-
drm.

A simple git blame revealed that this brokenness has been introduced by 
commit:

4744ad2 drm/exynos: use DMA_ATTR_NO_KERNEL_MAPPING attribute


and later fixed a bit by following depending patches (because the original 
patch apparently broke any allocations without IOMMU):

c704f1b drm/exynos: consider no iommu support to console framebuffer
694be45 drm/exynos: consider buffer allocation without iommu


Now, the real question is whether my reasoning is incorrect (sorry for the 
noise then) or this is really a bug which needs to be fixed?

Best regards,
Tomasz
