From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 8 Jan 2010 12:35:36 +1100
Subject: [RFC, PATCH 6/7] arm/icst307: use common struct clk,
	unify realview and versatile clocks
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089619@mi8nycmail19.Mi8.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<1262907852.738282.3449449719.6.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089619@mi8nycmail19.Mi8.com>
Message-ID: <201001081235.36976.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

> > +unsigned long clk_icst307_get_rate(struct clk *clk)
> > +{
> > +	return to_clk_icst307(clk)->rate;
> > +}
> > +
> > +long clk_icst307_round_rate(struct clk *clk, unsigned long rate)
> 
> I think the return value here should be 'unsigned long'

linux/clk.h defines clk_round_rate as returning 'long'.

> Could struct icst307_vco be part of struct clk_icst307?
> 
> If so, clk_icst307_set_rate could use clk_icst307_round_rate like this:
> 
> int clk_icst307_set_rate(struct clk *clk, unsigned long rate)
> {
> 	struct clk_icst307 *v_clk = to_clk_icst307(clk);
> 
> 	v_clk->rate = clk_icst307_round_rate(clk, rate);
> 	v_clk->setvco(v_clk);
> 
> 	return 0;
> }

If struct icst307_vco were a member of clk_icst307, then we'd only be using it 
to pass a value between two functions; it's not really a property of the clock 
itself.

But yes, set_rate should use round_rate, I'll update that.

Cheers,


Jeremy
