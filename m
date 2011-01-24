From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Jan 2011 08:27:31 +0100
Subject: [PATCH 1/3] ARM i.MX28: fix bit operation
In-Reply-To: <20110124092923.GB2625@S2100-06.ap.freescale.net>
References: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
	<1295607474-6559-2-git-send-email-s.hauer@pengutronix.de>
	<20110124092923.GB2625@S2100-06.ap.freescale.net>
Message-ID: <20110124072731.GH9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:29:28PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> On Fri, Jan 21, 2011 at 11:57:52AM +0100, Sascha Hauer wrote:
> > reg | (1 << clk->enable_shift) always evaluates to true. Switch it
> > to & which makes much more sense
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-mxs/clock-mx28.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > index 56312c0..4146b38 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -355,7 +355,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
> >  	} else {							\
> >  		reg &= ~BM_CLKCTRL_##dr##_DIV;				\
> >  		reg |= div << BP_CLKCTRL_##dr##_DIV;			\
> > -		if (reg | (1 << clk->enable_shift)) {			\
> > +		if (reg & (1 << clk->enable_shift)) {			\
> >  			pr_err("%s: clock is gated\n", __func__);	\
> >  			return -EINVAL;					\
> >  		}							\
> > -- 
> > 1.7.2.3
> > 
> > 
> Would you mind fixing the same issue in clock-mx23.c name##_set_rate()?
>

No, here it is:

8<---------------------------

[PATCH] ARM i.MX23: use correct register for setting the rate

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx23.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index b1a362e..7206924 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -304,7 +304,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 	reg &= ~BM_CLKCTRL_##dr##_DIV;					\
 	reg |= div << BP_CLKCTRL_##dr##_DIV;				\
-	if (reg | (1 << clk->enable_shift)) {				\
+	if (reg & (1 << clk->enable_shift)) {				\
 		pr_err("%s: clock is gated\n", __func__);		\
 		return -EINVAL;						\
 	}								\
-- 
1.7.2.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
