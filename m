From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed, 26 Sep 2012 23:45:17 +0200
Subject: [PATCH] samsung: clock: Modify for the case with the only parent
In-Reply-To: <1348123859-13842-1-git-send-email-kukyakya@gmail.com>
References: <1348123859-13842-1-git-send-email-kukyakya@gmail.com>
Message-ID: <5063776D.4030609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 08:50 AM, In-Bae Jeong wrote:
> 'camera' clock has the only parent and thus has no reg_src.
> It has a parent clock but it prints 'No parent clock specified' message.
> This patch is to deal with the case with the only parent clock.

Please make sure there is your Signed-off-by tag when submitting patches.

I think we could avoid your changes as below, which would have added 
some additional overhead at the clock API and would have affected all 
Samsung SoCs.

I think 'No parent clock specified' message really means what it says.
AFAIU for cases where there is only one parent clock we need to define
the parent statically.

Then s3c_set_clksrc() should just return doing nothing, since the parent
is already set. 

void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
{
	...

	if (!clk->reg_src.reg) {
		if (!clk->clk.parent)
			printk(KERN_ERR "%s: no parent clock specified\n",
				clk->clk.name);
		return;
	}

In our case clk->reg_src.reg == NULL, so when clk->clk.parent is set
the printk() will be skipped and the mux control register (non-existent
in our case) will not be touched. Could you try and see if the patch 
below helps in your case ?

8<-----------------------------------------------------------------------
>From c287280672565895b627c51ca8865cf43b37af28 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Wed, 26 Sep 2012 23:28:10 +0200
Subject: [PATCH] ARM: S3C64XX: Statically define parent clock of the "camera" clock

The "camera" clock defined in arch/arm/mach-s3c64xx/clock.c has null
clock source mux control register as it can have only one parent
clock. In such cases there is a need to configure the parent clock
statically, otherwise s3c_set_clksrc() bails out with an error message
"no parent clock specified" leaving the parent clock not configured.
Define statically the parent clock so it is possible to get or set rate
of the "camera" clock.

Reported-by: In-Bae Jeong <kukyakya@gmail.com>
Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 28041e8..85b9cf1 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -744,6 +744,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "camera",
 			.ctrlbit        = S3C_CLKCON_SCLK_CAM,
 			.enable		= s3c64xx_sclk_ctrl,
+			.parent		= &clk_h2,
 		},
 		.reg_div	= { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
 		.reg_src	= { .reg = NULL, .shift = 0, .size = 0  },
-- 
1.7.4.1
8<-----------------------------------------------------------------------

> ---
>   arch/arm/plat-samsung/clock-clksrc.c |   17 +++++++++--------
>   1 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
> index 786a410..c00bd86 100644
> --- a/arch/arm/plat-samsung/clock-clksrc.c
> +++ b/arch/arm/plat-samsung/clock-clksrc.c
> @@ -131,18 +131,19 @@ void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
>   {
>   	struct clksrc_sources *srcs = clk->sources;
>   	u32 mask = bit_mask(clk->reg_src.shift, clk->reg_src.size);
> -	u32 clksrc;
> +	u32 clksrc = 0;
> 
> -	if (!clk->reg_src.reg) {
> -		if (!clk->clk.parent)
> -			printk(KERN_ERR "%s: no parent clock specified\n",
> -				clk->clk.name);
> +	if (!clk->reg_src.reg&&  !clk->clk.parent&&  !srcs->nr_sources) {
> +		printk(KERN_ERR "%s: no parent clock specified\n",
> +		       clk->clk.name);
>   		return;
>   	}
> 
> -	clksrc = __raw_readl(clk->reg_src.reg);
> -	clksrc&= mask;
> -	clksrc>>= clk->reg_src.shift;
> +	if (srcs->nr_sources>  1) {
> +		clksrc = __raw_readl(clk->reg_src.reg);
> +		clksrc&= mask;
> +		clksrc>>= clk->reg_src.shift;
> +	}
> 
>   	if (clksrc>  srcs->nr_sources || !srcs->sources[clksrc]) {
>   		printk(KERN_ERR "%s: bad source %d\n",

--

Regards,
Sylwester
