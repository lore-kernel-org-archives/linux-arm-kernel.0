From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 17 Aug 2015 19:17:53 +0100
Subject: [PATCH 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1439835473.3341.88.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I haven't reviewed the code in detail, just had one comment I alluded to
in a private email the other day...

On Wed, 2015-08-05 at 15:28 +0100, Liviu Dudau wrote:

> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
[...]
> +void hdlcd_set_scanout(struct hdlcd_drm_private *hdlcd)
> +{
> +	struct drm_framebuffer *fb = hdlcd->crtc.primary->fb;
> +	struct drm_gem_cma_object *gem;
> +	unsigned int depth, bpp;
> +	dma_addr_t scanout_start;
> +
> +	drm_fb_get_bpp_depth(fb->pixel_format, &depth, &bpp);
> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> +
> +	scanout_start = gem->paddr + fb->offsets[0] +
> +		(hdlcd->crtc.y * fb->pitches[0]) + (hdlcd->crtc.x * bpp/8);
> +
> +	hdlcd_write(hdlcd, HDLCD_REG_FB_BASE, scanout_start);
> +}
> +

The above function accesses various pointers and values, which
presumably all need to be valid and consistent. However...

[...]
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
[...]
> +static irqreturn_t hdlcd_irq(int irq, void *arg)
> +{
> +	struct drm_device *dev = arg;
> +	struct hdlcd_drm_private *hdlcd = dev->dev_private;
> +	unsigned long irq_status;
> +
> +	irq_status = hdlcd_read(hdlcd, HDLCD_REG_INT_STATUS);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (irq_status & HDLCD_INTERRUPT_UNDERRUN) {
> +		atomic_inc(&hdlcd->buffer_underrun_count);
> +	}
> +	if (irq_status & HDLCD_INTERRUPT_DMA_END) {
> +		atomic_inc(&hdlcd->dma_end_count);
> +	}
> +	if (irq_status & HDLCD_INTERRUPT_BUS_ERROR) {
> +		atomic_inc(&hdlcd->bus_error_count);
> +	}
> +	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> +		atomic_inc(&hdlcd->vsync_count);
> +	}
> +#endif
> +	if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> +		struct drm_pending_vblank_event *event;
> +		unsigned long flags;
> +
> +		hdlcd_set_scanout(hdlcd);

hdlcd_set_scanout is being called on every vsync interrupt, can we
guarantee that is safe? What if we're in the middle of a page flip or
panning operation? Seems to me that there is at least scope for
incorrect addresses being calculated leading to a nasty glitch on the
screen for one frame. And in the worst case, possibly invalid pointer
being dereferenced.

So, if scanout needs to be set on every vsync, would it not be safer
(and more efficient) to have a single variable storing the value to use
during interrupts, and recalculate that value outside of interrupts
whenever things are changed?

-- 
Tixy
