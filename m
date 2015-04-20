From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 20 Apr 2015 12:13:43 +0800
Subject: [PATCH 1/2] drm: rockchip: Don't pass DRM fake offset to dma-api
In-Reply-To: <1429195312-25898-1-git-send-email-orjan.eide@arm.com>
References: <1429195312-25898-1-git-send-email-orjan.eide@arm.com>
Message-ID: <CAGS+omADEKZMDLxa9eEgrxhL1V7ZvFEU1Xnhc4rbPHLCthyvNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ?rjan,

On Thu, Apr 16, 2015 at 10:41 PM, ?rjan Eide <orjan.eide@arm.com> wrote:
>
> Set vm_pgoff to 0 after using it to look up the GEM node, before passing
> it on rockchip_gem_mmap_buf() where the offset must be from the start of
> the buffer.
>
> Passing in the fake offset currently works because the
> dma_mmap_attrs implementation that is used for this device,
> arm_iommu_mmap_attrs, ignores the offset completely.
>
> Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index 7ca8799e..69f01c3 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -94,6 +94,11 @@ int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>                 return -EACCES;
>         }
>
> +       /* Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
> +        * whole buffer from the start.
> +        */

One very tiny nit.  According to [0], multi-line comments start are
supposed to start with a single "/*"
[0] https://www.kernel.org/doc/Documentation/CodingStyle

Other than that, this patch is
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks for sending this up!


>
> +       vma->vm_pgoff = 0;
> +
>         obj = container_of(node, struct drm_gem_object, vma_node);
>         ret = rockchip_gem_mmap_buf(obj, vma);
>
> --
> 1.9.1
>
