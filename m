From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 25 Mar 2014 20:15:11 +0900
Subject: [PATCH] drm/bridge: PTN3460 needs DRM_KMS_HELPER
In-Reply-To: <17602160.PV0AMDU1du@wuerfel>
References: <17602160.PV0AMDU1du@wuerfel>
Message-ID: <CAAQKjZOsi9d+O3BDm-n9eyvc9uFHKp-a23yyjhtpFca3-X3J9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-25 20:06 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> The recently added PTN3460 device driver uses interfaces that
> are provided by the KMS helper infrastructure, so we should
> explicitly select that to avoid this linker error:
>
> ERROR: "drm_helper_probe_single_connector_modes" [drivers/gpu/drm/bridge/ptn3460.ko] undefined!
> ERROR: "drm_helper_connector_dpms" [drivers/gpu/drm/bridge/ptn3460.ko] undefined!
>

Ah, right. Exynos drm selects DRM_KMS_HELPER so I cannot see build error.

Thanks,
Inki Dae


> We have to drop the I2C dependency to avoid a circular dependency
> chain, but that's ok because DRM already selects I2C.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I found this today doing randconfig builds on linux-next.
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index f8db069..884923f 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -1,4 +1,5 @@
>  config DRM_PTN3460
>         tristate "PTN3460 DP/LVDS bridge"
> -       depends on DRM && I2C
> +       depends on DRM
> +       select DRM_KMS_HELPER
>         ---help---
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
