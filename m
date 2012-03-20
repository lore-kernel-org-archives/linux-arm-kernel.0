From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Mar 2012 08:19:57 +0100
Subject: [PATCH 1/2] clk: Fix error handling in fixed clock hardware type
 register fn
In-Reply-To: <1332214706-675-1-git-send-email-skannan@codeaurora.org>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
Message-ID: <20120320071957.GH3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 08:38:25PM -0700, Saravana Kannan wrote:
> If memory allocation for the parents array or the parent string fails, then
> fail the registration immediately instead of calling clk_register and
> hoping it fails there.
> 
> Return -ENOMEM on failure.
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
> There are still some memory free issues when clk_register() fails, but I will
> fix it when I fixed the other register() fns to return ENOMEM of alloc
> failure instead of a NULL.
> 
>  drivers/clk/clk-fixed-rate.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index 90c79fb..6423ae9 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -61,22 +61,26 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
>  		parent_names = kmalloc(sizeof(char *), GFP_KERNEL);
>  
>  		if (! parent_names)
> -			goto out;
> +			goto fail_ptr;
>  
>  		len = sizeof(char) * strlen(parent_name);
>  
>  		parent_names[0] = kmalloc(len, GFP_KERNEL);
>  
>  		if (!parent_names[0])
> -			goto out;
> +			goto fail_str;
>  
>  		strncpy(parent_names[0], parent_name, len);
>  	}

It's easier to add a char *parent to struct clk_fixed and pass it to
clk_register with &fixed->parent. This saves you a kmalloc call and
makes the error path simpler. It's the same way already done in the
divider.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
