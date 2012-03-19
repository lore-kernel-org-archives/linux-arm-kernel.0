From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 19 Mar 2012 09:51:43 +0800
Subject: [PATCH 1/2] ARM: imx6q: add pll round_rate support
In-Reply-To: <20120317122831.GD29317@pengutronix.de>
References: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
 <1331713379-8437-2-git-send-email-richard.zhao@linaro.org>
 <20120314085228.GM3852@pengutronix.de>
 <20120315144601.GA5701@richard-laptop>
 <20120315150048.GC3852@pengutronix.de>
 <20120315151521.GB5701@richard-laptop>
 <20120315185004.GD3852@pengutronix.de>
 <20120316011006.GA17459@b20223-02.ap.freescale.net>
 <20120317122831.GD29317@pengutronix.de>
Message-ID: <20120319015142.GA2603@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 01:28:31PM +0100, Sascha Hauer wrote:
> On Fri, Mar 16, 2012 at 09:10:07AM +0800, Richard Zhao wrote:
> > Hi Sascha,
> > 
> > On Thu, Mar 15, 2012 at 07:50:04PM +0100, Sascha Hauer wrote:
> > > On Thu, Mar 15, 2012 at 11:15:23PM +0800, Richard Zhao wrote:
> > > > On Thu, Mar 15, 2012 at 04:00:48PM +0100, Sascha Hauer wrote:
> > > > > On Thu, Mar 15, 2012 at 10:46:04PM +0800, Richard Zhao wrote:
> > > > > > On Wed, Mar 14, 2012 at 09:52:28AM +0100, Sascha Hauer wrote:
> > > > > > > On Wed, Mar 14, 2012 at 04:22:58PM +0800, Richard Zhao wrote:
> > > > > > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > > > > > ---
> > > > > > > >  
> > > > > > > >  #define DEF_PLL(name)					\
> > > > > > > >  	static struct clk name = {			\
> > > > > > > > @@ -681,6 +741,7 @@ static int pll_set_rate(struct clk *clk, unsigned long rate)
> > > > > > > >  		.disable	= pll_disable,		\
> > > > > > > >  		.get_rate	= name##_get_rate,	\
> > > > > > > >  		.set_rate	= name##_set_rate,	\
> > > > > > > > +		.round_rate	= name##_round_rate,	\
> > > > > > > 
> > > > > > > I hope this ## stuff is gone soon with the generic clock framework. It
> > > > > > > is so ugly and inefficient.
> > > > > > I hope this doesn't prevent this two patches go in.
> > > > > 
> > > > > Given that we are short from getting a generic clock framework (and I
> > > > > think this time it's for real) and that you are not mention in any words
> > > > > what these patches fix I don't see a reason for merging them.
> > > > I think the cpu clock is a great challenge for generic clock framework.
> > > > When it set_rate, it includes reparent, and change parent's parent's rate.
> > > > I don't see any upstream code like that till now. and it's really what
> > > > we need.
> > > 
> > > Then do a clk_set_parent, clk_set_rate and a clk_set_parent again
> > > in your cpufreq driver.
> > No, it's platform code, and supposed to be in arch/arm. What the cpufre
> > driver know is to get cpu clk, rather not how cpu clk change its rate.
> > And cpu clk/arm_clk is a real clock wires in SoC.
> 
> The job of the clock framework is to give a consistent view on the
> clocks and to handle parent/rate changes properly. It even the
> CLK_SET_RATE_GATE for ensuring that your PLL can only change its rate
> when it's gated. It's not the job of the clock framework to dynamically
> reorganize the clock tree on a rate change.
The reparent in set_rate is in mutex lock. Looks like, we only need
the unlocked version clk functions.
> 
> Besides, do you really want to reprogram the PLL with a cpufreq change?
> You have a divider behind that PLL which you apparently can change
> without having to reparent the PLL. Doesn't this give you enough choices
> for the cpu frequency?
No. The 3bit cpu divider is not enough. For example, if pll is 1G Hz, the
next lower freq will be 500M, which is a too large step.
> 
> > > The notifying mechanism even allows you to
> > > block any concurrent change in between these three steps if necessary.
> > > Noone says that these three steps have to be encapsulated in a single
> > > clk_set_rate call like you did in your patch.
> > If you're reviwing the patch, why not take a step advance? :)
> 
> I have prepared the patches for converting i.MX1/21/25/27 and I have
> (older) patches for the i.MX31/51/53 which I want to rebase on the
> current clock framework. 
You might notice I ever sent out serveral versions of MX5x clock porting
patches based on your first version. If you want to take it over, it's ok.
> That gives me enough to do until the next merge
> window. Additionally I'm not yet very familiar with the i.MX6.
So, Shawn, would you review it and consider the tricky things when
migrate to new framework?

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
> 
