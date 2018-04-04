From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 04 Apr 2018 11:15:04 +0200
Subject: [PATCH v4 1/5] drm/blend: Add a generic alpha property
In-Reply-To: <87vadd5mgf.fsf@anholt.net>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
 <402e596049beb3429faf5981682d902c70325274.1520974361.git-series.maxime.ripard@bootlin.com>
 <87vadd5mgf.fsf@anholt.net>
Message-ID: <e0c1e8af3c8e9a8283d78d4cdeb2fe92147c5945.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2018-03-30 at 13:37 -0700, Eric Anholt wrote:
> Maxime Ripard <maxime.ripard@bootlin.com> writes:
> 
> > Some drivers duplicate the logic to create a property to store a
> > per-plane
> > alpha.
> > 
> > This is especially useful if we ever want to support extra protocols
> > for
> > Wayland like:
> > https://lists.freedesktop.org/archives/wayland-devel/2017-August/034
> > 741.html
> > 
> > Let's create a helper in order to move that to the core.
> > diff --git a/drivers/gpu/drm/drm_blend.c
> > b/drivers/gpu/drm/drm_blend.c
> > index 5a81e1b4c076..05eda2d57c77 100644
> > --- a/drivers/gpu/drm/drm_blend.c
> > +++ b/drivers/gpu/drm/drm_blend.c
> > @@ -88,6 +88,12 @@
> >   * On top of this basic transformation additional properties can be
> > exposed by
> >   * the driver:
> >   *
> > + * alpha:
> > + * 	Alpha is setup with drm_plane_create_alpha_property().
> > It controls the
> 
> s/setup/set up/
> 
> > + * 	plane-wide opacity, from transparent (0) to opaque
> > (0xffff). It can be
> > + * 	combined with pixel alpha.
> > + * 	The alpha value is represented as premultiplied alpha.
> 
> I don't think this premultiplied comment makes any sense.  What are
> you saying it's premultiplied with?  Maybe you mean that the output
> pixels will have both their color and alpha channels multiplied by
> this alpha?
> I'd just drop it.

I disagree here: since there are multiple ways to blend the pixel alpha
value and the plane-wide alpha value, I think it's important to clearly
specify which blending equation DRM expects here. Otherwise, the plane-
wide alpha value just doesn't have a specified meaning and driver
implementations can't figure whether the hardware uses the same equation
or not and whether adaptation to this coefficient is needed.

The equations for premultiplied alpha blending are at:
https://en.wikipedia.org/wiki/Alpha_compositing#Alpha_blending

What do you think?

> Reviewed-by: Eric Anholt <eric@anholt.net>
> 
> We should probably do this property for vc4 at some point, too.

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/f1f7aa6e/attachment-0001.sig>
