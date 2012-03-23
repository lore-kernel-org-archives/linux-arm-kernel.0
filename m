From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Mar 2012 09:42:06 +0100
Subject: [PATCH 1/8] clk: add a fixed factor clock
In-Reply-To: <1332488489.2876.8.camel@flow>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
 <1332164166-6055-2-git-send-email-s.hauer@pengutronix.de>
 <1332488489.2876.8.camel@flow>
Message-ID: <20120323084206.GK3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 08:41:29AM +0100, Philipp Zabel wrote:
> Am Montag, den 19.03.2012, 14:35 +0100 schrieb Sascha Hauer:
> > Having fixed factors/dividers in hardware is a common pattern, so
> > add a clock doing this. Currently no rate propagation is supported.
> 
> Also, could I convince you to move struct clk_fixed_factor into
> clk-provider.h and provide a DEFINE_CLK_FIXED_FACTOR macro to align with
> the other basic clocks?

Given that this is the current way to statically initialize clocks, yes
I'll integrate it, but not without grumbling about these macros in
general...

> 
> ---
>  drivers/clk/clk-fixed-factor.c |   15 +++++++++------
>  include/linux/clk-private.h    |   28 ++++++++++++++++++++++++++++
>  include/linux/clk-provider.h   |   19 +++++++++++++++++++
>  3 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index d99b842..8ca427a 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -12,12 +12,15 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  
> -struct clk_fixed_factor {
> -	struct clk_hw	hw;
> -	unsigned int	mult;
> -	unsigned int	div;
> -	char		*parent[1];
> -};
> +/*
> + * DOC: basic fixed multiplier and divider clock that cannot gate
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is fixed.  clk->rate = parent->rate / div * mult
> + * parent - fixed parent.  No clk_set_parent support
> + */
>  
>  #define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
>  
> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> index 5e4312b..9501eab 100644
> --- a/include/linux/clk-private.h
> +++ b/include/linux/clk-private.h
> @@ -170,6 +170,34 @@ extern struct clk_ops clk_mux_ops;
>  		.flags = _flags,				\
>  	};
>  
> +extern struct clk_ops clk_fixed_factor_ops;
> +
> +#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name,		\
> +				_parent_ptr, _flags,		\
> +				_mult, _div)			\
> +	static struct clk _name;				\
> +	static struct clk *_name##_parents[] = {		\
> +		_parent_ptr,					\
> +	};							\
> +	static struct clk_fixed_factor _name##_hw = {		\
> +		.hw = {						\
> +			.clk = &_name,				\
> +		},						\
> +		.mult = _mult,					\
> +		.div = _div,					\
> +		.parent[0] = _parent_name,			\
> +	};							\
> +	static struct clk _name = {				\
> +		.name = #_name,					\
> +		.ops = &clk_fixed_factor_ops,			\
> +		.hw = &_name##_hw.hw,				\
> +		.parent_names = _name##_hw.parent,		\
> +		.num_parents =					\
> +			ARRAY_SIZE(_name##_hw.parent),		\
> +		.parents = _name##_parents,			\
> +		.flags = _flags,				\
> +	};
> +
>  /**
>   * __clk_init - initialize the data structures in a struct clk
>   * @dev:	device initializing this clk, placeholder for now
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 21ca2f8..b58f846 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -257,6 +257,25 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>  		void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_mux_flags, spinlock_t *lock);
>  
> +/**
> + * struct clk_fixed_factor - fixed multiplier and divider clock
> + *
> + * @hw:         handle between common and hardware-specific interfaces
> + * @mult:	multiplier
> + * @div:        divider
> + *
> + * Clock with a fixed multiplier and divider. The output frequency is the
> + * parent clock rate divided by div and multiplied by mult.
> + * Implements .recalc_rate, .set_rate and .round_rate
> + */
> +
> +struct clk_fixed_factor {
> +        struct clk_hw   hw;
> +        unsigned int    mult;
> +        unsigned int    div;
> +        char            *parent[1];
> +};
> +
>  struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
>  		const char *parent_name, unsigned long flags,
>  		unsigned int mult, unsigned int div);
> -- 
> 1.7.9.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
