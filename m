From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 11:20:30 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
Message-ID: <20161121112030.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 11:06:04AM +0000, Liviu Dudau wrote:
> On Fri, Nov 18, 2016 at 11:37:33PM +0000, Russell King - ARM Linux wrote:
> > Hi,
> 
> Hi Russell,
> 
> > 
> > While testing HDMI with Xorg on the Juno board, I find that when Xorg
> > starts up or shuts down, the display is shifted significantly to the
> > right and wrapped in the active region.  (No sync bars are visible.)
> > The timings are correct, it behaves as if the start address has been
> > shifted many pixels _into_ the framebuffer.
> > 
> > This occurs whenever the display mode size is changed - using xrandr
> > in Xorg shows that changing the resolution triggers the problem
> > almost every time, but changing the refresh rate does not.
> 
> Thanks for reporting this. To double check your issue, you are booting
> with HDLCD using the native monitor resolution as detected via EDID
> and then using xrandr to change the display mode. When you do that you
> are seeing the image being shifted to the right. Is that a correct
> description? (I'm trying to reproduce it here and want to make sure 
> I've got the details right).

I first noticed it when booting with the buggy I2C EDID reading, so
DRM wasn't seeing a valid EDID.  Then when Xorg started up and shut
down, I noticed that the framebuffer console was shifted.  It's actually
shifted to the left because framebuffer pixel 0,0 is not displayed.

> > Using devmem2 to disable and re-enable the HDLCD resolves the issue,
> > and repeated disable/enable cycles do not make the issue re-appear.
> 
> Do you resize the display mode as well afer re-enabling HDLCD?

I quite literally just did:

./devmem2 0x7ff60230 w 0; ./devmem2 0x7ff60230 w 1

(with a devmem2 fixed for ARM64) which immediately fixed the issue.

> > What I think is going on is that the FIFO or address generator for
> > reading data from the AXI bus is not properly reset when changing the
> > resolution, and the enable-disable-enable cycle causes the HDLCD
> > hardware to sort itself out.
> 
> That is likely what is happening. According to the datasheet, changing
> the resolution should be done while the HDLCD command mode is disabled,
> which is what writing 0 into HDLCD_REG_COMMAND does.

That does not appear to be sufficient.

> > It's (eg) significantly out - for example,
> > to properly align the display, I have to program an address of
> > 0xf4ff0200 into the hardware rather than 0xf5000000 - that's 896 pixels
> > before the real start of the frame buffer.
> 
> What is the resolution you are using?

In the case I detailed here, 1920x1080.

> > With this patch, a patch to TDA998x to avoid the i2c-designware issue,
> > and xf86-video-armada, I have LXDE running on the Juno.
> 
> Can you tell me more about the TDA998x and i2c-designware issue?
> Also, I don't think you need to use xf86-video-armada, the mode-setting
> driver built into Xorg should be working fine (that is what I've used
> in my testing).

See the i2c-designware thread on lakml.  It's a spontaneous high
interrupt latency causing the Tx FIFO not to be loaded before it
empties, and the i2c-designware crap decides at that point to
immediately generate an I2C stop.  The I2C controller in Juno can
only work reliably in a system which has guaranteed low interrupt
latencies.

> > Something I also noticed is this:
> > 
> >         scanout_start = gem->paddr + plane->state->fb->offsets[0] +
> >                 plane->state->crtc_y * plane->state->fb->pitches[0] +
> >                 plane->state->crtc_x * bpp / 8;
> > 
> > Surely this should be using src_[xy] (which are the position in the
> > source - iow, memory, and not crtc_[xy] which is the position on the
> > CRTC displayed window.  To put it another way, the src_* define the
> > region of the source material that is mapped onto a rectangular area
> > on the display defined by crtc_*.
> 
> Yes, that is a bug and most likely the source of the issue that you are
> seeing if my understanding of your testing is correct.

It isn't the source of this issue at all.  gem->paddr is 0xf5000000, and
the value programmed originally into the register is the same.  So, from
those two pieces of information, we can reasonably assume that crtc_y
and crtc_x were both zero here.

> > Another note is that since the CRTC can't place the plane in arbitary
> > positions and sizes within the active area, should the atomic_check
> > ensure that crtc_x = crtc_y = 0, and the crtc width/height are the
> > size of the active area?
> 
> That should be the case, indeed. I'm going prepare a patch to do that.

I've already a patch along the lines of Daniel Vetter's response to this
point which I'm just testing.

> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > index 48019ae22ddb..3e97acf6e2a7 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > @@ -150,6 +150,8 @@ static void hdlcd_crtc_enable(struct drm_crtc *crtc)
> >  	clk_prepare_enable(hdlcd->clk);
> >  	hdlcd_crtc_mode_set_nofb(crtc);
> >  	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
> > +	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
> > +	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
> 
> I am not convinced that this is the right fix. If anything, I would put a
> hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0); line before hdlcd_crtc_mode_set_nofs(crtc);
> line to make sure the command mode is disabled before setting the mode, but
> again, I need to understand your use case to make sure that this indeed fixes it.

Maybe hdlcd shouldn't be implementing the ->enable callback but instead
the ->commit callback then?

I'll give it a try.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
