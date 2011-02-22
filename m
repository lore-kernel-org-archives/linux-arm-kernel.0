From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 21:17:25 +0100
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <1298256658.862188.178150188637.1.gpush@pororo>
References: <1298256658.861611.43913489619.0.gpush@pororo>
	<1298256658.862188.178150188637.1.gpush@pororo>
Message-ID: <20110222201725.GF22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Mon, Feb 21, 2011 at 10:50:58AM +0800, Jeremy Kerr wrote:
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1d37f42..604be74 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -11,18 +12,168 @@
> ...
> +#ifdef CONFIG_USE_COMMON_STRUCT_CLK
> ...
> +#else /* !CONFIG_USE_COMMON_STRUCT_CLK */
>  
>  /*
> - * struct clk - an machine class defined object / cookie.
> + * Global clock object, actual structure is declared per-machine
>   */
>  struct clk;
>  
> +static inline void clk_common_init(struct clk *clk) { }
> +
> +/*
> + * For !CONFIG_USE_COMMON_STRUCT_CLK, we don't enforce any atomicity
> + * requirements for clk_enable/clk_disable, so the prepare and unprepare
> + * functions are no-ops
> + */
> +int clk_prepare(struct clk *clk) { return 0; }
> +void clk_unprepare(struct clk *clk) { }
these should be static inline.  Otherwise these functions end up in many
files and so provoke a build failure.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
