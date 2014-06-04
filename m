From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 4 Jun 2014 09:25:53 +0300
Subject: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
In-Reply-To: <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
 <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com>
 <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com>
 <20140531000207.10062.55946@quantum>
 <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
Message-ID: <538EBBF1.7040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/14 22:35, Paul Walmsley wrote:

> What's really needed is better control over rounding in the clock code.  

Well, if you ask me, what's really needed _now_ is to fix the bug that
makes am3xxx (and am4xxx when it's merged) display not to work. I don't
need a fix that solves all the clock set_rate/round issues once and for
all, I just want to get the display working.

> Both the driver API should be improved; and, to the extent that clock 
> sources share the same underlying code implementation, probably some clock 
> source configuration data enhancement is needed (DT or whatever).
> 
> Furthermore, clk_set_rate() should never silently round a requested rate - 
> it should just return an error if it can't satisfy the requested rate 
> precisely.  Silently rounding a rate is racy, and, if we care about 
> drivers behaving consistently across different integration environments, 
> prone to behavior that the driver may not expect.
> 
> Frankly, a DT "ti,round-rate" property is risible.  I certainly understand 
> why you don't like it and I don't know why that specific property was 
> proposed.  The issue has never been whether clk_round_rate() should round 

I created the property for the v2 because (if I recall right) you were
worried that fixing the rounding bug unconditionally could break some
drivers, and suggested that it should be used only for DSS.

> rates.  Of course it should.  The more pertinent question is, *how* should 
> it round the rate?  A more reasonable DT property approach would be to 
> specify how the clock's rate should be rounded: to the closest rate, to 
> the closest rate equal to or less than the desired rate, to the closest 
> rate greater than or equal to the desired rate; what the tolerance of the 
> "closest rate" should be, etc.  But drivers, e.g. many drivers that 
> control external I/O, should always be able to state that they want an 
> exact rate.
> 
> ...
> 
> In terms of the short-term thing to do, I'm currently thinking that the 
> thing to do is to modify the PLL set_rate() code in mach-omap2/ to not 
> round the rate at all, and then switch the PLL rate rounding code to 
> equal-or-closest-lesser-rate, with something like the oldhardcoded rate 
> tolerances.  That should push the responsibility out to the drivers to 
> control how they want the rounding to happen.  Then the drivers should be 
> able to probe available rates with repeated calls to clk_round_rate() if 
> they want, and if people get unhappy with that, then it might drive 
> rounding improvements in the clock API.

I agree, the current clock rounding is rather undefined, and I need to
do my own calculations in omapdss to "probe" the clock rates.

> But all this won't happen in -rc8; this is 3.16 material..
> 
> 
>> We can always see how it goes and fix it up afterwards when everything 
>> explodes.
> 
> No thanks... that's what leads to these kinds of messes :-( 

I don't understand how this fix would lead to a mess.

1. AM3xxx/AM4xxx display is broken
2. The PLL round function is broken, it doesn't round
3. The fix to omap2_dpll_round_rate has been in TI's kernel for a long
time, no problems observed
4. We've ran test runs with linux-next + the fix, no problems observed

I agree that there's a possibility that some driver could break with the
fix. I think it's a theoretical possibility, because clk-divider.c (I
think there's always a divider after the pll in omaps) doesn't handle
the error from the dpll code, so I don't really see how a driver could
manage to handle the error as the error is not conveyed to the driver.

In any case, if a driver breaks because of the fix, the driver's clock
handling is totally broken in any case, and it should be fixed.

Do we want to keep an important subsystem totally broken because there's
a theoretical possibility that the fix could break something else?

The fix was first posted in January. And we're still discussing about
it. And I still don't understand why the fix could cause problems. So
if the patch (v1 preferably) cannot be applied to 3.15, I'd very much
like to hear how it makes the situation worse, either for the current
kernel or for any future changes to the drivers/clock code.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/ff93366d/attachment.sig>
