From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 7 May 2018 15:46:02 +0200
Subject: [PATCH 00/13] drm/kms/mode: using helper func
 drm_display_mode_to/from_videomode for calculating timing parameters
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
References: <CGME20180503082417epcas5p19ee919d68eb5ae18f183a41881869cc1@epcas5p1.samsung.com>
 <cover.1525087679.git.satendra.t@samsung.com>
Message-ID: <20180507134602.GH12521@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 01:53:55PM +0530, Satendra Singh Thakur wrote:
> 1.There is a function in drm-core to calculate display timing parameters:
> horizontal front porch, back porch, sync length,
> vertical front porch, back porch, sync length and
> clock in Hz.
> However, some drivers are still calculating these parameters themselves.
> Therefore, there is a duplication of the code.
> This patch series replaces this redundant code with the function
> drm_display_mode_to_videomode.
> This removes nearly 100 redundant lines from the related drivers.
> 2.For some drivers (sun4i) the reverse helper
> drm_display_mode_from_videomode is used.
> 3.For some drivers it replaces arithmatic operators (*, /) with shifting
> operators (>>, <<).
> 4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
> 5.These changes apply to following crtc and encoder drivers:
> atmel-hlcdc
> bridge-tc358767
> exynos-dsi
> fsl-dcu
> gma500-mdfld_dsi_dpi
> hisilicon-kirin_dsi, ade
> meson-encoder
> pl111-display
> sun4i-tv
> ti lcdc
> tegra dc
> mediatek dpi dsi
> bridge-adv7533

The drm_mode_to_videomode helper is meant for interop between drm and v4l,
which have different internal structures to represent modes.

For drivers that only use drm I think the better option would be to add
these fields to struct drm_display_mode as another set of crtc_* values
(the computed values are stored in crtc_ prefixed members). And compute
front/back porch in drm_mode_set_crtcinfo.

Then we can use these new drm_display_mode->crtc_h|vfront|back_porch
fields in all the drivers you're changing. This way you avoid having to
change all the drm drivers to use v4l #defines.

Thanks,
Daniel

> 
> Satendra Singh Thakur (13):
>   drm/kms/mode/atmel-hlcdc: using helper func
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/bridge-tc358767: using helper func
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/exynos-dsi: using helper func
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/fsl-dcu: using helper func drm_display_mode_to_videomode 
>        for calculating timing parameters
>   drm/kms/mode/gma500-mdfld_dsi_dpi: using helper function
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/hisilicon-kirin-dsi-ade: using helper function    
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/meson-encoder: using helper function
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/pl111-display: using helper function
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/sun4i-tv: using helper func
>     drm_display_mode_from_videomode for calculating timing
>     parameters
>   drm/kms/mode/ti-lcdc: using helper func drm_display_mode_to_videomode 
>        for calculating timing parameters
>   drm/kms/mode/tegra: using helper func drm_display_mode_to_videomode
>     for calculating timing parameters
>   drm/kms/mode/mtk_dpi_dsi: using helper func
>     drm_display_mode_to_videomode for calculating timing parameters
>   drm/kms/mode/bridge-adv7533: using helper func
>     drm_display_mode_to_videomode for calculating timing parameters
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    |  28 +++--
>  drivers/gpu/drm/bridge/adv7511/adv7533.c        |  35 +++---
>  drivers/gpu/drm/bridge/tc358767.c               |  42 +++----
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c         |   9 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c      |  29 ++---
>  drivers/gpu/drm/gma500/mdfld_dsi_dpi.c          |  28 ++---
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    |  42 ++++---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  52 +++------
>  drivers/gpu/drm/mediatek/mtk_dpi.c              |  60 +++++-----
>  drivers/gpu/drm/mediatek/mtk_dsi.c              |  14 +--
>  drivers/gpu/drm/meson/meson_venc.c              | 149 +++++++++++-------------
>  drivers/gpu/drm/pl111/pl111_display.c           |  40 +++----
>  drivers/gpu/drm/sun4i/sun4i_tv.c                |  67 ++++-------
>  drivers/gpu/drm/tegra/dc.c                      |  15 ++-
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c            |  60 +++++-----
>  15 files changed, 280 insertions(+), 390 deletions(-)
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
