From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 31 Jan 2017 20:35:25 +0100
Subject: [PATCH 04/11] drm/vc4: Set up SCALER_DISPCTRL at boot.
In-Reply-To: <20161214194621.16499-5-eric@anholt.net>
References: <20161214194621.16499-1-eric@anholt.net>
 <20161214194621.16499-5-eric@anholt.net>
Message-ID: <20170131193525.bjwzmsy74ax4wyy7@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 11:46:14AM -0800, Eric Anholt wrote:
> We want the HVS on, obviously, and we also want DSP3 (PV1's source) to
> be muxed from HVS channel 2 like we expect in vc4_crtc.c.  The
> firmware wasn't setting the DSP3 mux up when both the LCD and HDMI
> were disabled.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Yeah, the hvs magic is checked with require_hvs_enable. And the hvs
channel 2 for pv 1 seems to check out too, though I wonder why you don't
just set up all the mappings unconditionally. Anyway, looks reasonable.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 14 ++++++++++++++
>  drivers/gpu/drm/vc4/vc4_regs.h |  3 +++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 6fbab1c82cb1..fc68b1b4da52 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -170,6 +170,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>  	struct vc4_dev *vc4 = drm->dev_private;
>  	struct vc4_hvs *hvs = NULL;
>  	int ret;
> +	u32 dispctrl;
>  
>  	hvs = devm_kzalloc(&pdev->dev, sizeof(*hvs), GFP_KERNEL);
>  	if (!hvs)
> @@ -211,6 +212,19 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>  		return ret;
>  
>  	vc4->hvs = hvs;
> +
> +	dispctrl = HVS_READ(SCALER_DISPCTRL);
> +
> +	dispctrl |= SCALER_DISPCTRL_ENABLE;
> +
> +	/* Set DSP3 (PV1) to use HVS channel 2, which would otherwise
> +	 * be unused.
> +	 */
> +	dispctrl &= ~SCALER_DISPCTRL_DSP3_MUX_MASK;
> +	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_DSP3_MUX);
> +
> +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> index 39f6886b2410..b3b297fba709 100644
> --- a/drivers/gpu/drm/vc4/vc4_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -244,6 +244,9 @@
>  # define SCALER_DISPCTRL_ENABLE			BIT(31)
>  # define SCALER_DISPCTRL_DSP2EISLUR		BIT(15)
>  # define SCALER_DISPCTRL_DSP1EISLUR		BIT(14)
> +# define SCALER_DISPCTRL_DSP3_MUX_MASK		VC4_MASK(19, 18)
> +# define SCALER_DISPCTRL_DSP3_MUX_SHIFT		18
> +
>  /* Enables Display 0 short line and underrun contribution to
>   * SCALER_DISPSTAT_IRQDISP0.  Note that short frame contributions are
>   * always enabled.
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
