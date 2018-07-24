From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 14:54:21 +0200
Subject: [PATCH 09/10] drm/vc4: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180724081121.GA22689@e114479-lin.cambridge.arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
 <20180720211509.23605-10-alexandru-cosmin.gheorghe@arm.com>
 <20180724065720.5bhepamdo57it7nl@flea>
 <20180724081121.GA22689@e114479-lin.cambridge.arm.com>
Message-ID: <20180724125421.zde2qtbeie5zkvpw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 09:11:21AM +0100, Alexandru-Cosmin Gheorghe wrote:
> Hi Maxime,
> 
> On Tue, Jul 24, 2018 at 08:57:20AM +0200, Maxime Ripard wrote:
> > On Fri, Jul 20, 2018 at 10:15:08PM +0100, Alexandru Gheorghe wrote:
> > > Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_plane.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> > > index 9d7a36f148cf..688ad9bb0f08 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_plane.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> > > @@ -200,9 +200,7 @@ static void vc4_plane_reset(struct drm_plane *plane)
> > >  	if (!vc4_state)
> > >  		return;
> > >  
> > > -	plane->state = &vc4_state->base;
> > > -	plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
> > > -	vc4_state->base.plane = plane;
> > > +	__drm_atomic_helper_plane_reset(plane, &vc4_state->base);
> > 
> > For vc4, rcar-du, atmel-hlcdc and sun4i, you're changing the reset
> > value of alpha from DRM_BLEND_ALPHA_OPAQUE to
> > plane->alpha_property->values[1].
> 
> plane->alpha_property->values[1] holds the max value for alpha, and
> it's initialized by the core to DRM_BLEND_ALPHA_OPAQUE.
> 
> > 
> > This might or might not be a good idea, but you should definitely
> > explain why.
> 
> Would a commit message suffice? Or do you have other ideas?

Yes, that would be enough.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/2848509e/attachment-0001.sig>
