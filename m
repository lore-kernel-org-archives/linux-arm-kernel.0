From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 14 Jan 2016 15:57:05 +0100
Subject: [PATCH 3/3] drm/rockchip: explain why we can't wait_for_vblanks
In-Reply-To: <107bbc36a316ed0ddc7b5a8bcd9b6db6cbc71d4f.1452782114.git.john@metanate.com>
References: <20160114142047.GD19130@phenom.ffwll.local>
 <cover.1452782114.git.john@metanate.com>
 <107bbc36a316ed0ddc7b5a8bcd9b6db6cbc71d4f.1452782114.git.john@metanate.com>
Message-ID: <20160114145705.GA24005@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 02:39:42PM +0000, John Keeping wrote:
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 679d23a..b267ce4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -177,6 +177,12 @@ static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
>  		crtc_funcs->wait_for_update(crtc);
>  }
>  
> +/*
> + * We can't use drm_atomic_helper_wait_for_vblanks() because rk3288 and rk3066
> + * have hardware counters for neither vblanks nor scanlines.  This function is
> + * equivalent but uses rockchip_crtc_wait_for_update() instead of waiting for
> + * vblank_count to change.
> + */

This is kind of misleading. From reading earlier parts of the thread the
reason why drm_atomic_helper_wait_for_vblanks() won't work is because it
has a potential race condition that can't be detected unless you also
have a vblank counter. However, the above comment makes it work like
drm_atomic_helper_wait_for_vblanks() doesn't work in the absence of a
vblank counter, which isn't quite true.

Perhaps also the drm_atomic_helper_wait_for_vblanks() kerneldoc needs to
be updated with these restrictions on its use?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160114/20fef853/attachment.sig>
