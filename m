From: airlied@gmail.com (Dave Airlie)
Date: Mon, 1 Jul 2013 10:01:30 +1000
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130630125238.GH3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
Message-ID: <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 10:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jun 30, 2013 at 01:59:41PM +0200, Daniel Vetter wrote:
>> On Sat, Jun 29, 2013 at 11:53:22PM +0100, Russell King wrote:
>> > +static uint32_t armada_drm_crtc_calculate_csc(struct armada_crtc *dcrtc)
>> > +{
>> > +   struct drm_display_mode *adj = &dcrtc->crtc.mode;
>> > +   uint32_t val = 0;
>> > +
>> > +   if (dcrtc->csc_yuv_mode == CSC_YUV_CCIR709)
>> > +           val |= CFG_CSC_YUV_CCIR709;
>> > +   if (dcrtc->csc_rgb_mode == CSC_RGB_STUDIO)
>> > +           val |= CFG_CSC_RGB_STUDIO;
>> > +
>> > +   /*
>> > +    * In auto mode, set the colorimetry, based upon the HDMI spec.
>> > +    * 1280x720p, 1920x1080p and 1920x1080i use ITU709, others use
>> > +    * ITU601.  It may be more appropriate to set this depending on
>> > +    * the source - but what if the graphic frame is YUV and the
>> > +    * video frame is RGB?
>> > +    */
>> > +   if ((adj->hdisplay == 1280 && adj->vdisplay == 720 &&
>> > +        !(adj->flags & DRM_MODE_FLAG_INTERLACE)) ||
>> > +       (adj->hdisplay == 1920 && adj->vdisplay == 1080)) {
>> > +           if (dcrtc->csc_yuv_mode == CSC_AUTO)
>> > +                   val |= CFG_CSC_YUV_CCIR709;
>> > +   }
>> > +
>> > +   /*
>> > +    * We assume we're connected to a TV-like device, so the YUV->RGB
>> > +    * conversion should produce a limited range.  We should set this
>> > +    * depending on the connectors attached to this CRTC, and what
>> > +    * kind of device they report being connected.
>> > +    */
>> > +   if (dcrtc->csc_rgb_mode == CSC_AUTO)
>> > +           val |= CFG_CSC_RGB_STUDIO;
>>
>> In the intel driver we check whether it's an cea mode with
>> drm_match_cea_mode, e.g. in intel_hdmi.c:
>>
>>       if (intel_hdmi->color_range_auto) {
>>               /* See CEA-861-E - 5.1 Default Encoding Parameters */
>>               if (intel_hdmi->has_hdmi_sink &&
>>                   drm_match_cea_mode(adjusted_mode) > 1)
>>                       intel_hdmi->color_range = HDMI_COLOR_RANGE_16_235;
>>               else
>>                       intel_hdmi->color_range = 0;
>>       }
>>
>> (The color_range gets then propageted to the right place since different
>> platforms have different ways to do that in intel hw).
>
> Unfortunately, this disagrees with the HDMI v1.3a specification:
>
> | Default Colorimetry
> |
> | ...
> |
> | 480p, 480i, 576p, 576i, 240p and 288p
> |
> | The default colorimetry for all 480-line, 576-line, 240-line, and 288-line
> | video formats described in CEA-861-D is based on SMPTE 170M.
> |
> | 1080i, 1080p and 720p
> |
> | The default colorimetry for high-definition video formats (1080i, 1080p and
> | 720p) described in CEA-861-D is based on ITU-R BT.709-5.
>
> As the HDMI spec refers to the CEA-861 specs, the HDMI spec overrides
> CEA when dealing with HDMI specifics.
>
> So, according to the HDMI specification, the default is that it's only
> 1080i, 1080p and 720p which are 709, the others are 601.  This does not
> correspond with "drm_match_cea_mode(adjusted_mode) > 1".
>
> Unfortunately, given DRM's structure, there's no way for the CRTC layer
> to really know what its driving, and this setting is at the CRTC layer,
> not the output layer.  It may be that you have the CRTC duplicated
> between two different display devices with different characteristics,
> which means you have to "choose" one - or just not bother.  I've chosen
> the latter because it's a simpler solution, and is in no way any more
> correct than any other solution.
>
> This is also why these are exported to userspace via properties, so if
> userspace knows better, it can deal with those issues.
>
>> > +struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
>> > +   struct drm_mode_fb_cmd2 *mode, struct armada_gem_object *obj)
>> > +{
>> > +   struct armada_framebuffer *dfb;
>> > +   uint8_t format, config;
>> > +   int ret;
>> > +
>> > +   switch (mode->pixel_format) {
>> > +#define FMT(drm, fmt, mod)         \
>> > +   case DRM_FORMAT_##drm:          \
>> > +           format = CFG_##fmt;     \
>> > +           config = mod;           \
>> > +           break
>> > +   FMT(RGB565,     565,            CFG_SWAPRB);
>> > +   FMT(BGR565,     565,            0);
>> > +   FMT(ARGB1555,   1555,           CFG_SWAPRB);
>> > +   FMT(ABGR1555,   1555,           0);
>> > +   FMT(RGB888,     888PACK,        CFG_SWAPRB);
>> > +   FMT(BGR888,     888PACK,        0);
>> > +   FMT(XRGB8888,   X888,           CFG_SWAPRB);
>> > +   FMT(XBGR8888,   X888,           0);
>> > +   FMT(ARGB8888,   8888,           CFG_SWAPRB);
>> > +   FMT(ABGR8888,   8888,           0);
>> > +   FMT(YUYV,       422PACK,        CFG_YUV2RGB | CFG_SWAPYU | CFG_SWAPUV);
>> > +   FMT(UYVY,       422PACK,        CFG_YUV2RGB);
>> > +   FMT(VYUY,       422PACK,        CFG_YUV2RGB | CFG_SWAPUV);
>> > +   FMT(YVYU,       422PACK,        CFG_YUV2RGB | CFG_SWAPYU);
>> > +   FMT(YUV422,     422,            CFG_YUV2RGB | CFG_SWAPUV);
>> > +   FMT(YVU422,     422,            CFG_YUV2RGB);
>> > +   FMT(YUV420,     420,            CFG_YUV2RGB | CFG_SWAPUV);
>> > +   FMT(YVU420,     420,            CFG_YUV2RGB);
>> > +   FMT(C8,         PSEUDO8,        0);
>> > +#undef FMT
>> > +   default:
>> > +           return ERR_PTR(-EINVAL);
>> > +   }
>> > +
>> > +   dfb = kzalloc(sizeof(*dfb), GFP_KERNEL);
>> > +   if (!dfb) {
>> > +           DRM_ERROR("failed to allocate Armada fb object\n");
>> > +           return ERR_PTR(-ENOMEM);
>> > +   }
>> > +
>> > +   dfb->fmt = format;
>> > +   dfb->mod = config;
>> > +
>> > +   ret = drm_framebuffer_init(dev, &dfb->fb, &armada_fb_funcs);
>> > +   if (ret) {
>> > +           kfree(dfb);
>> > +           return ERR_PTR(ret);
>> > +   }
>>
>> drm_framebuffer_init publishes the fb object to the world, hence
>> initialization of all invariant state _must_ be done beforehand. This is a
>> new requirement since the kms locking rework. So all the below should be
>> moved above.
>
> The constant rewriting of DRM is a right pain in the arse.  I'm dealing
> with v3.9 here, and v3.9 only... However, it doesn't harm moving the
> below so I'll do that.  When v3.10 comes along, that's the kernel I'll
> care about, and not v3.10-rcwhatever.
>

OMG I'm working in a subsystem where stuff is being developed, with only
a few resources! I know my full time job isn't maintaining a 500,000
line subsystem,
and the sub maintainers and developers do a great job refactoring
where required.

lots of other driver authors have made substantial changes to the drm core as
they've written drivers, you spot one bit of refactoring and its a
major shortcoming
of the entire subsystem and development community.

how about instead of writing:
"However, at least I've taken the time to _think_ about what I'm doing
and realise that there _is_ scope here for the DRM core to improve,
rather than burying this stuff deep inside my driver like everyone else
has.  That's no reason to penalise patches from the "good guys" who think"

you go with
"I noticed this piece of functionality could be refactored, here is a
patch adding them to
the core, does anyone think its a good idea?"

As Daniel pointed out every driver submitted has refactored things,
even exynos did a
lot of work to be the first ARM driver we shipped, the DRM core
doesn't write itself and
I fully expect driver authors to be the ones that tell me what needs
refactoring, since
they are on the pointy end, but to state that you are the only person
ever to think about
things is frankly being a dick.

Lets try for less dick, and more productive in future.
Dave.
