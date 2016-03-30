From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 14:43:28 +0200
Subject: [PATCH v2 1/9] drm: atmel-hlcdc: add a ->cleanup_fb() operation
In-Reply-To: <20160318175848.GK14170@phenom.ffwll.local>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
 <1458136663-21396-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160316151738.GQ14170@phenom.ffwll.local>
 <20160317094942.48079e49@bbrezillon>
 <20160318175848.GK14170@phenom.ffwll.local>
Message-ID: <20160330144328.6fe3375e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 18 Mar 2016 18:58:48 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Thu, Mar 17, 2016 at 09:49:42AM +0100, Boris Brezillon wrote:
> > Hi Daniel,
> > 
> > On Wed, 16 Mar 2016 16:17:38 +0100
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> > 
> > > On Wed, Mar 16, 2016 at 02:57:35PM +0100, Boris Brezillon wrote:
> > > > Add a ->cleanup_fb() operation to avoid memory leaks when the atomic
> > > > operation is interrupted after the ->prepare_fb() call.
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Fixes 2389fc1 ("drm: atmel-hlcdc: Atomic mode-setting conversion")
> > > > Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > ---
> > > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  2 ++
> > > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 22 +++++++++++++++++++---
> > > >  2 files changed, 21 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> > > > index fed517f..ec64140 100644
> > > > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> > > > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> > > > @@ -81,11 +81,13 @@ struct atmel_hlcdc_plane_properties {
> > > >   * @layer: HLCDC layer structure
> > > >   * @properties: pointer to the property definitions structure
> > > >   * @rotation: current rotation status
> > > > + * @prepared: flagging the plane has prepared for an atomic update
> > > >   */
> > > >  struct atmel_hlcdc_plane {
> > > >  	struct drm_plane base;
> > > >  	struct atmel_hlcdc_layer layer;
> > > >  	struct atmel_hlcdc_plane_properties *properties;
> > > > +	bool prepared;
> > > >  };
> > > >  
> > > >  static inline struct atmel_hlcdc_plane *
> > > > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > > > index 1ffe9c3..35027d0 100644
> > > > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > > > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > > > @@ -715,11 +715,25 @@ static int atmel_hlcdc_plane_prepare_fb(struct drm_plane *p,
> > > >  					const struct drm_plane_state *new_state)
> > > >  {
> > > >  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> > > > +	int ret;
> > > >  
> > > > -	if (!new_state->fb)
> > > > -		return 0;
> > > > +	ret = atmel_hlcdc_layer_update_start(&plane->layer);
> > > > +	if (!ret)
> > > > +		plane->prepared = true;
> > > 
> > > Atomic helpers will keep track of this for you, and only call ->cleanup_fb
> > > on a plane combo where it did (successfully) call ->prepare_fb.
> > 
> > Hm, it's not exactly encoding the same thing. What I want to do here is
> > call atmel_hlcdc_layer_update_rollback() only if the atomic update has
> > failed (see below, I set ->prepared back to false in the
> > ->atomic_update() method). AFAICT, ->cleanup_fb() is also called
> > when the whole operation succeed (and in this case I don't want to
> > call atmel_hlcdc_layer_update_rollback()).
> > 
> > Let me know if you see a better approach to do that.
> 
> Ah makes sense. And yeah I guess this is the only approach really. Note
> that you should put plane_prepared into plane_state though, in case we
> start to pipeline updates.

Still having a problem when putting the ->prepared field into my
atmel_hlcdc_plane_state struct: ->prepare_fb() and ->cleanup_fb() are
passing a pointer to a *const* struct drm_plane_state, and I'd like to
avoid a const to non-const cast here.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
