From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Mar 2017 11:21:35 +0100
Subject: [PATCH 3/3] drm/arm: hdlcd: check for rotation
In-Reply-To: <20170331101123.GK30290@intel.com>
References: <20170331094937.GO7909@n2100.armlinux.org.uk>
 <E1cttDk-00067G-1b@rmk-PC.armlinux.org.uk>
 <20170331101123.GK30290@intel.com>
Message-ID: <20170331102135.GE13355@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 01:11:23PM +0300, Ville Syrj?l? wrote:
> On Fri, Mar 31, 2017 at 10:51:52AM +0100, Russell King wrote:
> > hdlcd does not support rotation - check for it and reject plane updates
> > that try to rotate a plane.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/gpu/drm/arm/hdlcd_crtc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > index cf70184fd028..171acc842368 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > @@ -215,6 +215,10 @@ static int hdlcd_plane_atomic_check(struct drm_plane *plane,
> >  	if (!crtc)
> >  		return 0;
> >  
> > +	/* We do not support rotation */
> > +	if (state->rotation != DRM_ROTATE_0)
> > +		return -EINVAL;
> 
> This can't happen unless you attach a rotation property with a bogus
> set of supported rotations to the plane.

Which we don't. I did toy with the idea of adding it as one can hack support for 0? and 180?
rotation by playing with the line pitch, I've even created a patch but in the end I've
decided not to publish it. If there is anyone interested at some moment on this, I can dig it out.

Best regards,
Liviu

> 
> > +
> >  	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
> >  	if (!crtc_state->enable)
> >  		return -EINVAL;
> > -- 
> > 2.7.4
> 
> -- 
> Ville Syrj?l?
> Intel OTC

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
