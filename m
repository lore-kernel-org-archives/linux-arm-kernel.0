From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 26 Feb 2014 13:42:50 +0200
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
Message-ID: <530DD33A.20005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/14 21:49, Paul Walmsley wrote:
> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
> 
>> omap2_dpll_round_rate() doesn't actually round the given rate, even if
>> the name and the description so hints. Instead it only tries to find an
>> exact rate match, or if that fails, return ~0 as an error.
> 
> In the past, we had "rate tolerance" code, which allowed the clock code to 
> return an approximate rate within some margin.  See for example commit 
> 241d3a8dca239610d3d991bf58d4fe38c2d86fd5 ("OMAP2+: clock: remove the DPLL 
> rate tolerance code").  The rate tolerance was set at compile-time, but it 
> was set on a per-PLL basis, which in theory allowed PLLs responsible for 
> audio, etc. to have a very low rate tolerance, but PLLs that only drove 
> internal functional blocks to have a high rate tolerance.  
> 
> Part of the reason why this was removed is because some of the TI hardware 
> guys didn't want any PLL rates used that were not explicitly 
> characterized.

Ok.

>> What this basically means is that the user of the clock needs to know
>> what rates the dpll can support, which obviously isn't right.
> 
> In principle I agree with you, but I'm not sure that this rate rounding 
> function is the solution.
> 
>> This patch adds a simple method of rounding: during the iteration, the 
>> code keeps track of the closest rate match. If no exact match is found, 
>> the closest is returned.
> 
> So that's one possible rounding policy; maybe it works fine for a display 
> interface PLL, at least for some values of "closest rate".  But another 
> might be "only allow a selection from a set of pre-determined rates 
> characterized by the silicon validation team".  Or another rounding 
> function might need to select a more distant rate that minimizes jitter, 
> EMI, or power consumption.  
> 
> Seems to me that there needs to be some way for a clock user to 
> communicate its requirements along these lines to the clock framework for 
> use by the rate rounding code.  At the very least, some kind of [min, max] 
> interval seems appropriate.
> 
> Also I've often thought that it would be useful for your purposes to be 
> able to query a clock to return a list or some other parametric 
> description of the rates that it can provide.

I fully agree with all you said above.

However, I'm not trying to fix the omap clock framework here =). I just
want the displays to work properly in mainline kernel.

So, presuming this was merged, and gets display working, how would it
affect other users compared to the current state? The patched version
returns the same rate than before, if an exact match is found. Rounded
rate is only returned as a last option, instead of an error.

Do we have drivers that handle that error somehow, and then do something
(what?) to get some other rate?

If the clock path in question also has a divider component after the
pll, using clk-divider.c (which I guess is used in all/most of the
DPLLs?), things would go badly wrong if there's an error, as
clk-divider.c doesn't handle it.

So I can make no guarantees, but I have a hunch that all current users
ask for an exact clock, in which case this patch doesn't change their
behavior, except for display which it fixes.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/dd0551dd/attachment-0001.sig>
