From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 2 Oct 2014 10:39:42 +0200
Subject: [RFC 09/10] drm/tegra: Add IOMMU support
In-Reply-To: <CAOw6vbLFLrqWYB-4N50G7oucgMD+xd+QtdcMSzX4z7xRiU-vPQ@mail.gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
 <CAOw6vbJy6oy7cibH4f332UM=kS56KUMcnYdUTG0pEYXyQkFDoQ@mail.gmail.com>
 <CAOw6vbLFLrqWYB-4N50G7oucgMD+xd+QtdcMSzX4z7xRiU-vPQ@mail.gmail.com>
Message-ID: <20141002083941.GE30167@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 11:54:11AM -0400, Sean Paul wrote:
> On Tue, Sep 30, 2014 at 2:48 PM, Sean Paul <seanpaul@google.com> wrote:
> > On Thu, Jun 26, 2014 at 4:49 PM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> When an IOMMU device is available on the platform bus, allocate an IOMMU
> >> domain and attach the display controllers to it. The display controllers
> >> can then scan out non-contiguous buffers by mapping them through the
> >> IOMMU.
> >>
> >
> > Hi Thierry,
> > A few comments from St?phane and myself that came up while we were
> > reviewing this for our tree.
> >
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >>  drivers/gpu/drm/tegra/dc.c  |  21 ++++
> >>  drivers/gpu/drm/tegra/drm.c |  17 ++++
> >>  drivers/gpu/drm/tegra/drm.h |   3 +
> >>  drivers/gpu/drm/tegra/fb.c  |  16 ++-
> >>  drivers/gpu/drm/tegra/gem.c | 236 +++++++++++++++++++++++++++++++++++++++-----
> >>  drivers/gpu/drm/tegra/gem.h |   4 +
> >>  6 files changed, 273 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> >> index afcca04f5367..0f7452d04811 100644
> >> --- a/drivers/gpu/drm/tegra/dc.c
> >> +++ b/drivers/gpu/drm/tegra/dc.c
> >> @@ -9,6 +9,7 @@
> >>
> >>  #include <linux/clk.h>
> >>  #include <linux/debugfs.h>
> >> +#include <linux/iommu.h>
> >>  #include <linux/reset.h>
> >>
> >>  #include "dc.h"
> >> @@ -1283,8 +1284,18 @@ static int tegra_dc_init(struct host1x_client *client)
> >>  {
> >>         struct drm_device *drm = dev_get_drvdata(client->parent);
> >>         struct tegra_dc *dc = host1x_client_to_dc(client);
> >> +       struct tegra_drm *tegra = drm->dev_private;
> >>         int err;
> >>
> >> +       if (tegra->domain) {
> >> +               err = iommu_attach_device(tegra->domain, dc->dev);
> >> +               if (err < 0) {
> >> +                       dev_err(dc->dev, "failed to attach to IOMMU: %d\n",
> >> +                               err);
> >> +                       return err;
> >> +               }
> >
> > [from St?phane]
> >
> > shouldn't we call detach in the error paths below?
> >
> >
> >> +       }
> >> +
> >>         drm_crtc_init(drm, &dc->base, &tegra_crtc_funcs);
> >>         drm_mode_crtc_set_gamma_size(&dc->base, 256);
> >>         drm_crtc_helper_add(&dc->base, &tegra_crtc_helper_funcs);
> >> @@ -1318,7 +1329,9 @@ static int tegra_dc_init(struct host1x_client *client)
> >>
> >>  static int tegra_dc_exit(struct host1x_client *client)
> >>  {
> >> +       struct drm_device *drm = dev_get_drvdata(client->parent);
> >>         struct tegra_dc *dc = host1x_client_to_dc(client);
> >> +       struct tegra_drm *tegra = drm->dev_private;
> >>         int err;
> >>
> >>         devm_free_irq(dc->dev, dc->irq, dc);
> >> @@ -1335,6 +1348,8 @@ static int tegra_dc_exit(struct host1x_client *client)
> >>                 return err;
> >>         }
> >>
> >> +       iommu_detach_device(tegra->domain, dc->dev);
> >> +
> >>         return 0;
> >>  }
> >>
> >> @@ -1462,6 +1477,12 @@ static int tegra_dc_probe(struct platform_device *pdev)
> >>                 return -ENXIO;
> >>         }
> >>
> >> +       err = iommu_attach(&pdev->dev);
> >> +       if (err < 0) {
> >> +               dev_err(&pdev->dev, "failed to attach to IOMMU: %d\n", err);
> >> +               return err;
> >> +       }
> >> +
> >>         INIT_LIST_HEAD(&dc->client.list);
> >>         dc->client.ops = &dc_client_ops;
> >>         dc->client.dev = &pdev->dev;
> >> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> >> index 59736bb810cd..1d2bbafad982 100644
> >> --- a/drivers/gpu/drm/tegra/drm.c
> >> +++ b/drivers/gpu/drm/tegra/drm.c
> >> @@ -8,6 +8,7 @@
> >>   */
> >>
> >>  #include <linux/host1x.h>
> >> +#include <linux/iommu.h>
> >>
> >>  #include "drm.h"
> >>  #include "gem.h"
> >> @@ -33,6 +34,16 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
> >>         if (!tegra)
> >>                 return -ENOMEM;
> >>
> >> +       if (iommu_present(&platform_bus_type)) {
> >> +               tegra->domain = iommu_domain_alloc(&platform_bus_type);
> >> +               if (IS_ERR(tegra->domain)) {
> >> +                       kfree(tegra);
> >> +                       return PTR_ERR(tegra->domain);
> >> +               }
> >> +
> >> +               drm_mm_init(&tegra->mm, 0, SZ_2G);
> >
> >
> > [from St?phane]:
> >
> > none of these are freed in the error path below (iommu_domain_free and
> > drm_mm_takedown)
> >
> > also |tegra| isn't freed either?
> >
> >
> >
> >> +       }
> >> +
> >>         mutex_init(&tegra->clients_lock);
> >>         INIT_LIST_HEAD(&tegra->clients);
> >>         drm->dev_private = tegra;
> >> @@ -71,6 +82,7 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
> >>  static int tegra_drm_unload(struct drm_device *drm)
> >>  {
> >>         struct host1x_device *device = to_host1x_device(drm->dev);
> >> +       struct tegra_drm *tegra = drm->dev_private;
> >>         int err;
> >>
> >>         drm_kms_helper_poll_fini(drm);
> >> @@ -82,6 +94,11 @@ static int tegra_drm_unload(struct drm_device *drm)
> >>         if (err < 0)
> >>                 return err;
> >>
> >> +       if (tegra->domain) {
> >> +               iommu_domain_free(tegra->domain);
> >> +               drm_mm_takedown(&tegra->mm);
> >> +       }
> >> +
> >>         return 0;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> >> index 96d754e7b3eb..a07c796b7edc 100644
> >> --- a/drivers/gpu/drm/tegra/drm.h
> >> +++ b/drivers/gpu/drm/tegra/drm.h
> >> @@ -39,6 +39,9 @@ struct tegra_fbdev {
> >>  struct tegra_drm {
> >>         struct drm_device *drm;
> >>
> >> +       struct iommu_domain *domain;
> >> +       struct drm_mm mm;
> >> +
> >>         struct mutex clients_lock;
> >>         struct list_head clients;
> >>
> >> diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> >> index 7790d43ad082..21c65dd817c3 100644
> >> --- a/drivers/gpu/drm/tegra/fb.c
> >> +++ b/drivers/gpu/drm/tegra/fb.c
> >> @@ -65,8 +65,12 @@ static void tegra_fb_destroy(struct drm_framebuffer *framebuffer)
> >>         for (i = 0; i < fb->num_planes; i++) {
> >>                 struct tegra_bo *bo = fb->planes[i];
> >>
> >> -               if (bo)
> >> +               if (bo) {
> >> +                       if (bo->pages && bo->virt)
> >> +                               vunmap(bo->virt);
> >> +
> >>                         drm_gem_object_unreference_unlocked(&bo->gem);
> >> +               }
> >>         }
> >>
> >>         drm_framebuffer_cleanup(framebuffer);
> >> @@ -252,6 +256,16 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
> >>         offset = info->var.xoffset * bytes_per_pixel +
> >>                  info->var.yoffset * fb->pitches[0];
> >>
> >> +       if (bo->pages) {
> >> +               bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
> >> +                                pgprot_writecombine(PAGE_KERNEL));
> >> +               if (!bo->vaddr) {
> >> +                       dev_err(drm->dev, "failed to vmap() framebuffer\n");
> >> +                       err = -ENOMEM;
> >> +                       goto destroy;
> >> +               }
> >> +       }
> >> +
> >>         drm->mode_config.fb_base = (resource_size_t)bo->paddr;
> >>         info->screen_base = (void __iomem *)bo->vaddr + offset;
> >>         info->screen_size = size;
> >> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> >> index c1e4e8b6e5ca..2912e61a2599 100644
> >> --- a/drivers/gpu/drm/tegra/gem.c
> >> +++ b/drivers/gpu/drm/tegra/gem.c
> >> @@ -14,8 +14,10 @@
> >>   */
> >>
> >>  #include <linux/dma-buf.h>
> >> +#include <linux/iommu.h>
> >>  #include <drm/tegra_drm.h>
> >>
> >> +#include "drm.h"
> >>  #include "gem.h"
> >>
> >>  static inline struct tegra_bo *host1x_to_tegra_bo(struct host1x_bo *bo)
> >> @@ -90,14 +92,144 @@ static const struct host1x_bo_ops tegra_bo_ops = {
> >>         .kunmap = tegra_bo_kunmap,
> >>  };
> >>
> >> +static int iommu_map_sg(struct iommu_domain *domain, struct sg_table *sgt,
> >> +                       dma_addr_t iova, int prot)
> >> +{
> >> +       unsigned long offset = 0;
> >> +       struct scatterlist *sg;
> >> +       unsigned int i, j;
> >> +       int err;
> >> +
> >> +       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> >> +               dma_addr_t phys = sg_phys(sg);
> >> +               size_t length = sg->offset;
> >> +
> >> +               phys = sg_phys(sg) - sg->offset;
> >> +               length = sg->length + sg->offset;
> >> +
> >> +               err = iommu_map(domain, iova + offset, phys, length, prot);
> >> +               if (err < 0)
> >> +                       goto unmap;
> >> +
> >> +               offset += length;
> >> +       }
> >> +
> >> +       return 0;
> >> +
> >> +unmap:
> >> +       offset = 0;
> >> +
> >> +       for_each_sg(sgt->sgl, sg, i, j) {
> >> +               size_t length = sg->length + sg->offset;
> >> +               iommu_unmap(domain, iova + offset, length);
> >> +               offset += length;
> >> +       }
> >> +
> >> +       return err;
> >> +}
> >> +
> >> +static int iommu_unmap_sg(struct iommu_domain *domain, struct sg_table *sgt,
> >> +                         dma_addr_t iova)
> >> +{
> >> +       unsigned long offset = 0;
> >> +       struct scatterlist *sg;
> >> +       unsigned int i;
> >> +
> >> +       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> >> +               dma_addr_t phys = sg_phys(sg);
> >> +               size_t length = sg->offset;
> >> +
> >> +               phys = sg_phys(sg) - sg->offset;
> >> +               length = sg->length + sg->offset;
> >> +
> >> +               iommu_unmap(domain, iova + offset, length);
> >> +               offset += length;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int tegra_bo_iommu_map(struct tegra_drm *tegra, struct tegra_bo *bo)
> >> +{
> >> +       int prot = IOMMU_READ | IOMMU_WRITE;
> >> +       int err;
> >> +
> >> +       if (bo->mm)
> >> +               return -EBUSY;
> >> +
> >> +       bo->mm = kzalloc(sizeof(*bo->mm), GFP_KERNEL);
> >> +       if (!bo->mm)
> >> +               return -ENOMEM;
> >> +
> >> +       err = drm_mm_insert_node_generic(&tegra->mm, bo->mm, bo->gem.size,
> >> +                                        PAGE_SIZE, 0, 0, 0);
> >> +       if (err < 0) {
> >> +               dev_err(tegra->drm->dev, "out of virtual memory: %d\n", err);
> >> +               return err;
> >> +       }
> >> +
> >> +       bo->paddr = bo->mm->start;
> >> +
> >> +       err = iommu_map_sg(tegra->domain, bo->sgt, bo->paddr, prot);
> >> +       if (err < 0) {
> >> +               dev_err(tegra->drm->dev, "failed to map buffer: %d\n", err);
> >> +               return err;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int tegra_bo_iommu_unmap(struct tegra_drm *tegra, struct tegra_bo *bo)
> >> +{
> >> +       if (!bo->mm)
> >> +               return 0;
> >> +
> >> +       iommu_unmap_sg(tegra->domain, bo->sgt, bo->paddr);
> >> +       drm_mm_remove_node(bo->mm);
> >> +
> >> +       kfree(bo->mm);
> >> +       return 0;
> >> +}
> >> +
> >>  static void tegra_bo_destroy(struct drm_device *drm, struct tegra_bo *bo)
> >>  {
> >> -       dma_free_writecombine(drm->dev, bo->gem.size, bo->vaddr, bo->paddr);
> >> +       if (!bo->pages)
> >> +               dma_free_writecombine(drm->dev, bo->gem.size, bo->vaddr,
> >> +                                     bo->paddr);
> 
> One more thing. If tegra_bo_alloc fails, we'll have bo->vaddr == NULL
> and bo->paddr == ~0 here, which causes a crash.
> 
> I posted https://lkml.org/lkml/2014/9/30/659 to check for the error
> condition in the mm code, but it seems like reviewer consensus is to
> check for this before calling free.
> 
> As such, we'll need to make sure bo->vaddr != NULL before calling
> dma_free_writecombine to avoid this situation.
> 
> Would you prefer I send a patch up to fix this separately, or would
> you like to roll this into your next version?

Thanks for pointing all of these out. I'm going to trace the failure
code path anyway since there seem to be a couple of loose ends here and
there, so I'll probably roll in a fix for this anyway.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/13e85145/attachment.sig>
