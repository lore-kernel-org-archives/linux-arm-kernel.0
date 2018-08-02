From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Thu, 2 Aug 2018 11:55:56 +0530
Subject: [PATCH v2] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
In-Reply-To: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
References: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
Message-ID: <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 9:24 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> exynos_drm_fbdev_suspend/resume can be removed
> as drm_mode_config_helper_suspend/resume has
> implement the same in generic way.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
> v2: Address Inki Dae's comment. Remove
>     ret variable from both suspend/resume
>     function.
>

Any further comment on this patch ?

>  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++++----------------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>  3 files changed, 4 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index a81b4a5..46d28cd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -151,39 +151,21 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>  static int exynos_drm_suspend(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> -       struct exynos_drm_private *private;
>
> -       if (pm_runtime_suspended(dev) || !drm_dev)
> +       if (pm_runtime_suspended(dev))
>                 return 0;
>
> -       private = drm_dev->dev_private;
> -
> -       drm_kms_helper_poll_disable(drm_dev);
> -       exynos_drm_fbdev_suspend(drm_dev);
> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
> -       if (IS_ERR(private->suspend_state)) {
> -               exynos_drm_fbdev_resume(drm_dev);
> -               drm_kms_helper_poll_enable(drm_dev);
> -               return PTR_ERR(private->suspend_state);
> -       }
> -
> -       return 0;
> +       return drm_mode_config_helper_suspend(drm_dev);
>  }
>
>  static int exynos_drm_resume(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> -       struct exynos_drm_private *private;
>
> -       if (pm_runtime_suspended(dev) || !drm_dev)
> +       if (pm_runtime_suspended(dev))
>                 return 0;
>
> -       private = drm_dev->dev_private;
> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
> -       exynos_drm_fbdev_resume(drm_dev);
> -       drm_kms_helper_poll_enable(drm_dev);
> -
> -       return 0;
> +       return drm_mode_config_helper_resume(drm_dev);
>  }
>  #endif
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 132dd52..918dd2c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>         private->fb_helper = NULL;
>  }
>
> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *private = dev->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
> -       console_unlock();
> -}
> -
> -void exynos_drm_fbdev_resume(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *private = dev->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
> -       console_unlock();
> -}
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> index b338472..6840b6a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> @@ -19,8 +19,6 @@
>
>  int exynos_drm_fbdev_init(struct drm_device *dev);
>  void exynos_drm_fbdev_fini(struct drm_device *dev);
> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>
>  #else
>
> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>
>  #define exynos_drm_output_poll_changed (NULL)
>
> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
> -{
> -}
> -
> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
> -{
> -}
> -
>  #endif
>
>  #endif
> --
> 1.9.1
>
