From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Tue, 2 Jul 2013 21:01:55 +0300
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAKMK7uFcsbxciq-J_HLCm61kOtGpeAK0Tg2=2AOWSa9YYc4TeA@mail.gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAKMK7uFcsbxciq-J_HLCm61kOtGpeAK0Tg2=2AOWSa9YYc4TeA@mail.gmail.com>
Message-ID: <20130702180155.GP5004@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 07:29:27PM +0200, Daniel Vetter wrote:
> On Sun, Jun 30, 2013 at 2:52 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Jun 30, 2013 at 01:59:41PM +0200, Daniel Vetter wrote:
> >> On Sat, Jun 29, 2013 at 11:53:22PM +0100, Russell King wrote:
> >> > +static uint32_t armada_drm_crtc_calculate_csc(struct armada_crtc *dcrtc)
> >> > +{
> >> > +   struct drm_display_mode *adj = &dcrtc->crtc.mode;
> >> > +   uint32_t val = 0;
> >> > +
> >> > +   if (dcrtc->csc_yuv_mode == CSC_YUV_CCIR709)
> >> > +           val |= CFG_CSC_YUV_CCIR709;
> >> > +   if (dcrtc->csc_rgb_mode == CSC_RGB_STUDIO)
> >> > +           val |= CFG_CSC_RGB_STUDIO;
> >> > +
> >> > +   /*
> >> > +    * In auto mode, set the colorimetry, based upon the HDMI spec.
> >> > +    * 1280x720p, 1920x1080p and 1920x1080i use ITU709, others use
> >> > +    * ITU601.  It may be more appropriate to set this depending on
> >> > +    * the source - but what if the graphic frame is YUV and the
> >> > +    * video frame is RGB?
> >> > +    */
> >> > +   if ((adj->hdisplay == 1280 && adj->vdisplay == 720 &&
> >> > +        !(adj->flags & DRM_MODE_FLAG_INTERLACE)) ||
> >> > +       (adj->hdisplay == 1920 && adj->vdisplay == 1080)) {
> >> > +           if (dcrtc->csc_yuv_mode == CSC_AUTO)
> >> > +                   val |= CFG_CSC_YUV_CCIR709;
> >> > +   }
> >> > +
> >> > +   /*
> >> > +    * We assume we're connected to a TV-like device, so the YUV->RGB
> >> > +    * conversion should produce a limited range.  We should set this
> >> > +    * depending on the connectors attached to this CRTC, and what
> >> > +    * kind of device they report being connected.
> >> > +    */
> >> > +   if (dcrtc->csc_rgb_mode == CSC_AUTO)
> >> > +           val |= CFG_CSC_RGB_STUDIO;
> >>
> >> In the intel driver we check whether it's an cea mode with
> >> drm_match_cea_mode, e.g. in intel_hdmi.c:
> >>
> >>       if (intel_hdmi->color_range_auto) {
> >>               /* See CEA-861-E - 5.1 Default Encoding Parameters */
> >>               if (intel_hdmi->has_hdmi_sink &&
> >>                   drm_match_cea_mode(adjusted_mode) > 1)
> >>                       intel_hdmi->color_range = HDMI_COLOR_RANGE_16_235;
> >>               else
> >>                       intel_hdmi->color_range = 0;
> >>       }
> >>
> >> (The color_range gets then propageted to the right place since different
> >> platforms have different ways to do that in intel hw).
> >
> > Unfortunately, this disagrees with the HDMI v1.3a specification:
> >
> > | Default Colorimetry
> > |
> > | ...
> > |
> > | 480p, 480i, 576p, 576i, 240p and 288p
> > |
> > | The default colorimetry for all 480-line, 576-line, 240-line, and 288-line
> > | video formats described in CEA-861-D is based on SMPTE 170M.
> > |
> > | 1080i, 1080p and 720p
> > |
> > | The default colorimetry for high-definition video formats (1080i, 1080p and
> > | 720p) described in CEA-861-D is based on ITU-R BT.709-5.

I think this was pretty much copy pasted from CEA-861-D which is very
vague.

CEA-861-E is a bit better, and more clearly states that if the sink can
receive YCbCr, then the source should use it by default for CE formats,
and the default colorimetry depends on whether it's SD or HD. It also
states that when transmitting IT or CE formats as RGB, the color space
is the one defined in the EDID. CEA-861-D only made that statement for
IT formats, and left the RGB CE format case out in the cold.

> > As the HDMI spec refers to the CEA-861 specs, the HDMI spec overrides
> > CEA when dealing with HDMI specifics.
> >
> > So, according to the HDMI specification, the default is that it's only
> > 1080i, 1080p and 720p which are 709, the others are 601.  This does not
> > correspond with "drm_match_cea_mode(adjusted_mode) > 1".

We're mixing our apples and oranges here. The logic in i915 has to do
with the default RGB quantization range only.

> Hm, sounds like we need to improve stuff a bit, maybe add a common cea
> helper to the drm core with a bool is_hdmi to decide whether it's
> palin CEA or HDMI-CEA. Ville (who's written the current code and the
> match cea mode helper) can you please take a look?

Currently i915 only outputs RGB, so based on CEA-861-E setting C=00 is
the right thing to do. So I think the only thing we could improve is to
use YCbCr for CE formats by default, but first we need to implement
YCbCr output support :P

Oh and the other thing someone should do is fix the intel Xv code to
use BT.709 CSC matrix for HD content. I believe that code is hardcoded
for BT.601 currently, which may explain the last weirdness reported in
that CEA bug or ours.

> > Unfortunately, given DRM's structure, there's no way for the CRTC layer
> > to really know what its driving, and this setting is at the CRTC layer,
> > not the output layer.  It may be that you have the CRTC duplicated
> > between two different display devices with different characteristics,
> > which means you have to "choose" one - or just not bother.  I've chosen
> > the latter because it's a simpler solution, and is in no way any more
> > correct than any other solution.
> >
> > This is also why these are exported to userspace via properties, so if
> > userspace knows better, it can deal with those issues.
> 
> Yeah, allowing userspace to overwrite the default selection makes lots
> of sense, we expose similar properties.

We really should start documenting properties in some ABI document,
and actually designing them properly. Too many ad-hoc things in most
of the the drivers.

-- 
Ville Syrj?l?
Intel OTC
