From: Alexandru-Cosmin.Gheorghe@arm.com (Alexandru-Cosmin Gheorghe)
Date: Tue, 24 Jul 2018 09:14:02 +0100
Subject: [PATCH 01/10] drm/atomic: Add  __drm_atomic_helper_plane_reset
In-Reply-To: <1532418533.4078.2.camel@pengutronix.de>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
 <20180720211509.23605-2-alexandru-cosmin.gheorghe@arm.com>
 <1532418533.4078.2.camel@pengutronix.de>
Message-ID: <20180724081402.GB22689@e114479-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 09:48:53AM +0200, Philipp Zabel wrote:
> Hi Alexandru,
> 
> On Fri, 2018-07-20 at 22:15 +0100, Alexandru Gheorghe wrote:
> > There are a lot of drivers that subclass drm_plane_state, all of them
> > duplicate the code that links toghether the plane with plane_state.
> > 
> > On top of that, drivers that enable core properties also have to
> > duplicate the code for initializing the properties to their default
> > values, which in all cases are the same as the defaults from core.
> > 
> > Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 32 +++++++++++++++++++++--------
> >  include/drm/drm_atomic_helper.h     |  2 ++
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 8008a7de2e10..e1c6f101652e 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3507,6 +3507,28 @@ void drm_atomic_helper_crtc_destroy_state(struct drm_crtc *crtc,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_crtc_destroy_state);
> >  
> > +/**
> > + * __drm_atomic_helper_plane_reset - resets planes state to default values
> > + * @plane: plane object
> > + * @new_state: atomic plane state
> > + *
> > + * Initializes plane state to default. This is useful for drivers that subclass
> > + * the plane state.
> > + */
> > +void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
> > +				     struct drm_plane_state *state)
> > +{
> > +	if (state) {
> > +		state->plane = plane;
> > +		state->rotation = DRM_MODE_ROTATE_0;
> > +		/* Reset the alpha value to fully opaque if it matters */
> > +		if (plane->alpha_property)
> > +			state->alpha = plane->alpha_property->values[1];
> > +	}
> 
> Is this function supposed to be callable with state == NULL ?
> 
> > +	plane->state = state;
> 
> If so, the comment could mention that this sets plane->state to NULL if
> state == NULL, and a few of the call sites could be simplified.
> 
> If not, I would remove the conditional if (state) {} part and also
> mention this in the comment.

Yes, It's intended to be callable with null. I will update the
comment.

> 
> regards
> Philipp

-- 
Cheers,
Alex G
