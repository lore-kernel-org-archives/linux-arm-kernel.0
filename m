From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 11 Oct 2015 12:41:09 +0200
Subject: [PATCH 1/3] clk: add flag for clocks that need to be enabled on
 rate changes
In-Reply-To: <20151008215840.GJ26883@codeaurora.org>
References: <1929669.AsgMSusdJb@phil> <3137165.kmu68gRS44@diego>
 <20151008215840.GJ26883@codeaurora.org>
Message-ID: <13378907.1JCOSf8QGs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am Donnerstag, 8. Oktober 2015, 14:58:40 schrieb Stephen Boyd:
> On 10/02, Heiko St?bner wrote:
> > Hi,
> > 
> > any comment on these 3 patches?
> 
> Dong has a similar problem, but those patches conflate this with
> enabling parent clocks during clk_disable_unused() which makes no
> sense to me. So I'm ok with the requirement that we turn clocks
> on to change rates, but I wonder if in this case we need to turn
> on the clock that's changing rates itself, or if we just need to
> turn on the parent and/or future parent of the clock during the
> rate switch. Care to elaborate on that?

As you can see in the follow-up patches, the fractional dividers on Rockchip 
SoCs are quite strange in that they even need to have their _downstream_ mux 
point to them to actually accept rate changes.

The register value always reflects the value set by the system, but hardware 
really only accepts it if the clock is enabled and even the downstream mux 
selects the fractional divider as parent (they call it a auto-gating feature).

So in the worst (and current) case, you end up with the register showing the 
right value, but the hardware can use completely different dividers from the 
previous setting.

That strange behaviour got quite deeply investigated between Rockchip and 
Google engineers who stumbled upon this in the first place, so I'm reasonably 
sure this is the right solution for that clock type :-) .


Heiko
