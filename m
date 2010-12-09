From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Thu, 9 Dec 2010 16:15:19 -0600
Subject: [PATCH] OMAP: device: make rt_va easily avaialable to drivers
In-Reply-To: <1291852792-3584-1-git-send-email-omar.ramirez@ti.com>
References: <1291852792-3584-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTi=_xRUX_jGwWUzUnGrCZ7pdi23PAKCtoYC+0XtK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 5:59 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Patch "OMAP: hwmod/device: add omap_{device, hwmod}_get_mpu_rt_va"[1],
> introduces omap_device_get_rt_va which is meant to be called
> by drivers to retrieve the _mpu_rt_va, however this function
> receives a pointer to an omap_device; since there is no
> practical way for a driver to get this parameter without
> fiddling with pdev and container_of macro, and omap_device code
> already does this, it is better for it to handle this case.
>
> Also moved header declaration to appear in the set of
> functions to be used by drivers, as per the comment there.
>
> [1] http://marc.info/?l=linux-omap&m=127808467703366&w=2
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---

Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>

> ?arch/arm/plat-omap/include/plat/omap_device.h | ? ?3 +--
> ?arch/arm/plat-omap/omap_device.c ? ? ? ? ? ? ?| ? ?8 ++++++--
> ?2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 28e2d1a..1877c1a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -80,6 +80,7 @@ struct omap_device {
> ?int omap_device_enable(struct platform_device *pdev);
> ?int omap_device_idle(struct platform_device *pdev);
> ?int omap_device_shutdown(struct platform_device *pdev);
> +void __iomem *omap_device_get_rt_va(struct platform_device *pdev);
>
> ?/* Core code interface */
>
> @@ -101,8 +102,6 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
> ?int omap_device_register(struct omap_device *od);
> ?int omap_early_device_register(struct omap_device *od);
>
> -void __iomem *omap_device_get_rt_va(struct omap_device *od);
> -
> ?/* OMAP PM interface */
> ?int omap_device_align_pm_lat(struct platform_device *pdev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? u32 new_wakeup_lat_limit);
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index abe933c..9d11195 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -681,7 +681,7 @@ struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)
>
> ?/**
> ?* omap_device_get_mpu_rt_va - return the MPU's virtual addr for the hwmod base
> - * @od: struct omap_device *
> + * @pdev: struct platform_device *
> ?*
> ?* Return the MPU's virtual address for the base of the hwmod, from
> ?* the ioremap() that the hwmod code does. ?Only valid if there is one
> @@ -690,8 +690,12 @@ struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)
> ?* otherwise, passes along the return value from
> ?* omap_hwmod_get_mpu_rt_va().
> ?*/
> -void __iomem *omap_device_get_rt_va(struct omap_device *od)
> +void __iomem *omap_device_get_rt_va(struct platform_device *pdev)
> ?{
> + ? ? ? struct omap_device *od;
> +
> + ? ? ? od = _find_by_pdev(pdev);
> +
> ? ? ? ?if (od->hwmods_cnt != 1)
> ? ? ? ? ? ? ? ?return NULL;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
