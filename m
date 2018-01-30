From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 30 Jan 2018 10:53:57 +0100
Subject: [PATCH 3/5] drm: add ARM64 flush implementations
In-Reply-To: <2cf40ed8-cb7c-3f17-a8e4-2cbf2fb980e6@arm.com>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
 <20180124025606.3020-3-gurchetansingh@chromium.org>
 <2cf40ed8-cb7c-3f17-a8e4-2cbf2fb980e6@arm.com>
Message-ID: <20180130095357.GI25930@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 12:00:59PM +0000, Robin Murphy wrote:
> On 24/01/18 02:56, Gurchetan Singh wrote:
> > This patch uses the __dma_map_area function to flush the cache
> > on ARM64.
> > 
> > v2: Don't use DMA API, call functions directly (Daniel)
> > 
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > ---
> >   drivers/gpu/drm/drm_cache.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> > index 5124582451c6..250cdfbb711f 100644
> > --- a/drivers/gpu/drm/drm_cache.c
> > +++ b/drivers/gpu/drm/drm_cache.c
> > @@ -159,6 +159,12 @@ drm_flush_pages(struct page *pages[], unsigned long num_pages)
> >   	for (i = 0; i < num_pages; i++)
> >   		drm_cache_maint_page(pages[i], 0, PAGE_SIZE, DMA_TO_DEVICE,
> >   				     dmac_map_area);
> > +#elif defined(CONFIG_ARM64)
> > +	unsigned long i;
> > +
> > +	for (i = 0; i < num_pages; i++)
> > +		__dma_map_area(phys_to_virt(page_to_phys(pages[i])), PAGE_SIZE,
> > +			       DMA_TO_DEVICE);
> 
> Note that this is not exactly equivalent to clflush - if it's at all
> possible for a non-coherent GPU to write back to these pages and someone
> somewhere expects to be able to read the updated data from a CPU, that's
> going to be subtly broken.
> 
> This also breaks building DRM as a module. And I doubt that either of the
> two easy solutions to that are going to fly with the respective
> maintainers...
> 
> Given all the bodging around which seems to happen in DRM/ION/etc., it would
> be really nice to pin down what exactly the shortcomings of the DMA API are
> for these use-cases, and extend it to address them properly.

tldr; a dma-buf exporter more-or-less has to act like a dma-api
architecture implementation. Which means flushing stuff at the right time.
Going through the dma-api means we need to pass around a struct device *
where none is needed, which seems silly. The original patches did add that
dummy struct device *, but after digging around in the actual
implementations we've noticed that there's no need for them.

Ofc you can question whether gpu drivers really need to noodle around in
such platform details, but given that all of them do that (all = those
that implement rendering, not just display) I'm just accepting that as a
fact of life. It's definitely unrealistic to demand those all get fixed,
even if the end result would be more maintainable.

We can ofc postpone this entire discussion by mandating that all shared
gpu buffers on ARM32 must be wc mapped by everyone. But at least on some
x86 machines (it's a function of how big your caches are and where your
gpu sits) cached access is actually faster for upload/download buffers.
Ofc since the dma-api tries to hide all this the wc vs. cached assumptions
are all implicit in dma-buf, which makes this all lots of fun.
-Daniel

> 
> Robin.
> 
> >   #else
> >   	pr_err("Architecture has no drm_cache.c support\n");
> >   	WARN_ON_ONCE(1);
> > @@ -196,6 +202,13 @@ drm_flush_sg(struct sg_table *st)
> >   	for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
> >   		drm_cache_maint_page(sg_page_iter_page(&sg_iter), 0, PAGE_SIZE,
> >   				     DMA_TO_DEVICE, dmac_map_area);
> > +#elif defined(CONFIG_ARM64)
> > +	int i;
> > +	struct scatterlist *sg;
> > +
> > +	for_each_sg(st->sgl, sg, st->nents, i)
> > +		__dma_map_area(phys_to_virt(sg_phys(sg)), sg->length,
> > +			       DMA_TO_DEVICE);
> >   #else
> >   	pr_err("Architecture has no drm_cache.c support\n");
> >   	WARN_ON_ONCE(1);
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
