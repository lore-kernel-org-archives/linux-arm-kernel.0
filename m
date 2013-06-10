From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 22:38:58 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
Message-ID: <20130610213858.GA18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:57:32AM -0400, Rob Clark wrote:
> On Sun, Jun 9, 2013 at 3:29 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > +/* The mode_config.mutex will be held for this call */
> > +static int armada_drm_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
> > +       struct drm_framebuffer *old_fb)
> > +{
> > +       struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
> > +       struct armada_regs regs[4];
> > +       unsigned i;
> > +
> > +       i = armada_drm_crtc_calc_fb(crtc->fb, crtc->x, crtc->y, regs, dcrtc->interlaced);
> > +       armada_reg_queue_end(regs, i);
> > +
> > +       /* Wait for pending flips to complete */
> > +       wait_event(dcrtc->frame_wait, !dcrtc->frame_work);
> > +
> > +       /* Take a reference to the new fb as we're using it */
> > +       drm_gem_object_reference(&drm_fb_obj(crtc->fb)->obj);
> 
> note that you probably want to ref/unref the fb (and let the fb hold a
> ref to the gem bo).. that will make life easier for planar formats too
> (as the fb should hold ref's to the bo for each plane)

Now changed - and it looks from my debug of gem_linear that it's working
correctly (iow, not leaking).

> > +struct drm_armada_gem_create {
> > +       uint32_t height;
> > +       uint32_t width;
> > +       uint32_t bpp;
> 
> just fwiw, typically height/width/bpp are properties of the fb but not
> the bo.. (except in some cases where kernel needs to know this to
> setup GTT correctly for tiled buffers)

Also fixed.

> > +struct drm_armada_gem_pwrite {
> > +       uint32_t handle;
> > +       uint32_t offset;
> > +       uint32_t size;
> 
> probably want a uint32_t padding here, or move the uint64_t up in the
> struct to avoid 32 vs 64b alignment differences.

And also fixed.
