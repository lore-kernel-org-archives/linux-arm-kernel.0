From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Oct 2013 20:39:48 +0100
Subject: imx-drm: Add HDMI support
In-Reply-To: <52602EEA.6060402@prisktech.co.nz>
References: <52602EEA.6060402@prisktech.co.nz>
Message-ID: <20131017193948.GT25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 07:39:38AM +1300, Tony Prisk wrote:
> Hi Fabio,
>
> Little bit late to the party, but here is the patch for the latest  
> version of the HDMI driver I was working on. Having had a quick flick  
> through the mailing list I see Russell has noticed a few of the problems  
> I had earlier on, which are resolved in my later work. Thought this  
> might be useful to help you tidy things up.
>
> In particular, it fixes the VIC=6 forced issue, and the pink-line on the  
> edge of the screen issue.

Where to start.  Well, last night's testing resulted in this result
(from my g+ update last night):

1280x720 (720p) - works fine.
1920x1080 (1080p) - blank screen/no detected signal.
1280x1024 - blank screen/no detected signal.
1366x768 - works.
1024x768 - works.
800x600 - blank screen/no detected signal.
720x576 (576p) - speckles, the occasional line, and blanks.
848x480 - blank screen/no detected signal.
720x480 (480p) - speckles, the occasional line, and blanks.
640x480 - blank screen/no detected signal/occasional picture with speckles.

So there's a whole bunch of problems here - quite a lot of resolutions
just don't work.  Many reasons.

One of them is the settings for two registers on the HDMI Phy.
You and Fabio have these settings in your patch(es) - you do it in
different ways but the resulting settings are the same:

+    if (mode->clock <= 148500) {
+        imx_hdmi_phy_i2c_write(hdmi, 0x0210, HDMI_PHY_VLEVCTRL);
+        imx_hdmi_phy_i2c_write(hdmi, 0x8009, HDMI_PHY_CKSYMTXCTRL);
+    } else {
+        imx_hdmi_phy_i2c_write(hdmi, 0x0129, HDMI_PHY_VLEVCTRL);
+        imx_hdmi_phy_i2c_write(hdmi, 0x800b, HDMI_PHY_CKSYMTXCTRL);
+    }

This doesn't work reliably for me, and differs from the FSL 4.1.0 BSP,
which does work for me:

+       hdmi_phy_i2c_write(hdmi, 0x800d, 0x09);  /* CKSYMTXCTRL */
+       hdmi_phy_i2c_write(hdmi, 0x01ad, 0x0E);  /* VLEVCTRL */

This stops the 576p and 480p modes from blanking, although the speckles
are still there.  So, using the freescale settings results in a marginal
improvement - and actually means that when I put a 'scope on the lines,
the behaviour doesn't change.  That tells me the settings both you and
Fabio are suggesting seem to be borderline.


Now, what did 'scoping the TMDS clock tell me.  Well, I have a photograph
of the TMDS clock at the non-working 800x600 resolution:

  http://www.home.arm.linux.org.uk/~rmk/imx/IMG_1545-adj.JPG

and they say a picture paints a thousand words.  Essentially, the TMDS
clock is being frequency modulated.

If I load up a LVDS output on the same IPU output as the HDMI, and give
it the same EDID as on the HDMI, and then do this to X (from working
720p to non-working 800x600):

# xrandr --output LVDS1 --off --output HDMI1 --mode 800x600

That results in the TV blanking and the modulation on the TMDS clock
line.  Incidentally, the TMDS clock is a little over 40.01MHz.  Follow
that with:

# xrandr --output HDMI1 --off --output LVDS1 --mode 800x600

and the TV unblanks, says it has 800x600 and the picture looks fine.
The TMDS clock looks clean, and it's running at 39.997MHz.  Go back
to the HDMI1 output:

# xrandr --output LVDS1 --off --output HDMI1 --mode 800x600

and the picture goes again and the TMDS clock is again unstable, and
at the slightly higher frequency.

Note: This is only possible because of other bugs in the HDMI output
driver - it doesn't _actually_ shut down the output when told to by
DRM, but leaves it mostly programmed as it was, only clearing two
bits which are to do with low power mode (PDZ and ENTMDS in the
HDMI_PHY_CONF0 register).  These don't actually shut down the output
at all!  Put a scope on the output to prove it to yourself!

I've dumped out all the HDMI registers.  Very little changes between
these two (only the PHY_CONF0 and a couple of registers in the Phy
change to do with reading back the impedance of the lines.)  So it's
not a HDMI or a HDMI phy problem.

What's more interesting is the DI0 clocking mode changes between
these two: with HDMI1 selected, the IPU is used as the clock for
the DI.  With LVDS, the DI0 "external" clock is used instead.

Great, or so I thought.  Let's try using the same DI0 external clock
for HDMI.  Now, what happens is slightly strange.  With just
IPU_DI_CLKMODE_EXT set, our initial mode works fine, but others
don't because the clock doesn't get set - unless we go via selecting
LVDS1 output mode first.

With IPU_DI_CLKMODE_EXT and IPU_DI_CLKMODE_SYNC set, things become
loads worse - switching resolutions loses display and returning back
to the working one also fails until the next reboot.

Now, I notice that the FSL 4.1.0 stuff appears to try and decide
which of the two clock inputs to use for the DI module, something
which isn't done in the driver in staging.  Also there's the commented
out stuff:

#ifdef WTF_IS_THIS
        /*
         * Freescale has this in their Kernel. It is neither clear what
         * it does nor why it does it
         */
        if (div & 0x10)
                div &= ~0x7;
        else {
                /* Round up divider if it gets us closer to desired pix clk */
                if ((div & 0xC) == 0xC) {
                        div += 0x10;
                        div &= ~0xF;
                }
        }
#endif

Quite simply, the "div" value is as follows:

bits 11:4 - integer divider
bits  3:0 - fractional part

So, what this is saying is that for any _odd_ integer divider, we want
to either divide by the odd divider, or odd.5 - but no other fractional
values.  Otherwise, if the divider is an even integer divider, and the
fractional part is greater than .75, we want to round that up.  (It may
also be that the final div & ~0xf should be outside that second if
statement.)

It could be that the fractional divider is broken and doesn't work
correctly with the values that this is trying to avoid.

That would explain the apparant modulation on the TMDS clock (normally
such fractional dividers work by skipping clock pulses, which would
then explain why the MPLL slews back and forth in a fairly regular
manner.)

If you're doing scan-out, you *really* don't want a pulse-skipping
fractional divider anywhere in the chain.

Well,@for the time being, I'm giving up with HDMI on the IMX - it's
far too broken for it to be sensibly used, and the IPU stuff in the
manual just lacks far too much information to be able to debug this
stuff properly.  I fear that this hardware is a victim of its own
immense complexity.
