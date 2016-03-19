From: mark.yao@rock-chips.com (Mark yao)
Date: Sat, 19 Mar 2016 09:15:45 +0800
Subject: [PATCH] drm/rockchip: vop: Reset yrgb_mst when re-enabling
In-Reply-To: <1458300147-6472-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1458300147-6472-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <56ECA841.40803@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?18? 19:22, Tomeu Vizoso wrote:
> When the VOP is re-enabled, it will start scanning right away the
> framebuffers that were configured from the last time, even if those have
> been destroyed already. To prevent the VOP from trying to access freed
> memory, reset the registers that hold pointers to framebuffers right
> after we can write to them, but before the VOP is awaken from standby.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Link: http://lkml.kernel.org/g/CAAObsKAv+05ih5U+=4kic_NsjGMhfxYheHR8xXXmacZs+p5SHw at mail.gmail.com
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 5e57f5b2e4b0..0df91c28740b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -429,6 +429,7 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
>   static void vop_enable(struct drm_crtc *crtc)
>   {
>   	struct vop *vop = to_vop(crtc);
> +	int i;
>   	int ret;
>   
>   	if (vop->is_enabled)
> @@ -476,6 +477,18 @@ static void vop_enable(struct drm_crtc *crtc)
>   	 */
>   	vop->is_enabled = true;
>   
> +	/*
> +	 * Before turning the VOP completely on, unset the registers
> +	 * containing FB addresses to avoid the HW start scanning old FBs.
> +	 */
> +	for (i = 0; i < vop->data->win_size; i++) {
> +		struct vop_win *vop_win = &vop->win[i];
> +		const struct vop_win_data *win = vop_win->data;
> +
> +		VOP_WIN_SET(vop, win, yrgb_mst, 0x0);
> +		VOP_WIN_SET(vop, win, uv_mst, 0x0);
> +	}
> +
Hi Tomeu

Thanks for your fix.

Set yrgb_mst and uv_mst is not a good idea, because 0x0 also is a memory 
buffer address, ddr will access the 0x0 buffer.
I think you may enable DRM_FBDEV_EMULATION, the 0x0 address is iommu 
mmaped address for fbdev, so your test can works.
but if DRM_FBDEV_EMULATION is not define, may be 0x0 address is 
unmmaped, would get the iommu crash.

I think we can use atomic disable function like this:
for_each_plane_in_state(old_state, plane, old_plane_state, i) {
     const struct drm_plane_helper_funcs *funcs;
     funcs = plane->helper_private;
     funcs->atomic_disable(plane, old_plane_state);
}

But I think we'd better find why we need do this hack here.

Does the old FB address is ummaped when crtc disabling? why plane is not 
disabled?

Thanks.

>   	spin_lock(&vop->reg_lock);
>   
>   	VOP_CTRL_SET(vop, standby, 0);


-- 
?ark Yao
