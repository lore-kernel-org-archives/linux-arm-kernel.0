From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 May 2015 13:13:28 +0200
Subject: [PATCH] drm: atmel_hlcdc: Add support for get_timings
In-Reply-To: <20150526112853.688d26b7@bbrezillon>
References: <1432199216-1139-1-git-send-email-davidcdueck@googlemail.com>
 <20150526112853.688d26b7@bbrezillon>
Message-ID: <1432811608.3228.43.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Am Dienstag, den 26.05.2015, 11:28 +0200 schrieb Boris Brezillon:
> Hi David,
> 
> On Thu, 21 May 2015 11:06:56 +0200
> David Dueck <davidcdueck@googlemail.com> wrote:
> 
> > drm_panel supports querying timing ranges. If the supplied mode does
> > not work with the hlcdc we query the panel and try to find a suitable
> > mode.
> 
> This patch looks good to me.
> 
> Philip, Thierry, could you confirm this is the correct way of dealing
> with timing ranges.

I wonder about two things:

This implementation minimizes the sum of absolute differences between
chosen and typical values. I wonder if it would be better to try and
minimize the difference between the chosen and nominal vertical refresh
rate.

Is this something that should be done earlier, in create_panel_output,
so that the connector's modes already contain the corrected settings?

regards
Philipp

> > 
> > Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> > ---
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 118 +++++++++++++++++++----
> >  1 file changed, 98 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> > index 9c45130..ea36c24 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> > @@ -20,6 +20,7 @@
> >   */
> >  
> >  #include <linux/of_graph.h>
> > +#include <video/display_timing.h>
> >  
> >  #include <drm/drmP.h>
> >  #include <drm/drm_panel.h>
> > @@ -78,6 +79,8 @@ drm_encoder_to_atmel_hlcdc_rgb_output(struct drm_encoder *encoder)
> >  struct atmel_hlcdc_panel {
> >  	struct atmel_hlcdc_rgb_output base;
> >  	struct drm_panel *panel;
> > +	struct display_timing *timings;
> > +	unsigned int num_timings;
> >  };
> >  
> >  static inline struct atmel_hlcdc_panel *
> > @@ -104,14 +107,6 @@ static void atmel_hlcdc_panel_encoder_disable(struct drm_encoder *encoder)
> >  	drm_panel_disable(panel->panel);
> >  }
> >  
> > -static bool
> > -atmel_hlcdc_panel_encoder_mode_fixup(struct drm_encoder *encoder,
> > -				     const struct drm_display_mode *mode,
> > -				     struct drm_display_mode *adjusted)
> > -{
> > -	return true;
> > -}
> > -
> >  static void
> >  atmel_hlcdc_rgb_encoder_mode_set(struct drm_encoder *encoder,
> >  				 struct drm_display_mode *mode,
> > @@ -142,8 +137,86 @@ atmel_hlcdc_rgb_encoder_mode_set(struct drm_encoder *encoder,
> >  			   cfg);
> >  }
> >  
> > +/**
> > + * atmel_hlcdc_choose_parameter - choose timing parameter
> > + * @dc_min: minimum parameter value allowed by dc
> > + * @dc_max: maximum parameter value allowed by dc
> > + * @te: parameter range allowed by panel
> > + * @result: chosen parameter
> > + *
> > + * DESCRIPTION:
> > + * If there is overlap in the allowed ranges, we will pick a parameter
> > + * minimizing the distance to te.typ. If not, we return te.min or te.max.
> > + **/
> > +static u32 atmel_hlcdc_choose_parameter(u32 dc_min, u32 dc_max,
> > +					struct timing_entry te)
> > +{
> > +	if (te.typ <= dc_max && te.typ >= dc_min)
> > +		return te.typ;
> > +	else if (te.typ > dc_max)
> > +		return max(dc_max, te.min);
> > +	else
> > +		return min(dc_min, te.max);
> > +}
> > +
> > +static void atmel_hlcdc_calculate_mode(struct display_timing *timings,
> > +				       struct drm_display_mode *adjusted_mode)
> > +{
> > +	u32 hsync_len, hfront_porch, hback_porch;
> > +	u32 vsync_len, vfront_porch, vback_porch;
> > +
> > +	hsync_len = atmel_hlcdc_choose_parameter(1, 0x40, timings->hsync_len);
> > +	vsync_len = atmel_hlcdc_choose_parameter(1, 0x40, timings->vsync_len);
> > +
> > +	hfront_porch = atmel_hlcdc_choose_parameter(1, 0x200,
> > +						    timings->hfront_porch);
> > +	hback_porch = atmel_hlcdc_choose_parameter(1, 0x200,
> > +						   timings->hback_porch);
> > +	vfront_porch = atmel_hlcdc_choose_parameter(1, 0x40,
> > +						    timings->vfront_porch);
> > +	vback_porch = atmel_hlcdc_choose_parameter(0, 0x40,
> > +						   timings->vback_porch);
> > +
> > +	adjusted_mode->hsync_start = adjusted_mode->hdisplay + hfront_porch;
> > +	adjusted_mode->hsync_end = adjusted_mode->hsync_start + hsync_len;
> > +	adjusted_mode->htotal = adjusted_mode->hsync_end + hback_porch;
> > +
> > +	adjusted_mode->vsync_start = adjusted_mode->vdisplay + vfront_porch;
> > +	adjusted_mode->vsync_end = adjusted_mode->vsync_start + vsync_len;
> > +	adjusted_mode->vtotal = adjusted_mode->vsync_end + vback_porch;
> > +}
> > +
> > +static int
> > +atmel_hlcdc_panel_encoder_atomic_check(struct drm_encoder *encoder,
> > +				       struct drm_crtc_state *crtc_state,
> > +				       struct drm_connector_state *conn_state)
> > +{
> > +	struct atmel_hlcdc_rgb_output *rgb =
> > +			drm_encoder_to_atmel_hlcdc_rgb_output(encoder);
> > +	struct atmel_hlcdc_panel *panel = atmel_hlcdc_rgb_output_to_panel(rgb);
> > +	struct drm_display_mode *mode = &crtc_state->mode;
> > +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> > +	int i;
> > +
> > +	if (atmel_hlcdc_dc_mode_valid(rgb->dc, mode) == MODE_OK)
> > +		return 0;
> > +
> > +	for (i = 0; i < panel->num_timings; i++) {
> > +		if (panel->timings->hactive.typ != mode->hdisplay ||
> > +		    panel->timings->vactive.typ != mode->vdisplay)
> > +			continue;
> > +
> > +		atmel_hlcdc_calculate_mode(panel->timings, adjusted_mode);
> > +		if (atmel_hlcdc_dc_mode_valid(rgb->dc, adjusted_mode) ==
> > +		    MODE_OK)
> > +			return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  static struct drm_encoder_helper_funcs atmel_hlcdc_panel_encoder_helper_funcs = {
> > -	.mode_fixup = atmel_hlcdc_panel_encoder_mode_fixup,
> > +	.atomic_check = atmel_hlcdc_panel_encoder_atomic_check,
> >  	.mode_set = atmel_hlcdc_rgb_encoder_mode_set,
> >  	.disable = atmel_hlcdc_panel_encoder_disable,
> >  	.enable = atmel_hlcdc_panel_encoder_enable,
> > @@ -168,16 +241,6 @@ static int atmel_hlcdc_panel_get_modes(struct drm_connector *connector)
> >  	return panel->panel->funcs->get_modes(panel->panel);
> >  }
> >  
> > -static int atmel_hlcdc_rgb_mode_valid(struct drm_connector *connector,
> > -				      struct drm_display_mode *mode)
> > -{
> > -	struct atmel_hlcdc_rgb_output *rgb =
> > -			drm_connector_to_atmel_hlcdc_rgb_output(connector);
> > -
> > -	return atmel_hlcdc_dc_mode_valid(rgb->dc, mode);
> > -}
> > -
> > -
> >  
> >  static struct drm_encoder *
> >  atmel_hlcdc_rgb_best_encoder(struct drm_connector *connector)
> > @@ -190,7 +253,6 @@ atmel_hlcdc_rgb_best_encoder(struct drm_connector *connector)
> >  
> >  static struct drm_connector_helper_funcs atmel_hlcdc_panel_connector_helper_funcs = {
> >  	.get_modes = atmel_hlcdc_panel_get_modes,
> > -	.mode_valid = atmel_hlcdc_rgb_mode_valid,
> >  	.best_encoder = atmel_hlcdc_rgb_best_encoder,
> >  };
> >  
> > @@ -273,6 +335,22 @@ static int atmel_hlcdc_create_panel_output(struct drm_device *dev,
> >  	drm_panel_attach(p, &panel->base.connector);
> >  	panel->panel = p;
> >  
> > +	if (!panel->panel->funcs->get_timings)
> > +		return 0;
> > +
> > +	panel->num_timings =
> > +		panel->panel->funcs->get_timings(panel->panel, 0, NULL);
> > +	panel->timings =
> > +		devm_kzalloc(dev->dev,
> > +			     panel->num_timings * sizeof(struct display_timing),
> > +			     GFP_KERNEL);
> > +
> > +	if (!panel->timings)
> > +		return 0;
> > +
> > +	panel->panel->funcs->get_timings(panel->panel, panel->num_timings,
> > +					 panel->timings);
> > +
> >  	return 0;
> >  
> >  err_encoder_cleanup:
> 
> 
> 
