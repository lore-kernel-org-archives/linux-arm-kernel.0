From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 11 Apr 2015 03:32:55 +0200
Subject: [PATCH 3/4] clk: add CLK_DEFER_ORPHAN flag to prevent orphans
 from being used
In-Reply-To: <5528705B.3040102@codeaurora.org>
References: <1427988853-9549-1-git-send-email-heiko@sntech.de>
 <1427988853-9549-4-git-send-email-heiko@sntech.de>
 <5528705B.3040102@codeaurora.org>
Message-ID: <2590765.DXLmcCCmf5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 10. April 2015, 17:52:43 schrieb Stephen Boyd:
> On 04/02/15 08:34, Heiko Stuebner wrote:
> > The usage of clocks derived from an orphan can produce issues when trying
> > to set rates etc. So ideally a clk_get to such a clock should defer till
> > the clock hierarchy is complete.
> > But as some arches probably rely on such clocks we can't disable them all.
> > Therefore add a new clk flag where arches can enable this behaviour for
> > their clocks.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/clk/clk.c            | 6 ++++++
> >  include/linux/clk-provider.h | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 476f491..8511c62 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3041,6 +3041,12 @@ struct clk *__of_clk_get_from_provider(struct
> > of_phandle_args *clkspec,> 
> >  		if (provider->node == clkspec->np)
> >  		
> >  			clk = provider->get(clkspec, provider->data);
> >  		
> >  		if (!IS_ERR(clk)) {
> > 
> > +			if ((__clk_get_flags(clk) & CLK_DEFER_ORPHAN)
> > +						&& clk_is_orphan(clk)) {
> > +				clk = ERR_PTR(-EPROBE_DEFER);
> > +				break;
> > +			}
> > +
> > 
> >  			clk = __clk_create_clk(__clk_get_hw(clk), dev_id,
> >  			
> >  					       con_id);
> > 
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 28abf1b..ef8d669 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -31,6 +31,7 @@
> > 
> >  #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
> >  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change
> >  */ #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk
> >  accuracy */> 
> > +#define CLK_DEFER_ORPHAN	BIT(9) /* defer clk_get calls for orphans */
> 
> I don't see why this is an opt-in feature. If we think there are arches
> that are setting rates of clocks before they're ready then we have a
> problem and we should fix it. These last two patches don't look necessary.

yep this is some sort of policy-decision ... I'm perfectly fine with changing 
the default behaviour from my Rockchip-pov but was reluctant to do this for 
everybody.

For example in the cited example in patch1, the clock from an i2c-device 
supplies a soc-clock and the soc-clock only gets enabled/disabled at this 
point. The i2c-device is default on, so everything works till it falls over 
when going to suspend. So I guess similar corner cases might exist on other 
platforms.

It might very well be better to change the behaviour and hope for little 
fallout to fix.

So, it looks like your on favour of preventing the usage of orphans 
altogether, so I'll try to come up with a better implementation taking into 
account your comments to patch2.


Thanks
Heiko
