From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 8 Aug 2013 06:27:15 -0300
Subject: [PATCH 3/5] clocksource: armada-370-xp: Introduce new compatibles
In-Reply-To: <20130808075356.GC29815@lunn.ch>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1375919556-24104-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130808075356.GC29815@lunn.ch>
Message-ID: <20130808092714.GA2295@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 09:53:56AM +0200, Andrew Lunn wrote:
> On Wed, Aug 07, 2013 at 08:52:34PM -0300, Ezequiel Garcia wrote:
> > The Armada XP SoC clocksource driver cannot work without the 25 MHz
> > fixed timer. Therefore it's appropriate to introduce a new compatible
> > string and use it to set the 25 MHz fixed timer.
> > 
> > The 'marvell,timer-25MHz' property will be marked as deprecated.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/clocksource/time-armada-370-xp.c | 59 ++++++++++++++++++++++++--------
> >  1 file changed, 45 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> > index a2351ac..1458a85 100644
> > --- a/drivers/clocksource/time-armada-370-xp.c
> > +++ b/drivers/clocksource/time-armada-370-xp.c
> > @@ -212,7 +212,7 @@ static struct local_timer_ops armada_370_xp_local_timer_ops = {
> >  	.stop	=  armada_370_xp_timer_stop,
> >  };
> >  
> > -static void __init armada_370_xp_timer_init(struct device_node *np)
> > +static void __init armada_370_xp_timer_common_init(struct device_node *np)
> >  {
> >  	u32 clr = 0, set = 0;
> >  	int res;
> > @@ -221,21 +221,10 @@ static void __init armada_370_xp_timer_init(struct device_node *np)
> >  	WARN_ON(!timer_base);
> >  	local_base = of_iomap(np, 1);
> >  
> > -	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
> > -
> > -		/* The fixed 25MHz timer is available so let's use it */
> > +	if (timer25Mhz)
> >  		set = TIMER0_25MHZ;
> > -		timer_clk = 25000000;
> > -	} else {
> > -		unsigned long rate = 0;
> > -		struct clk *clk = of_clk_get(np, 0);
> > -		WARN_ON(IS_ERR(clk));
> > -		rate =  clk_get_rate(clk);
> > -		timer_clk = rate / TIMER_DIVIDER;
> > -
> > +	else
> >  		clr = TIMER0_25MHZ;
> > -		timer25Mhz = false;
> > -	}
> >  	local_timer_ctrl_clrset(clr, set);
> >  	timer_ctrl_clrset(clr, set);
> >  
> > @@ -289,5 +278,47 @@ static void __init armada_370_xp_timer_init(struct device_node *np)
> >  #endif
> >  	}
> >  }
> > +
> > +static void __init armada_370_xp_timer_init(struct device_node *np)
> > +{
> > +	if (of_find_property(np, "marvell,timer-25Mhz", NULL)) {
> > +		/* The fixed 25MHz timer is required */
> > +		timer_clk = 25000000;
> > +	} else {
> > +		unsigned long rate = 0;
> > +		struct clk *clk = of_clk_get(np, 0);
> > +		WARN_ON(IS_ERR(clk));
> > +		rate =  clk_get_rate(clk);
> > +		timer_clk = rate / TIMER_DIVIDER;
> > +		timer25Mhz = false;
> > +	}
> > +
> > +	armada_370_xp_timer_common_init(np);
> > +}
> >  CLOCKSOURCE_OF_DECLARE(armada_370_xp, "marvell,armada-370-xp-timer",
> >  		       armada_370_xp_timer_init);
> 
> Hi Ezequiel
> 
> I think it would be good to have a comment saying this compatibility
> string, and the marvell,timer-25Mhz is depreciated, and a short
> explanation why. Maybe sometime in the future we can even remove it,
> depending on the outcome of the DT stability discussions.
> 

Sure, I'll do that.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
