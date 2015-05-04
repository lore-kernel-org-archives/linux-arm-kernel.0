From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 04 May 2015 16:43:53 +0900
Subject: [PATCH] drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
In-Reply-To: <1430539706-2945-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430539706-2945-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <55472339.8040408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 05? 02? 13:08, Krzysztof Kozlowski wrote:
> Selecting CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD leading to build
> error:

No, eDP has no any dependency of FIMD but DECON. Just add dependency
code like below,

 config DRM_EXYNOS7_DECON
        bool "Exynos DRM DECON"
-       depends on DRM_EXYNOS
+       depends on DRM_EXYNOS && !FB_S3C

> 
> drivers/built-in.o: In function `exynos_dp_dpms':
> binder.c:(.text+0xd6a840): undefined reference to `fimd_dp_clock_enable'
> binder.c:(.text+0xd6ab54): undefined reference to `fimd_dp_clock_enable'
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.h b/drivers/gpu/drm/exynos/exynos_drm_fimd.h
> index b4fcaa568456..db67f3d9786d 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.h
> @@ -10,6 +10,10 @@
>  #ifndef _EXYNOS_DRM_FIMD_H_
>  #define _EXYNOS_DRM_FIMD_H_
>  
> +#ifdef CONFIG_DRM_EXYNOS_FIMD
>  extern void fimd_dp_clock_enable(struct exynos_drm_crtc *crtc, bool enable);
> +#else
> +static inline void fimd_dp_clock_enable(struct exynos_drm_crtc *crtc, bool enable) {};
> +#endif

So above codes are unnecessary. It's really not good to add #ifdef ~ #endif.

Thanks,
Inki Dae

>  
>  #endif /* _EXYNOS_DRM_FIMD_H_ */
> 
