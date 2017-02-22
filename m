From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Wed, 22 Feb 2017 17:42:30 +0200
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20170220185948.GR21222@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20170220121603.GA1132@n2100.armlinux.org.uk>
 <20170220175331.GC963@e110455-lin.cambridge.arm.com>
 <20170220180558.GB31595@intel.com>
 <20170220185948.GR21222@n2100.armlinux.org.uk>
Message-ID: <20170222154230.GJ31595@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 06:59:49PM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 20, 2017 at 08:05:58PM +0200, Ville Syrj?l? wrote:
> > This stuff should be using the clipped coordinates, not the user
> > coordinates. And it doesn't look like this guy is even calling the
> > clip helper thing.
> > 
> > malidp seems to be calling that thing, but it still doesn't
> > manage to program the hw with the right coordinates from what
> > I can see.
> > 
> > /me feels a bit like a broken record...
> 
> If you mean drm_plane_helper_check_state(), then...
> 
> $ grep drm_plane_helper_check_state Documentation/gpu/ -r
> 
> So nothing there... but in drivers/gpu/drm/drm_plane_helper.c, there's
> the following, and I think this really isn't helping people understand
> what's required:
> 
>  * This helper library has two parts. The first part has support to implement
>  * primary plane support on top of the normal CRTC configuration interface.
>  * Since the legacy ->set_config interface ties the primary plane together with
>  * the CRTC state this does not allow userspace to disable the primary plane
>  * itself.  To avoid too much duplicated code use
>  * drm_plane_helper_check_update() which can be used to enforce the same
>  * restrictions as primary planes had thus. The default primary plane only
>  * expose XRBG8888 and ARGB8888 as valid pixel formats for the attached
>  * framebuffer.
>  *
>  * Drivers are highly recommended to implement proper support for primary
>  * planes, and newly merged drivers must not rely upon these transitional
>  * helpers.
> 
> Which functions are defined as "these transitional helpers" - the above
> is rather ambiguous.  Is drm_plane_helper_check_state() a "transitional
> helper" or is it not?  (It probably isn't, but the documentation does not
> make that clear.)

Nope. And I guess we might want to move it into some atomic code
instead. IIRC Daniel even suggested that but I was too lazy to do it at
the time.

> 
> It then goes on to:
> 
>  * The second part also implements transitional helpers which allow drivers to
> 
> So maybe the second paragraph needs to be moved after this line to
> remove the confusion?
> 
> If you find that you're repeating something to many people, it's always
> a good idea to re-read the documentation that's supposed to be giving
> people guidance.

Docs are such a new thing. I've not ever read them through myself TBH.

> 
> Now, when you say that we're supposed to program "clipped coordinates"
> maybe you can give a hint what those are and where they come from?
> Is that the vaguely documented "clip" parameter in
> drm_plane_helper_check_state() ?
> 
>  * @clip: integer clipping coordinatesa

/**
 * struct drm_plane_state - mutable plane state
 ...
 * @src: clipped source coordinates of the plane (in 16.16)
 * @dst: clipped destination coordinates of the plane

> 
> If it is, that doesn't really describe it, and neither does the
> description of what the function does, nor what it returns:
> 
>  * Checks that a desired plane update is valid.  Drivers that provide
>  * their own plane handling rather than helper-provided implementations may
>  * still wish to call this function to avoid duplication of error checking
>  * code.
>  *
>  * RETURNS:
>  * Zero if update appears valid, error code on failure
> 
> So, some improvement there could go a long way towards eliminating
> some of these issues...
> 
> Atomic modeset is hideously complex... having poor documentation doesn't
> help.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Ville Syrj?l?
Intel OTC
