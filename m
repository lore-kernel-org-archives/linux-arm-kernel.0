From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 21 Jan 2014 16:12:46 +0900
Subject: [patch] drm/exynos: potential use after free in exynos_drm_open()
In-Reply-To: <20140121065748.GC31535@elgon.mountain>
References: <20140121065748.GC31535@elgon.mountain>
Message-ID: <CAAQKjZNQH45BizkRUqh2k=h_bS2ECZWy=v1kMGFSLyqC9uR2xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This issue had already been reported, and fixed by Sachin. And also
that patch has been merged to exynos-drm-next. Please see below link,
        http://www.spinics.net/lists/dri-devel/msg51889.html


Thanks,
Inki Dae

2014/1/21 Dan Carpenter <dan.carpenter@oracle.com>:
> If exynos_drm_subdrv_open() fails then we re-use "file_priv".
>
> Fixes: 96f5421523df ('drm/exynos: use a new anon file for exynos gem mmaper')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index 9d096a0c5f8d..3c845292845a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -174,6 +174,7 @@ static int exynos_drm_open(struct drm_device *dev, struct drm_file *file)
>         if (ret) {
>                 kfree(file_priv);
>                 file->driver_priv = NULL;
> +               return ret;
>         }
>
>         anon_filp = anon_inode_getfile("exynos_gem", &exynos_drm_gem_fops,
> @@ -186,7 +187,7 @@ static int exynos_drm_open(struct drm_device *dev, struct drm_file *file)
>         anon_filp->f_mode = FMODE_READ | FMODE_WRITE;
>         file_priv->anon_filp = anon_filp;
>
> -       return ret;
> +       return 0;
>  }
>
>  static void exynos_drm_preclose(struct drm_device *dev,
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
