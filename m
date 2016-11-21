From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 21 Nov 2016 11:06:04 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161118233733.GP1041@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
Message-ID: <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 11:37:33PM +0000, Russell King - ARM Linux wrote:
> Hi,

Hi Russell,

> 
> While testing HDMI with Xorg on the Juno board, I find that when Xorg
> starts up or shuts down, the display is shifted significantly to the
> right and wrapped in the active region.  (No sync bars are visible.)
> The timings are correct, it behaves as if the start address has been
> shifted many pixels _into_ the framebuffer.
> 
> This occurs whenever the display mode size is changed - using xrandr
> in Xorg shows that changing the resolution triggers the problem
> almost every time, but changing the refresh rate does not.

Thanks for reporting this. To double check your issue, you are booting
with HDLCD using the native monitor resolution as detected via EDID
and then using xrandr to change the display mode. When you do that you
are seeing the image being shifted to the right. Is that a correct
description? (I'm trying to reproduce it here and want to make sure 
I've got the details right).

> 
> Using devmem2 to disable and re-enable the HDLCD resolves the issue,
> and repeated disable/enable cycles do not make the issue re-appear.

Do you resize the display mode as well afer re-enabling HDLCD?

> 
> So, I patched the HDLCD to do this, and testing it with Xorg after
> several repetitions seems to work.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> What I think is going on is that the FIFO or address generator for
> reading data from the AXI bus is not properly reset when changing the
> resolution, and the enable-disable-enable cycle causes the HDLCD
> hardware to sort itself out.

That is likely what is happening. According to the datasheet, changing
the resolution should be done while the HDLCD command mode is disabled,
which is what writing 0 into HDLCD_REG_COMMAND does.


> It's (eg) significantly out - for example,
> to properly align the display, I have to program an address of
> 0xf4ff0200 into the hardware rather than 0xf5000000 - that's 896 pixels
> before the real start of the frame buffer.

What is the resolution you are using?

> 
> With this patch, a patch to TDA998x to avoid the i2c-designware issue,
> and xf86-video-armada, I have LXDE running on the Juno.

Can you tell me more about the TDA998x and i2c-designware issue?
Also, I don't think you need to use xf86-video-armada, the mode-setting
driver built into Xorg should be working fine (that is what I've used
in my testing).

> 
> Something I also noticed is this:
> 
>         scanout_start = gem->paddr + plane->state->fb->offsets[0] +
>                 plane->state->crtc_y * plane->state->fb->pitches[0] +
>                 plane->state->crtc_x * bpp / 8;
> 
> Surely this should be using src_[xy] (which are the position in the
> source - iow, memory, and not crtc_[xy] which is the position on the
> CRTC displayed window.  To put it another way, the src_* define the
> region of the source material that is mapped onto a rectangular area
> on the display defined by crtc_*.

Yes, that is a bug and most likely the source of the issue that you are
seeing if my understanding of your testing is correct.

> 
> Another note is that since the CRTC can't place the plane in arbitary
> positions and sizes within the active area, should the atomic_check
> ensure that crtc_x = crtc_y = 0, and the crtc width/height are the
> size of the active area?

That should be the case, indeed. I'm going prepare a patch to do that.

> 
>  drivers/gpu/drm/arm/hdlcd_crtc.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 48019ae22ddb..3e97acf6e2a7 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -150,6 +150,8 @@ static void hdlcd_crtc_enable(struct drm_crtc *crtc)
>  	clk_prepare_enable(hdlcd->clk);
>  	hdlcd_crtc_mode_set_nofb(crtc);
>  	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
> +	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
> +	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);

I am not convinced that this is the right fix. If anything, I would put a
hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0); line before hdlcd_crtc_mode_set_nofs(crtc);
line to make sure the command mode is disabled before setting the mode, but
again, I need to understand your use case to make sure that this indeed fixes it.

Best regards,
Liviu

>  }
>  
>  static void hdlcd_crtc_disable(struct drm_crtc *crtc)
> 
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
