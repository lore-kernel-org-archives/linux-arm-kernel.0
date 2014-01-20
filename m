From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jan 2014 21:12:07 +0000
Subject: [PATCH 5/5] clk: versatile: respect parent rate in ICST clock
In-Reply-To: <1390251332-6411-1-git-send-email-linus.walleij@linaro.org>
References: <1390251332-6411-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140120211207.GI15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 09:55:32PM +0100, Linus Walleij wrote:
> If the ICST clock has a parent, respect the rate of the parent
> when calculating the clock frequency. Alter const arguments
> as this involves modifying the ICST parameter struct, and do
> not define the reference clock on the Integrator as we have
> the reference clock from the device tree. Keep it everywhere
> else.

This is not what I'd call a good idea.

> @@ -84,6 +84,8 @@ static unsigned long icst_recalc_rate(struct clk_hw *hw,
>  	struct clk_icst *icst = to_icst(hw);
>  	struct icst_vco vco;
>  
> +	if (parent_rate)
> +		icst->params->ref = parent_rate;
...
> diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
> index 6d8b8e1a080a..a3edc0463517 100644
> --- a/drivers/clk/versatile/clk-impd1.c
> +++ b/drivers/clk/versatile/clk-impd1.c
> @@ -39,7 +39,7 @@ static struct impd1_clk impd1_clks[4];
>   * There are two VCO's on the IM-PD1
>   */
>  
> -static const struct icst_params impd1_vco1_params = {
> +static struct icst_params impd1_vco1_params = {
>  	.ref		= 24000000,	/* 24 MHz */
>  	.vco_max	= ICST525_VCO_MAX_3V,
>  	.vco_min	= ICST525_VCO_MIN,
> @@ -57,7 +57,7 @@ static const struct clk_icst_desc impd1_icst1_desc = {
>  	.lock_offset = IMPD1_LOCK,
>  };
>  
> -static const struct icst_params impd1_vco2_params = {
> +static struct icst_params impd1_vco2_params = {
>  	.ref		= 24000000,	/* 24 MHz */
>  	.vco_max	= ICST525_VCO_MAX_3V,
>  	.vco_min	= ICST525_VCO_MIN,

Right, so we end up writing directly into these _shared_ _statically_
_allocated_ structures.

> diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
> index c8b523117fb7..a1491590e028 100644
> --- a/drivers/clk/versatile/clk-realview.c
> +++ b/drivers/clk/versatile/clk-realview.c
> @@ -21,7 +21,7 @@
>   * Implementation of the ARM RealView clock trees.
>   */
>  
> -static const struct icst_params realview_oscvco_params = {
> +static struct icst_params realview_oscvco_params = {
>  	.ref		= 24000000,

And this one is shared by two different VCOs.  Thankfully, the only
reason this isn't a problem is because they're both sourced from a
24MHz clock.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
