From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jul 2016 11:48:52 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
Message-ID: <20160721094852.GI5993@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:38:54PM +0200, Ond?ej Jirman wrote:
> On 15.7.2016 10:53, Maxime Ripard wrote:
> > On Fri, Jul 01, 2016 at 02:50:57AM +0200, Ond?ej Jirman wrote:
> >>>>  /**
> >>>> + * sun8i_h3_apply_pll1_factors() - applies n, k, m, p factors to the
> >>>> + * register using an algorithm that tries to reserve the PLL lock
> >>>> + */
> >>>> +
> >>>> +static void sun8i_h3_apply_pll1_factors(struct clk_factors *factors, struct factors_request *req)
> >>>> +{
> >>>> +	const struct clk_factors_config *config = factors->config;
> >>>> +	u32 reg;
> >>>> +
> >>>> +	/* Fetch the register value */
> >>>> +	reg = readl(factors->reg);
> >>>> +
> >>>> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) < req->p) {
> >>>> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
> >>>> +
> >>>> +		writel(reg, factors->reg);
> >>>> +		__delay(2000);
> >>>> +	}
> >>>
> >>> So there was some doubts about the fact that P was being used, or at
> >>> least that it was useful.
> >>
> >> p is necessary to reduce frequencies below 288 MHz according to the
> >> datasheet.
> > 
> > Yes, but you could reach those frequencies without P, too, and it's
> > not part of any OPP provided by Allwinner.
> 
> The arisc firmware for H3 contains table of factors for frequences from
> 0 to 2GHz and, P is used below 240MHz. M is never used, BTW. (other
> datasheets specify M as for testing use only, whatever that means - not
> H3, but it seems it's the same PLL block)

Interesting. Which SoCs in particular?

> >>>> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) < req->m) {
> >>>> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
> >>>> +
> >>>> +		writel(reg, factors->reg);
> >>>> +		__delay(2000);
> >>>> +	}
> >>>> +
> >>>> +	reg = FACTOR_SET(config->nshift, config->nwidth, reg, req->n);
> >>>> +	reg = FACTOR_SET(config->kshift, config->kwidth, reg, req->k);
> >>>> +
> >>>> +	writel(reg, factors->reg);
> >>>> +	__delay(20);
> >>>> +
> >>>> +	while (!(readl(factors->reg) & (1 << config->lock)));
> >>>
> >>> So, they are applying the dividers first, and then applying the
> >>> multipliers, and then wait for the PLL to stabilize.
> >>
> >> Not exactly, first we are increasing dividers if the new dividers are
> >> higher that that what's already set. This ensures that because
> >> application of dividers is immediate by the design of the PLL, the
> >> application of multipliers isn't. So the VCO would still run at the same
> >> frequency for a while gradually rising to a new value for example,
> >> while the dividers would be reduced immediately. Leading to crash.
> >>
> >> PLL
> >> --------------------------
> >> PRE DIV(f0) -> VCO(f1) -> POST DIV(f2)
> >>    P             K,N           M
> >>
> >> Example: (we set all factors at once, reducing dividers and multipliers
> >> at the same time at 0ms - this should lead to no change in the output
> >> frequency, but...)
> >>
> >> -1ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz
> >>  0ms: f0 = 24MHz, f1 = 2GHz,   f2 = 2GHz       - boom
> >>  1ms: f0 = 24MHz, f1 = 1.5GHz, f2 = 1.5GHz
> >>  2ms: f0 = 24MHz, f1 = 1GHz,   f2 = 1GHz
> >>
> >> The current code crashes exactly at boom, you don't get any more
> >> instructions to execute.
> >>
> >> See.
> >>
> >> So this patch first increases dividers (only if necessary), changes
> >> multipliers and waits for change to happen (takes around 2000 cycles),
> >> and then decreases dividers (only if necessary).
> >>
> >> So we get:
> >>
> >> -1ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz
> >>  0ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz   - no boom, multiplier
> >>                                              reduced
> >>  1ms: f0 = 24MHz, f1 = 1.5GHz, f2 = 0.75GHz
> >> 1.9ms: f0 = 24MHz, f1 = 1GHz,   f2 = 0.5GHz - we got PLL sync
> >>  2ms: f0 = 24MHz, f1 = 1GHz,   f2 = 1GHz   - and here we reduce divider
> >> at last
> > 
> > Awesome explanation, thanks!
> > 
> > So I guess it really all boils down to the fact that the CPU is
> > clocked way outside of it's operating frequency while the PLL
> > stabilizes, right?
> 
> It may be, depending on the factors before and after change. I haven't
> tested what factors the mainline kernel calculates for each frequency.
> The arisc never uses M, and only uses P at frequencies that would not
> allow for this behavior.
> 
> I created a test program for arisc that runs a loop on the main CPU
> using msgbox to send pings to the arisc CPU, and the vary the PLL1
> randomly from the arisc, and haven't been able to lockup the main CPU
> yet with either method.
> 
> There's also AXI clock, that depends on PLL1. Arisc firmware uses the
> same method to change it while changing CPUX clock. If the clock would
> rise above certain frequency, AXI divider is increased before the PLL1
> change. If it would fall below certain frequency it is decreased after
> the PLL1 change.

If we ever need to change that, we can always rely on a clock notifier
to adjust the divider before the change happen (and support all the
scenarios, like the clock change has been aborted).

> > If so, then yes, trying to switch to the 24MHz oscillator before
> > applying the factors, and then switching back when the PLL is stable
> > would be a nice solution.
> > 
> > I just checked, and all the SoCs we've had so far have that
> > possibility, so if it works, for now, I'd like to stick to that.
> 
> It would need to be tested. U-boot does the change only once, while the
> kernel would be doing it all the time and between various frequencies
> and PLL settings. So the issues may show up with this solution too.

That would have the benefit of being quite easy to document, not be a
huge amount of code and it would work on all the CPUs PLLs we have so
far, so still, a pretty big win. If it doesn't, of course, we don't
really have the choice.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/de014597/attachment.sig>
