From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 11:58:16 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
Message-ID: <20120502095816.GG20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 10:58:56PM -0700, Saravana Kannan wrote:
> Create a struct clk_init_data to hold all data that needs to be passed from
> the platfrom specific driver to the common clock framework during clock
> registration. Add a pointer to this struct inside clk_hw.
> 
> This has several advantages:
> * Completely hides struct clk from many clock platform drivers and static
>   clock initialization code that don't care for static initialization of
>   the struct clks.
> * For platforms that want to do complete static initialization, it removed
>   the need to directly mess with the struct clk's fields while still
>   allowing to statically allocate struct clk. This keeps the code more
>   future proof even if they include clk-private.h.
> * Simplifies the generic clk_register() function and allows adding optional
>   fields in the future without modifying the function signature.
> * Simplifies the static initialization of clocks on all platforms by
>   removing the need for forward delcarations or convoluted macros.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergman <arnd.bergmann@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Richard Zhao <richard.zhao@linaro.org>
> Cc: Saravana Kannan <skannan@codeaurora.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Deepak Saxena <dsaxena@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/clk/clk-divider.c    |   14 +++--
>  drivers/clk/clk-fixed-rate.c |   14 +++--
>  drivers/clk/clk-gate.c       |   15 +++--
>  drivers/clk/clk-mux.c        |   10 +++-
>  drivers/clk/clk.c            |   91 +++++++++++++++++++------------
>  include/linux/clk-private.h  |  121 +-----------------------------------------
>  include/linux/clk-provider.h |   59 +++++++++++++-------
>  7 files changed, 129 insertions(+), 195 deletions(-)
> 
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 6e58f11..8e97491 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>  {
>  	struct clk_mux *mux;
>  	struct clk *clk;
> +	struct clk_init_data init;
>  
>  	/* allocate the mux */
>  	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
> @@ -103,6 +104,12 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	init.name = name;
> +	init.ops = &clk_mux_ops;
> +	init.flags = flags;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +
>  	/* struct clk_mux assignments */
>  	mux->reg = reg;
>  	mux->shift = shift;
> @@ -110,8 +117,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>  	mux->flags = clk_mux_flags;
>  	mux->lock = lock;

There is a mux->hw.init = &init missing here.

Sascha

>  
> -	clk = clk_register(dev, name, &clk_mux_ops, &mux->hw,
> -			parent_names, num_parents, flags);
> +	clk = clk_register(dev, &mux->hw);
>  
>  	if (IS_ERR(clk))
>  		kfree(mux);

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
