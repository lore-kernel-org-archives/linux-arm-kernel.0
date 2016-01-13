From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 13 Jan 2016 15:23:20 +0100
Subject: [RFC/PATCH] drm/rockchip: don't wait for vblank if fb hasn't
 changed
In-Reply-To: <1452689614-6570-1-git-send-email-john@metanate.com>
References: <1452689614-6570-1-git-send-email-john@metanate.com>
Message-ID: <20160113142320.GQ19130@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 12:53:34PM +0000, John Keeping wrote:
> As commented in drm_atomic_helper_wait_for_vblanks(), userspace relies
> on cursor ioctls being unsynced.  Converting the rockchip driver to
> atomic has significantly impacted cursor performance by making every
> cursor update wait for vblank.
> 
> By skipping the vblank sync when the framebuffer has not changed (as is
> done in drm_atomic_helper_wait_for_vblanks()) we can avoid this for the
> common case of moving the cursor and only need to delay the cursor ioctl
> when the cursor icon changes.
> 
> I originally inserted a check on legacy_cursor_update as well, but that
> caused a storm of iommu page faults.  I didn't investigate the cause of
> those since this change gives enough of a performance improvement for my
> use case.
> 
> This is RFC because of that and because the framebuffer_changed()
> function is copied from drm_atomic_helper.c as a quick way to test the
> result.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index f784488..8fd9821 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -177,8 +177,28 @@ static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
>  		crtc_funcs->wait_for_update(crtc);
>  }
>  
> +static bool framebuffer_changed(struct drm_device *dev,
> +				struct drm_atomic_state *old_state,
> +				struct drm_crtc *crtc)
> +{
> +	struct drm_plane *plane;
> +	struct drm_plane_state *old_plane_state;
> +	int i;
> +
> +	for_each_plane_in_state(old_state, plane, old_plane_state, i) {
> +		if (plane->state->crtc != crtc &&
> +		    old_plane_state->crtc != crtc)
> +			continue;
> +
> +		if (plane->state->fb != old_plane_state->fb)
> +			return true;
> +	}
> +
> +	return false;
> +}

Please don't hand-roll logic that affects semantics like this. Instead
please use drm_atomic_helper_wait_for_vblanks(), which should do this
correctly for you.

If that's not the case then we need to improve the generic helper, or
figure out what's different with rockhip.

Thanks, Daniel

> +
>  static void
> -rockchip_atomic_wait_for_complete(struct drm_atomic_state *old_state)
> +rockchip_atomic_wait_for_complete(struct drm_device *dev, struct drm_atomic_state *old_state)
>  {
>  	struct drm_crtc_state *old_crtc_state;
>  	struct drm_crtc *crtc;
> @@ -194,6 +214,9 @@ rockchip_atomic_wait_for_complete(struct drm_atomic_state *old_state)
>  		if (!crtc->state->active)
>  			continue;
>  
> +		if (!framebuffer_changed(dev, old_state, crtc))
> +			continue;
> +
>  		ret = drm_crtc_vblank_get(crtc);
>  		if (ret != 0)
>  			continue;
> @@ -241,7 +264,7 @@ rockchip_atomic_commit_complete(struct rockchip_atomic_commit *commit)
>  
>  	drm_atomic_helper_commit_planes(dev, state, true);
>  
> -	rockchip_atomic_wait_for_complete(state);
> +	rockchip_atomic_wait_for_complete(dev, state);
>  
>  	drm_atomic_helper_cleanup_planes(dev, state);
>  
> -- 
> 2.7.0.rc3.140.g520a093
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
