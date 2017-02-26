From: daniel@ffwll.ch (Daniel Vetter)
Date: Sun, 26 Feb 2017 20:31:59 +0100
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20170222154230.GJ31595@intel.com>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20170220121603.GA1132@n2100.armlinux.org.uk>
 <20170220175331.GC963@e110455-lin.cambridge.arm.com>
 <20170220180558.GB31595@intel.com>
 <20170220185948.GR21222@n2100.armlinux.org.uk>
 <20170222154230.GJ31595@intel.com>
Message-ID: <20170226193159.jweze3jiwrzoyayn@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 05:42:30PM +0200, Ville Syrj?l? wrote:
> On Mon, Feb 20, 2017 at 06:59:49PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 20, 2017 at 08:05:58PM +0200, Ville Syrj?l? wrote:
> > > This stuff should be using the clipped coordinates, not the user
> > > coordinates. And it doesn't look like this guy is even calling the
> > > clip helper thing.
> > > 
> > > malidp seems to be calling that thing, but it still doesn't
> > > manage to program the hw with the right coordinates from what
> > > I can see.
> > > 
> > > /me feels a bit like a broken record...
> > 
> > If you mean drm_plane_helper_check_state(), then...
> > 
> > $ grep drm_plane_helper_check_state Documentation/gpu/ -r
> > 
> > So nothing there... but in drivers/gpu/drm/drm_plane_helper.c, there's
> > the following, and I think this really isn't helping people understand
> > what's required:
> > 
> >  * This helper library has two parts. The first part has support to implement
> >  * primary plane support on top of the normal CRTC configuration interface.
> >  * Since the legacy ->set_config interface ties the primary plane together with
> >  * the CRTC state this does not allow userspace to disable the primary plane
> >  * itself.  To avoid too much duplicated code use
> >  * drm_plane_helper_check_update() which can be used to enforce the same
> >  * restrictions as primary planes had thus. The default primary plane only
> >  * expose XRBG8888 and ARGB8888 as valid pixel formats for the attached
> >  * framebuffer.
> >  *
> >  * Drivers are highly recommended to implement proper support for primary
> >  * planes, and newly merged drivers must not rely upon these transitional
> >  * helpers.
> > 
> > Which functions are defined as "these transitional helpers" - the above
> > is rather ambiguous.  Is drm_plane_helper_check_state() a "transitional
> > helper" or is it not?  (It probably isn't, but the documentation does not
> > make that clear.)
> 
> Nope. And I guess we might want to move it into some atomic code
> instead. IIRC Daniel even suggested that but I was too lazy to do it at
> the time.

Yeah, this is a half-finished job with docs not really updated, and most
drivers also not really updated. I guess time to at least note this in our
shiny new todo.rst file. I'll type a patch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
