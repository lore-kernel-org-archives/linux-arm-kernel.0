From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 21 Nov 2016 17:32:32 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121140349.GG1041@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
 <20161121140349.GG1041@n2100.armlinux.org.uk>
Message-ID: <20161121173231.GM1005@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 02:03:49PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 01:50:31PM +0000, Liviu Dudau wrote:
> > On Mon, Nov 21, 2016 at 01:24:19PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 21, 2016 at 12:56:53PM +0000, Liviu Dudau wrote:
> > > > That is mostly due to the check in hdlcd_crtc_disable() which I should
> > > > remove, I've added it because I was getting a ->disable() hook call
> > > > before any ->enable() was called at startup time. I need to revisit
> > > > this as I remember Daniel was commenting that this was not needed.
> > > 
> > > Removing that test results in:
> > > 
> > > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
> > > 
> > > and the kernel hanging, seemingly in an IRQs-off region.
> > 
> > Right, I need to sort this one out. Are you doing these tests out of
> > some tagged branch that I can get in sync with?

Hi Russell,

> 
> No, not yet, and some of the changes I have are rather hacky.
> 
> I do always build my full tree of patches (which is currently running at
> around 320 patches at the moment) but I never share that entire patch
> set.  However, none of those touch i2c (apart from the ones I've recently
> posted) and the only patches touching hdlcd are those I've posted so far.
> 
> Most of the problems I'm finding are through trying basic stuff - I'm not
> doing anything special or unusual to find them, at the moment quite
> literally just starting Xorg up and shutting it down.  For example, the
> above was caused by logging in on serial, running:
> 
> 	Xorg -terminate -verbose
> 
> and then hitting ^C.  (I have lxdm disabled so systemd boots to VT login
> prompts on both the "framebuffer" and serial - I don't want Xorg coming
> up when the machine is booting for its nightly KVM boot tests.)
> 
> I'm afraid that when I try someone elses code, I have a tendency to find
> loads of seemingly trivial bugs when I try putting it through some basic
> tests.

I'm not being able to reproduce your bug conditions. I'm running the following
setup when testing:

- mainline v4.9-rc6
- edited the juno-base.dtsi file to disable the hdlcd at 7f600000 and
  hdmi-transmitter at 70 nodes to remove the second HDMI output from the test.
- patched tda998x_drv.c to set interlace_allowed = 0, see below why
- modified the hdlcd_crtc.c file with the following patch:

-8<-----------------------------------------------------------------------
diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 48019ae..656dc43 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -156,9 +156,7 @@ static void hdlcd_crtc_disable(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 
-	if (!crtc->state->active)
-		return;
-
+	drm_crtc_vblank_off(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
 	clk_disable_unprepare(hdlcd->clk);
 }
->8-----------------------------------------------------------------------

That takes care of the pxlclk refcounting issue you were seeing. I've started
Xorg several times (and yes, I do see EDID checksum error every now and then,
specially when running xrandr). When closing down Xorg I get back the framebuffer
console with the login prompt and no image shifting. My monitor is a TV that
reports that preferred mode is 1080i, however HDLCD and TDA19988 don't talk
propertly with each other to be able to set the interlaced mode correctly, so
I've had to disable support for interlacing mode in tda998x_drv.c and now the
preferred mode that gets picked up is 1920x1200 at 60Hz.

Please advise on what other steps I can take to try to reproduce this.

P.S: What revision of Juno do you have? Any chance you can capture the start
of the boot process where the firmware component prints the version numbers?

Best regards,
Liviu


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
