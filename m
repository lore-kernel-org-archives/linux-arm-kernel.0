From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 4 Jan 2017 10:10:20 +0100
Subject: [PATCH] drm/meson: Fix plane atomic check when no crtc for the
 plane
In-Reply-To: <1483435254-27955-1-git-send-email-narmstrong@baylibre.com>
References: <1483435254-27955-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170104091020.rvikywzzfsqxxp5t@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:20:54AM +0100, Neil Armstrong wrote:
> When no CRTC is associated with the plane, the meson_plane_atomic_check()
> call breaks the kernel with an Oops.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Makes sense, pls send a pull request with this to Dave.
-Daniel

> ---
>  drivers/gpu/drm/meson/meson_plane.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index 4942ca0..7890e30 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -51,6 +51,9 @@ static int meson_plane_atomic_check(struct drm_plane *plane,
>  	struct drm_crtc_state *crtc_state;
>  	struct drm_rect clip = { 0, };
>  
> +	if (!state->crtc)
> +		return 0;
> +
>  	crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
>  	if (IS_ERR(crtc_state))
>  		return PTR_ERR(crtc_state);
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
