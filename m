From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Dec 2010 13:14:13 +0100
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1291774094.270492.31002734529.2.gpush@pororo>
References: <1291774094.269634.503532219345.0.gpush@pororo>
	<1291774094.270492.31002734529.2.gpush@pororo>
Message-ID: <20101213121413.GA29833@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Wed, Dec 08, 2010 at 10:08:14AM +0800, Jeremy Kerr wrote:
> Since most platforms will need a fixed-rate clock, add one. This will
> also serve as a basic example of an implementation of struct clk.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  include/linux/clk.h |   13 +++++++++++++
>  kernel/clk.c        |   14 ++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index e09e40e..ae7e4ed 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -158,6 +158,19 @@ static inline void clk_common_init(struct clk *clk)
>  		mutex_init(&clk->lock.mutex);
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

Is there any other valid usecase for this other than

struct clk_fixed bla = INIT_CLK_FIXED(bla, rate);

Otherwise I suggest to convert the macro to:

#define INIT_CLK_FIXED(name, r) \
	struct clk_fixed name = { \
		.clk = INIT_CLK(name.clk, clk_fixed_ops), \
		.rate = (r) \
	}

This way we do not have to specify the same name twice (and it has
to be exactly the same name, otherwise it won't compile).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
