From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Apr 2014 09:14:41 +0200
Subject: [PATCH 3/4] drm: Introduce drm_fb_helper_prepare()
In-Reply-To: <20140422155406.GU10722@phenom.ffwll.local>
References: <1398177741-28482-1-git-send-email-thierry.reding@gmail.com>
 <1398177741-28482-3-git-send-email-thierry.reding@gmail.com>
 <20140422155406.GU10722@phenom.ffwll.local>
Message-ID: <20140423071439.GA31226@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 05:54:06PM +0200, Daniel Vetter wrote:
> On Tue, Apr 22, 2014 at 04:42:20PM +0200, Thierry Reding wrote:
[...]
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
[...]
> > @@ -502,6 +503,33 @@ static void drm_fb_helper_crtc_free(struct drm_fb_helper *helper)
> >  }
> >  
> >  /**
> > + * drm_fb_helper_prepare - setup a drm_fb_helper structure
> > + * @dev: DRM device
> > + * @helper: driver-allocated fbdev helper structure to set up
> > + * @funcs: pointer to structure of functions associate with this helper
> > + *
> > + * Sets up the bare minimum to make the framebuffer helper usable. This is
> > + * useful to implement race-free initialization of the polling helpers. In
> > + * that case a typical sequence would be:
> > + *
> > + *   - call drm_fb_helper_prepare()
> > + *   - set dev->mode_config.funcs
> 
> This step is done in drm_fb_helper_prepare already.

drm_fb_helper_prepare() sets fb_helper->funcs. dev->mode_config.funcs
needs to be set because it gets called by drm_kms_helper_hotplug_event()
which in turn is called by output_poll_execute(), which can be called at
any point after drm_kms_helper_poll_init(). It could be scheduled
immediately by drm_kms_helper_poll_enable().

I wonder if perhaps we should be wrapping that into a function as well.
Currently this is only documented in code by the drivers that call this.
But since it's only a single step it doesn't seem worth it. Perhaps if
we rolled the min/max_width/height into that function as well it would
be more worth it? That could be difficult to do since a couple of
drivers need to set those depending on the chipset generation.

> > + *   - perform driver-specific setup
> > + *   - call drm_kms_helper_poll_init()
> 
> Maybe mention that after this you can start to handle hpd events using the
> probe helpers?

Isn't that somewhat implied already? The poll helpers call directly the
dev->mode_config.funcs->output_poll_changed() function, which has
already been set up earlier.

> > + *   - call drm_fb_helper_init()
> > + *   - call drm_fb_helper_single_add_all_connectors()
> > + *   - call drm_fb_helper_initial_config()
> 
> Does this list look sane in the generated DocBook? Afaik kerneldoc
> unfortunately lacks any form of markup, at least afaik :(

I must admit I didn't check. I'll make sure I do that before sending out
the next version.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/dc7ba188/attachment.sig>
