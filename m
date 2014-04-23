From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 23 Apr 2014 09:35:48 +0200
Subject: [PATCH 3/4] drm: Introduce drm_fb_helper_prepare()
In-Reply-To: <20140423071439.GA31226@ulmo>
References: <1398177741-28482-1-git-send-email-thierry.reding@gmail.com>
 <1398177741-28482-3-git-send-email-thierry.reding@gmail.com>
 <20140422155406.GU10722@phenom.ffwll.local>
 <20140423071439.GA31226@ulmo>
Message-ID: <20140423073548.GW10722@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 09:14:41AM +0200, Thierry Reding wrote:
> On Tue, Apr 22, 2014 at 05:54:06PM +0200, Daniel Vetter wrote:
> > On Tue, Apr 22, 2014 at 04:42:20PM +0200, Thierry Reding wrote:
> [...]
> > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> [...]
> > > @@ -502,6 +503,33 @@ static void drm_fb_helper_crtc_free(struct drm_fb_helper *helper)
> > >  }
> > >  
> > >  /**
> > > + * drm_fb_helper_prepare - setup a drm_fb_helper structure
> > > + * @dev: DRM device
> > > + * @helper: driver-allocated fbdev helper structure to set up
> > > + * @funcs: pointer to structure of functions associate with this helper
> > > + *
> > > + * Sets up the bare minimum to make the framebuffer helper usable. This is
> > > + * useful to implement race-free initialization of the polling helpers. In
> > > + * that case a typical sequence would be:
> > > + *
> > > + *   - call drm_fb_helper_prepare()
> > > + *   - set dev->mode_config.funcs
> > 
> > This step is done in drm_fb_helper_prepare already.
> 
> drm_fb_helper_prepare() sets fb_helper->funcs. dev->mode_config.funcs
> needs to be set because it gets called by drm_kms_helper_hotplug_event()
> which in turn is called by output_poll_execute(), which can be called at
> any point after drm_kms_helper_poll_init(). It could be scheduled
> immediately by drm_kms_helper_poll_enable().
> 
> I wonder if perhaps we should be wrapping that into a function as well.
> Currently this is only documented in code by the drivers that call this.
> But since it's only a single step it doesn't seem worth it. Perhaps if
> we rolled the min/max_width/height into that function as well it would
> be more worth it? That could be difficult to do since a couple of
> drivers need to set those depending on the chipset generation.

Oh I've misread this step for the fb_helper->funcs assignment. Makes sense
and I don't think we need to augment your kerneldoc more to explain this.

> > > + *   - perform driver-specific setup

Hm, maybe clarify this as "initialize modeset objects like crtcs, encoders
and connectors"? Since that's the important part we need to get done here.

> > > + *   - call drm_kms_helper_poll_init()
> > 
> > Maybe mention that after this you can start to handle hpd events using the
> > probe helpers?
> 
> Isn't that somewhat implied already? The poll helpers call directly the
> dev->mode_config.funcs->output_poll_changed() function, which has
> already been set up earlier.

I've more meant that after this it's save for drivers to enable hpd
interrupts and start to process them. I.e.

	- enable interrupts and start processing hpd events

as an additional step to make it really cleear how it all fits together.
Otherwise driver authors are left wondering wtf this isn't just one
function call to do it all for them ;-)

> > > + *   - call drm_fb_helper_init()
> > > + *   - call drm_fb_helper_single_add_all_connectors()
> > > + *   - call drm_fb_helper_initial_config()
> > 
> > Does this list look sane in the generated DocBook? Afaik kerneldoc
> > unfortunately lacks any form of markup, at least afaik :(
> 
> I must admit I didn't check. I'll make sure I do that before sending out
> the next version.

If it looks ugly I'm ok as-is, just wondered. Kerneldoc is a bit
simplistic ime.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
