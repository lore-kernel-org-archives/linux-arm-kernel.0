From: fabio.giovagnini@aurion-tech.com (Fabio Giovagnini)
Date: Wed, 9 Feb 2011 07:58:17 +0100
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <1297233693.242725.820672531799.2.gpush@pororo>
References: <1297233693.242725.820672531799.2.gpush@pororo>
Message-ID: <201102090758.21020.fabio.giovagnini@aurion-tech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, guys,
is there a documentation about clk framework?
Or only to read the sources?

Thanks a lot, and best regards


On Wednesday 09 February 2011 07:41:33 Jeremy Kerr wrote:
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
> +
> +#define DEFINE_CLK_FIXED(name, r) \
> +	struct clk_fixed name = INIT_CLK_FIXED(name, r)
> +
>  #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
> 
>  /*
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
