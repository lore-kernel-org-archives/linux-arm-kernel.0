From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 19 Aug 2015 10:46:26 +0100
Subject: [PATCH 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <1439835473.3341.88.camel@linaro.org>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
 <1439835473.3341.88.camel@linaro.org>
Message-ID: <20150819094626.GG1020@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 07:17:53PM +0100, Jon Medhurst (Tixy) wrote:
> I haven't reviewed the code in detail, just had one comment I alluded to
> in a private email the other day...
> 
> On Wed, 2015-08-05 at 15:28 +0100, Liviu Dudau wrote:
> 
> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> [...]
> > +void hdlcd_set_scanout(struct hdlcd_drm_private *hdlcd)
> > +{
> > +	struct drm_framebuffer *fb = hdlcd->crtc.primary->fb;
> > +	struct drm_gem_cma_object *gem;
> > +	unsigned int depth, bpp;
> > +	dma_addr_t scanout_start;
> > +
> > +	drm_fb_get_bpp_depth(fb->pixel_format, &depth, &bpp);
> > +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> > +
> > +	scanout_start = gem->paddr + fb->offsets[0] +
> > +		(hdlcd->crtc.y * fb->pitches[0]) + (hdlcd->crtc.x * bpp/8);
> > +
> > +	hdlcd_write(hdlcd, HDLCD_REG_FB_BASE, scanout_start);
> > +}
> > +
> 
> The above function accesses various pointers and values, which
> presumably all need to be valid and consistent. However...
> 
> [...]
> > diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> [...]
> > +static irqreturn_t hdlcd_irq(int irq, void *arg)
> > +{
> > +	struct drm_device *dev = arg;
> > +	struct hdlcd_drm_private *hdlcd = dev->dev_private;
> > +	unsigned long irq_status;
> > +
> > +	irq_status = hdlcd_read(hdlcd, HDLCD_REG_INT_STATUS);
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +	if (irq_status & HDLCD_INTERRUPT_UNDERRUN) {
> > +		atomic_inc(&hdlcd->buffer_underrun_count);
> > +	}
> > +	if (irq_status & HDLCD_INTERRUPT_DMA_END) {
> > +		atomic_inc(&hdlcd->dma_end_count);
> > +	}
> > +	if (irq_status & HDLCD_INTERRUPT_BUS_ERROR) {
> > +		atomic_inc(&hdlcd->bus_error_count);
> > +	}
> > +	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> > +		atomic_inc(&hdlcd->vsync_count);
> > +	}
> > +#endif
> > +	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> > +		struct drm_pending_vblank_event *event;
> > +		unsigned long flags;
> > +
> > +		hdlcd_set_scanout(hdlcd);
> 
> hdlcd_set_scanout is being called on every vsync interrupt, can we
> guarantee that is safe? What if we're in the middle of a page flip or
> panning operation? Seems to me that there is at least scope for
> incorrect addresses being calculated leading to a nasty glitch on the
> screen for one frame. And in the worst case, possibly invalid pointer
> being dereferenced.

Agree, there is a risk of corruption here. I'm going to look at the atomic
mode setting which should hopefully resolve most of these issues.

> 
> So, if scanout needs to be set on every vsync, would it not be safer
> (and more efficient) to have a single variable storing the value to use
> during interrupts, and recalculate that value outside of interrupts
> whenever things are changed?

hdlcd_set_scanout() function is merely a convenience function to calculate
the scanout_start variable. The interrupt handler probably doesn't need to
call that and it was mostly a shortcut to make sure the HDLCD_REG_FB_BASE
register was up-to-date when the vsync interrupt happened. I hope the
atomic modeset will cleanup things here.

Best regards,
Liviu

> 
> -- 
> Tixy
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
