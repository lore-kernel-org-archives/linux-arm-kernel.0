From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jan 2018 15:06:48 +0100
Subject: [PATCH 2/5] drm: add ARM flush implementation
In-Reply-To: <20180124192610.GA30716@n2100.armlinux.org.uk>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
 <20180124124542.GV17719@n2100.armlinux.org.uk>
 <CAAfnVBkwmrcr14ZhmhgAnLHwL8zotnnCeWAVwBGmVcU9oGRerA@mail.gmail.com>
 <20180124192610.GA30716@n2100.armlinux.org.uk>
Message-ID: <20180125140648.GA27888@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 07:26:11PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 24, 2018 at 10:45:28AM -0800, Gurchetan Singh wrote:
> > On Wed, Jan 24, 2018 at 4:45 AM, Russell King - ARM Linux <
> > linux at armlinux.org.uk> wrote:
> > > So no, this is not an acceptable approach.
> > >
> > > Secondly, in light of spectre and meltdown, do we _really_ want to
> > > export cache flushing to userspace in any case - these attacks rely
> > > on being able to flush specific cache lines from the caches in order
> > > to do the timing attacks (while leaving others in place.)
> > 
> > > Currently, 32-bit ARM does not export such flushing capabilities to
> > > userspace, which makes it very difficult (I'm not going to say
> > > impossible) to get any working proof-of-code program that even
> > > illustrates the timing attack.  Exposing this functionality changes
> > > that game, and means that we're much more open to these exploits.
> > > (Some may say that you can flush cache lines by reading a large
> > > enough buffer - I'm aware, I've tried that, the results are too
> > > unreliable even for a simple attempt which doesn't involve crossing
> > > privilege boundaries.)
> > >
> > 
> > Will using the DMA API (dma_sync_single_for_device /
> > dma_sync_sg_for_device) mitigate your Meltdown / Spectre concerns in any
> > way?
> 
> I see no point in answering that question based on what you've written
> below (see below for why).
> 
> > > Do you really need cacheable GPU buffers, or will write combining
> > > buffers (as we use elsewhere such as etnaviv) suffice?  Please provide
> > > some _real_ _world_ performance measurements that demonstrate that
> > > there is a real need for this functionality.
> > 
> > 
> > My desire is for the vgem driver to work correctly on ARM, which requires
> > cache flushing.  The mappings vgem itself creates are write combine.
> 
> If the pages are mapped write-combine, they are by definition *not*
> cacheable, so there should be no cache flushing required.
> 
> > The
> > issue is the pages retrieved on ARM architecture usually have to be flushed
> > before they can be used (see rockchip_gem_get_pages / tegra_bo_get_pages).
> > This patch set attempts to do the flushing in an architecture independent
> > manner (since vgem is intended to work on ARM / x86).
> 
> I see rockchip_gem_get_pages() using shmem_read_mapping_page() to get
> the pages.  That's more or less fine, we do that on Etnaviv too.
> 
> (Side note: provided the pages are not coming from lowmem, as mapping
> lowmem pages are mapped cacheable, and if you also map them elsewhere
> as write-combine, you're stepping into some potential cache attribute
> issues.)
> 
> How we deal with this in Etnaviv is to use dma_map_sg() after we get
> the pages - see
> 
>   etnaviv_gem_get_pages(), which calls the memory specific .get_pages
>     method, and goes on to call etnaviv_gem_scatter_map().

I think I'm to blame for this. Back at the time the patch was based on
my incomplete understanding of the DMA API. It's also possible that it
wasn't working at the time because the DMA/IOMMU glue wasn't quite the
same as it is today. I have a vague recollection that I tried using
dma_map_sg() and it was creating a second IOVA mapping (in addition to
the one we explicitly create in the driver with the IOMMU API).

However, that's no longer happening today, so I ended up doing something
very similar to etnaviv. I've got the below patch queued for v4.17 and I
think the same should work for both Rockchip and VGEM.

Thierry

--- >8 ---
>From 0f83d1aefcd0ca49c88d483a4161e3a02b5d1f32 Mon Sep 17 00:00:00 2001
From: Thierry Reding <treding@nvidia.com>
Date: Wed, 13 Dec 2017 12:22:48 +0100
Subject: [PATCH] drm/tegra: gem: Map pages via the DMA API

When allocating pages, map them with the DMA API in order to invalidate
caches. This is the correct usage of the API and works just as well as
faking up the SG table and using the dma_sync_sg_for_device() function.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/gem.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 1bc5c6d1e5b5..8ab6057808e6 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -203,6 +203,8 @@ static struct tegra_bo *tegra_bo_alloc_object(struct drm_device *drm,
 static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 {
 	if (bo->pages) {
+		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
+			     DMA_BIDIRECTIONAL);
 		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
 		sg_free_table(bo->sgt);
 		kfree(bo->sgt);
@@ -213,8 +215,7 @@ static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 
 static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 {
-	struct scatterlist *s;
-	unsigned int i;
+	int err;
 
 	bo->pages = drm_gem_get_pages(&bo->gem);
 	if (IS_ERR(bo->pages))
@@ -223,27 +224,26 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 	bo->num_pages = bo->gem.size >> PAGE_SHIFT;
 
 	bo->sgt = drm_prime_pages_to_sg(bo->pages, bo->num_pages);
-	if (IS_ERR(bo->sgt))
+	if (IS_ERR(bo->sgt)) {
+		err = PTR_ERR(bo->sgt);
 		goto put_pages;
+	}
 
-	/*
-	 * Fake up the SG table so that dma_sync_sg_for_device() can be used
-	 * to flush the pages associated with it.
-	 *
-	 * TODO: Replace this by drm_clflash_sg() once it can be implemented
-	 * without relying on symbols that are not exported.
-	 */
-	for_each_sg(bo->sgt->sgl, s, bo->sgt->nents, i)
-		sg_dma_address(s) = sg_phys(s);
-
-	dma_sync_sg_for_device(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			       DMA_TO_DEVICE);
+	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
+			 DMA_BIDIRECTIONAL);
+	if (err == 0) {
+		err = -EFAULT;
+		goto free_sgt;
+	}
 
 	return 0;
 
+free_sgt:
+	sg_free_table(bo->sgt);
+	kfree(bo->sgt);
 put_pages:
 	drm_gem_put_pages(&bo->gem, bo->pages, false, false);
-	return PTR_ERR(bo->sgt);
+	return err;
 }
 
 static int tegra_bo_alloc(struct drm_device *drm, struct tegra_bo *bo)
-- 
2.15.1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180125/a76bd96b/attachment.sig>
