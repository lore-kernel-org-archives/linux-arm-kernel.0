From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 20 May 2015 15:59:35 +0800
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150520071152.GP24769@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150518184300.GB28888@pengutronix.de>
 <1432089611.13819.9.camel@mtksdaap41>
 <20150520071152.GP24769@pengutronix.de>
Message-ID: <1432108775.12796.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, 2015-05-20 at 09:11 +0200, Uwe Kleine-K?nig wrote:
> Hello Eddie,
> 
> On Wed, May 20, 2015 at 10:40:11AM +0800, Eddie Huang wrote:
> > On Mon, 2015-05-18 at 20:43 +0200, Uwe Kleine-K?nig wrote:
> > > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > > > +/* calculate i2c port speed */
> > > It would be nice to summarize the clock frequency settings here.
> > > Something like:
> > > 
> > > 	/*
> > > 	 * The input clock is divided by the value specified in the
> > > 	 * device tree as clock-div. The actual bus speed is then
> > > 	 * derived from this frequency by the following formula:
> > > 	 *  ....
> > > 
> > > This would make it possible to verify your calculations below.
> > 
> > The comment will be:
> > /*
> >  * khz: I2C bus clock
> >  * hclk: The input clock is divided by the value specified in the 
> >  *       device tree as clock-div
> and which one of the two clocks you're writing about is hclk now? I
> assume the divided one.
> >  * div = (sample_cnt + 1) * (step_cnt + 1)
> >  * khz = (hclk / 2) / div
> khz for the 2nd time.
> 
> >  *
> >  * The calculation is to get div value that let result of 
> >  * ((hclk / 2) / div) most approach and less than khz
> >  */
> I imagined something more hardware related. A list of register (or
> register bit fields) that influence the frequency and a formula

> 	i2c_freq = parent_clk / clock-div * (...)
> 
> (It seems to be a bit more complicated here as there are two registers
> involved that are set differently depending on the target frequency.)

Yes, hardware is a little complicated. I rewrite the comment:

/*
 * Calculate i2c port speed
 *
 * Hardware design:
 * i2c_bus_freq = parent_clk / (clock-div * 2 * (sample_cnt) *
(step_cnt))
 * clock-div: fixed in hardware, but may be various in different SoCs
 *
 * The calculation want to pick the highest bus frequency that is still 
 * less than or equal to i2c->speed_hz. and the calculation try to get 
 * sample_cnt and step_cnt to fill in hardware register.
 */

> 
> > > > +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_src_in_hz)
> clk_src_in_hz is the module's input rate already divided by clock-div.
> This clock-div value is fixed in hardware and unchangeable, right?
Yes

> Maybe give that divided clock a nice name?
I don't know, after new comment, maybe this name is ok.

> The target frequency is i2c->speed_hz, so among the possible frequencies
> we want to pick the highest one that is still less than or equal
> i2c->speed_hz, right?
Right.

> 
> > > > +		/* Set the hign speed mode register */
> I just notice s/hign/high/ here.
> 
Thanks, will fix it.

Eddie
