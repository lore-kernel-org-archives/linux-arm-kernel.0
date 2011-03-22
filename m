From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Tue, 22 Mar 2011 02:13:26 +0100
Subject: [PATCH v3 3/9] lpc2k: clk API
In-Reply-To: <083DF309106F364B939360100EC290F80B15C9C579@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300653009-11675-4-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15C9C579@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300756406.2648.25.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-22 at 01:16 +0100, Kevin Wells wrote:
> > +struct clk {
> > +	int		refcount;
> > +	struct clk	*parent;
> > +	unsigned long	rate;
> 
> It looks like this rate field is only used in 3 clock
> descriptors. It might save some space to get rid of this field
> and associated code and have those 3 clocks just use functions
> for get_rate() that return the direct value.

Fair enough, I can update that....

> > +static unsigned long pclkdiv[] = { 4, 1, 2, 8 };
> > +
> > +#define PERCLK(name, pnum)	\
> > +	static unsigned long name ## _get_rate(struct clk *clk) \
> > +	{	\
> > +		unsigned long rate = clk_get_rate(clk->parent);	\
> > +		u32 val = clk_readl((pnum < 16) ? PCLKSEL0 : PCLKSEL1); \
> > +		val >>= (pnum < 16) ? pnum * 2 : (pnum - 16) * 2;	\
> > +		return rate / pclkdiv[val & 3];	\
> > +	}	\
> > +	struct clk clk_ ## name = {	\
> > +		.parent = &clk_cpu,	\
> > +		.enable_mask = (1 << pnum),	\
> > +		.get_rate = name ## _get_rate,	\
> > +	}
> > +
> 
> This macro will generate multiple functions with different names but the same
> code. Can the function be made common to the supported clocks and the macro
> just handle clock descriptor setup?

I could add a field to the clk struct to store it, since the peripheral
clock is the most common type of clk in the system, so it wouldn't waste
too much.

Regards,

Ithamar.
