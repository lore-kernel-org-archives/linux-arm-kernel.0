From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 13 Jan 2016 17:21:56 +0100
Subject: [RFC/PATCH] drm/rockchip: don't wait for vblank if fb hasn't
 changed
In-Reply-To: <20160113155529.6048b2c1.john@metanate.com>
References: <1452689614-6570-1-git-send-email-john@metanate.com>
 <20160113142320.GQ19130@phenom.ffwll.local>
 <20160113143425.363ce07a.john@metanate.com>
 <20160113154005.GT19130@phenom.ffwll.local>
 <20160113155529.6048b2c1.john@metanate.com>
Message-ID: <20160113162156.GA19130@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 03:55:29PM +0000, John Keeping wrote:
> On Wed, 13 Jan 2016 16:40:05 +0100, Daniel Vetter wrote:
> 
> > On Wed, Jan 13, 2016 at 02:34:25PM +0000, John Keeping wrote:
> > > On Wed, 13 Jan 2016 15:23:20 +0100, Daniel Vetter wrote:
> > >   
> > > > On Wed, Jan 13, 2016 at 12:53:34PM +0000, John Keeping wrote:  
> > > > > As commented in drm_atomic_helper_wait_for_vblanks(), userspace
> > > > > relies on cursor ioctls being unsynced.  Converting the rockchip
> > > > > driver to atomic has significantly impacted cursor performance by
> > > > > making every cursor update wait for vblank.
> > > > > 
> > > > > By skipping the vblank sync when the framebuffer has not changed
> > > > > (as is done in drm_atomic_helper_wait_for_vblanks()) we can avoid
> > > > > this for the common case of moving the cursor and only need to
> > > > > delay the cursor ioctl when the cursor icon changes.
> > > > > 
> > > > > I originally inserted a check on legacy_cursor_update as well, but
> > > > > that caused a storm of iommu page faults.  I didn't investigate the
> > > > > cause of those since this change gives enough of a performance
> > > > > improvement for my use case.
> > > > > 
> > > > > This is RFC because of that and because the framebuffer_changed()
> > > > > function is copied from drm_atomic_helper.c as a quick way to test
> > > > > the result.
> > > > > 
> > > > > Signed-off-by: John Keeping <john@metanate.com>
> > > > > ---
> > > > >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 27
> > > > > +++++++++++++++++++++++++-- 1 file changed, 25 insertions(+), 2
> > > > > deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > > > > b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c index f784488..8fd9821
> > > > > 100644 --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > > > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > > > > @@ -177,8 +177,28 @@ static void
> > > > > rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
> > > > > crtc_funcs->wait_for_update(crtc); }
> > > > >  
> > > > > +static bool framebuffer_changed(struct drm_device *dev,
> > > > > +				struct drm_atomic_state *old_state,
> > > > > +				struct drm_crtc *crtc)
> > > > > +{
> > > > > +	struct drm_plane *plane;
> > > > > +	struct drm_plane_state *old_plane_state;
> > > > > +	int i;
> > > > > +
> > > > > +	for_each_plane_in_state(old_state, plane, old_plane_state,
> > > > > i) {
> > > > > +		if (plane->state->crtc != crtc &&
> > > > > +		    old_plane_state->crtc != crtc)
> > > > > +			continue;
> > > > > +
> > > > > +		if (plane->state->fb != old_plane_state->fb)
> > > > > +			return true;
> > > > > +	}
> > > > > +
> > > > > +	return false;
> > > > > +}    
> > > > 
> > > > Please don't hand-roll logic that affects semantics like this. Instead
> > > > please use drm_atomic_helper_wait_for_vblanks(), which should do this
> > > > correctly for you.
> > > > 
> > > > If that's not the case then we need to improve the generic helper, or
> > > > figure out what's different with rockhip.  
> > > 
> > > According to commit 63ebb9f (drm/rockchip: Convert to support atomic
> > > API) it's because rockchip doesn't have a hardware vblank counter.
> > > 
> > > I'm not entirely clear on why this prevents the use of
> > > drm_atomic_helper_wait_for_vblanks().  
> > 
> > Hm, that commit isn't terribly helpful. If that's really needed then imo I
> > think we should extract a "drm_atomic_helper_plane_needs_vblank_wait()"
> > helper that's used by both. But since rockchip does vblank_get/put calls
> > I'd hope vblanks actually work correctly. And then the helper should work
> > too.
> 
> I tried switching the call to rockchip_crtc_wait_for_update() to
> drm_atomic_helper_wait_for_vblanks() and it works fine until I switch
> the buffer associated with a cursor, at which point I get iommu page
> faults, presumably because the GEM buffer is unreferenced too early.
> 
> AFAICT the buffer will be released via drm_atomic_state_free()
> unconditionally, but I suspect I'm missing something since that would
> mean every driver would hit a similar problem.

Yeah, with the helper we always skip, which means when the cursor bo
changes you indeed unmap too early. So can't even share the overall
condition, but we could definitely share the little framebuffer_changed
helper. Plus rockchip_crtc_wait_for_update should have a big comment
explaining why we have different rules than core helpers!

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
