From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 15:55:41 +0800
Subject: [PATCH 19/33] ARM i.MX: prepare for common clock framework
In-Reply-To: <20120427071622.GP17184@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-20-git-send-email-s.hauer@pengutronix.de>
 <20120427064007.GM2234@S2101-09.ap.freescale.net>
 <20120427071622.GP17184@pengutronix.de>
Message-ID: <20120427075539.GS2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 09:16:22AM +0200, Sascha Hauer wrote:
> On Fri, Apr 27, 2012 at 02:40:09PM +0800, Shawn Guo wrote:
> > On Wed, Apr 25, 2012 at 05:28:09PM +0200, Sascha Hauer wrote:
> > > - Add necessary #ifdefs for CONFIG_COMMON_CLOCK
> > > - Add a global spinlock to protect the CCM registers
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > > +
> > > +static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
> > > +		u8 shift, u8 width, const char **parents, int num_parents)
> > > +{
> > > +	return clk_register_mux(NULL, name, parents, num_parents, 0, reg, shift,
> > 
> > I think the fourth parameter should be CLK_SET_RATE_PARENT too, as mux
> > could also likely be in a clk_set_rate propagation path, saying it has
> > a parent clk who has .round_rate and .set_rate operations.
> 
> Nope, we can't do this. When we do this every clock_set_rate on a leaf
> node will propagate up to the ipg, ahb, main_clk, plls and whatever is
> up there.

PLL does not have CLK_SET_RATE_PARENT set, right?

What's the problem with that propagation?  Isn't it designed so?  Now
on imx6q, 792MHz is a set point for cpu frequency, we have to propagate
up to pll's set_rate to get that frequency.  There is a mux in the
middle of the propagation path.  If we do not set CLK_SET_RATE_PARENT
for mux, how can we get this frequency?

Regards,
Shawn

> 
> I made the assumption that we can safely propagate up to the next mux
> but not further. It may turn out that this is to simple and needs
> adjustments, but generally adding a CLK_SET_RATE_PARENT to a mux won't
> work.
> 
