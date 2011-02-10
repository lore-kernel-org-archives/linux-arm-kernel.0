From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 11 Feb 2011 12:23:56 +1300
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <1297233693.242725.820672531799.2.gpush@pororo>
References: <1297233693.242725.820672531799.2.gpush@pororo>
Message-ID: <4D54738C.80900@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2011 07:41 PM, Jeremy Kerr wrote:
> Since most platforms will need a fixed-rate clock, add one. This will
> also serve as a basic example of an implementation of struct clk.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  drivers/clk/clk.c   |   14 ++++++++++++++
>  include/linux/clk.h |   16 ++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c35478a..bbbdb0d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -124,3 +124,17 @@ void __clk_put(struct clk *clk)
>  	if (clk->ops->put)
>  		clk->ops->put(clk);
>  }
> +
> +/* clk_fixed support */
> +
> +#define to_clk_fixed(clk) (container_of(clk, struct clk_fixed, clk))
> +
> +static unsigned long clk_fixed_get_rate(struct clk *clk)
> +{
> +	return to_clk_fixed(clk)->rate;
> +}
> +
> +struct clk_ops clk_fixed_ops = {
> +	.get_rate = clk_fixed_get_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_fixed_ops);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index fe806b7..e67fdb0 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -185,6 +185,22 @@ static inline void clk_common_init(struct clk *clk)
>  	mutex_init(&clk->prepare_lock);
>  }
>  
> +/* Simple fixed-rate clock */
> +struct clk_fixed {
> +	struct clk	clk;
> +	unsigned long	rate;
> +};
> +
> +extern struct clk_ops clk_fixed_ops;
> +
> +#define INIT_CLK_FIXED(name, r) { \
> +	.clk = INIT_CLK(name.clk, clk_fixed_ops), \
> +	.rate = (r) \
> +}

A fixed clock may still have other operations such as enable/disable.
Maybe do something like this instead:

#define INIT_CLK_FIXED(name, ops, r) { 		\
	.clk = INIT_CLK(name.clk, ops, rate), 	\
	.clk.ops.get_rate = clk_fixed_get_rate, \
	.rate = (r),				\
}

That's untested though. I'm not sure if you can reliably assign
something twice in a struct initialiser?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
