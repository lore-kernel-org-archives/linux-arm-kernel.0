From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 30 Jun 2017 15:41:18 +0200
Subject: [PATCH 2/2] drm/atomic: Wait indefinitely and interruptibly for
 hw_done.
In-Reply-To: <20170628132812.14927-2-maarten.lankhorst@linux.intel.com>
References: <20170628132812.14927-1-maarten.lankhorst@linux.intel.com>
 <20170628132812.14927-2-maarten.lankhorst@linux.intel.com>
Message-ID: <20170630134118.qtfalfscgabcwo5o@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 03:28:12PM +0200, Maarten Lankhorst wrote:
> Without waiting for hw_done, previous atomic updates may dereference
> the wrong state and cause a lot of confusion. The real fix is fixing
> all obj->state to use the accessor macros, but for now wait
> indefinitely and interruptibly.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-kernel at vger.kernel.org
> Cc: intel-gfx at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: freedreno at lists.freedesktop.org
> Cc: nouveau at lists.freedesktop.org
> Cc: linux-tegra at vger.kernel.org
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index f66b6c45cdd0..56e7729d993d 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2144,8 +2144,7 @@ EXPORT_SYMBOL(drm_atomic_helper_cleanup_planes);
>  int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>  				  bool stall)

Needs improved kernel-doc:

 * Returns:
 * 
 * 0 on success. Can return -EINTR when @stall is true and the waiting for
 * the previous commits has been interrupted.

With that Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  {
> -	int i;
> -	long ret;
> +	int i, ret;
>  	struct drm_connector *connector;
>  	struct drm_connector_state *old_conn_state, *new_conn_state;
>  	struct drm_crtc *crtc;
> @@ -2168,12 +2167,11 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>  			if (!commit)
>  				continue;
>  
> -			ret = wait_for_completion_timeout(&commit->hw_done,
> -							  10*HZ);
> -			if (ret == 0)
> -				DRM_ERROR("[CRTC:%d:%s] hw_done timed out\n",
> -					  crtc->base.id, crtc->name);
> +			ret = wait_for_completion_interruptible(&commit->hw_done);
>  			drm_crtc_commit_put(commit);
> +
> +			if (ret)
> +				return ret;
>  		}
>  	}
>  
> -- 
> 2.11.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
