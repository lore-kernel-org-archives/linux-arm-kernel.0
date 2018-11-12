From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 12 Nov 2018 20:01:11 +0000
Subject: [PATCH 2/2] drm/atomic: Create and use
 __drm_atomic_helper_crtc_reset() everywhere
In-Reply-To: <20181112150114.18395-2-maarten.lankhorst@linux.intel.com>
References: <20181112150114.18395-1-maarten.lankhorst@linux.intel.com>
 <20181112150114.18395-2-maarten.lankhorst@linux.intel.com>
Message-ID: <20181112200111.GA2124@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 04:01:14PM +0100, Maarten Lankhorst wrote:
> We already have __drm_atomic_helper_connector_reset() and
> __drm_atomic_helper_plane_reset(), extend this to crtc as well.
> 
> Most drivers already have a gpu reset hook, correct it.
> Nouveau already implemented its own __drm_atomic_helper_crtc_reset(),
> convert it to the common one.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K??nig" <christian.koenig@amd.com>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: Mali DP Maintainers <malidp@foss.arm.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St??bner" <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: Sinclair Yeh <syeh@vmware.com>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Tony Cheng <Tony.Cheng@amd.com>
> Cc: Shirish S <shirish.s@amd.com>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: David Francis <David.Francis@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Bruce Wang <bzwang@chromium.org>
> Cc: Sravanthi Kollukuduru <skolluku@codeaurora.org>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Steve Kowalik <steven@wedontsleep.org>
> Cc: Carsten Behling <carsten.behling@googlemail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Mahesh Kumar <mahesh1.kumar@intel.com>
> Cc: amd-gfx at lists.freedesktop.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: intel-gfx at lists.freedesktop.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: freedreno at lists.freedesktop.org
> Cc: nouveau at lists.freedesktop.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-tegra at vger.kernel.org
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +--
>  drivers/gpu/drm/arm/malidp_crtc.c             |  5 +--
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  5 +--
>  drivers/gpu/drm/drm_atomic_state_helper.c     | 31 ++++++++++++++++---
>  drivers/gpu/drm/i915/intel_display.c          |  2 +-
>  drivers/gpu/drm/imx/ipuv3-crtc.c              |  5 +--
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  5 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 12 ++-----
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  6 +---
>  drivers/gpu/drm/nouveau/dispnv50/head.c       | 13 ++------
>  drivers/gpu/drm/omapdrm/omap_crtc.c           |  7 ++---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  4 +--
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  7 +++--
>  drivers/gpu/drm/tegra/dc.c                    |  5 +--
>  drivers/gpu/drm/vc4/vc4_crtc.c                |  8 ++---
>  drivers/gpu/drm/vkms/vkms_crtc.c              |  7 +----
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |  9 +-----
>  include/drm/drm_atomic_state_helper.h         |  2 ++
>  18 files changed, 56 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5064768642f3..770a71726cd1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2802,9 +2802,7 @@ static void dm_crtc_reset_state(struct drm_crtc *crtc)
>  	if (WARN_ON(!state))
>  		return;
>  
> -	crtc->state = &state->base;
> -	crtc->state->crtc = crtc;
> -
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>  }
>  
>  static struct drm_crtc_state *
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index e1b72782848c..9a924ff27148 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -474,10 +474,7 @@ static void malidp_crtc_reset(struct drm_crtc *crtc)
>  
>  	kfree(state);
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
> -	if (state) {
> -		crtc->state = &state->base;
> -		crtc->state->crtc = crtc;
> -	}
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>  }
>  
>  static void malidp_crtc_destroy_state(struct drm_crtc *crtc,

For the malidp changes:
Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 96f4082671fe..8084d549c7d1 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -412,10 +412,7 @@ static void atmel_hlcdc_crtc_reset(struct drm_crtc *crtc)
>  	}
>  
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
> -	if (state) {
> -		crtc->state = &state->base;
> -		crtc->state->crtc = crtc;
> -	}
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>  }
>  
>  static struct drm_crtc_state *
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 3ba996069d69..3eee1ca33fc5 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -55,6 +55,29 @@
>   * for these functions.
>   */
>  
> +/**
> + * __drm_atomic_helper_crtc_reset - reset state on CRTC
> + * @crtc: drm CRTC
> + * @crtc_state: CRTC state to assign
> + *
> + * Initializes the newly allocated @crtc_state and assigns it to
> + * the &drm_conector->state pointer of @crtc, usually required when
> + * initializing the drivers or when called from the &drm_crtc_funcs.reset
> + * hook.
> + *
> + * This is useful for drivers that subclass the CRTC state.
> + */
> +void
> +__drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
> +			       struct drm_crtc_state *crtc_state)
> +{
> +	if (crtc_state)
> +		crtc_state->crtc = crtc;
> +
> +	crtc->state = crtc_state;
> +}
> +EXPORT_SYMBOL(__drm_atomic_helper_crtc_reset);
> +
>  /**
>   * drm_atomic_helper_crtc_reset - default &drm_crtc_funcs.reset hook for CRTCs
>   * @crtc: drm CRTC
> @@ -64,14 +87,14 @@
>   */
>  void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc)
>  {
> +	struct drm_crtc_state *crtc_state =
> +		kzalloc(sizeof(*crtc->state), GFP_KERNEL);
> +
>  	if (crtc->state)
>  		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>  
>  	kfree(crtc->state);
> -	crtc->state = kzalloc(sizeof(*crtc->state), GFP_KERNEL);
> -
> -	if (crtc->state)
> -		crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, crtc_state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_crtc_reset);
>  
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index f383417571ec..907ffeb64781 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -15457,7 +15457,7 @@ static void intel_modeset_readout_hw_state(struct drm_device *dev)
>  
>  		__drm_atomic_helper_crtc_destroy_state(&crtc_state->base);
>  		memset(crtc_state, 0, sizeof(*crtc_state));
> -		crtc_state->base.crtc = &crtc->base;
> +		__drm_atomic_helper_crtc_reset(&crtc->base, &crtc_state->base);
>  
>  		crtc_state->base.active = crtc_state->base.enable =
>  			dev_priv->display.get_pipe_config(crtc, crtc_state);
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index 7d4b710b837a..8bc36f0d2b6b 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -120,12 +120,9 @@ static void imx_drm_crtc_reset(struct drm_crtc *crtc)
>  		memset(state, 0, sizeof(*state));
>  	} else {
>  		state = kzalloc(sizeof(*state), GFP_KERNEL);
> -		if (!state)
> -			return;
> -		crtc->state = &state->base;
>  	}
>  
> -	state->base.crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>  }
>  
>  static struct drm_crtc_state *imx_drm_crtc_duplicate_state(struct drm_crtc *crtc)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 92ecb9bf982c..a743e5ed1177 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -119,12 +119,9 @@ static void mtk_drm_crtc_reset(struct drm_crtc *crtc)
>  		memset(state, 0, sizeof(*state));
>  	} else {
>  		state = kzalloc(sizeof(*state), GFP_KERNEL);
> -		if (!state)
> -			return;
> -		crtc->state = &state->base;
>  	}
>  
> -	state->base.crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>  }
>  
>  static struct drm_crtc_state *mtk_drm_crtc_duplicate_state(struct drm_crtc *crtc)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index d4530d60767b..c86e603f486a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -894,20 +894,12 @@ static void dpu_crtc_reset(struct drm_crtc *crtc)
>  		_dpu_crtc_set_suspend(crtc, false);
>  
>  	/* remove previous state, if present */
> -	if (crtc->state) {
> +	if (crtc->state)
>  		dpu_crtc_destroy_state(crtc, crtc->state);
> -		crtc->state = 0;
> -	}
>  
>  	dpu_crtc = to_dpu_crtc(crtc);
>  	cstate = kzalloc(sizeof(*cstate), GFP_KERNEL);
> -	if (!cstate) {
> -		DPU_ERROR("failed to allocate state\n");
> -		return;
> -	}
> -
> -	cstate->base.crtc = crtc;
> -	crtc->state = &cstate->base;
> +	__drm_atomic_helper_crtc_reset(crtc, &cstate->base);
>  }
>  
>  static void dpu_crtc_handle_power_event(u32 event_type, void *arg)
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index b1da9ce54379..138da66b1530 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -1019,11 +1019,7 @@ static void mdp5_crtc_reset(struct drm_crtc *crtc)
>  	}
>  
>  	mdp5_cstate = kzalloc(sizeof(*mdp5_cstate), GFP_KERNEL);
> -
> -	if (mdp5_cstate) {
> -		mdp5_cstate->base.crtc = crtc;
> -		crtc->state = &mdp5_cstate->base;
> -	}
> +	__drm_atomic_helper_crtc_reset(crtc, &mdp5_cstate->base);
>  }
>  
>  static struct drm_crtc_state *
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
> index 4f57e5379796..341600406589 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/head.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
> @@ -418,16 +418,6 @@ nv50_head_atomic_duplicate_state(struct drm_crtc *crtc)
>  	return &asyh->state;
>  }
>  
> -static void
> -__drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
> -			       struct drm_crtc_state *state)
> -{
> -	if (crtc->state)
> -		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
> -	crtc->state = state;
> -	crtc->state->crtc = crtc;
> -}
> -
>  static void
>  nv50_head_reset(struct drm_crtc *crtc)
>  {
> @@ -436,6 +426,9 @@ nv50_head_reset(struct drm_crtc *crtc)
>  	if (WARN_ON(!(asyh = kzalloc(sizeof(*asyh), GFP_KERNEL))))
>  		return;
>  
> +	if (crtc->state)
> +		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
> +
>  	__drm_atomic_helper_crtc_reset(crtc, &asyh->state);
>  }
>  
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
> index caffc547ef97..9c5f8109913c 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -554,14 +554,13 @@ static int omap_crtc_atomic_get_property(struct drm_crtc *crtc,
>  
>  static void omap_crtc_reset(struct drm_crtc *crtc)
>  {
> +	struct omap_crtc_state *crtc_state =
> +		kzalloc(sizeof(*crtc_state), GFP_KERNEL);
>  	if (crtc->state)
>  		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>  
>  	kfree(crtc->state);
> -	crtc->state = kzalloc(sizeof(struct omap_crtc_state), GFP_KERNEL);
> -
> -	if (crtc->state)
> -		crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
>  }
>  
>  static struct drm_crtc_state *
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index 17741843cf51..7beab22b4674 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -857,14 +857,12 @@ static void rcar_du_crtc_reset(struct drm_crtc *crtc)
>  	}
>  
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	__drm_atomic_helper_crtc_reset(crtc, &state->state);
>  	if (state == NULL)
>  		return;
>  
>  	state->crc.source = VSP1_DU_CRC_NONE;
>  	state->crc.index = 0;
> -
> -	crtc->state = &state->state;
> -	crtc->state->crtc = crtc;
>  }
>  
>  static int rcar_du_crtc_enable_vblank(struct drm_crtc *crtc)
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fb70fb486fbf..d2d5aa676084 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1071,13 +1071,14 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
>  
>  static void vop_crtc_reset(struct drm_crtc *crtc)
>  {
> +	struct rockchip_crtc_state *crtc_state =
> +		kzalloc(sizeof(*crtc_state), GFP_KERNEL);
> +
>  	if (crtc->state)
>  		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>  	kfree(crtc->state);
>  
> -	crtc->state = kzalloc(sizeof(struct rockchip_crtc_state), GFP_KERNEL);
> -	if (crtc->state)
> -		crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
>  }
>  
>  static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index f80e82e16475..140d6191d8d2 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -1164,10 +1164,7 @@ static void tegra_crtc_reset(struct drm_crtc *crtc)
>  	crtc->state = NULL;
>  
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
> -	if (state) {
> -		crtc->state = &state->base;
> -		crtc->state->crtc = crtc;
> -	}
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>  
>  	drm_crtc_vblank_reset(crtc);
>  }
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index cd226e63d557..76beeda157fc 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -998,12 +998,12 @@ static void vc4_crtc_destroy_state(struct drm_crtc *crtc,
>  static void
>  vc4_crtc_reset(struct drm_crtc *crtc)
>  {
> -	if (crtc->state)
> -		vc4_crtc_destroy_state(crtc->state);
> +	struct vc4_crtc_state *crtc_state =
> +		kzalloc(sizeof(*crtc_state), GFP_KERNEL);
>  
> -	crtc->state = kzalloc(sizeof(struct vc4_crtc_state), GFP_KERNEL);
>  	if (crtc->state)
> -		crtc->state->crtc = crtc;
> +		vc4_crtc_destroy_state(crtc, crtc->state);
> +	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
>  }
>  
>  static const struct drm_crtc_funcs vc4_crtc_funcs = {
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 177bbcb38306..7b018f6ee971 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -98,15 +98,10 @@ static void vkms_atomic_crtc_reset(struct drm_crtc *crtc)
>  		vkms_state = to_vkms_crtc_state(crtc->state);
>  		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>  		kfree(vkms_state);
> -		crtc->state = NULL;
>  	}
>  
>  	vkms_state = kzalloc(sizeof(*vkms_state), GFP_KERNEL);
> -	if (!vkms_state)
> -		return;
> -
> -	crtc->state = &vkms_state->base;
> -	crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &vkms_state->base);
>  }
>  
>  static struct drm_crtc_state *
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index e6b11f6ae2e4..2878bc0a4718 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -633,14 +633,7 @@ void vmw_du_crtc_reset(struct drm_crtc *crtc)
>  	}
>  
>  	vcs = kzalloc(sizeof(*vcs), GFP_KERNEL);
> -
> -	if (!vcs) {
> -		DRM_ERROR("Cannot allocate vmw_crtc_state\n");
> -		return;
> -	}
> -
> -	crtc->state = &vcs->base;
> -	crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &vcs->base);
>  }
>  
>  
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 5b82ccfdb502..ab2b5a49948c 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -37,6 +37,8 @@ struct drm_private_state;
>  struct drm_modeset_acquire_ctx;
>  struct drm_device;
>  
> +void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
> +				    struct drm_crtc_state *state);
>  void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
>  					      struct drm_crtc_state *state);
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
