From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jul 2017 02:43:12 +0300
Subject: [PATCH 1/4] drm/atomic: implement drm_atomic_helper_commit_tail
 for runtime_pm users
In-Reply-To: <aeeb8f778dae8f170294b6da92819973b742feb2.1499956639.git-series.maxime.ripard@free-electrons.com>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
 <aeeb8f778dae8f170294b6da92819973b742feb2.1499956639.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1823154.LT2zYSFJ4j@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Thursday 13 Jul 2017 16:41:13 Maxime Ripard wrote:
> The current drm_atomic_helper_commit_tail helper works only if the CRTC is
> accessible, and documents an alternative implementation that is supposed to
> be used if that happens.
> 
> That implementation is then duplicated by some drivers. Instead of
> documenting it, let's implement an helper that all the relevant users can
> use directly.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c        | 47 +++++++++++++++--------
>  drivers/gpu/drm/exynos/exynos_drm_fb.c     | 27 +-------------
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c      | 18 +---------

I've submitted "[PATCH] drm: rcar-du: Setup planes before enabling CRTC to 
avoid flicker" that changes the rcar-du implementation to the standard 
disable/update planes/enable order, so I'd appreciate if you could drop the 
rcar-du part of this patch to avoid conflicts.

This being said, the reason why I switched back from the "runtime PM" to the 
"standard" order is probably of interest to you. Quoting the commit message,

> Commit 52055bafa1ff ("drm: rcar-du: Move plane commit code from CRTC
> start to CRTC resume") changed the order of the plane commit and CRTC
> enable operations to accommodate the runtime PM requirements. However,
> this introduced corruption in the first displayed frame, as the CRTC is
> now enabled without any plane configured. On Gen2 hardware the first
> frame will be black and likely unnoticed, but on Gen3 hardware we end up
> starting the display before the VSP compositor, which is more
> noticeable.
> 
> To fix this, revert the order of the commit operations back, and handle
> runtime PM requirements in the CRTC .atomic_begin() and .atomic_enable()
> helper operation handlers.

I believe that the "runtime PM" order is problematic in most drivers. The 
problem usually goes unnoticed as most monitors will not even display the 
first frame, and I assume many devices will just output it black, but it's an 
issue nonetheless.

Note that my driver hasn't lost the "runtime PM" requirements, so I had to 
support them with the "standard" order. The best way I've found was to runtime 
resume in the one of .atomic_begin() and .enable() that is run first. Not very 
neat, as similar code would be needed in most drivers. I wonder whether it 
wouldn't be useful to add resume/suspend helper callbacks for the CRTC.

>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 21 +----------
>  include/drm/drm_atomic_helper.h            |  1 +-
>  5 files changed, 36 insertions(+), 78 deletions(-)

-- 
Regards,

Laurent Pinchart
