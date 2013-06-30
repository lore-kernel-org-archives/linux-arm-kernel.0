From: daniel@ffwll.ch (Daniel Vetter)
Date: Sun, 30 Jun 2013 14:37:41 +0200
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
Message-ID: <20130630123741.GJ18285@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 11:53:22PM +0100, Russell King wrote:
> This patch adds support for the pair of LCD controllers on the Marvell
> Armada 510 SoCs.  This driver supports:
> - multiple contiguous scanout buffers for video and graphics
> - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
>   acceleration
> - dual lcd0 and lcd1 crt operation
> - video overlay on each LCD crt
> - page flipping of the main scanout buffers
> 
> Included in this commit is the core driver with no output support; output
> support is platform and encoder driver dependent.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Found one more ...

[snip]

> +int
> +armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
> +{
> +	struct armada_private *priv = dev->dev_private;
> +	size_t size = obj->obj.size;
> +
> +	if (obj->page || obj->linear)
> +		return 0;
> +
> +	/*
> +	 * If it is a small allocation (typically cursor, which will
> +	 * be 32x64 or 64x32 ARGB pixels) try to get it from the system.
> +	 * Framebuffers will never be this small (our minimum size for
> +	 * framebuffers is larger than this anyway.)  Such objects are
> +	 * only accessed by the CPU so we don't need any special handing
> +	 * here.
> +	 */
> +	if (size <= 8192) {
> +		unsigned int order = get_order(size);
> +		struct page *p = alloc_pages(GFP_KERNEL, order);
> +
> +		if (p) {
> +			obj->addr = page_address(p);
> +			obj->phys_addr = page_to_phys(p);
> +			obj->page = p;
> +
> +			memset(obj->addr, 0, PAGE_ALIGN(size));
> +		}
> +	}
> +
> +	/*
> +	 * We could grab something from CMA if it's enabled, but that
> +	 * involves building in a problem:
> +	 *
> +	 * CMA's interface uses dma_alloc_coherent(), which provides us
> +	 * with an CPU virtual address and a device address.
> +	 *
> +	 * The CPU virtual address may be either an address in the kernel
> +	 * direct mapped region (for example, as it would be on x86) or
> +	 * it may be remapped into another part of kernel memory space
> +	 * (eg, as it would be on ARM.)  This means virt_to_phys() on the
> +	 * returned virtual address is invalid depending on the architecture
> +	 * implementation.
> +	 *
> +	 * The device address may also not be a physical address; it may
> +	 * be that there is some kind of remapping between the device and
> +	 * system RAM, which makes the use of the device address also
> +	 * unsafe to re-use as a physical address.
> +	 *
> +	 * This makes DRM usage of dma_alloc_coherent() in a generic way
> +	 * at best very questionable and unsafe.
> +	 */
> +
> +	/* Otherwise, grab it from our linear allocation */
> +	if (!obj->page) {
> +		struct drm_mm_node *free;
> +		unsigned align = min_t(unsigned, size, SZ_2M);
> +		void __iomem *ptr;
> +
> +		mutex_lock(&dev->struct_mutex);
> +		free = drm_mm_search_free(&priv->linear, size, align, 0);
> +		if (free)
> +			obj->linear = drm_mm_get_block(free, size, align);
> +		mutex_unlock(&dev->struct_mutex);

The two-stage search_free+get_block drm_mm interface is something I'd like
to remove since it' complicates the interface for no gain. And the
preallocation trick for atomic contexts is pretty racy as-is. Can you
please convert this over to the insert_node interfaces which take a
preallocate drm_mm_node?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
