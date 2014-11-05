From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 5 Nov 2014 11:26:59 +0100
Subject: [RFC 09/10] drm/tegra: Add IOMMU support
In-Reply-To: <CAOw6vbJy6oy7cibH4f332UM=kS56KUMcnYdUTG0pEYXyQkFDoQ@mail.gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
 <CAOw6vbJy6oy7cibH4f332UM=kS56KUMcnYdUTG0pEYXyQkFDoQ@mail.gmail.com>
Message-ID: <20141105102657.GB12458@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 02:48:35PM -0400, Sean Paul wrote:
> On Thu, Jun 26, 2014 at 4:49 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > When an IOMMU device is available on the platform bus, allocate an IOMMU
> > domain and attach the display controllers to it. The display controllers
> > can then scan out non-contiguous buffers by mapping them through the
> > IOMMU.
> >
> 
> Hi Thierry,
> A few comments from St?phane and myself that came up while we were
> reviewing this for our tree.

I just realized that I hadn't integrated these comments completely yet,
but I've done so now in my local tree. I'm running a couple of tests to
verify that it's all handled correctly.

> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c  |  21 ++++
> >  drivers/gpu/drm/tegra/drm.c |  17 ++++
> >  drivers/gpu/drm/tegra/drm.h |   3 +
> >  drivers/gpu/drm/tegra/fb.c  |  16 ++-
> >  drivers/gpu/drm/tegra/gem.c | 236 +++++++++++++++++++++++++++++++++++++++-----
> >  drivers/gpu/drm/tegra/gem.h |   4 +
> >  6 files changed, 273 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index afcca04f5367..0f7452d04811 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/iommu.h>
> >  #include <linux/reset.h>
> >
> >  #include "dc.h"
> > @@ -1283,8 +1284,18 @@ static int tegra_dc_init(struct host1x_client *client)
> >  {
> >         struct drm_device *drm = dev_get_drvdata(client->parent);
> >         struct tegra_dc *dc = host1x_client_to_dc(client);
> > +       struct tegra_drm *tegra = drm->dev_private;
> >         int err;
> >
> > +       if (tegra->domain) {
> > +               err = iommu_attach_device(tegra->domain, dc->dev);
> > +               if (err < 0) {
> > +                       dev_err(dc->dev, "failed to attach to IOMMU: %d\n",
> > +                               err);
> > +                       return err;
> > +               }
> 
> [from St?phane]
> 
> shouldn't we call detach in the error paths below?

This was mostly rewritten for universal plane support, but I've made
sure that the DC properly detaches from the IOMMU in case of failure
during the code below.

> > diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
[...]
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/host1x.h>
> > +#include <linux/iommu.h>
> >
> >  #include "drm.h"
> >  #include "gem.h"
> > @@ -33,6 +34,16 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
> >         if (!tegra)
> >                 return -ENOMEM;
> >
> > +       if (iommu_present(&platform_bus_type)) {
> > +               tegra->domain = iommu_domain_alloc(&platform_bus_type);
> > +               if (IS_ERR(tegra->domain)) {
> > +                       kfree(tegra);
> > +                       return PTR_ERR(tegra->domain);
> > +               }
> > +
> > +               drm_mm_init(&tegra->mm, 0, SZ_2G);
> 
> 
> [from St?phane]:
> 
> none of these are freed in the error path below (iommu_domain_free and
> drm_mm_takedown)
> 
> also |tegra| isn't freed either?

None of the resources were actually being cleaned up, but I think I have
it all handled properly now.

> > @@ -108,22 +240,33 @@ struct tegra_bo *tegra_bo_create(struct drm_device *drm, unsigned int size,
> >         host1x_bo_init(&bo->base, &tegra_bo_ops);
> >         size = round_up(size, PAGE_SIZE);
> >
> > -       bo->vaddr = dma_alloc_writecombine(drm->dev, size, &bo->paddr,
> > -                                          GFP_KERNEL | __GFP_NOWARN);
> > -       if (!bo->vaddr) {
> > -               dev_err(drm->dev, "failed to allocate buffer with size %u\n",
> > -                       size);
> > -               err = -ENOMEM;
> > -               goto err_dma;
> > -       }
> > -
> >         err = drm_gem_object_init(drm, &bo->gem, size);
> >         if (err)
> > -               goto err_init;
> > +               goto free;
> >
> >         err = drm_gem_create_mmap_offset(&bo->gem);
> 
> We need to call drm_gem_free_mmap_offset if one of the calls below
> fails, otherwise we'll try to free the mmap_offset on an already
> destroyed bo.

drm_gem_object_release() (below) already calls drm_gem_free_mmap_offset()
for us implicitly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/31f52e43/attachment.sig>
