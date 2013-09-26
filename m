From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 26 Sep 2013 12:12:41 -0300
Subject: [PATCH 1/5] clk: mvebu: Add core-divider clock
In-Reply-To: <20130926082404.GA18244@lunn.ch>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost> <20130926082404.GA18244@lunn.ch>
Message-ID: <20130926151240.GB4583@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 10:24:04AM +0200, Andrew Lunn wrote:
> Hi Ezequiel
> 
> > +static int clk_corediv_enable(struct clk_hw *hwclk)
> > +{
> > +	struct clk_corediv *corediv = to_corediv_clk(hwclk);
> > +	struct clk_corediv_desc *desc = &corediv->desc;
> > +	u32 reg;
> > +
> > +	reg = readl(corediv->reg);
> > +	reg |= (BIT(desc->fieldbit) << CORE_CLOCK_DIVIDER_ENABLE_OFFSET);
> > +	writel(reg, corediv->reg);
> > +	return 0;
> > +}
> 
> Shouldn't there be spinlocks around these register accesses? At least
> the core gate clk driver has a spinlock.
> 

Indeed.

> > +static long clk_corediv_round_rate(struct clk_hw *hwclk, unsigned long rate,
> > +	     				          unsigned long *parent_rate)
> > +{
> > +	/* Valid ratio are 1:4, 1:5, 1:6 and 1:8 */
> > +	u32 div;
> > +
> > +	div = *parent_rate / rate;
> > +	if (div <= 4)
> > +	   div = 4;
> > +	   else if (div <= 5)
> > +	   	div = 5;
> > +		else if (div <= 6)
> > +		     div = 6;
> > +		     else
> > +			div = 8;
> > +
> > +	return *parent_rate / div;
> > +}
> 
> This looks odd. Is not the following clearer?
> 
> 	div = *parent_rate / rate;
> 	if (div < 5)
> 	   div = 4;
> 	   else if (div > 6)
> 		div = 8;
> 
> The CodingStyle might require some {} here?
> 

Mmmm... no, it's not at all clearer to me.
IMHO, the original construction explicitly show the possible ratios:

	/* If it's smaller than or equal to 4, set to 4 */
	if (div <= 4)
		div = 4;

	/* Otherwise, if it's between 4 and 5, set to 5 */
	else if (div <= 5)
	 	div = 5;

	/* Otherwise, if it's between 5 and 6, set to 6 */
	else if (div <= 6)
		div = 6;

	/* Otherwise, if it's bigger than 6, set to 8 */
	else
		div = 8;

(And I don't think we need any braces).

Is this not clear?

> +   /*
> +    * Wait for clocks to settle down, and then clear all the
> +     * ratios request and the reload request.
> +      */
> +      udelay(1000);
> +      reg &= ~(CORE_CLOCK_DIVIDER_RATIO_MASK | CORE_CLOCK_DIVIDER_RATIO_RELOAD);
> +      writel(reg, corediv->reg);
> +      udelay(1000);
> 
> 
> Documentation/timers/timers-howto.txt says: 
> 
>        SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
>        		* Use usleep_range
> 

Right, forgot about that as well...

Thanks for the feedback!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
