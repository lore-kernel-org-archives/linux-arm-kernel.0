From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Wed, 4 Jan 2017 15:27:37 +0200
Subject: [PATCH] drm/meson: Fix plane atomic check when no crtc for the
 plane
In-Reply-To: <1483435254-27955-1-git-send-email-narmstrong@baylibre.com>
References: <1483435254-27955-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170104132737.GF31595@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:20:54AM +0100, Neil Armstrong wrote:
> When no CRTC is associated with the plane, the meson_plane_atomic_check()
> call breaks the kernel with an Oops.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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

Since you're not going to call drm_plane_helper_check_state() you will
fail to update plane_state->visible.

What i915 does in this case is look for state->crtc first, and if that's
NULL it'll pick the crtc from the old state (plane->state->crtc). It
looks a bit ugly, but maybe we should hide it in a small helper function
that could be used by all drivers?

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
Ville Syrj?l?
Intel OTC
