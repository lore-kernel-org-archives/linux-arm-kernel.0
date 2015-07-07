From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 7 Jul 2015 15:02:21 +0800
Subject: [PATCH 1/2] drm: rockchip: Don't pass DRM fake offset to dma-api
In-Reply-To: <1743547.3D2D8THGkI@diego>
References: <1429195312-25898-1-git-send-email-orjan.eide@arm.com>
 <1743547.3D2D8THGkI@diego>
Message-ID: <CAGS+omBWhFO=+rcy0rv5VNwWmYSU6MT4wLOwuL4n8GfUcNN8rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 19, 2015 at 12:55 AM, Heiko St?bner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 16. April 2015, 16:41:51 schrieb ?rjan Eide:
> > Set vm_pgoff to 0 after using it to look up the GEM node, before passing
> > it on rockchip_gem_mmap_buf() where the offset must be from the start of
> > the buffer.
> >
> > Passing in the fake offset currently works because the
> > dma_mmap_attrs implementation that is used for this device,
> > arm_iommu_mmap_attrs, ignores the offset completely.
> >
> > Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
>
> both patches on a rk3288-veyron-pinky
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
> Through which tree do you want to take these patches? I guess the rockchip-drm
> related patch should go through the tree that will take the dma-mapping patch,
> so you'll probably need an "Ack" from Mark Yao (Cc'ed).

As far as I can tell, these two patches ([0] & [1]) were never picked up.
Russell, can you pick both of them up in your tree?

[0] https://patchwork.kernel.org/patch/6226591/
[1] https://patchwork.kernel.org/patch/6226581/

-Dan

> Heiko
>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c index 7ca8799e..69f01c3
> > 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > @@ -94,6 +94,11 @@ int rockchip_gem_mmap(struct file *filp, struct
> > vm_area_struct *vma) return -EACCES;
> >       }
> >
> > +     /* Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
> > +      * whole buffer from the start.
> > +      */
> > +     vma->vm_pgoff = 0;
> > +
> >       obj = container_of(node, struct drm_gem_object, vma_node);
> >       ret = rockchip_gem_mmap_buf(obj, vma);
>
