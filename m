From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 19 Feb 2018 10:40:45 +0100
Subject: [PATCH 1/3] drm: simple_kms_helper: Add mode_valid() callback
 support
In-Reply-To: <87bmgwdb71.fsf@anholt.net>
References: <20180206121854.4407-1-linus.walleij@linaro.org>
 <20180206121854.4407-2-linus.walleij@linaro.org>
 <87bmgwdb71.fsf@anholt.net>
Message-ID: <20180219094045.GJ22199@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 05:08:34PM +0000, Eric Anholt wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
> 
> > The PL111 needs to filter valid modes based on memory bandwidth.
> > I guess it is a pretty simple operation, so we can still claim
> > the DRM KMS helper pipeline is simple after adding this (optional)
> > vtable callback.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/gpu/drm/drm_simple_kms_helper.c | 15 +++++++++++++++
> >  include/drm/drm_simple_kms_helper.h     | 15 +++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> > index dc9fd109de14..b7840cf34808 100644
> > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > @@ -34,6 +34,20 @@ static const struct drm_encoder_funcs drm_simple_kms_encoder_funcs = {
> >  	.destroy = drm_encoder_cleanup,
> >  };
> >  
> > +static enum drm_mode_status
> > +drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
> > +			       const struct drm_display_mode *mode)
> > +{
> > +	struct drm_simple_display_pipe *pipe;
> > +
> > +	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
> > +	if (!pipe->funcs || !pipe->funcs->mode_valid)
> > +		/* Anything goes */
> > +		return MODE_OK;
> > +
> > +	return pipe->funcs->mode_valid(crtc, mode);
> > +}
> > +
> >  static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
> >  				     struct drm_crtc_state *state)
> >  {
> > @@ -72,6 +86,7 @@ static void drm_simple_kms_crtc_disable(struct drm_crtc *crtc,
> >  }
> >  
> >  static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
> > +	.mode_valid = drm_simple_kms_crtc_mode_valid,
> >  	.atomic_check = drm_simple_kms_crtc_check,
> >  	.atomic_enable = drm_simple_kms_crtc_enable,
> >  	.atomic_disable = drm_simple_kms_crtc_disable,
> > diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
> > index 6d9adbb46293..ad74cb33c539 100644
> > --- a/include/drm/drm_simple_kms_helper.h
> > +++ b/include/drm/drm_simple_kms_helper.h
> > @@ -21,6 +21,21 @@ struct drm_simple_display_pipe;
> >   *                                        display pipeline
> >   */
> >  struct drm_simple_display_pipe_funcs {
> > +	/**
> > +	 * @mode_valid:
> > +	 *
> > +	 * This function is called to filter out valid modes from the
> > +	 * suggestions suggested by the bridge or display. This optional
> > +	 * hook is passed in when initializing the pipeline.
> > +	 *
> > +	 * RETURNS:
> > +	 *
> > +	 * MODE_OK if the mode is acceptable.
> > +	 * MODE_BAD if we need to try something else.
> > +	 */
> 
> I don't see why MODE_BAD would be the only valid error return from this
> hook.  Can we just use the same RETURNS docs as other mode_valid methods?
> 
> Other than that,
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Same comment (although note that except for dmesg noise we currently throw
them away), and I agree that mode_valid makes sense for simple drivers,
especially with all the refactoring we've done to call mode_valid both in
the connector probe and atomic_check paths. On the respun patch (I'm
behind on mails ...):

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> > +	enum drm_mode_status (*mode_valid)(struct drm_crtc *crtc,
> > +					   const struct drm_display_mode *mode);
> > +
> >  	/**
> >  	 * @enable:
> >  	 *
> > -- 
> > 2.14.3



> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
