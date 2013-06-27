From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jun 2013 16:16:40 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a73a4: add Z2 clock support
In-Reply-To: <1371798638-10530-5-git-send-email-g.liakhovetski@gmx.de>
References: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
 <1371798638-10530-5-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130627071640.GB25014@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 09:10:38AM +0200, Guennadi Liakhovetski wrote:
> The Z2 clock on r8a73a4 is used to clock the 4 Cortex A7 cores on the SoC.
> Add a definition for this clock to later use it from the arm_big_little
> CPUFreq driver.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.12 in the soc branch.

> ---
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
> index 508cb1e..b717e98 100644
> --- a/arch/arm/mach-shmobile/clock-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
> @@ -324,6 +324,21 @@ static struct clk z_clk = {
>  	.ops = &zclk_ops,
>  };
>  
> +/*
> + * It seems only 1/2 divider is usable in manual mode. 1/2 / 2/3
> + * switching is only available in auto-DVFS mode
> + */
> +SH_FIXED_RATIO_CLK(pll0_div2_clk,	pll0_clk,		div2);
> +
> +static struct clk z2_clk = {
> +	.parent = &pll0_div2_clk,
> +	.div_mask = 0x1f,
> +	.enable_bit = 0,
> +	/* We'll need to access FRQCRB and FRQCRC */
> +	.enable_reg = (void __iomem *)FRQCRB,
> +	.ops = &zclk_ops,
> +};
> +
>  static struct clk *main_clks[] = {
>  	&extalr_clk,
>  	&extal1_clk,
> @@ -342,6 +357,8 @@ static struct clk *main_clks[] = {
>  	&pll2s_clk,
>  	&pll2h_clk,
>  	&z_clk,
> +	&pll0_div2_clk,
> +	&z2_clk,
>  };
>  
>  /* DIV4 */
> -- 
> 1.7.2.5
> 
