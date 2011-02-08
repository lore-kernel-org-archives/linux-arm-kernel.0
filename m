From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Feb 2011 18:48:26 -0700 (MST)
Subject: [PATCH v2 4/9] omap: clocks: Add checks to see if enable/disable
	ops are supported
In-Reply-To: <1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1102071846570.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Check if enable/disable operations are supported for a given
> clock node before attempting to call them.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 2a2f152..5c08c18 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -261,7 +261,8 @@ void omap2_clk_disable(struct clk *clk)
>  
>  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
>  
> -	clk->ops->disable(clk);
> +	if (clk->ops && clk->ops->enable)
> +		clk->ops->disable(clk);

Shouldn't that read:

    if (clk->ops && clk->ops->disable)

?


- Paul
