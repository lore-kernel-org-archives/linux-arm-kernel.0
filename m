From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 10:09:53 +0200
Subject: [PATCH 19/33] ARM i.MX: prepare for common clock framework
In-Reply-To: <20120427075539.GS2234@S2101-09.ap.freescale.net>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-20-git-send-email-s.hauer@pengutronix.de>
 <20120427064007.GM2234@S2101-09.ap.freescale.net>
 <20120427071622.GP17184@pengutronix.de>
 <20120427075539.GS2234@S2101-09.ap.freescale.net>
Message-ID: <20120427080953.GX17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:55:41PM +0800, Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 09:16:22AM +0200, Sascha Hauer wrote:
> > On Fri, Apr 27, 2012 at 02:40:09PM +0800, Shawn Guo wrote:
> > > On Wed, Apr 25, 2012 at 05:28:09PM +0200, Sascha Hauer wrote:
> > > > - Add necessary #ifdefs for CONFIG_COMMON_CLOCK
> > > > - Add a global spinlock to protect the CCM registers
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > > +
> > > > +static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
> > > > +		u8 shift, u8 width, const char **parents, int num_parents)
> > > > +{
> > > > +	return clk_register_mux(NULL, name, parents, num_parents, 0, reg, shift,
> > > 
> > > I think the fourth parameter should be CLK_SET_RATE_PARENT too, as mux
> > > could also likely be in a clk_set_rate propagation path, saying it has
> > > a parent clk who has .round_rate and .set_rate operations.
> > 
> > Nope, we can't do this. When we do this every clock_set_rate on a leaf
> > node will propagate up to the ipg, ahb, main_clk, plls and whatever is
> > up there.
> 
> PLL does not have CLK_SET_RATE_PARENT set, right?
> 
> What's the problem with that propagation?  Isn't it designed so?  Now
> on imx6q, 792MHz is a set point for cpu frequency, we have to propagate
> up to pll's set_rate to get that frequency.  There is a mux in the
> middle of the propagation path.  If we do not set CLK_SET_RATE_PARENT
> for mux, how can we get this frequency?

We need a way to set the propagation flag on some muxes (maybe also a
way to not set it on some dividers or gates). As said, the assumption
that all dividers/gates can propagate whereas all muxes cannot propagate
may turn out to be too simple. You found one case where this is wrong,
I'm sure there are others.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
