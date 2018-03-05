From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 05 Mar 2018 12:08:12 +0200
Subject: [PATCH v3 1/8] drm/blend: Add a generic alpha property
In-Reply-To: <20180305085841.GF22212@phenom.ffwll.local>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <20180221130757.al7i57kiptrqh4j2@flea.lan>
 <20180305085841.GF22212@phenom.ffwll.local>
Message-ID: <16735594.PliY9Ubb24@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday, 5 March 2018 10:58:41 EET Daniel Vetter wrote:
> On Wed, Feb 21, 2018 at 02:07:57PM +0100, Maxime Ripard wrote:
> > On Mon, Feb 19, 2018 at 10:58:40PM +0100, Daniel Vetter wrote:
> >> On Mon, Feb 19, 2018 at 9:19 PM, Laurent Pinchart wrote:
> >>> On Friday, 16 February 2018 20:20:41 EET Ville Syrj?l? wrote:
> >>>> On Fri, Feb 16, 2018 at 06:39:29PM +0100, Maxime Ripard wrote:
> >>>>> Some drivers duplicate the logic to create a property to store a
> >>>>> per-plane alpha.
> >>>>> 
> >>>>> This is especially useful if we ever want to support extra
> >>>>> protocols for Wayland like:
> >>>>> https://lists.freedesktop.org/archives/wayland-devel/2017-August/03
> >>>>> 4741.html
> >>>>> 
> >>>>> Let's create a helper in order to move that to the core.
> >>>>> 
> >>>>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >>>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >>>>> ---
> >>>>> 
> >>>>>  Documentation/gpu/kms-properties.csv |  2 +-
> >>>>>  drivers/gpu/drm/drm_atomic.c         |  4 ++++-
> >>>>>  drivers/gpu/drm/drm_atomic_helper.c  |  4 ++++-
> >>>>>  drivers/gpu/drm/drm_blend.c          | 32 +++++++++++++++++++++++-
> >>>>>  include/drm/drm_blend.h              |  1 +-
> >>>>>  include/drm/drm_plane.h              |  6 +++++-
> >>>>>  6 files changed, 48 insertions(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/Documentation/gpu/kms-properties.csv
> >>>>> b/Documentation/gpu/kms-properties.csv index
> >>>>> 927b65e14219..25ad3503d663
> >>>>> 100644
> >>>>> --- a/Documentation/gpu/kms-properties.csv
> >>>>> +++ b/Documentation/gpu/kms-properties.csv
> >>>>> @@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0,
> >>>>> Max=1",Connector,TBD>
> >>>>> 
> >>>>>  ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
> >>>>>  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
> >>>>>  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> >>>>> 
> >>>>> -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
> >>>>> +,,"""alpha""",RANGE,"Min=0, Max=Driver dependant",Plane,Opacity of
> >>>>> the plane from transparent (0) to fully opaque (MAX). If this
> >>>>> property is set to a value different than max, and that the pixel
> >>>>> will define an alpha component, the property will have precendance
> >>>>> and the pixel value will be ignored.
> >> 
> >> Please don't document new properties in that csv file, it's an
> >> unreadable mess. Instead follow how we document standardized
> >> properties nowadays in full-blown sections. For plane blending we
> >> have:
> >> 
> >> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-> >> properties
> > 
> > Ack
> > 
> >>>>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> >>>>> index 8185e3468a23..5a6f29524f12 100644
> >>>>> --- a/include/drm/drm_plane.h
> >>>>> +++ b/include/drm/drm_plane.h
> >>>>> @@ -42,6 +42,7 @@ struct drm_modeset_acquire_ctx;
> >>>>>   * plane (in 16.16)
> >>>>>   * @src_w: width of visible portion of plane (in 16.16)
> >>>>>   * @src_h: height of visible portion of plane (in 16.16)
> >>>>> + * @alpha: opacity of the plane
> >>>>>   * @rotation: rotation of the plane
> >>>>>   * @zpos: priority of the given plane on crtc (optional)
> >>>>>   * Note that multiple active planes on the same crtc can have an
> >>>>>   identical
> >>>>> @@ -105,6 +106,9 @@ struct drm_plane_state {
> >>>>>     uint32_t src_x, src_y;
> >>>>>     uint32_t src_h, src_w;
> >>>>> 
> >>>>> +   /* Plane opacity */
> >>>>> +   u8 alpha;
> >>>> 
> >>>> We may want to make that u16. The general we expect 16bpc for most
> >>>> color related things, but since this is a range prop I suppose we
> >>>> should just expose the actual hardware range. But making it u16 might
> >>>> avoid some head scratching for the first person to have hardware with
> >>>> higher precision. Either that or we should make the prop creation
> >>>> fail if the driver asks for more bits than we have in the state.
> >>> 
> >>> I'm tempted to go one step further and always make the alpha property
> >>> 16-bits wide for new users (we can't do so for existing users as it
> >>> could break userspace), and let drivers convert that internally to
> >>> the range they need. There could however be drawbacks I don't
> >>> foresee.
> >> 
> >> I think scaling the range to match the hw is the most sensible (yes
> >> I'm flip-flopping around here). And once someone needs more than u8,
> >> we can extend the internal representation easily. The external
> >> representation in the property is an u64, that /should/ be enough for
> >> the next few years :-)
> > 
> > Just to make sure we're on the same page, you want to keep the u8, and
> > if the hardware uses say an u16, the driver for that hardware will do
> > the upscaling?
> 
> The idea is that we'd set the u16 limit in the property and so inform
> userspace that a different range applies. But that's probably going to be
> ignored.
> 
> Could we do the property itself as u16 range, and (for now, only
> internally in drm in drm_plane_state) throw the lower u8 bits away? Or
> just let drivers do this.

I'm fine with this except for the drivers that currently implement the alpha 
property with a different range. The rcar-du driver for instances has the 
alpha range set to 0x00 to 0xff, so we can't change it without risk of 
breaking userspace. I don't know whether there's any userspace using the 
property, and whether that userspace has any hardcoded assumption.

> Sorry that I'm flip-flopping around on this, but we just have an ongoing
> discussion about a range/size mixup in the CTM uapi, I think assuming that
> all userspace will correctly scale is not realistic. So larger scale in
> the uapi (but maybe not internally) from the start seems like a good idea.

Can we make the range randomly chosen at every boot then ? :-) That would 
force userspace to be generic.

-- 
Regards,

Laurent Pinchart
