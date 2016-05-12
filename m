From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 May 2016 16:33:38 -0700
Subject: [PATCH 2/4] drvers/clk: Support fourth generation Aspeed SoCs
In-Reply-To: <CACPK8Xfq=Pfy=7GYuS7LJs-CFJOimBUoHA=Y6NHb4=DRcOnvfQ@mail.gmail.com>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
 <1462797111-14271-3-git-send-email-joel@jms.id.au>
 <20160509224953.GZ3492@codeaurora.org>
 <CACPK8Xfq=Pfy=7GYuS7LJs-CFJOimBUoHA=Y6NHb4=DRcOnvfQ@mail.gmail.com>
Message-ID: <20160512233338.GM3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10, Joel Stanley wrote:
> On Tue, May 10, 2016 at 8:19 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > Please write a proper clk driver that sets clkin to be the parent
> > of this clk registered here and then calculates the frequency
> > based on the parent clk rate and the strapping registers via the
> > recalc rate callback.
> 
> After a few goes I understood what you meant here.
> 
> Is the pclk part okay? I modified the pclk part use a fixed factor
> clock instead of the fixed clock, so I could drop the pclk_get_rate
> call below.

Sorry what's the pclk part? Using a fixed factor is OK, as long
as we don't have to call clk_get_rate() in this driver it's a
better design.

> 
> > Also please move this to a platform driver
> > instead of using CLK_OF_DECLARE assuming this isn't required for
> > any timers in the system.
> 
> Can you clarify here? We do use the rate of pclk (the apb clock) in
> the clocksource driver to calculate our count_per_tick value.

Ok. I was hoping that this wasn't providing any clks required in
the timer driver. Even if that's true, we could just register the
part of the clk tree that needs to be ready for the timer from
CLK_OF_DECLARE() and then register the other clks from a regular
platform driver. Some people have already started doing this, so
there are some examples around (clk/nxp/clk-lpc18xx-creg.c is one
example).

> > Following on Rob's comment, please combine this into one driver
> > instead of having different DT nodes for different clks that are
> > all really part of one clock controller hw block.
> 
> Ok, I have had a go at this. In our case the clock registers are part
> of the "SCU" IP; a collection of disparate functions that happen to
> include clock control. Is syscon the right thing to use here?
> 
> regmap = syscon_regmap_lookup_by_compatible("aspeed,ast2400-syscon-scu");
> ret = regmap_read(hpll->regmap, 0x70, &reg);
> 

In that case I don't have a problem with a toplevel MFD node in
DT with a child node for the clk part and a child node for other
logical driver parts. Or it could all be one MFD driver and node
that knows to add a clk device as a child of the MFD purely in
software so that we can fork control of the clk part over to the
drivers/clk directory. If you have the clk driver attach to some
child device then you can always get the regmap from the parent
MFD via the dev->parent pointer.

Maybe Rob can chime in here too with the proper design, because
I've seen both styles.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
