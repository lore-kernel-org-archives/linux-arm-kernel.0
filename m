From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 19:49:19 +0000 (UTC)
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jan 2014, Tomi Valkeinen wrote:

> omap2_dpll_round_rate() doesn't actually round the given rate, even if
> the name and the description so hints. Instead it only tries to find an
> exact rate match, or if that fails, return ~0 as an error.

In the past, we had "rate tolerance" code, which allowed the clock code to 
return an approximate rate within some margin.  See for example commit 
241d3a8dca239610d3d991bf58d4fe38c2d86fd5 ("OMAP2+: clock: remove the DPLL 
rate tolerance code").  The rate tolerance was set at compile-time, but it 
was set on a per-PLL basis, which in theory allowed PLLs responsible for 
audio, etc. to have a very low rate tolerance, but PLLs that only drove 
internal functional blocks to have a high rate tolerance.  

Part of the reason why this was removed is because some of the TI hardware 
guys didn't want any PLL rates used that were not explicitly 
characterized.

> What this basically means is that the user of the clock needs to know
> what rates the dpll can support, which obviously isn't right.

In principle I agree with you, but I'm not sure that this rate rounding 
function is the solution.

> This patch adds a simple method of rounding: during the iteration, the 
> code keeps track of the closest rate match. If no exact match is found, 
> the closest is returned.

So that's one possible rounding policy; maybe it works fine for a display 
interface PLL, at least for some values of "closest rate".  But another 
might be "only allow a selection from a set of pre-determined rates 
characterized by the silicon validation team".  Or another rounding 
function might need to select a more distant rate that minimizes jitter, 
EMI, or power consumption.  

Seems to me that there needs to be some way for a clock user to 
communicate its requirements along these lines to the clock framework for 
use by the rate rounding code.  At the very least, some kind of [min, max] 
interval seems appropriate.

Also I've often thought that it would be useful for your purposes to be 
able to query a clock to return a list or some other parametric 
description of the rates that it can provide. 


- Paul
