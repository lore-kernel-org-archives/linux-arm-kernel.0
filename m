From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jun 2010 15:14:18 +0100
Subject: [PATCH 2/6] U6715 clocks gating management U6 clock generic
	driver & U6715 cgu clock specific (V2)
In-Reply-To: <1274948852-9179-3-git-send-email-philippe.langlais@stericsson.com>
References: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
	<1274948852-9179-3-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100624141418.GB6523@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:27:28AM +0200, Philippe Langlais wrote:
> +#if defined(DEBUG_CGU)
> +#define debug(fmt, args...)                                          \
> +	printk(PKMOD fmt, ## args)
> +#else
> +#define debug(fmt, args...)
> +#endif

pr_debug?
> +
> +/**
> + * U6 hw low level access clock functions
> + **/
> +static void u6_clk_disable(struct clk *clk);
> +static int u6_clk_enable(struct clk *clk);
> +
> +/**
> + * HW enable clock function.
> + **/
> +
> +static int u67xx_cgu_enable_fake_clock(struct clk *clk)
> +{
> +	debug("u67xx_cgu_enable_fake_clock for %s\n", clk->name);
> +	return 0;
> +}
> +
> +static int u67xx_cgu_enable_hw_clock(struct clk *clk)
> +{
> +	unsigned long value;
> +	debug("u67xx_cgu_enable_hw_clock for %s\n", clk->name);
> +
> +	if (unlikely(clk->enable_reg == 0)) {

These are pointers.  0 is an integer.  Use NULL.  Check your code with
sparse and you'll get warnings for these things.

> +/*** Basic clocks ***/
> +
> +/* Base external input clocks */
> +static struct clk func_32k_ck = {
> +	.name = "func_32k_ck",
> +	.rate = 32000,
> +	.flags = RATE_FIXED | ALWAYS_ENABLED,
> +	.usecount = 1,
> +};

Don't put data definitions in header files.

> +static struct clk *onchip_clks[] = {
> +	/* external root sources */
> +	&func_32k_ck,
> +	&osc_ck,
> +	&sys_ck,
> +	&sc_ck,
> +	&fix_ck,
> +	&tv_ck,
> +#ifndef U6_OPTIMIZED_TREE
> +	&dsp2_ck,
> +#endif
> +	&sdm_ck,
> +	&arm_ck,
> +	&hclk_ck,
> +	&hclk2_ck,
> +	&pclk1_ck,
> +	&pclk2_ck,
> +	&tvclk_ck,

This all looks very much like it was copied from the OMAP code as of about
a year ago.  The OMAP code has moved forwards with lots of improvements,
including using clkdev to eliminate the disgusting SoC specific code from
drivers (which clkdev is there to prevent.)
