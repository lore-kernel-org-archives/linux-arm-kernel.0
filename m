From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Mon, 26 Nov 2018 11:06:42 +0530
Subject: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
In-Reply-To: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
References: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
Message-ID: <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Thu, Nov 15, 2018 at 9:14 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any feedback for this patch ?

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index a8db758..2cb83bb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>                                               struct vm_area_struct *vma)
>  {
>         struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> -       unsigned int i, count = obj->size >> PAGE_SHIFT;
>         unsigned long user_count = vma_pages(vma);
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long offset = vma->vm_pgoff;
> -       unsigned long end = user_count + offset;
> -       int ret;
> -
> -       if (user_count == 0)
> -               return -ENXIO;
> -       if (end > count)
> -               return -ENXIO;
>
> -       for (i = offset; i < end; i++) {
> -               ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> -               if (ret)
> -                       return ret;
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
> +                               user_count);
>  }
>
>  static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
> --
> 1.9.1
>
