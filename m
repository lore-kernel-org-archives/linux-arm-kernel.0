From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 22 Feb 2011 08:51:19 +1300
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1298256658.862488.956979497586.2.gpush@pororo>
References: <1298256658.862488.956979497586.2.gpush@pororo>
Message-ID: <4D62C237.1020803@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2011 03:50 PM, Jeremy Kerr wrote:
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
> index 0bc9c6f..0da0bb9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -130,3 +130,17 @@ void __clk_put(struct clk *clk)
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
> index 604be74..7c0808c 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -155,6 +155,22 @@ static inline void clk_common_init(struct clk *clk)
>  	mutex_init(&clk->prepare_lock);
>  }
>  
> +/* Simple fixed-rate clock */
> +struct clk_fixed {
> +	struct clk	clk;
> +	unsigned long	rate;

If we never need to dynamically create fixed clocks (which seems
unlikely) then rate can be const.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
