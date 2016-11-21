From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 21 Nov 2016 18:23:24 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121175602.GM1041@n2100.armlinux.org.uk>
References: <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
 <20161121140349.GG1041@n2100.armlinux.org.uk>
 <20161121173231.GM1005@e106497-lin.cambridge.arm.com>
 <20161121175602.GM1041@n2100.armlinux.org.uk>
Message-ID: <20161121182324.GP1005@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 05:56:02PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 05:32:32PM +0000, Liviu Dudau wrote:
> > On Mon, Nov 21, 2016 at 02:03:49PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 21, 2016 at 01:50:31PM +0000, Liviu Dudau wrote:
> > > > On Mon, Nov 21, 2016 at 01:24:19PM +0000, Russell King - ARM Linux wrote:
> > > > > On Mon, Nov 21, 2016 at 12:56:53PM +0000, Liviu Dudau wrote:
> > > > > > That is mostly due to the check in hdlcd_crtc_disable() which I should
> > > > > > remove, I've added it because I was getting a ->disable() hook call
> > > > > > before any ->enable() was called at startup time. I need to revisit
> > > > > > this as I remember Daniel was commenting that this was not needed.
> > > > > 
> > > > > Removing that test results in:
> > > > > 
> > > > > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
> > > > > 
> > > > > and the kernel hanging, seemingly in an IRQs-off region.
> > > > 
> > > > Right, I need to sort this one out. Are you doing these tests out of
> > > > some tagged branch that I can get in sync with?
> > 
> > Hi Russell,
> > 
> > > 
> > > No, not yet, and some of the changes I have are rather hacky.
> > > 
> > > I do always build my full tree of patches (which is currently running at
> > > around 320 patches at the moment) but I never share that entire patch
> > > set.  However, none of those touch i2c (apart from the ones I've recently
> > > posted) and the only patches touching hdlcd are those I've posted so far.
> > > 
> > > Most of the problems I'm finding are through trying basic stuff - I'm not
> > > doing anything special or unusual to find them, at the moment quite
> > > literally just starting Xorg up and shutting it down.  For example, the
> > > above was caused by logging in on serial, running:
> > > 
> > > 	Xorg -terminate -verbose
> > > 
> > > and then hitting ^C.  (I have lxdm disabled so systemd boots to VT login
> > > prompts on both the "framebuffer" and serial - I don't want Xorg coming
> > > up when the machine is booting for its nightly KVM boot tests.)
> > > 
> > > I'm afraid that when I try someone elses code, I have a tendency to find
> > > loads of seemingly trivial bugs when I try putting it through some basic
> > > tests.
> > 
> > I'm not being able to reproduce your bug conditions. I'm running the following
> > setup when testing:
> > 
> > - mainline v4.9-rc6
> > - edited the juno-base.dtsi file to disable the hdlcd at 7f600000 and
> >   hdmi-transmitter at 70 nodes to remove the second HDMI output from the test.
> > - patched tda998x_drv.c to set interlace_allowed = 0, see below why
> > - modified the hdlcd_crtc.c file with the following patch:
> > 
> > -8<-----------------------------------------------------------------------
> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > index 48019ae..656dc43 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > @@ -156,9 +156,7 @@ static void hdlcd_crtc_disable(struct drm_crtc *crtc)
> >  {
> >  	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> >  
> > -	if (!crtc->state->active)
> > -		return;
> > -
> > +	drm_crtc_vblank_off(crtc);
> 
> Don't you need a drm_crtc_vblank_on() call in the enable function?

I do, thanks for calling me on that!

> 
> >  	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
> >  	clk_disable_unprepare(hdlcd->clk);
> >  }
> > ->8-----------------------------------------------------------------------
> > 
> > That takes care of the pxlclk refcounting issue you were seeing. I've started
> > Xorg several times (and yes, I do see EDID checksum error every now and then,
> > specially when running xrandr). When closing down Xorg I get back the framebuffer
> > console with the login prompt and no image shifting.
> 
> For me, the image shift was 100% reproducable.  With the above patch
> and a call to drm_crtc_vblank_on() in the enable path, it seems to
> behave correctly - I can alternately switch between 1920x1080 and
> 1280x1024 and it behaves correctly.  Indeed, my debug prints show that
> the right thing is happening wrt disabling the controller:

OK, so I'll take it that you did not also use your patch to fix the base plane
calculations, or was that included as well in your stack?

> 
> [   76.869136] hdlcd_crtc_disable: active 0
> [   76.869159] hdlcd_plane_atomic_update: pitch 7680 lines 1080
> [   76.888983] hdlcd_plane_atomic_update: pitch 5120 lines 1024
> [   76.888995] hdlcd_crtc_enable: active 1 cmd 00000000
> [   85.262451] hdlcd_crtc_disable: active 0
> [   85.262474] hdlcd_plane_atomic_update: pitch 5120 lines 1024
> [   85.286667] hdlcd_plane_atomic_update: pitch 7680 lines 1080
> [   85.286679] hdlcd_crtc_enable: active 1 cmd 00000000
> [   92.658038] hdlcd_crtc_disable: active 0
> [   92.658057] hdlcd_plane_atomic_update: pitch 7680 lines 1080
> [   92.680659] hdlcd_plane_atomic_update: pitch 5120 lines 1024
> [   92.680668] hdlcd_crtc_enable: active 1 cmd 00000000
> [   97.805205] hdlcd_crtc_disable: active 0
> [   97.805220] hdlcd_plane_atomic_update: pitch 5120 lines 1024
> [   97.834415] hdlcd_plane_atomic_update: pitch 7680 lines 1080
> [   97.834423] hdlcd_crtc_enable: active 1 cmd 00000000
> 
> > My monitor is a TV that
> > reports that preferred mode is 1080i, however HDLCD and TDA19988 don't talk
> > propertly with each other to be able to set the interlaced mode correctly, so
> > I've had to disable support for interlacing mode in tda998x_drv.c and now the
> > preferred mode that gets picked up is 1920x1200 at 60Hz.
> 
> That's more of a generic DRM issue - the CRTC layer doesn't get a
> look-in when a connector parses the modes supplied from the display,
> so there's no real way for the CRTC layer to apply any kind of
> limitations to the available modes, except when a mode is attempted
> to be set.
> 
> I don't want to see an "interlace" DT property introduced for the
> TDA998x, because that's the wrong approach - it would be adding a
> property for the needs of the implementation, and not a description
> of the hardware.

AFAICT the issue is the fact that while HDLCD could scan out the alternate
lines with a bit of a convoluted hack, there is no way to tell TDA19988
to generate the interlaced timings. And no, I'm not advocating introducing
a DT property as this is a runtime mode, depending on the resolution
selected by userspace.

> 
> > Please advise on what other steps I can take to try to reproduce this.
> 
> I guess if you've tried and failed to reproduce it, there is something
> very specific to my setup which I can't describe.
> 
> > P.S: What revision of Juno do you have? Any chance you can capture the start
> > of the boot process where the firmware component prints the version numbers?
> 
> All I know is that it's a HBI0282B, which thanks to Sudeep's efforts
> (he spent _all_ of last Tuesday logged in to one of my systems trying
> to upgrade the firmware) is now running the Linaro 16.10 firmware.
> Sudeep says that my hardware is a very early revision which went out
> the door without being properly calibrated.

:) That is what you get for having special access to early samples of hardware :)

Might be worth asking your ARM contacts if a swap with an R2 is possible.

But, yes, my tests were also run on a Juno R0 (HBI0282B is just the R0 code)
and mine I'm pretty sure is earlier build than yours (board #13 no less).

> 
> Whether that has any bearing on the reproducability of this or not, I've
> no idea.

The one factor that could affect it is the capability of the SCP firmware
to generate the exact pixel clock for your 1080p mode. If it doesn't, then
restoring the old mode might lead to an incorrect synchronisation with the
TDA chip. Current (less than 1.5 years old I guess) SCP firmware has that
sorted via an hdlcd.dat file that pre-calculates a lot of common pixel clock
frequencies).

Best regards,
Liviu

> 
> If you want to see the boot messages, head to my autobuilder status page
> and look at the juno-kvm entries - they contain all the boot messages
> from initial power up of the juno.  I'll send you a link in private
> mail so googlebot doesn't end up hammering on it after it expires.
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
