From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 14 Mar 2016 10:39:16 +0800
Subject: [PATCH v2] drm/rockchip: vop: fix crtc size in plane check
In-Reply-To: <1457089443-6069-1-git-send-email-john@metanate.com>
References: <56D8DF39.8020104@rock-chips.com>
 <1457089443-6069-1-git-send-email-john@metanate.com>
Message-ID: <56E62454.1070808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?04? 19:04, John Keeping wrote:
> If the geometry of a crtc is changing in an atomic update then we must
> validate the plane size against the new state of the crtc and not the
> current size, otherwise if the crtc size is increasing the plane will be
> cropped at the previous size and will not fill the screen.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> On Fri, 04 Mar 2016 09:04:57 +0800, Mark yao wrote:
>> On 2016?02?22? 20:22, John Keeping wrote:
>>> If the geometry of a crtc is changing in an atomic update then we much
>> I think "we much validate" should be "we must validate".:-)
> Yes, here's v2 with that fixed.
>
>>> validate the plane size against the new state of the crtc and not the
>>> current size, otherwise if the crtc size is increasing the plane will be
>>> cropped at the previous size and will not fill the screen.
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fd37054..82d55bd 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -549,6 +549,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
>   			   struct drm_plane_state *state)
>   {
>   	struct drm_crtc *crtc = state->crtc;
> +	struct drm_crtc_state *crtc_state;
>   	struct drm_framebuffer *fb = state->fb;
>   	struct vop_win *vop_win = to_vop_win(plane);
>   	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
> @@ -563,12 +564,13 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
>   	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
>   					DRM_PLANE_HELPER_NO_SCALING;
>   
> -	crtc = crtc ? crtc : plane->state->crtc;
> -	/*
> -	 * Both crtc or plane->state->crtc can be null.
> -	 */
>   	if (!crtc || !fb)
>   		goto out_disable;
> +
> +	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
> +	if (WARN_ON(!crtc_state))
> +		return -EINVAL;
> +
>   	src->x1 = state->src_x;
>   	src->y1 = state->src_y;
>   	src->x2 = state->src_x + state->src_w;
> @@ -580,8 +582,8 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
>   
>   	clip.x1 = 0;
>   	clip.y1 = 0;
> -	clip.x2 = crtc->mode.hdisplay;
> -	clip.y2 = crtc->mode.vdisplay;
> +	clip.x2 = crtc_state->adjusted_mode.hdisplay;
> +	clip.y2 = crtc_state->adjusted_mode.vdisplay;
>   
>   	ret = drm_plane_helper_check_update(plane, crtc, state->fb,
>   					    src, dest, &clip,

Looks good for me, applied into my drm-fixes.

Thanks for the fix.

-- 
?ark Yao
