From: Alexandru-Cosmin.Gheorghe@arm.com (Alexandru-Cosmin Gheorghe)
Date: Mon, 6 Aug 2018 09:53:22 +0100
Subject: [PATCH v3 06/10] drm/imx: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <1533536953.4204.3.camel@pengutronix.de>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
 <20180804161530.12275-7-alexandru-cosmin.gheorghe@arm.com>
 <1533536953.4204.3.camel@pengutronix.de>
Message-ID: <20180806085322.GA16672@e114479-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 08:29:13AM +0200, Philipp Zabel wrote:

Hi,

> Hi Alexandru,
> 
> On Sat, 2018-08-04 at 17:15 +0100, Alexandru Gheorghe wrote:
> > A new helper function(__drm_atomic_helper_plane_reset) has been added
> > for linking a plane with its state and resetting the core
> > properties(alpha, rotation, etc.) to their default values.
> > Use that instead of duplicating the logic.
> > 
> > Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> > ---
> >  drivers/gpu/drm/imx/ipuv3-plane.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
> > index 203f247d4854..1bd4de03ce9e 100644
> > --- a/drivers/gpu/drm/imx/ipuv3-plane.c
> > +++ b/drivers/gpu/drm/imx/ipuv3-plane.c
> > @@ -281,16 +281,14 @@ static void ipu_plane_state_reset(struct drm_plane *plane)
> >  		ipu_state = to_ipu_plane_state(plane->state);
> >  		__drm_atomic_helper_plane_destroy_state(plane->state);
> >  		kfree(ipu_state);
> > +		plane->state = NULL;
> >  	}
> >  
> >  	ipu_state = kzalloc(sizeof(*ipu_state), GFP_KERNEL);
> >  
> > -	if (ipu_state) {
> > -		ipu_state->base.plane = plane;
> > -		ipu_state->base.rotation = DRM_MODE_ROTATE_0;
> > -	}
> > +	if (ipu_state)
> > +		__drm_atomic_helper_plane_reset(plane, &ipu_state->base);
> >  
> 
> Could you remove this white line as well?

Yes, will do before applying.


> 
> > -	plane->state = &ipu_state->base;
> >  }
> >  
> >  static struct drm_plane_state *
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> to be merged through drm-misc together with the other changes.
> 
> regards
> Philipp

-- 
Cheers,
Alex G
