From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Jul 2010 19:29:18 +0900
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
In-Reply-To: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
References: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <027d01cb1f51$99a74780$ccf5d680$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
Hi,

Cc'ed Ben Dooks.

> This patch allows clk in init_clocks[] and init_clocks_disable[] to use
> clksrc_clk.clk in clksrcs[].
> 
> For example, clk "lcd" may need to set "sclk-fimd" as a parent if
> the div and src settting of sclk-fimd changes and a user of "lcd" wants
> to get the exact information about the rate. If "sclk-fimd" is set as a
> parent of "lcd", then the clk framework can provide the wanted
> information; otherwise, the change in "sclk-fimd" does not update "lcd"
> properly.
> 
I don't think so.

This can be problem because the parent clock of LCD(FIMD) is not always
SCLK_FIMD. And LCD block is on DSYS clock domain, so the parent clock of
'lcd' should be dsys clock, not sclk_fimd.
Basically used dsys bus clock as LCD IP clock and can be used sclk_fimd or
not. So should separate them and need to separate control.

As I still saying, the CLK_GATE_IP1[0] for LCD block can gate clock of
SCLK_ACLK and SCLK_FIMD which can be source of LCD block, and
CLK_SRC_MASK0[5] can gate only SCLK_FIMD, output clock of MUX FIMD.

> To do so, we have relocated clksrcs[] and put enum indexes to clksrcs in
> order to allow clk in init_clocks[] and init_clocks_disable[] may refer
> one of clksrcs[] as its parent. (enum clksrc_refer)
> 
> For example, "lcd" may set "sclk-fimd" as a parent if the following line
> replaces the line 878:
> 
> 		.parent		= &clk_hclk_dsys.clk,
> 
> to
> 
> 		.parent		= &clksrcs[_clksrc_sclk_fimd],
> 


> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |  986
++++++++++++++++++++++-------------------
>  1 files changed, 520 insertions(+), 466 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index aa2b1c5..e33c6ed 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -264,6 +264,526 @@ static struct clksrc_clk clk_sclk_vpll = {
>  	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
>  };
> 

And...hmm...maybe made this patch with wrong way...

> +static struct clk *clkset_uart_list[] = {
> +	[6] = &clk_mout_mpll.clk,
> +	[7] = &clk_mout_epll.clk,
> +};
> +

Following is from this patch...

-static struct clk *clkset_uart_list[] = {
-	[6] = &clk_mout_mpll.clk,
-	[7] = &clk_mout_epll.clk,
-};
-

Same? :-(
Why did you remove and add same code?

(snip)

And...see the below.

Added like below...

> +static struct clksrc_clk clksrcs[] = {
> +	[_clksrc_sclk_dmc] = {
> +		.clk	= {
> +			.name		= "sclk_dmc",
> +			.id		= -1,
> +		},
> +		.sources = &clkset_group1,
> +		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
> +	},
> +	[_clksrc_sclk_onenand] = {
> +		.clk	= {
> +			.name		= "sclk_onenand",
> +			.id		= -1,
> +		},
> +		.sources = &clkset_sclk_onenand,
> +		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
> +		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
> +	},

(snip)

And removed like below...

> -static struct clksrc_clk clksrcs[] = {
> -	{
> -		.clk	= {
> -			.name		= "sclk_dmc",
> -			.id		= -1,
> -		},
> -		.sources = &clkset_group1,
> -		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
> -		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
> -	}, {
> -		.clk	= {
> -			.name		= "sclk_onenand",
> -			.id		= -1,
> -		},
> -		.sources = &clkset_sclk_onenand,
> -		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 28, .size = 1 },
> -		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
> -	}, {

But only changed small lines not every.
Following is from my local machine.

@@ -665,7 +665,7 @@ static struct clksrc_sources clkset_group2 = {
 };

 static struct clksrc_clk clksrcs[] = {
-       {
+       [_clksrc_sclk_dmc] = {
                .clk    = {
                        .name           = "sclk_dmc",
                        .id             = -1,
@@ -673,7 +673,8 @@ static struct clksrc_clk clksrcs[] = {
                .sources = &clkset_group1,
                .reg_src = { .reg = S5P_CLK_SRC6, .shift = 24, .size = 2 },
                .reg_div = { .reg = S5P_CLK_DIV6, .shift = 28, .size = 4 },
-       }, {
+       },
+       [_clksrc_sclk_onenand] = {
                .clk    = {
                        .name           = "sclk_onenand",
                        .id             = -1,
 (snip)

Please make sure your patch has no problem before submitting.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
