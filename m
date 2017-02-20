From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Mon, 20 Feb 2017 20:05:58 +0200
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20170220175331.GC963@e110455-lin.cambridge.arm.com>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20170220121603.GA1132@n2100.armlinux.org.uk>
 <20170220175331.GC963@e110455-lin.cambridge.arm.com>
Message-ID: <20170220180558.GB31595@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 05:53:31PM +0000, Liviu Dudau wrote:
> Hi Russell,
> 
> On Mon, Feb 20, 2017 at 12:16:03PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Nov 18, 2016 at 11:37:33PM +0000, Russell King - ARM Linux wrote:
> > > Something I also noticed is this:
> > > 
> > >         scanout_start = gem->paddr + plane->state->fb->offsets[0] +
> > >                 plane->state->crtc_y * plane->state->fb->pitches[0] +
> > >                 plane->state->crtc_x * bpp / 8;
> > > 
> > > Surely this should be using src_[xy] (which are the position in the
> > > source - iow, memory, and not crtc_[xy] which is the position on the
> > > CRTC displayed window.  To put it another way, the src_* define the
> > > region of the source material that is mapped onto a rectangular area
> > > on the display defined by crtc_*.
> > 
> > This problem still exists...
> 
> Sorry, looks like this fell through the cracks of us trying to fix the
> other issues you were seeing. I'm attaching a patch, please let me know
> if this works for you.
> 
> Best regards,
> Liviu
> 
> > 
> > -- 
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> > according to speedtest.net.
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ?\_(?)_/?

> >From a495d262cb91fdeccb00685646ddb71774c18e7e Mon Sep 17 00:00:00 2001
> From: Liviu Dudau <Liviu.Dudau@arm.com>
> Date: Mon, 20 Feb 2017 17:44:42 +0000
> Subject: [PATCH] arm: hdlcd: Fix the calculation of scanout start address
> 
> The framebuffer start address uses the CRTC's x,y position rather
> than the source framebuffer's. Fix that.
> 
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 798a3cc480a2..4c1ab73d9e07 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -244,21 +244,20 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
>  	struct drm_framebuffer *fb = plane->state->fb;
>  	struct hdlcd_drm_private *hdlcd;
>  	struct drm_gem_cma_object *gem;
> -	u32 src_w, src_h, dest_w, dest_h;
> +	u32 src_x, src_y, dest_w, dest_h;
>  	dma_addr_t scanout_start;
>  
>  	if (!fb)
>  		return;
>  
> -	src_w = plane->state->src_w >> 16;
> -	src_h = plane->state->src_h >> 16;
> +	src_x = plane->state->src_x >> 16;
> +	src_y = plane->state->src_y >> 16;

This stuff should be using the clipped coordinates, not the user
coordinates. And it doesn't look like this guy is even calling the
clip helper thing.

malidp seems to be calling that thing, but it still doesn't
manage to program the hw with the right coordinates from what
I can see.

/me feels a bit like a broken record...

>  	dest_w = plane->state->crtc_w;
>  	dest_h = plane->state->crtc_h;
>  	gem = drm_fb_cma_get_gem_obj(fb, 0);
>  	scanout_start = gem->paddr + fb->offsets[0] +
> -		plane->state->crtc_y * fb->pitches[0] +
> -		plane->state->crtc_x *
> -		fb->format->cpp[0];
> +		src_y * fb->pitches[0] +
> +		src_x *	fb->format->cpp[0];
>  
>  	hdlcd = plane->dev->dev_private;
>  	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_LENGTH, fb->pitches[0]);
> -- 
> 2.11.0
> 

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Ville Syrj?l?
Intel OTC
