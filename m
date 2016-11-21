From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 18:43:42 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121182324.GP1005@e106497-lin.cambridge.arm.com>
References: <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
 <20161121140349.GG1041@n2100.armlinux.org.uk>
 <20161121173231.GM1005@e106497-lin.cambridge.arm.com>
 <20161121175602.GM1041@n2100.armlinux.org.uk>
 <20161121182324.GP1005@e106497-lin.cambridge.arm.com>
Message-ID: <20161121184342.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 06:23:24PM +0000, Liviu Dudau wrote:
> On Mon, Nov 21, 2016 at 05:56:02PM +0000, Russell King - ARM Linux wrote:
> > For me, the image shift was 100% reproducable.  With the above patch
> > and a call to drm_crtc_vblank_on() in the enable path, it seems to
> > behave correctly - I can alternately switch between 1920x1080 and
> > 1280x1024 and it behaves correctly.  Indeed, my debug prints show that
> > the right thing is happening wrt disabling the controller:
> 
> OK, so I'll take it that you did not also use your patch to fix the base
> plane calculations, or was that included as well in your stack?

It was before that patch - so it was using crtc_x and crtc_y.  However,
I can guarantee that those were both zero (as I've previously
described.)

> > That's more of a generic DRM issue - the CRTC layer doesn't get a
> > look-in when a connector parses the modes supplied from the display,
> > so there's no real way for the CRTC layer to apply any kind of
> > limitations to the available modes, except when a mode is attempted
> > to be set.
> > 
> > I don't want to see an "interlace" DT property introduced for the
> > TDA998x, because that's the wrong approach - it would be adding a
> > property for the needs of the implementation, and not a description
> > of the hardware.
> 
> AFAICT the issue is the fact that while HDLCD could scan out the alternate
> lines with a bit of a convoluted hack, there is no way to tell TDA19988
> to generate the interlaced timings. And no, I'm not advocating introducing
> a DT property as this is a runtime mode, depending on the resolution
> selected by userspace.

The TDA998x doesn't "generate" the timings.  They come from the input
to it, the TDA998x merely tracks where it is within the frame, so it
knows where it can place things like the infoframes and other data.

So, the responsibility for generating the interlaced timings is with
the CRTC.

That means the CRTC needs to not only scan out alternate lines (which
is the easy bit - setting the pitch to twice the value) but it also
needs to be able to adjust the timing of the vertical sync by half
a line.  The HDLCD from what I can see does not support that, the
overall system does not support for interlaced modes.

> > Whether that has any bearing on the reproducability of this or not, I've
> > no idea.
> 
> The one factor that could affect it is the capability of the SCP firmware
> to generate the exact pixel clock for your 1080p mode. If it doesn't, then
> restoring the old mode might lead to an incorrect synchronisation with the
> TDA chip. Current (less than 1.5 years old I guess) SCP firmware has that
> sorted via an hdlcd.dat file that pre-calculates a lot of common pixel clock
> frequencies).

The TDA998x takes the sync signals itself to synchronise with the CRTC,
and the pixel clock had better be synchronous with the data being closed
out of the CRTC otherwise its going to be in violation of the RGB data
setup and hold timings - which will cause random colour errors.

That isn't what's going on here - the image is rock stable, it's just
shifted.

I tried inverting the sync signals from the CRTC to the TDA998x, and
that shifts the display (as I expect, because the TDA998x synchronises
on the transition of the sync signals not on their absolute values) and
at that point I get the black sync bars appearing - again as expected.

Same kind of effect if I swap the horizontal front and back porches.

Of course, adjusting such things necessitates the TDA998x to re-lock
to the CRTC each time something like that changes, and the image
shift remains.

As I described originally, the _only_ two things that solved the image
shift was (a) shifting the framebuffer start address earlier than it
should be, or (b) disabling the CRTC and re-enabling the CRTC.  Both
of those were tried using devmem2 in userspace with no patches to the
HDLCD code over v4.9-rc5.

The only patches that would be in effect are my TDA998x patch stack
(which you've already tested), the i2c-designware patches to sort that
crappy thing out, and a dirty patch to the TDA998x code to read the
EDID in 16 byte chunks [*], so that the i2c-designware crappage never
causes a problem.

* - I'm not submitting this patch, because while it may solve the
    EDID reading issue on Juno, it's putting intimate knowledge of
    i2c-designware into the TDA998x driver - it's a hack around the
    problem, it's not a real fix.  It's possible that there are other
    i2c-designware crappages out there which have even smaller FIFOs
    which would need us to read in even smaller chunks for reliability.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
