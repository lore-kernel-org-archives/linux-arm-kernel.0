From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 21 Nov 2016 12:56:53 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121122556.GE1041@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
Message-ID: <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 12:25:56PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 11:32:12AM +0000, Liviu Dudau wrote:
> > On Mon, Nov 21, 2016 at 11:20:30AM +0000, Russell King - ARM Linux wrote:
> > > I first noticed it when booting with the buggy I2C EDID reading, so
> > > DRM wasn't seeing a valid EDID.  Then when Xorg started up and shut
> > > down, I noticed that the framebuffer console was shifted.  It's actually
> > > shifted to the left because framebuffer pixel 0,0 is not displayed.
> > 
> > I see. So the reason why I did not notice this was the EDID transfers
> > mostly working for me.
> 
> It also happens when EDID transfers work too!
> 
> > > > > Using devmem2 to disable and re-enable the HDLCD resolves the issue,
> > > > > and repeated disable/enable cycles do not make the issue re-appear.
> > > > 
> > > > Do you resize the display mode as well afer re-enabling HDLCD?
> > > 
> > > I quite literally just did:
> > > 
> > > ./devmem2 0x7ff60230 w 0; ./devmem2 0x7ff60230 w 1
> > 
> > Sorry, was not very clear. Under my assumption that you were resizing the
> > display with xrandr, I was wondering if the issue you were seeing disappeared
> > when using devmem2 plus the resizing.
> 
> I think the problems are much deeper.  I've added this:
> 
> static void hdlcd_crtc_enable(struct drm_crtc *crtc)
> {
>         struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> printk("%s: active %d cmd %08x\n", __func__, crtc->state->active, hdlcd_read(hdlcd, HDLCD_REG_COMMAND));
>         clk_prepare_enable(hdlcd->clk);
> 
> ...
> static void hdlcd_crtc_disable(struct drm_crtc *crtc)
> {
>         struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> printk("%s: active %d\n", __func__, crtc->state->active);
>         if (!crtc->state->active)
>                 return;
> 
> What I see in the kernel log each time I change the resolution is:
> 
> [  221.409577] hdlcd_crtc_disable: active 0
> [  221.430206] hdlcd_crtc_enable: active 1 cmd 00000001
> [  239.264672] hdlcd_crtc_disable: active 0
> [  239.285180] hdlcd_crtc_enable: active 1 cmd 00000001
> [  278.712792] hdlcd_crtc_disable: active 0
> [  278.730361] hdlcd_crtc_enable: active 1 cmd 00000001
> [  281.633841] hdlcd_crtc_disable: active 0
> [  281.668578] hdlcd_crtc_enable: active 1 cmd 00000001
> 
> So, when ->disable is called, active is always zero.  

That is expected, the DRM framework will determine that the crtc is no longer active and
call ->disable hook on the CRTC helper struct.

> This leads to...
> 
> $ head -n3 /sys/kernel/debug/clk/clk_summary
>    clock                         enable_cnt  prepare_cnt        rate   accuracy
>   phase
> ----------------------------------------------------------------------------------------
>  pxlclk                                   6            6   148500000          0 0
> 
> the enable and prepare counts for this clock incrementing by one each
> time I change the resolution.

That is mostly due to the check in hdlcd_crtc_disable() which I should remove,
I've added it because I was getting a ->disable() hook call before any ->enable()
was called at startup time. I need to revisit this as I remember Daniel was commenting
that this was not needed.

> 
> > > Maybe hdlcd shouldn't be implementing the ->enable callback but instead
> > > the ->commit callback then?
> > 
> > I believe we need ->enable for the initial setup (cold boot or module
> > reloading).
> 
> Yes, I found a comment in DRM saying that ->commit is for legacy drivers
> only.
> 
> I think the problem is that hdlcd is not really knowing what the true
> state of the CRTC is, as illustrated by the clock counts increasing
> and the state of crtc->state->active.

I think crtc->state->active is correct, we are just not acting as we should
in HDLCD.

> 
> I'm wondering if this is a core DRM bug though... the comments and
> code do not align:
> 
> /**
>  * drm_atomic_helper_commit_tail - commit atomic update to hardware
>  * @state: new modeset state to be committed
> 
> void drm_atomic_helper_commit_tail(struct drm_atomic_state *state)
> {
>         struct drm_device *dev = state->dev;
> 
>         drm_atomic_helper_commit_modeset_disables(dev, state);
> 
> /**
>  * drm_atomic_helper_commit_modeset_disables - modeset commit to disable outputs * @dev: DRM device
>  * @old_state: atomic state object with old state structures
> void drm_atomic_helper_commit_modeset_disables(struct drm_device *dev,
>                                                struct drm_atomic_state *old_state)
> 
> So, is "state" in drm_atomic_helper_commit_tail the old state or the
> new state?  Should this state be passed to
> drm_atomic_helper_commit_modeset_disables(), which seems to expect
> the old state?

Yes, you have reached one (of the many?) DRM quirks. When drm_atomic_helper_commit_tail()
gets called the *state pointer contains the old state that was swapped
out by drm_atomic_helper_commit() function before calling commit_tail().
The comment on drm_atomic_helper_commit_tail function (and maybe parameter name)
should be updated.


> 
> It looks _really_ screwed up here - in any case, it really doesn't
> help when you're not experienced with atomic mode set to work out
> what the hell this code is doing... it seems to be a horrible mess.
> Maybe someone who understands this code ought to read through it
> from the point of view of someone who doesn't understand it and fix
> the comments, or get rid of the down-right misleading comments.
> 
> Comments are worse than useless if they mislead.  Better to have no
> comments than misleading comments.

Sometimes code gets shuffled around and functions that made sense in
one workflow are kept in the new workflow except their order gets changed.
I believe that was the case for the function above.

Best regards,
Liviu

> 
> Daniel?
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
