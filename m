From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 5 Nov 2014 10:50:05 +0100
Subject: [RFC 09/10] drm/tegra: Add IOMMU support
In-Reply-To: <CAOw6vbLFLrqWYB-4N50G7oucgMD+xd+QtdcMSzX4z7xRiU-vPQ@mail.gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
 <CAOw6vbJy6oy7cibH4f332UM=kS56KUMcnYdUTG0pEYXyQkFDoQ@mail.gmail.com>
 <CAOw6vbLFLrqWYB-4N50G7oucgMD+xd+QtdcMSzX4z7xRiU-vPQ@mail.gmail.com>
Message-ID: <20141105095003.GA12458@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 11:54:11AM -0400, Sean Paul wrote:
> On Tue, Sep 30, 2014 at 2:48 PM, Sean Paul <seanpaul@google.com> wrote:
> > On Thu, Jun 26, 2014 at 4:49 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> >> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
[...]
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

I've rolled this check into my series because I touch that area of code
anyway.

Thanks for bringing it up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/8099e49a/attachment.sig>
