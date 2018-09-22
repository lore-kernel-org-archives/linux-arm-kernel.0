From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 22 Sep 2018 15:06:02 +0300
Subject: [PATCH v2 1/8] drm/bridge: use bus flags in bridge timings
In-Reply-To: <bf38f469923e1c2a16252c6d1d2bcb2b@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
 <6714863.eJMplaj6yU@avalon> <bf38f469923e1c2a16252c6d1d2bcb2b@agner.ch>
Message-ID: <3905999.JCVWYgpCCG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tuesday, 18 September 2018 21:14:22 EEST Stefan Agner wrote:
> On 14.09.2018 02:23, Laurent Pinchart wrote:
> > On Wednesday, 12 September 2018 21:32:15 EEST Stefan Agner wrote:
> >> The DRM bus flags conveys additional information on pixel data on
> >> the bus. All currently available bus flags might be of interest for
> >> a bridge. In the case at hand a dumb VGA bridge needs a specific
> >> data enable polarity (DRM_BUS_FLAG_DE_LOW).
> >> 
> >> Replace the sampling_edge field with input_bus_flags and allow all
> >> currently documented bus flags.
> >> 
> >> This changes the perspective from sampling side to the driving
> >> side for the currently supported flags. We assume that the sampling
> >> edge is always the opposite of the driving edge (hence we need to
> >> invert the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE flags). This is an
> >> assumption we already make for displays. For all we know it is a
> >> safe assumption for bridges too.
> > 
> > Please don't, that will get confusing very quickly. Flag names such as
> > DRM_BUS_FLAG_PIXDATA_NEGEDGE don't mention sampling or driving. There's
> > only a small comment next to their definition, which will easily be
> > overlooked. I'd rather update the definition to cover both sampling and
> > driving, and document the input_bus_flags field to explain that all flags
> > refer to sampling.
> 
> There is history to that, and I'd really rather prefer to keep that similar
> across the kernel. There is already precedence in the kernel, the display
> timings (which is a consumer) defines it from the driving perspective too
> (see DISPLAY_FLAGS_PIXDATA_POSEDGE).
> 
> That is why I introduced the bus flags using the same perspective.
> 
> If we _really_ want it from sampling side, we should create new defines
> which are explicit about that, e.g.: DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE.

I'm not opposed to that.

> But again, since even the display flags use the driving perspective, I'd
> rather prefer to have it that way also for bridges too.

But look at the following diff:

-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,

The first line makes it very explicit that the data signals are sampled on the 
rising edge. The second line reads to me as sampling on the negative edge, as 
it reports input information from a bridge perspective. I'll have to read the 
documentation to get it right, and I'm sure I and other will overlook it from 
time to time.

The following would be much more explicit:

	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLING_POSEDGE,

and we could define macros as follows:

/*
 * Don't use those two flags directly, use the DRM_BUS_FLAG_PIXDATA_DRIVE_*
 * and DRM_BUS_FLAG_PIXDATA_SAMPLE_* variants to qualify the flags explicitly.
 * The DRM_BUS_FLAG_PIXDATA_SAMPLE_* flags are defined as the opposite of the
 * DRM_BUS_FLAG_PIXDATA_DRIVE_* flags to make code simpler, as signals are
 * usually to be sampled on the opposite edge of the driving edge.
 */
#define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
#define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)

/* Drive data on rising edge */
#define DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE    DRM_BUS_FLAG_PIXDATA_POSEDGE
/* Drive data on falling edge */
#define DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE    DRM_BUS_FLAG_PIXDATA_NEGEDGE
/* Sample data on rising edge */
#define DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE   DRM_BUS_FLAG_PIXDATA_NEGEDGE
/* Sample data on falling edge */
#define DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE   DRM_BUS_FLAG_PIXDATA_POSEDGE

I'll submit a patch series.

> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> 
> >>  drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
> >>  include/drm/drm_bridge.h              | 11 +++++------
> >>  2 files changed, 8 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> >> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 9b706789a341..d5aa0f931ef2
> >> 100644
> >> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> >> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> >> @@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device
> >> *pdev)
> >>  */
> >>  static const struct drm_bridge_timings default_dac_timings = {
> >>  	/* Timing specifications, datasheet page 7 */
> >> -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
> >> +	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> >>  	.setup_time_ps = 500,
> >>  	.hold_time_ps = 1500,
> >>  };
> >> @@ -245,7 +245,7 @@ static const struct drm_bridge_timings
> >> default_dac_timings = {
> >>  */
> >>  static const struct drm_bridge_timings ti_ths8134_dac_timings = {
> >>  	/* From timing diagram, datasheet page 9 */
> >> -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
> >> +	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> >>  	/* From datasheet, page 12 */
> >>  	.setup_time_ps = 3000,
> >>  	/* I guess this means latched input */
> >> @@ -258,7 +258,7 @@ static const struct drm_bridge_timings
> >> ti_ths8134_dac_timings = {
> >>  */
> >>  static const struct drm_bridge_timings ti_ths8135_dac_timings = {
> >>  	/* From timing diagram, datasheet page 14 */
> >> -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
> >> +	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> >>  	/* From datasheet, page 16 */
> >>  	.setup_time_ps = 2000,
> >>  	.hold_time_ps = 500,
> >> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >> index bd850747ce54..45e90f4b46c3 100644
> >> --- a/include/drm/drm_bridge.h
> >> +++ b/include/drm/drm_bridge.h
> >> @@ -244,14 +244,13 @@ struct drm_bridge_funcs {
> >>   */
> >>  struct drm_bridge_timings {
> >>  	/**
> >> -	 * @sampling_edge:
> >> +	 * @input_bus_flags:
> >>  	 *
> >> -	 * Tells whether the bridge samples the digital input signal
> >> -	 * from the display engine on the positive or negative edge of the
> >> -	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
> >> -	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
> >> +	 * Additional settings this bridge requires for the pixel data on
> >> +	 * the input bus (e.g. pixel signal polarity). See also
> >> +	 * &drm_display_info->bus_flags.
> >>  	 */
> >> -	u32 sampling_edge;
> >> +	u32 input_bus_flags;
> >> 
> >>  	/**
> >>  	 * @setup_time_ps:
> >>  	 *

-- 
Regards,

Laurent Pinchart
