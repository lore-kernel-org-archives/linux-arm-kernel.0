From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 3 Jun 2016 09:37:43 +0200
Subject: [PATCH 01/20] drm/atomic: Fix remaining places where
 !funcs->best_encoder is valid
In-Reply-To: <CAKMK7uHyqNbA8Scw2fE0geAyNt0a0XVtzf81nwWjEhbZ-gAvKw@mail.gmail.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464877907-27723-2-git-send-email-boris.brezillon@free-electrons.com>
 <8671722.LHaiaBNqfE@avalon>
 <CAKMK7uHyqNbA8Scw2fE0geAyNt0a0XVtzf81nwWjEhbZ-gAvKw@mail.gmail.com>
Message-ID: <20160603093743.000ef95b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2016 23:57:02 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Thu, Jun 2, 2016 at 11:05 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Boris,
> >
> > Thank you for the patch.
> >
> > On Thursday 02 Jun 2016 16:31:28 Boris Brezillon wrote:  
> >> Adapt drm_pick_crtcs() and update_connector_routing() to fallback to
> >> drm_atomic_helper_best_encoder() if funcs->best_encoder() is NULL so
> >> that DRM drivers can leave this hook unassigned if they know they want
> >> to use drm_atomic_helper_best_encoder().  
> >
> > Could you please update include/drm/drm_modeset_helper_vtables.h to document
> > this new behaviour ?  
> 
> Thanks for reminding me. Please update hooks for both
> atomic_best_encoder and best_encoder. Also mention that it's only
> optional for atomic drivers. There's lots of examples in that file for
> the wording usually used.

Hm, I haven't changed anything for the ->atomic_best_encoder() hook, or
am I missing something?

> 
> > The only drawback I see in this patch is the additional object lookup
> > performed by drm_atomic_helper_best_encoder() at runtime. I wonder if we could
> > somehow cache the information, as the assignment can't change when there's a
> > 1:1 correspondence between encoders and connectors.  
> 
> drm_encoder_find is an idr lookup. That should be plenty fast,
> especially for modeset code. Usually what's too expensive even for
> modeset code is linear list walks. But Chris just submitted patches to
> convert most of them into simple lookups.
> -Daniel
> 
> >>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
> >> ---
> >>  drivers/gpu/drm/drm_atomic_helper.c |  4 +++-
> >>  drivers/gpu/drm/drm_fb_helper.c     | 13 ++++++++++++-
> >>  2 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> >> b/drivers/gpu/drm/drm_atomic_helper.c index f6a3350..849d029 100644
> >> --- a/drivers/gpu/drm/drm_atomic_helper.c
> >> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> >> @@ -300,8 +300,10 @@ update_connector_routing(struct drm_atomic_state
> >> *state, if (funcs->atomic_best_encoder)
> >>               new_encoder = funcs->atomic_best_encoder(connector,
> >>                                                        connector_state);
> >> -     else
> >> +     else if (funcs->best_encoder)
> >>               new_encoder = funcs->best_encoder(connector);
> >> +     else
> >> +             new_encoder = drm_atomic_helper_best_encoder(connector);
> >>
> >>       if (!new_encoder) {
> >>               DRM_DEBUG_ATOMIC("No suitable encoder found for [CONNECTOR:%d:%s]\n",
> >> diff --git a/drivers/gpu/drm/drm_fb_helper.c
> >> b/drivers/gpu/drm/drm_fb_helper.c index 7c2eb75..d44389a 100644
> >> --- a/drivers/gpu/drm/drm_fb_helper.c
> >> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >> @@ -2000,7 +2000,18 @@ static int drm_pick_crtcs(struct drm_fb_helper
> >> *fb_helper, my_score++;
> >>
> >>       connector_funcs = connector->helper_private;
> >> -     encoder = connector_funcs->best_encoder(connector);
> >> +
> >> +     /*
> >> +      * If the DRM device implements atomic hooks and ->best_encoder() is
> >> +      * NULL we fallback to the default drm_atomic_helper_best_encoder()
> >> +      * helper.
> >> +      */
> >> +     if (fb_helper->dev->mode_config.funcs->atomic_commit &&
> >> +         !connector_funcs->best_encoder)
> >> +             encoder = drm_atomic_helper_best_encoder(connector);
> >> +     else
> >> +             encoder = connector_funcs->best_encoder(connector);
> >> +
> >>       if (!encoder)
> >>               goto out;  
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> >  
> 
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
