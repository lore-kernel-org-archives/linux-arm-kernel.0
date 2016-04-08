From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 8 Apr 2016 12:54:10 +0200
Subject: [PATCH 1/2] drm/rockchip: vop: Do check if an update is pending
 during disable
In-Reply-To: <5707043D.6060706@rock-chips.com>
References: <1459937686-9142-1-git-send-email-tomeu.vizoso@collabora.com>
 <5707043D.6060706@rock-chips.com>
Message-ID: <CAAObsKAeAjUP1retiZqo5geOK2OkVjKvSB6g6nvGTh_rdNiFJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2016 at 03:07, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2016?04?06? 18:14, Tomeu Vizoso wrote:
>
> When a plane is being disabled but it's still enabled, do check if the
> previous update has been completed by reading yrgb_mst back.
>
> Otherwise, pending pageflips would remain pending after a CRTC is
> disabled.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index a9b1e8b5ac85..f46b1fd1887b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1064,8 +1064,9 @@ static bool vop_win_pending_is_complete(struct vop_win
> *vop_win)
>   struct vop_plane_state *state = to_vop_plane_state(plane->state);
>   dma_addr_t yrgb_mst;
>
> - if (!state->enable)
> - return VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0;
> + if (!state->enable &&
> +    VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0)
> + return true;
>
>
> It is wrong, the patch would cause a bug.
>
> when state->enable is 0, check yrgb_mst == state->yrgb_mst always be true,
> because state->yrgb_mst not update on plane disabled funtion, that would
> cause iommu crash.

Sorry, but I don't understand where's the bug and what could cause
that crash. What the existing code was doing is saying that a pageflip
event is still pending if we have told the plane to disable but for
some reason it hasn't yet.

With this modification, if we read back that it's already disabled, we
return true as before. But if we read back that it isn't disabled yet,
then we still check the fb pointers and compare them.

The iommu mapping is removed when the _CRTC_ is disabled, and what
this series does is to wait for the pending pageflip to finish before
conitnuing with CRTC disablement.

> About pending pageflips would remain pending, can you  describe more info
> about it? I think those pending pageflips should be ignore when CRTC is
> disabled.

Well, right now in rockchip-drm pending pageflips won't be ignored
when a CRTC is disabled, but will be delivered when it's re-enabled.

If they would be to be ignored (understanding that as dropped), that
would require modifications to clients so they keep track of which fbs
were used in a particular crtc and destroy them when the crtc is
disabled, but that would be incorrect when using the i915 DRM driver
(I also assume others do the same). Given that the pageflip ioctl
isn't driver-specific, I think there cannot be such a difference in
behavior between drivers.

With the current behavior (pending pageflip events being delayed until
the CRTC is enabled again), compositors and other clients will be
holding on to the fb in the pending pageflip until an arbitrary point
in the future that may not ever come. To me that sounds like a serious
modification of the assumptions on fb lifecycle that might not be
warranted.

So in summary, even if I haven't found any explicit documentation on
this, I think the ABI is that any pending pageflips are to be
delivered when that CRTC is being disabled and not later.

Thanks,

Tomeu

> Thanks.
>
>
>   yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win->data);
>
>
>
> --
> ?ark Yao
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
