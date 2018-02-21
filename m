From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 Feb 2018 22:39:02 +0200
Subject: [PATCH v3 1/8] drm/blend: Add a generic alpha property
In-Reply-To: <CAKMK7uH+jiKt9pV+9OoXWCUr=yBGiNVh-iv600P-LVvBYcz_rw@mail.gmail.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <1841868.3gpkeNesVL@avalon>
 <CAKMK7uH+jiKt9pV+9OoXWCUr=yBGiNVh-iv600P-LVvBYcz_rw@mail.gmail.com>
Message-ID: <2609360.oaDrMcTLzt@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday, 19 February 2018 23:58:40 EET Daniel Vetter wrote:
> On Mon, Feb 19, 2018 at 9:19 PM, Laurent Pinchart wrote:
> > On Friday, 16 February 2018 20:20:41 EET Ville Syrj?l? wrote:
> >> On Fri, Feb 16, 2018 at 06:39:29PM +0100, Maxime Ripard wrote:
> >> Some drivers duplicate the logic to create a property to store a
> >>> per-plane alpha.
> >>> 
> >>> This is especially useful if we ever want to support extra protocols
> >>> for Wayland like:
> >>> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741
> >>> .html
> >>> 
> >>> Let's create a helper in order to move that to the core.
> >>> 
> >>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >>> ---
> >>> 
> >>>  Documentation/gpu/kms-properties.csv |  2 +-
> >>>  drivers/gpu/drm/drm_atomic.c         |  4 ++++-
> >>>  drivers/gpu/drm/drm_atomic_helper.c  |  4 ++++-
> >>>  drivers/gpu/drm/drm_blend.c          | 32 ++++++++++++++++++++++++++++-
> >>>  include/drm/drm_blend.h              |  1 +-
> >>>  include/drm/drm_plane.h              |  6 +++++-
> >>>  6 files changed, 48 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/Documentation/gpu/kms-properties.csv
> >>> b/Documentation/gpu/kms-properties.csv index 927b65e14219..25ad3503d663
> >>> 100644
> >>> --- a/Documentation/gpu/kms-properties.csv
> >>> +++ b/Documentation/gpu/kms-properties.csv
> >>> @@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0,
> >>> Max=1",Connector,TBD>
> >>> 
> >>>  ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
> >>>  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
> >>>  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> >>> 
> >>> -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
> >>> +,,"""alpha""",RANGE,"Min=0, Max=Driver dependant",Plane,Opacity of the
> >>> plane from transparent (0) to fully opaque (MAX). If this property is
> >>> set to a value different than max, and that the pixel will define an
> >>> alpha component, the property will have precendance and the pixel value
> >>> will be ignored.
> 
> Please don't document new properties in that csv file, it's an
> unreadable mess. Instead follow how we document standardized
> properties nowadays in full-blown sections. For plane blending we
> have:
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-prop
> erties
> 
> >> Those semantics don't seem particularly good to me. I think we would want
> >> the per-pixel alpha and global alpha both to be effecive at the same
> >> time. You can always decide to ignore the per-pixel alpha by using a
> >> pixel format without alpha.
> > 
> > That makes sense to me. However, it also brings a new question: how should
> > a driver that supports either global alpha or pixel alpha but not both
> > signal that to userspace, and how should it reacts when userspace selects
> > a format with an alpha channel and set a global alpha value other than
> > fully opaque ? To make things more complex, note that some drivers
> > support combining global alpha and pixel alpha only for a subset of the
> > formats with an alpha channel (for instance for ARGB 1555 formats, but
> > not for ARGB 8888 formats).
> 
> atomic_check can reject unsupported configs. Userspace needs to fall
> back somehow (either switch to xrgb or make alpha fully opaque or just
> give up on that plane). We have a lot of such corner-cases we don't
> tell userspace about explicitly at all.

I'm OK with failing the commit in case in invalid configuration is requested. 
However, using a check-only commit to find out whether combining global alpha 
and pixel alpha is supported doesn't seem a good idea to me. First of all 
userspace would need to try that for all formats, making it cumbersome. Then, 
an atomic commit is a black box, we don't report the failure cause to 
userspace. It makes it hard to use it to test support for a feature as it 
could fail for an unrelated reason. Finally, we'd open the door to various 
kind of heuristics implemented differently in different userspace stacks, and 
that would increase the risk of breaking userspace. I'd rather have an 
explicitly documented way to perform such checks.

> >> Also, where's the userspace that wants this feature?
> >> 
> >> <snip>
> >> 
> >>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> >>> index 8185e3468a23..5a6f29524f12 100644
> >>> --- a/include/drm/drm_plane.h
> >>> +++ b/include/drm/drm_plane.h
> >>> @@ -42,6 +42,7 @@ struct drm_modeset_acquire_ctx;
> >>>   * plane (in 16.16)
> >>>   * @src_w: width of visible portion of plane (in 16.16)
> >>>   * @src_h: height of visible portion of plane (in 16.16)
> >>> + * @alpha: opacity of the plane
> >>>   * @rotation: rotation of the plane
> >>>   * @zpos: priority of the given plane on crtc (optional)
> >>>   * Note that multiple active planes on the same crtc can have an
> >>>   identical
> >>> @@ -105,6 +106,9 @@ struct drm_plane_state {
> >>>     uint32_t src_x, src_y;
> >>>     uint32_t src_h, src_w;
> >>> 
> >>> +   /* Plane opacity */
> >>> +   u8 alpha;
> >> 
> >> We may want to make that u16. The general we expect 16bpc for most color
> >> related things, but since this is a range prop I suppose we should just
> >> expose the actual hardware range. But making it u16 might avoid some head
> >> scratching for the first person to have hardware with higher precision.
> >> Either that or we should make the prop creation fail if the driver asks
> >> for more bits than we have in the state.
> > 
> > I'm tempted to go one step further and always make the alpha property
> > 16-bits wide for new users (we can't do so for existing users as it could
> > break userspace), and let drivers convert that internally to the range
> > they need. There could however be drawbacks I don't foresee.
> 
> I think scaling the range to match the hw is the most sensible (yes
> I'm flip-flopping around here).

So you mean keeping the proposed implementation, with a driver-specific 
maximum value ?

> And once someone needs more than u8, we can extend the internal
> representation easily. The external representation in the property is an
> u64, that /should/ be enough for the next few years :-)

The external representation is split in two parts. The value is stored in a 
64-bits field, and that is safe. The second part of the representation is the 
minimum (hardcoded to 0) and maximum (currently variable) values reported by 
the property. What we need to decide now is whether to hardcode the maximum 
value to 0xffff for all new users of the alpha property, or to always expose 
the hardware range.

> >> Oh, and you should plug this into the state dumper as well.
> >> 
> >>> +
> >>> 
> >>>     /* Plane rotation */
> >>>     unsigned int rotation;
> >>> @@ -481,6 +485,7 @@ enum drm_plane_type {
> >>>   * @funcs: helper functions
> >>>   * @properties: property tracking for this plane
> >>>   * @type: type of plane (overlay, primary, cursor)
> >>> + * @alpha_property: alpha property for this plane
> >>>   * @zpos_property: zpos property for this plane
> >>>   * @rotation_property: rotation property for this plane
> >>>   * @helper_private: mid-layer private data
> >>> @@ -556,6 +561,7 @@ struct drm_plane {
> >>>      */
> >>>     
> >>>     struct drm_plane_state *state;
> >>> +   struct drm_property *alpha_property;
> >>>     struct drm_property *zpos_property;
> >>>     struct drm_property *rotation_property;
> >>>  };

-- 
Regards,

Laurent Pinchart
