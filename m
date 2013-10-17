From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Oct 2013 21:35:45 +0100
Subject: imx-drm: Add HDMI support
In-Reply-To: <1382039535.976669051@f130.i.mail.ru>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
Message-ID: <20131017203545.GV25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 11:52:15PM +0400, Alexander Shiyan wrote:
> > > Little bit late to the party, but here is the patch for the latest  
> > > version of the HDMI driver I was working on. Having had a quick flick  
> > > through the mailing list I see Russell has noticed a few of the problems  
> > > I had earlier on, which are resolved in my later work. Thought this  
> > > might be useful to help you tidy things up.
> ...
> > Now, I notice that the FSL 4.1.0 stuff appears to try and decide
> > which of the two clock inputs to use for the DI module, something
> > which isn't done in the driver in staging.  Also there's the commented
> > out stuff:
> > 
> > #ifdef WTF_IS_THIS
> >         /*
> >          * Freescale has this in their Kernel. It is neither clear what
> >          * it does nor why it does it
> >          */
> >         if (div & 0x10)
> >                 div &= ~0x7;
> >         else {
> >                 /* Round up divider if it gets us closer to desired pix clk */
> >                 if ((div & 0xC) == 0xC) {
> >                         div += 0x10;
> >                         div &= ~0xF;
> >                 }
> >         }
> > #endif
> > 
> > Quite simply, the "div" value is as follows:
> > 
> > bits 11:4 - integer divider
> > bits  3:0 - fractional part
> > 
> > So, what this is saying is that for any _odd_ integer divider, we want
> > to either divide by the odd divider, or odd.5 - but no other fractional
> > values.  Otherwise, if the divider is an even integer divider, and the
> > fractional part is greater than .75, we want to round that up.  (It may
> > also be that the final div & ~0xf should be outside that second if
> > statement.)
> > 
> > It could be that the fractional divider is broken and doesn't work
> > correctly with the values that this is trying to avoid.
> 
> This problem has been described by me, but solution hung in the air:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/176424.html

There's a whinge I've got to have here about the clk API code in here,
and the use of the clk API.  It's broken.

Let's start at the beginning.  What does "clk_set_rate()" and
"clk_round_rate()" do?  Well, clk_set_rate() sets the rate on the clock
to the value requested or a value close to that value appropriate to the
clock.  So, what does clk_round_rate() do?  clk_round_rate() tells you
what clock rate you _would_ get if you requested that rate via
clk_set_rate().

In other words:

	rounded_rate = clk_round_rate(clk, rate);

and

	clk_set_rate(clk, rate);
	rounded_rate = clk_get_rate(clk);

are exactly the same _except_ that the former doesn't have the side
effect of changing the actual clock itself.  So:

	rounded_rate = clk_round_rate(clk, rate);
	clk_set_rate(clk, rounded_rate);

is quite insane and wasteful.

--- end of whinge ---

Using your adjustements (which are basically):

        if (div & 0xf)
                div += 0x10;
        div &= ~15;

gives me working 1024x768, 800x600, and 640x480, (all @60, other
refreshes not checked) but nothing else.

I then thought about "round to nearest", which would be:

	if (div & 8)
		div += 8;
	div &= ~7;

but this gives me no difference from your version.  The plus point is
that with both of these, the result is a nice and clean display, with
no sign of any speckles or any other artifacts.

So, what happens if I re-enable the WTF_IS_THIS code?  Well:

1280x720p @ 60 works.
1280x720p @ 50 works.
1366x768 @ 59.8 works.
1024x768 @ 60 works.
800x600 @ 60.3 works.

1920x1080p @ 50 doesn't.
1920x1080p @ 60 doesn't.
1280x1024 @ 60 doesn't.
800x600 @ 56.2 doesn't.
720x576 @ 50 doesn't.
848x480 @ 60 doesn't.
720x480 @ 60 doesn't.
640x480 @ 60 doesn't.

What else does the FSL 4.1.0 code do?  Well, there's this:

	if (clk_get(NULL, "tve_clk") == di_parent ||
		clk_get(NULL, "ldb_di0_clk") == di_parent ||
		clk_get(NULL, "ldb_di1_clk") == di_parent) {
		/* if di clk parent is tve/ldb, then keep it;*/
		dev_dbg(ipu->dev, "use special clk parent\n");
		clk_set_parent(&ipu->pixel_clk[disp], ipu->di_clk[disp]);
	} else {
		/* try ipu clk first*/
		dev_dbg(ipu->dev, "try ipu internal clk\n");
		clk_set_parent(&ipu->pixel_clk[disp], ipu->ipu_clk);
		rounded_pixel_clk = clk_round_rate(&ipu->pixel_clk[disp], pixel_clk);
		/*
		 * we will only use 1/2 fraction for ipu clk,
		 * so if the clk rate is not fit, try ext clk.
		 */
		if (!sig.int_clk &&
			((rounded_pixel_clk >= pixel_clk + pixel_clk/200) ||
			(rounded_pixel_clk <= pixel_clk - pixel_clk/200))) {
			dev_dbg(ipu->dev, "try ipu ext di clk\n");
			rounded_pixel_clk = pixel_clk * 2;
			rounded_parent_clk = clk_round_rate(di_parent,
						rounded_pixel_clk);
			while (rounded_pixel_clk < rounded_parent_clk) {
				/* the max divider from parent to di is 8 */
				if (rounded_parent_clk / pixel_clk < 8)
					rounded_pixel_clk += pixel_clk * 2;
				else
					rounded_pixel_clk *= 2;
			}
			clk_set_rate(di_parent, rounded_pixel_clk);
			rounded_pixel_clk =
				clk_round_rate(ipu->di_clk[disp], pixel_clk);
			clk_set_rate(ipu->di_clk[disp], rounded_pixel_clk);
			clk_set_parent(&ipu->pixel_clk[disp], ipu->di_clk[disp]);
		}
	}
	rounded_pixel_clk = clk_round_rate(&ipu->pixel_clk[disp], pixel_clk);
	clk_set_rate(&ipu->pixel_clk[disp], rounded_pixel_clk);

which appears to be about selecting either the IPU clock or the DI
external clock.  (The comments are misleading btw.)  This is
unimplemented in imx-drm, and it just selects the IPU clock or the DI
clock depending on which "encoder" is being used.  For HDMI, that's IPU
clock only.  For LVDS and TVE, that's DI external clock only.
