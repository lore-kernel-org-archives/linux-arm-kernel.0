From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Mar 2011 01:16:16 +0100
Subject: [PATCH v3 3/9] lpc2k: clk API
In-Reply-To: <1300653009-11675-4-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300653009-11675-4-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <083DF309106F364B939360100EC290F80B15C9C579@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ithamar,

> +#define clk_readl(a)	\
> +	ioread32(APB_SCB_BASE + (a))
> +#define clk_writel(v, a)	\
> +	iowrite32(v, APB_SCB_BASE + (a))
> +
> +struct clk {
> +	int		refcount;
> +	struct clk	*parent;
> +	unsigned long	rate;

It looks like this rate field is only used in 3 clock
descriptors. It might save some space to get rid of this field
and associated code and have those 3 clocks just use functions
for get_rate() that return the direct value.

> +
> +static unsigned long pclkdiv[] = { 4, 1, 2, 8 };
> +
> +#define PERCLK(name, pnum)	\
> +	static unsigned long name ## _get_rate(struct clk *clk) \
> +	{	\
> +		unsigned long rate = clk_get_rate(clk->parent);	\
> +		u32 val = clk_readl((pnum < 16) ? PCLKSEL0 : PCLKSEL1); \
> +		val >>= (pnum < 16) ? pnum * 2 : (pnum - 16) * 2;	\
> +		return rate / pclkdiv[val & 3];	\
> +	}	\
> +	struct clk clk_ ## name = {	\
> +		.parent = &clk_cpu,	\
> +		.enable_mask = (1 << pnum),	\
> +		.get_rate = name ## _get_rate,	\
> +	}
> +

This macro will generate multiple functions with different names but the same
code. Can the function be made common to the supported clocks and the macro
just handle clock descriptor setup?

> +PERCLK(timer0, 1);
> +PERCLK(timer1, 2);
