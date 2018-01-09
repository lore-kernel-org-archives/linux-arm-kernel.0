From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Jan 2018 14:59:13 +0100
Subject: [PATCH 06/19] drm/blend: Add a generic alpha property
In-Reply-To: <2691997.qmgyvrLtFu@avalon>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <5c765fc730d75cb362dc37bcdb3b3aeacc7bdb30.1515494838.git-series.maxime.ripard@free-electrons.com>
 <2691997.qmgyvrLtFu@avalon>
Message-ID: <20180109135913.wgyfvdfdffigxcll@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jan 09, 2018 at 02:34:47PM +0200, Laurent Pinchart wrote:
> > Some drivers duplicate the logic to create a property to store a per-plane
> > alpha.
> > 
> > Let's create a helper in order to move that to the core.
> > 
> > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/gpu/kms-properties.csv |  2 +-
> >  drivers/gpu/drm/drm_atomic.c         |  4 ++++-
> >  drivers/gpu/drm/drm_atomic_helper.c  |  1 +-
> >  drivers/gpu/drm/drm_blend.c          | 32 +++++++++++++++++++++++++++++-
> >  include/drm/drm_blend.h              |  1 +-
> >  include/drm/drm_plane.h              |  6 +++++-
> >  6 files changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/gpu/kms-properties.csv
> > b/Documentation/gpu/kms-properties.csv index 927b65e14219..a3c3969c1992
> > 100644
> > --- a/Documentation/gpu/kms-properties.csv
> > +++ b/Documentation/gpu/kms-properties.csv
> > @@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
> > ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
> >  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
> >  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> > -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
> > +,,"""alpha""",RANGE,"Min=0, Max=255",Plane,Opacity of the plane from
> > transparent (0) to opaque (255) ,,"""colorkey""",RANGE,"Min=0,
> > Max=0x01ffffff",Plane,TBD
> 
> I think more documentation is needed. You should explain how the property 
> operates and which formats it is applicable to. For instance you need to 
> clarify what happens for format that contain an alpha component.

That's a very good point, and I'm not quite sure what should happen in
the first place :)

Should we forbid that configuration?

> >  /**
> > + * drm_plane_create_alpha_property - create a new alpha property
> > + * @plane: drm plane
> > + * @alpha: initial value of alpha, from 0 (transparent) to 255 (opaque)
> 
> Do you have a use case for initializing the alpha value to something else than 
> fully opaque ?

I don't, but thought it might be useful. Maybe it isn't, in which case
I'm totally fine with it getting away.

> > + * This function initializes a generic, mutable, alpha property and
> > + * enables support for it in the DRM core.
> > + *
> > + * Drivers can then attach this property to their plane to enable
> > + * support for configurable plane alpha.
> 
> The function attaches the property to the plane, is the
> documentation outdated ?

Yes, I'll fix it.

> > + * Returns:
> > + * 0 on success, negative error code on failure.
> > + */
> > +int drm_plane_create_alpha_property(struct drm_plane *plane, u8 alpha)
> > +{
> > +	struct drm_property *prop;
> > +
> > +	prop = drm_property_create_range(plane->dev, 0, "alpha", 0, 255);
> 
> Do you think the 0-255 range will fit all use cases ?

This is kind of the same discussion we're having with Daniel, but are
there hardware or formats with an alpha component wider than 255?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/813be6e9/attachment.sig>
