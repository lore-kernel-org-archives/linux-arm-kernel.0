From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 15 Mar 2012 22:46:04 +0800
Subject: [PATCH 1/2] ARM: imx6q: add pll round_rate support
In-Reply-To: <20120314085228.GM3852@pengutronix.de>
References: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
 <1331713379-8437-2-git-send-email-richard.zhao@linaro.org>
 <20120314085228.GM3852@pengutronix.de>
Message-ID: <20120315144601.GA5701@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 09:52:28AM +0100, Sascha Hauer wrote:
> On Wed, Mar 14, 2012 at 04:22:58PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/mach-imx/clock-imx6q.c |   85 +++++++++++++++++++++++++++++++++-----
> >  1 files changed, 73 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
> > index e4e4f5e..3d5dc56 100644
> > --- a/arch/arm/mach-imx/clock-imx6q.c
> > +++ b/arch/arm/mach-imx/clock-imx6q.c
> > @@ -519,6 +519,18 @@ static int pll1_sys_set_rate(struct clk *clk, unsigned long rate)
> >  	return 0;
> >  }
> >  
> > +static unsigned long pll1_sys_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	u32 div;
> > +	unsigned long parent_rate = clk_get_rate(clk->parent);
> > +
> > +	rate = rate < FREQ_650M ? FREQ_650M : rate;
> > +	rate = rate > FREQ_1300M ? FREQ_1300M : rate;
> > +
> > +	div = rate * 2 / parent_rate;
> > +	return parent_rate * div / 2;
> > +}
> > +
> >  static unsigned long pll8_enet_get_rate(struct clk *clk)
> >  {
> >  	u32 div = (readl_relaxed(PLL8_ENET) & BM_PLL_ENET_DIV_SELECT) >>
> > @@ -567,6 +579,20 @@ static int pll8_enet_set_rate(struct clk *clk, unsigned long rate)
> >  	return 0;
> >  }
> >  
> > +static unsigned long pll8_enet_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	if (rate >= 125000000)
> > +		rate = 125000000;
> > +	else if (rate >= 100000000)
> > +		rate = 100000000;
> > +	else if (rate >= 50000000)
> > +		rate = 50000000;
> > +	else
> > +		rate = 25000000;
> > +	return rate;
> > +}
> > +
> > +
> >  static unsigned long pll_av_get_rate(struct clk *clk)
> >  {
> >  	void __iomem *reg = (clk == &pll4_audio) ? PLL4_AUDIO : PLL5_VIDEO;
> > @@ -606,6 +632,25 @@ static int pll_av_set_rate(struct clk *clk, unsigned long rate)
> >  	return 0;
> >  }
> >  
> > +static unsigned long pll_av_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	unsigned long parent_rate = clk_get_rate(clk->parent);
> > +	u32 div;
> > +	u32 mfn, mfd = 1000000;
> > +	s64 temp64;
> > +
> > +	rate = rate < FREQ_650M ? FREQ_650M : rate;
> > +	rate = rate > FREQ_1300M ? FREQ_1300M : rate;
> > +
> > +	div = rate / parent_rate;
> > +	temp64 = (u64) (parent_rate - (div * parent_rate));
> > +        temp64 *= mfd;
> > +        do_div(temp64, parent_rate);
> > +        mfn = temp64;
> > +
> > +        return (parent_rate * div) + ((parent_rate / mfd) * mfn);
> > +}
> > +
> >  static void __iomem *pll_get_div_reg_bit(struct clk *clk, u32 *bp, u32 *bm)
> >  {
> >  	void __iomem *reg;
> > @@ -662,18 +707,33 @@ static int pll_set_rate(struct clk *clk, unsigned long rate)
> >  	return 0;
> >  }
> >  
> > -#define pll2_bus_get_rate	pll_get_rate
> > -#define pll2_bus_set_rate	pll_set_rate
> > -#define pll3_usb_otg_get_rate	pll_get_rate
> > -#define pll3_usb_otg_set_rate	pll_set_rate
> > -#define pll7_usb_host_get_rate	pll_get_rate
> > -#define pll7_usb_host_set_rate	pll_set_rate
> > -#define pll4_audio_get_rate	pll_av_get_rate
> > -#define pll4_audio_set_rate	pll_av_set_rate
> > -#define pll5_video_get_rate	pll_av_get_rate
> > -#define pll5_video_set_rate	pll_av_set_rate
> > -#define pll6_mlb_get_rate	NULL
> > -#define pll6_mlb_set_rate	NULL
> > +static unsigned long pll_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	if (rate >= FREQ_528M)
> > +		rate = FREQ_528M;
> > +	else
> > +		rate = FREQ_480M;
> > +	return rate;
> > +}
> > +
> > +#define pll2_bus_get_rate		pll_get_rate
> > +#define pll2_bus_set_rate		pll_set_rate
> > +#define pll2_bus_round_rate		pll_round_rate
> > +#define pll3_usb_otg_get_rate		pll_get_rate
> > +#define pll3_usb_otg_set_rate		pll_set_rate
> > +#define pll3_usb_otg_round_rate		pll_round_rate
> > +#define pll7_usb_host_get_rate		pll_get_rate
> > +#define pll7_usb_host_set_rate		pll_set_rate
> > +#define pll7_usb_host_round_rate	pll_round_rate
> > +#define pll4_audio_get_rate		pll_av_get_rate
> > +#define pll4_audio_set_rate		pll_av_set_rate
> > +#define pll4_audio_round_rate		pll_av_round_rate
> > +#define pll5_video_get_rate		pll_av_get_rate
> > +#define pll5_video_set_rate		pll_av_set_rate
> > +#define pll5_video_round_rate		pll_av_round_rate
> > +#define pll6_mlb_get_rate		NULL
> > +#define pll6_mlb_set_rate		NULL
> > +#define pll6_mlb_round_rate		NULL
> >  
> >  #define DEF_PLL(name)					\
> >  	static struct clk name = {			\
> > @@ -681,6 +741,7 @@ static int pll_set_rate(struct clk *clk, unsigned long rate)
> >  		.disable	= pll_disable,		\
> >  		.get_rate	= name##_get_rate,	\
> >  		.set_rate	= name##_set_rate,	\
> > +		.round_rate	= name##_round_rate,	\
> 
> I hope this ## stuff is gone soon with the generic clock framework. It
> is so ugly and inefficient.
I hope this doesn't prevent this two patches go in.

Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
