From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 7 Jul 2010 11:00:13 +0300
Subject: [PATCH] mx25: set GPT clock source to PER
In-Reply-To: <20100706073314.GJ26079@pengutronix.de>
References: <20100704084343.GB19559@jasper.tkos.co.il>
	<40bc9462f125233cc9c63631a9b987ed684b6d97.1278233166.git.baruch@tkos.co.il>
	<20100705082123.GD26079@pengutronix.de>
	<20100706063511.GB28547@jasper.tkos.co.il>
	<20100706073314.GJ26079@pengutronix.de>
Message-ID: <20100707080012.GE24774@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jul 06, 2010 at 09:33:14AM +0200, Sascha Hauer wrote:
> On Tue, Jul 06, 2010 at 09:35:11AM +0300, Baruch Siach wrote:
> > On Mon, Jul 05, 2010 at 10:21:23AM +0200, Sascha Hauer wrote:
> > > On Sun, Jul 04, 2010 at 11:47:29AM +0300, Baruch Siach wrote:
> > > > This fixes time accounting on mx25 base systems.
> > > > 
> > > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > > ---
> > > >  arch/arm/plat-mxc/time.c |    3 ++-
> > > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> > > > index f9a1b05..0d7e0f9 100644
> > > > --- a/arch/arm/plat-mxc/time.c
> > > > +++ b/arch/arm/plat-mxc/time.c
> > > > @@ -56,6 +56,7 @@
> > > >  /* MX31, MX35, MX25, MXC91231, MX5 */
> > > >  #define V2_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
> > > >  #define V2_TCTL_CLK_IPG		(1 << 6)
> > > > +#define V2_TCTL_CLK_PER		(2 << 6)
> > > >  #define V2_TCTL_FRR		(1 << 9)
> > > >  #define V2_IR			0x0c
> > > >  #define V2_TSTAT		0x08
> > > > @@ -308,7 +309,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
> > > >  	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
> > > >  
> > > >  	if (timer_is_v2())
> > > > -		tctl_val = V2_TCTL_CLK_IPG | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
> > > > +		tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
> > > >  	else
> > > >  		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
> > > > 
> > > 
> > > I wonder why I applied
> > > 
> > > commit faed40665d2d81b7e0e537d14ef680ab3da9f22d
> > > Author: Baruch Siach <baruch@tkos.co.il>
> > > Date:   Mon Jan 25 12:58:21 2010 +0200
> > > 
> > >     mx25: fix time accounting
> > >     
> > >     The gpt_clk rate function doesn't consider the PER divider. This causes a
> > >     significant drift in time accounting. Fix this by introducing the correct rate
> > >     calculation function.
> > >     
> > >     Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > >     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> > > index 08aaa38..c003ac4 100644
> > > --- a/arch/arm/mach-mx25/clock.c
> > > +++ b/arch/arm/mach-mx25/clock.c
> > > @@ -119,6 +119,11 @@ static unsigned long get_rate_nfc(struct clk *clk)
> > >  	return get_rate_per(8);
> > >  }
> > >  
> > > +static unsigned long get_rate_gpt(struct clk *clk)
> > > +{
> > > +	return get_rate_per(5);
> > > +}
> > > +
> > >  static unsigned long get_rate_otg(struct clk *clk)
> > >  {
> > >  	return 48000000; /* FIXME */
> > > @@ -156,7 +161,7 @@ static void clk_cgcr_disable(struct clk *clk)
> > >  		.secondary	= s,			\
> > >  	}
> > >  
> > > -DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL, NULL);
> > > +DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
> > >  DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
> > >  DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
> > >  DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
> > > 
> > > This changed the gpt clock from ipg to the peripheral clock and I
> > > explained why this is wrong. Now of course we now must use the
> > > peripheral clock in the timer code.
> > > 
> > > Does it work when you revert faed40665d2d81b7e0e537d14ef680ab3da9f22d?
> > 
> > Reverting faed406 works on our target board, but breaks the i.MX25 PDK.
> > 
> > > In any case, we can't apply your patch because it would break other v2
> > > based architectures like i.MX35.
> > 
> > What do you suggest then?
> 
> Tell the timer code which clock to use with an argument to
> mxc_timer_init() and add the missing clocks to the clock.c file. You
> also have to pass this argument through from the board to
> mx25_clocks_init(). That's a lot of work and in the end we still do not
> know why some i.MX25 variants need the peripheral clock and others need
> the ipg clock. So what I really suggest is that you invest some
> research to find the source of this strangeness.

OK. I think I've nailed it down. The CCM MCR register was initialized 
differently.  

On the PDK I use the factory installed RedBoot bootloader. RedBoot leaves the 
PER CLK MUX field at its default state, that is, MCR[15:0] = 0.

On our target board I use a port of Barebox based on the built-in PDK support.  
The board_init_lowlevel routine of the PDK platform code includes the 
following line:

    writel(0x0000FEFF, IMX_CCM_BASE + MX25_CCM_MCR)

This makes MCR[15:0] = 0xfeff. Commenting out this line makes both boards 
behave the same way. The timer clock runs correctly with or without setting 
the V2_TCTL_CLK_PER bit.  Reverting faed406, however, breaks both boards.

So, I thing we should keep faed406. You may also consider applying this patch 
setting V2_TCTL_CLK_PER, For the reason Rob Herring has stated.

baruch

> Some things that could help you are:
> 
> - the clko pin
> - Do both boards have identical i.MX25 tapeout versions?
> - Are the clocks initialized identically?
> 
> I bricked my i.MX25 PDK so unfortunately I do not have any hardware to
> do some tests myself.

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
