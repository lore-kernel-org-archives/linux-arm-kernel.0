From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 4 Oct 2017 14:18:20 -0700
Subject: [PATCH v2 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <CACPK8XeHj2xdw6HgkWRDiJPjurip3wVbkOmY0mGW=dSTVWsYmg@mail.gmail.com>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-4-joel@jms.id.au>
 <20171002212435.GP457@codeaurora.org>
 <CACPK8XeHj2xdw6HgkWRDiJPjurip3wVbkOmY0mGW=dSTVWsYmg@mail.gmail.com>
Message-ID: <20171004211820.GX457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03, Joel Stanley wrote:
> On Tue, Oct 3, 2017 at 6:54 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 09/21, Joel Stanley wrote:
> >> @@ -160,6 +191,104 @@ static struct clk_hw *aspeed_calc_pll(const char *name, u32 val)
> >> +     /*
> >> +      * Memory controller (M-PLL) PLL. This clock is configured by the
> >> +      * bootloader, and is exposed to Linux as a read-only clock rate.
> >> +      */
> >> +     regmap_read(map, ASPEED_MPLL_PARAM, &val);
> >> +     aspeed_clk_data->hws[ASPEED_CLK_MPLL] = aspeed_calc_pll("mpll", val);
> >> +
> >> +     /* SD/SDIO clock divider (TODO: There's a gate too) */
> >> +     hw = clk_hw_register_divider_table(NULL, "sdio", "hpll", 0,
> >
> > Please pass your dev pointer here from the platform device.
> >
> >> +                     scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
> >> +                     div_table,
> >> +                     &aspeed_clk_lock);
> >
> > And check for errors? Perhaps use devm_clk_hw_regsiter() APIs and
> > construct the dividers and muxes directly instead of using the
> > basic type registration APIs.
> 
> Do you think that devm_ is overkill, given we will never unload this driver?

Is probe defer going to happen? Even if unload can't happen,
probe defer is a concern unless that is also ruled out.

> 
> Can you explain why you suggest to construct the structures directly
> instead of using the APIs?

There aren't devm APIs for some of these basic clk type
registration functions.

> 
> I had a read of the basic type registration functions, and the
> relevant failure paths are memory allocation failures. If we're out of
> memory that early in boot then things have gone pretty bad.
> 
> I can add checks for null and bail out; I don't think there's value in
> freeing the allocated memory: if a system can't load it's clock driver
> then it's super hosed.

If we can't proceed without this driver because it's super hosed,
then perhaps we need to panic the system on errors here. Should
be simple enough to add some error checks and goto panic("Things
are super hosed").

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
