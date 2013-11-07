From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Nov 2013 17:29:20 +0000
Subject: imx-drm: Add HDMI support
In-Reply-To: <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
 <20131030190123.GM16735@n2100.arm.linux.org.uk>
 <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
Message-ID: <20131107172920.GH16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 04:39:40PM -0600, Matt Sealey wrote:
> On Wed, Oct 30, 2013 at 2:01 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > That's where validating the modes you're prepared to support becomes
> > important, and there's hooks in DRM for doing that.
> 
> Nope! Not in the right place.

Sure it's the right place.  It's the connector which gets to read the
modes, and the connector is part of the DRM system.

> > If you can't support those with 148.5MHz dotclocks, then you have to return
> > MODE_CLOCK_HIGH from the connector's mode_valid callback.
> 
> Here's the problem; connectors and encoders are initialized under DRM
> before the display driver. For the connector to even KNOW what the
> highest valid clock is, it would need to ask the lower level display
> driver, since the connector and even encoder has no clue of this
> limitation and shouldn't be hardcoded, or even know what the input
> pixel clock capabilities are.

That's because the way imx-drm is setup with its multitude of individual
drivers is utter madness; there's no way that it will ever move out of
drivers/staging as long as it messes around violating the internals of
DRM by playing those kinds of games.  This was discussed at some
considerable length at kernel summit, with me as the main motivator for
it - including some private discussions with various people involved.

The DRM model is a card model, just like ALSA.  In this model, the
subsystem gets initialised once, and at that point all components of
the "card" are expected to be known.  The reverse is true when tearing
down a card: the whole card goes away in one go, individual components
do not.

What this means for DRM is that all CRTCs, connectors and encoders are
registered with DRM entirely within the card-level ->load callback,
and all of those are torn down at the ->unload callback.  Between those
two points in time, nothing in the configuration of the "card" ever
changes.

The same is true of ALSA: ALSA too does not support hotplugging
individual components.  This is why we have ASoC - ASoC handles the
grouping up of individual components, works out when all components
are available, and only then does it register the "card" with ALSA.
When any of those components go away, ASoC pulls the whole card from
ALSA.

As I say, this was discussed at kernel summit.  One thing was made
abundently clear: DRM is _not_ going to support hotplugging individual
components of a card.  Moreover, what has been made perfectly clear
is that imx-drm is not going to move out of drivers/staging as long
as it abuses DRM's card model.

> I already pointed the above out on the DRM list maybe 18 months ago,
> it's a big flaw in the DRM design, and the only way I can figure
> around it is to have the connector driver look for it's display
> controller in the device tree and read out the clocks from there, or
> just a property (max-tmds-clock?) which would hack around it,
> overriding a higher value from EDID.

No, not at all.  If you build up the set of components first, before
involving DRM, then you have the full information.  I'm doing that
today: the DRM "card" can only finish initialisation when all known
connectors can find their CRTCs within the DRM card.  If any CRTC
(== IPU DIs) specified in the DT file for a "connector" (eg, HDMI
interface, lvds bridge, etc) are not present, the DRM card doesn't
initialise.

Once you have that in place, you have a way to find out the properties
of the CRTC, and you then have a way to validate the modes properly
against all parts of the display system.

> True, and it looks a lot like the Freescale drivers now,

Not at all.  The Freescale drivers use the clk API as this did, and just
as badly.  I'm afraid that by making that comment, you've just shown that
you much prefer writing long verbose emails rather than actually reading
and understanding the subject for which you're responding.

I refer you to this:

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/ipu3/ipu_disp.c?h=imx_3.0.35_4.1.0#n155

which clearly shows Freescale's 4.1.0 BSP using the clk API to control
the DI clock mux.

When you look at the mess that using the clk API creates in the imx-drm
driver in staging:

static int clk_di_set_rate(struct clk_hw *hw, unsigned long rate,
                                unsigned long parent_rate)
{
        struct ipu_di *di = container_of(hw, struct ipu_di, clk_hw_out);
        int div;
        u32 clkgen0;

        clkgen0 = ipu_di_read(di, DI_BS_CLKGEN0) & ~0xfff;

        div = ipu_di_clk_calc_div(parent_rate, rate);

        ipu_di_write(di, clkgen0 | div, DI_BS_CLKGEN0);

int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
{
..
        ret = clk_set_rate(di->clk_di_pixel, round);
...
        div = ipu_di_read(di, DI_BS_CLKGEN0) & 0xfff;
        div = div / 16;         /* Now divider is integer portion */

        /* Setup pixel clock timing */
        /* Down time is half of period */
        ipu_di_write(di, (div << 16), DI_BS_CLKGEN1);

So, we call clk_set_rate(), that calls down to clk_di_set_rate() which
sets up the DI_BS_CLKGEN0 register.  We then have to read that register
layer in ipu_di_init_sync_panel() to get the divider to program the
duty cycle which we want generated.  Now, compare that to this, where
we choose which clock locally according to some rules set down by the
requirements of the attached display bridge, calculate the divider
required, and then:

        /* Set the divider */
        ipu_di_write(di, clkgen0, DI_BS_CLKGEN0);

        /*
         * Set the high/low periods.  Bits 24:16 give us the falling edge,
         * and bits 8:0 give the rising edge.  LSB is fraction, and is
         * based on the divider above.  We want a 50% duty cycle, so set
         * the falling edge to be half the divider.
         */
        ipu_di_write(di, (clkgen0 >> 4) << 16, DI_BS_CLKGEN1);

That's quite a bit simpler, and doesn't violate abstraction levels at
all.  And getting rid of this clk API crap where it's not required (a)
ends up with a better driver which actually _works_, and (b) results
in fewer lines of code:

 drivers/staging/imx-drm/ipu-v3/ipu-di.c |  328 ++++++++++---------------------
 1 files changed, 105 insertions(+), 223 deletions(-)

> but I do
> think creating a clockdev clock is probably the "correct" way to do
> it, especially since in debug situations you'd be able to see this -
> and it's value, and it's current parent - in sysfs along with the
> other clocks.

The clk API just gets in the way of making the correct decisions.
Really, it does.  We need to calculate the divider to work out what
is the right clock to use, or whether we can use a clock.  Having
that hidden behind the clk API does not give us the ability to make
that decision.

> It might also help to encourage people not to just play with internal
> clocks, but to create clock devices and use them inside their drivers

Drivers playing with their own _internal_ clocks is entirely reasonable,
and it's entirely reasonable that they need not be exposed to userspace.
Take for instance your average PC, it has lots of clocks, especially
on the video card, none of them exposed.  They've gotten away with that
for decades.  Why are we any different.

"Oh, we're embedded, we're special!" I hear you cry.  No we're not
special at all.

> I don't think I like that fractional dividers aren't used; until
> someone can come up with a great reason why not (except, I think odd
> fractions dividers are not stable, so it could be just masking off the
> bottom bit of the fraction is the key) and someone tests it on more
> than one monitor..

Why fractional dividers are bad news - this is the TMDS clock that
resulted from the DI being configured with a fractional divider:

http://www.home.arm.linux.org.uk/~rmk/cubox/IMG_1545-adj.JPG

No, that's not blur.  That's the result of a fractional divider before
the HDMI phy PLL.  The result is that the PLL is frequency modulated,
and the connected TV basically tells the IMX to "piss off".

It's not "odd fractions" that are a problem - I believe Freescale's
code is correct, the problem is that no one has _thought_ about what
this is doing:

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

I know what that's doing, it's not rocket science.  But if you have to
resort to using fractional dividers when you have another clock available
to generate a precise clock without the inherent instability caused by
fractional dividers, you might as well make use of it.

Moreover, I'm not the only one to run into _real_ problems with fractional
dividers - other people have too with the iMX stuff, and have also had to
disable these fractional dividers too.
