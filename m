From: satendra.t@samsung.com (Satendra Singh Thakur)
Date: Tue,  8 May 2018 16:28:30 +0530
Subject: [PATCH 00/13] drm/kms/mode: using helper func
 drm_display_mode_to/from_videomode for calculating timing parameters
In-Reply-To: <20180507134602.GH12521@phenom.ffwll.local>
References: <20180507134602.GH12521@phenom.ffwll.local>
 <CGME20180508105900epcas5p25ffe94a214e5ad0848d834d6c3562ad6@epcas5p2.samsung.com>
Message-ID: <1525777110-11378-1-git-send-email-satendra.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2018 at 15:46:02 +0200, Daniel Vetter wrote:
> On Thu, May 03, 2018 at 01:53:55PM +0530, Satendra Singh Thakur wrote:
> > 1.There is a function in drm-core to calculate display timing parameters:
> > horizontal front porch, back porch, sync length,
> > vertical front porch, back porch, sync length and
> > clock in Hz.
> > However, some drivers are still calculating these parameters themselves.
> > Therefore, there is a duplication of the code.
> > This patch series replaces this redundant code with the function
> > drm_display_mode_to_videomode.
> > This removes nearly 100 redundant lines from the related drivers.
> > 2.For some drivers (sun4i) the reverse helper
> > drm_display_mode_from_videomode is used.
> > 3.For some drivers it replaces arithmatic operators (*, /) with shifting
> > operators (>>, <<).
> > 4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
> > 5.These changes apply to following crtc and encoder drivers:
> > atmel-hlcdc
> > bridge-tc358767
> > exynos-dsi
> > fsl-dcu
> > gma500-mdfld_dsi_dpi
> > hisilicon-kirin_dsi, ade
> > meson-encoder
> > pl111-display
> > sun4i-tv
> > ti lcdc
> > tegra dc
> > mediatek dpi dsi
> > bridge-adv7533
> 
> The drm_mode_to_videomode helper is meant for interop between drm and v4l,
> which have different internal structures to represent modes.
> 
> For drivers that only use drm I think the better option would be to add
> these fields to struct drm_display_mode as another set of crtc_* values
> (the computed values are stored in crtc_ prefixed members). And compute
> front/back porch in drm_mode_set_crtcinfo.
> 
> Then we can use these new drm_display_mode->crtc_h|vfront|back_porch
> fields in all the drivers you're changing. This way you avoid having to
> change all the drm drivers to use v4l #defines.
> 
> Thanks,
> Daniel

Hi Daniel,
Thanks for the comments.
I will look into it.

Thanks
-Satendra
