From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 22 Dec 2017 13:36:31 +1100
Subject: [PATCH v6 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <20171221233927.GE7997@codeaurora.org>
References: <20171128071908.12279-1-joel@jms.id.au>
 <20171128071908.12279-5-joel@jms.id.au>
 <20171221233927.GE7997@codeaurora.org>
Message-ID: <1513910191.2743.77.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-21 at 15:39 -0800, Stephen Boyd wrote:
> On 11/28, Joel Stanley wrote:
> > diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> > index 839243691b26..b5dc3e298693 100644
> > --- a/drivers/clk/clk-aspeed.c
> > +++ b/drivers/clk/clk-aspeed.c
> > @@ -202,6 +202,107 @@ static const struct aspeed_clk_soc_data ast2400_data = {
> >        .calc_pll = aspeed_ast2400_calc_pll,
> >   };
> >   
> > +static int aspeed_clk_enable(struct clk_hw *hw)
> > +{
> > +     struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> > +     unsigned long flags;
> > +     u32 clk = BIT(gate->clock_idx);
> > +     u32 rst = BIT(gate->reset_idx);
> > +
> > +     spin_lock_irqsave(gate->lock, flags);
> > +
> > +     if (gate->reset_idx >= 0) {
> > +             /* Put IP in reset */
> > +             regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, rst);
> > +
> > +             /* Delay 100us */
> > +             udelay(100);
> > +     }
> > +
> > +     /* Enable clock */
> > +     regmap_update_bits(gate->map, ASPEED_CLK_STOP_CTRL, clk, 0);
> > +
> > +     if (gate->reset_idx >= 0) {
> > +             /* Delay 10ms */
> > +             /* TODO: can we sleep here? */
> > +             msleep(10);
> 
> No you can't sleep here. It needs to delay because this is inside
> spinlock_irqsave.

Additionally you really don't want to delay for 10ms with interrupts
off :-(

Sadly, it looks like the clk framework already calls you with spinlock
irqsafe, which is a rather major suckage.

Stephen, why is that so ? That pretty much makes it impossible to
do sleeping things, which prevents things like i2c based clock
controllers etc...

I think the clk framework needs to be overhauled to use sleeping
mutexes instead. Doing clock enable/disable at interrupt time is
a bad idea anyway.


In the meantime, Joel, you have little choice but do an mdelay
though that really sucks.

> > +             /* Take IP out of reset */
> > +             regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, 0);
> > +     }
> > +
> > +     spin_unlock_irqrestore(gate->lock, flags);
> > +
> > +     return 0;
> > +}
